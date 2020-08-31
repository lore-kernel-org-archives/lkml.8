Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BE4C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1E206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598867796;
	bh=8yMQdTXBY8cQmkVCJWjYQCGKmduWY33EwADjjgbXbOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=bp5haiLPY8eMLMFE3P5BY0b4sB1P6oUhp+ngrJo+Bg+mAemWkvojpObh2SFL0LWhU
	 r+/flanYzfBi6jn9Q7didZ0V3dLWsgNbo6hsGXFmN4KW4siMqpTciW1wAhBj5THouE
	 RbVKahfNu708O9PvJYK0+opELJ5r9Pa7g7e387/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgHaJ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHaJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:56:27 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5364206EB;
        Mon, 31 Aug 2020 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598867786;
        bh=8yMQdTXBY8cQmkVCJWjYQCGKmduWY33EwADjjgbXbOQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CTTm1Xp+6eu4sCExbS33lyjWCv+M/eiOMviMXp+imXmEFzv2VNI/Zdl4DNv3bbYGF
         uCUHOli/ug/kc9Q2Bfm+GfqvZkR1qPFrNqzaJsMx3jHHGhtKNUYilEGQjYWwkcSCKq
         hbh3JgtkfSvzEbjaABhH9M2sXnEw1F66PuQnxz3U=
From:   Felipe Balbi <balbi@kernel.org>
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
In-Reply-To: <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
 <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
Date:   Mon, 31 Aug 2020 12:56:22 +0300
Message-ID: <87v9gz9m0p.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Tao Ren <rentao.bupt@gmail.com> writes:
>> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > index cdf96911e4b1..be7bb64e3594 100644
>> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
>> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
>> >  
>> >  	/* Handle device interrupts */
>> >  	if (istat & vhub->port_irq_mask) {
>> > -		unsigned long bitmap = istat;
>> > -		int offset = VHUB_IRQ_DEV1_BIT;
>> > -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
>> > -
>> > -		for_each_set_bit_from(offset, &bitmap, size) {
>> > -			i = offset - VHUB_IRQ_DEV1_BIT;
>> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
>> > +		for (i = 0; i < vhub->max_ports; i++) {
>> > +			if (istat & VHUB_DEV_IRQ(i))
>> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
>> 
>> how have you measured your statement above? for_each_set_bit() does
>> exactly what you did. Unless your architecture has an instruction which
>> helps finds the next set bit (like cls on ARM), which, then, makes it
>> much faster.
>
> I did some testing and result shows for() loop runs faster than
> for_each_set_bit() loop. Please refer to details below (discussion with
> Benjamin in the original patch) and kindly let me know your
> suggestions.

no strong feelings, just surprised you're already worried about 20~40
cycles of cpu time ;-)

patch queued for next merge window

-- 
balbi

Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052EB20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dddKWnC4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PLDu4peJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHCUUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:20:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64517 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHCUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:20:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8731CF554D;
        Mon,  3 Aug 2020 16:20:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=PF90wNMuKpjCQ5V/5619nvwTLro=; b=dddKWn
        C44X0MRBNrallMp/OYIZNUaHHnSOD31wde63SYuclky+jvS7AokK5gpWV4ZpDQp8
        1YS2JK/IY5WAZcq1jarHa6cRuFYp/jvIy4hyBAXdxB5LRAz+W4kPtznwOMHlWmc0
        2aUvRMw7tYOPek0quk9K5ioEvcyKfG+qDDKrs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F25CF554C;
        Mon,  3 Aug 2020 16:20:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Q9xTu3Q7G6ybCTets5WU0b++RTe3jw3gfIDCaIw+Fog=; b=PLDu4peJV9GFqRgQ/gK3uKs6SclhX6iumGQpARWgslvZ828s41isyydhcY7iIHhe2e64FRi8PUaMlo1CFSRE4HJYWM8Dru0DeXAh61lbYkj3l5iYcA95R9VwQbau3alTvFj1CKrn/zpzhsFyb/bU85/IesAEyZdhQ/WtDqbkfjA=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E6C2F554B;
        Mon,  3 Aug 2020 16:20:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 851B62DA0BFC;
        Mon,  3 Aug 2020 16:20:11 -0400 (EDT)
Date:   Mon, 3 Aug 2020 16:20:11 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Culhane <conor.culhane@silvaco.com>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        npitre@baylibre.com
Subject: Re: [PATCH 3/4] i3c: master: svc: Add Silvaco I3C master driver
In-Reply-To: <20200709080159.2178-3-miquel.raynal@bootlin.com>
Message-ID: <nycvar.YSQ.7.77.849.2008031546570.1112668@knanqh.ubzr>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com> <20200709080159.2178-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: BCB8755A-D5C6-11EA-B562-F0EA2EB3C613-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020, Miquel Raynal wrote:

> Add support for Silvaco I3C dual-role IP. The master role is supported
> in SDR mode only. I2C transfers have not been tested but are shared
> because they are so close to the I3C transfers in terms of registers
> configuration.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'm worried by constructs like these:

> +static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
> +				     struct i3c_dev_desc *dev)
> +{
> +	struct svc_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +	struct i3c_ibi_slot *slot;
> +	unsigned int count;
> +	u32 mdatactrl;
> +	u8 *buf;
> +	int ret;
> +	u32 reg;
> +
> +	spin_lock(&master->ibi.lock);
> +
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot) {
> +		ret = -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	slot->len = 0;
> +	buf = slot->data;
> +
> +	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +				 reg & SVC_I3C_MINT_RXPEND, 0, 1000);

Here you're in atomic context due to the lock, and 
readl_poll_timeout(() is built using usleep() which may ... sleep.

Also, is it actually possible for execution to reach this point if 
SVC_I3C_MINT_RXPEND is not set?

The rest looks reasonable to me.


Nicolas

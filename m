Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E702D2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598524517;
	bh=j53l6xpN5pfCrGpF8KAKqigp2K/D3ZSlNkM8qZH4iBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GW0H5Qk7AIb/ZKygCOW3ri5G1Yyo+zVAMGZVdmZ7xvT0A2a21aOWDWWXbeEI3nTQo
	 2vYF8tlfVMzDgwfmbx3ubuuqVI9E6uCI2aekQIUZLYnFy1enmABm/RF+3HpDWvKax+
	 zp5GKiU3ainqlbmXX2xZIn8g1Wnd/5GLu01Xw0jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgH0KfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgH0KfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:35:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7AE2080C;
        Thu, 27 Aug 2020 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598524508;
        bh=j53l6xpN5pfCrGpF8KAKqigp2K/D3ZSlNkM8qZH4iBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1QJbiyzNg3t5cOLZnLALBry05iDYnUfmlvxdMa+gNBq+poiejYDO/HotOcgm2kQrr
         OCvUO1JJ0veZ52Vd9ETYHdmWCcvQp7Sgv9Q+8D/+HNX9Y+2VVnBweShMgDbzgzeKLu
         OMBNP7tvMokoJgPZOtwj/knq9U5MtWlwARObRb+4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kBFFK-0076Gl-U5; Thu, 27 Aug 2020 11:35:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Aug 2020 11:35:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
In-Reply-To: <20200827100629.GA2451538@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus> <20200826214220.GA2444747@BV030612LT>
 <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
 <20200827100629.GA2451538@BV030612LT>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <64580e3b9acada6ff4ae9fdef02ac304@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: cristian.ciocaltea@gmail.com, robh@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, afaerber@suse.de, manivannan.sadhasivam@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 11:06, Cristian Ciocaltea wrote:
> On Wed, Aug 26, 2020 at 04:48:38PM -0600, Rob Herring wrote:
>> On Wed, Aug 26, 2020 at 3:42 PM Cristian Ciocaltea
>> <cristian.ciocaltea@gmail.com> wrote:

[...]

>> Ultimately the GIC trigger type has to be
>> something. Is it fixed or passed thru? If the latter, just use 0
>> (IRQ_TYPE_NONE) if the GIC trigger mode is not fixed. Having some sort
>> of translation of the trigger is pretty common.
> 
> Yes, as explained above, the SIRQ controller performs indeed the
> translation of the incoming signal. So if I understand correctly, your
> suggestion would be to use the following inside the sirq node:
> 
> interrupts = <GIC_SPI 13 IRQ_TYPE_NONE>, /* SIRQ0 */
>              [...]

Please don't. If you are describing a GIC interrupt, use a
trigger that actually exists. Given that you have a 1:1
mapping between input and output, just encode the output
trigger that matches the input.

         M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739BE206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="K1hCL8HE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0Olz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:41:55 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:32917 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgC0Olz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:41:55 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2388F22FEC;
        Fri, 27 Mar 2020 15:41:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585320112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhhqnEEjd7j8YFsiPIF4MDR1OPYkqd3YBJDx5dOWyuM=;
        b=K1hCL8HEIQ0t2wWT5JN3F9eKgjFQvtlGnT4UaTb+9ygZy6AV2lxWRbRkxLHU3PIDZkMdgF
        MH5SIMhDWci/IF6T2HTZdAGkucEYG49WrRkOCsuW0q/LdfFyPWA4EfNUikWz/CaLR102ht
        BbZldfsn5j/9eoNWNZLvNrkwmUid9I4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Mar 2020 15:41:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, richard@nod.at,
        boris.brezillon@collabora.com, miquel.raynal@bootlin.com,
        marex@denx.de
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
In-Reply-To: <a4f3657b-8ebe-a54d-8a11-c6e4ce8a3561@ti.com>
References: <20200103221229.7287-1-michael@walle.cc>
 <8187061.UfBqSTmf1g@192.168.0.113>
 <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
 <5323055.WqobA3rpa8@192.168.0.113>
 <990b9b16-36e5-ce73-36c7-0ebfa391c26b@ti.com>
 <e64cc3ac32d2b44c9e6f4b4f795354ae@walle.cc>
 <a4f3657b-8ebe-a54d-8a11-c6e4ce8a3561@ti.com>
Message-ID: <926471a04028dda58ff2aba2657c2fe2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 2388F22FEC
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.870];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-01-23 18:20, schrieb Vignesh Raghavendra:
> On 1/22/2020 6:14 PM, Michael Walle wrote:
>> Hi Vignesh,
>> 
>> Am 2020-01-22 13:10, schrieb Vignesh Raghavendra:
>>> On 22/01/20 12:23 am, Tudor.Ambarus@microchip.com wrote:
>>>> Hi, Michael, Vignesh,
>>>> 
>>>> On Sunday, January 12, 2020 12:50:57 AM EET Michael Walle wrote:
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>> know the
>>>>> content is safe
>>> [...]
>>> 
> 
> [...]
> 
>>>>>> Preferences or suggestions?
>>>>> 
>>>> I would go with 2/ or 3/. Vignesh, what do you prefer and why?
>>>> 
>>> 
>>> I dont like option 1, because I am not convinced that this is a HW
>>> description to be put in DT.  IIUC, problem is more of what to do 
>>> with
>>> locking configuration that is done before Linux comes up(either in
>>> previous boot or by bootloader or POR default). Current code just
>>> discards it and unlocks entire flash.
>> 
>> But this is not the main problem. It is rather the intention of the
>> user to actually want write protect the flash (for flashes who has
>> proper support for them, that is the ones which have non-volatile
>> bits).
>> 
>> Flashes with volatile bits are another subject. Here it might be 
>> useful
>> to unlock them either at probe time or when we first write to them, so
>> the user doesn't need to know if its this kind of flash and he would
>> actually have to unlock the flash before writing. I've left the
>> behaviour for these flashes as it was before.
>> 
>> And yes, u-boot suffers from the same problem, eg. it unlocks the 
>> whole
>> flash too. I guess they inherited the behaviour from linux. But I
>> wanted to start with linux first.
>> 
> 
> U-Boot only unlocks entire flash in case of Atmel or SST or Intel.

well for now.. until someone thinks its a good idea to follow linux
behaviour.

>>> But proposal is not to touch those bits at probe time and leave this
>>> upto userspace to handle.
>> 
>> No, my proposal was to divide the flashes into two categories. The
>> unlocking is only done on the flashes which have volatile locking 
>> bits,
>> thus even when the new option is enabled it won't break access to 
>> these
>> flashes.
>> 
> 
> Hmm, looks like before commit 3e0930f109e7 ("mtd: spi-nor: Rework the
> disabling of block write protection") global unlock was being done only
> for Atmel, SST and Intel flashes. So 3e0930f109e7 definitely changes
> this behavior to unlock all flashes that have SPI_NOR_HAS_LOCK set (in
> addition to Atmel,SST and Intel).
> I think we should just revert to the behavior before 3e0930f109e7 so as
> not to break userspace expectation of preserving non volatile BP 
> setting
> across boots
> 
> Are we sure there are no Atmel and SST flashes that have non-volatile 
> BP
> bits? If so, then I have no objection for this patch as this 
> effectively
> reverts back to behavior before 3e0930f109e7.

I've gone through all the flashes which were supported (at that time), 
all
which have non-volatile have the SPI_NOR_UNPROTECT flag. Also some ESMT
parts have non-volatile flags.

But this patch doesn't restore the state as of before 3e0930f109e7. 
Before
this commit any Atmel, Intel and SST flashes were unlocked. With this
patch only the ones are unlocked which have volatile bits.

I'll send a v3 which introduces a new kernel config option with three
choices:
  (1) Disable WP on any flashes (legacy behaviour)
  (2) Disable WP on flashes w/ volatile protection bits
  (3) Keep write protection as is

(1) is enabled by default. One should choose (2) though, because that is
the sane thing to do and (3) is for completeness and the special case if
anyone will actually keep the write protection on flashes with volatile
bits.

I still don't think a kernel parameter is a good idea because you may
miss it and end up with your flash being unprotected.

And i still hope that sometime, (2) may be the default..

-michael


> 
> Regards
> Vignesh
> 
>>> Adding a Kconfig does not scale well for multi-platform builds. There
>>> would not be a way to have protection enabled on one platform but
>>> disabled on other. Does not scale for multiple flashes either
>>> 
>>> Option 3 sounds least bad among all. If module param can be designed 
>>> to
>>> be a string then, we could control locking behavior to be per flash
>>> using flash name.
>> 
>> What about both? A kconfig option which defines the default for the
>> kernel parameter? My fear is that once it is a kernel parameter it is
>> easy to forget (thus having the non-volatile bits, the flash is
>> completely unlocked again) and it is not very handy; for proper write
>> protection you'd always have to have this parameter.
>> 
>> btw. I don't see a need to have this option per flash, because once
>> the user actually enables it, he is aware that its for all of his
>> flashes. I haven't seen flashes which has non-volatile protection bits
>> _and_ are protected by default. There shouldn't be a noticable
>> difference for the user if the option when enabled.
>> 
>> -michael

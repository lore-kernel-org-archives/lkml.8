Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6743C20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="H0PwnKhV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Go7v+amR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZDwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:52:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45529 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgHZDwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:52:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D4F15C00EA;
        Tue, 25 Aug 2020 23:52:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Aug 2020 23:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=A
        HHyrVT2yZtv8CDzm2Z+80V4YM66+fJjRzmbLB9O36M=; b=H0PwnKhVfn7iItQoc
        eBu7fWlcHa0wdAuZW/sxcMKLCkXEFchXAwMMQRU2Q04IYfxpmx5N/rmLZSkjfnjc
        o6umRHLbvQuX2ycPBBApodDYdPDy0I/xstPOFSNBeqzgR+Mh6Byfo76t7sN+5M3e
        LAtAsfEcuoEJo3JUOmfwutX7lobJwRg1TRN+bOsYv3cl+F9jB3RN4twXcR70PxMq
        5waoDd4GO3rvfo1MHP9ift3RpxW9WllW7wFxlSAosxipQl51OcIFkgezrI61TOYK
        NfjtBfrUWoUWWo5V62vx2C5WBqoCDReRBfgEOAZh6ct0lXym6QOx5CiWehqwOJGq
        eCRMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=AHHyrVT2yZtv8CDzm2Z+80V4YM66+fJjRzmbLB9O3
        6M=; b=Go7v+amRcYP0NsMrw8SNTJ1JssFQ/tJFpauAt+M8Iz3JXNFIYXJBgIleK
        fvmhioclTngWwajWkfQBt6ikqI36yjoP26vSuHwGm1SxlNVx4Sxlfm8/JIlfz2te
        Xyn2MAWb7IbPKzvi3bsdkP+qtxqEep5Z2AcV44m5NSTUAa4zmgiXaztOuwZUXNQq
        KmaPNgXmwoPHVLGvrQf7xPLqfZBm8IffDG1ioGLs88ZPHa+GFDLgyL8idB5giFb2
        qg9hGKIv09iderWNeaG8MrgYdek1NKcqjYAc5dnRz+dPVh58IJwef3VdzhnEWgDn
        SFfQ0JLlAfYa3XPpYf48rOgq0Zy7g==
X-ME-Sender: <xms:ZdxFX0LM7PbgRt7EQjpFLZ0pFf3W95gaFXn7YArcfST68uty2xwRjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvuddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:ZdxFX0JgJLNmfkOcprwv6N334SDNEj-hcAYwe2L9qsRV_WkEFzGyxA>
    <xmx:ZdxFX0ugMOUKd9dh6NtbkM9iYkGYOBMs3RvZUO8xEp8IQtiBHennyA>
    <xmx:ZdxFXxYOv1khtEol7k5WQWEavHXuqF7UdBoXYKw99hbpvmbrWKctnQ>
    <xmx:Z9xFXyyG5QnYN5THBE3c6ofWZKbKHkpt1KbhJXimZCmaDrDpgDwUtQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E3D3328005D;
        Tue, 25 Aug 2020 23:52:05 -0400 (EDT)
Subject: Re: [PATCH] arm64: dts: allwinner: Mark timer as stopped in suspend
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200809021822.5285-1-samuel@sholland.org>
 <20200818091038.uie3gxn7i74loho6@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bc4a7dc0-0f46-cd9a-a2cf-7de40a7830d1@sholland.org>
Date:   Tue, 25 Aug 2020 22:52:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200818091038.uie3gxn7i74loho6@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 4:10 AM, Maxime Ripard wrote:
> Hi!
> 
> On Sat, Aug 08, 2020 at 09:18:22PM -0500, Samuel Holland wrote:
>> When possible, system firmware on 64-bit Allwinner platforms disables
>> OSC24M during system suspend. Since this oscillator is the clock source
>> for the ARM architectural timer, this causes the timer to stop counting.
>> Therefore, the ARM architectural timer must not be marked as NONSTOP on
>> these platforms, or the time will be wrong after system resume.
>>
>> Adding the arm,no-tick-in-suspend property forces the kernel to ignore
>> the ARM architectural timer when calculating sleeptime; it falls back to
>> reading the RTC. Note that this only affects deep suspend, not s2idle.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Applied, thanks!
> 
> I assume it affects all the SoCs with a Cortex-A7 as well?

Yes, they all have the same ability to turn off OSC24M. Though they don't yet
have support for deep sleep.

Supposedly they can also reparent OSC24M from the crystal to IOSC, but I have
not got that to work, and IOSC belongs nowhere near timekeeping anyway (20%+
frequency error).

Ideally, we would run some MMIO counter off of LOSC during suspend. This would
be several orders of magnitude more accurate than the RTC for accounting
sleeptime. However, none of the basic timer blocks appear to work when OSC24M is
disabled and AHB1 is running off of LOSC; they count for about 10 cycles and
then stop.

The HSTIMER is the only timer block that I got working. It runs at the same
frequency as AHB1, so it would only be useful for timekeeping if we reparented
AHB1 to LOSC during Linux's suspend process before switching clock sources. I
doubt that is workable.

So the RTC is the best solution I know of for now.

> Maxime

Samuel


Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54350C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDA6207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hhOs7lAO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KP1aCXG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHAQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:24:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44983 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgHAQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:24:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D9CF5C00EF;
        Sat,  1 Aug 2020 12:24:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 01 Aug 2020 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=A
        R8KqUnGVjK7QTE3PI1CuQvIC++1Koq61ifqJ5NJFGw=; b=hhOs7lAOcdDJ16NvU
        gnuvG12GqRYeEQVrMudf56LnoOOpWN6gu57sIPiqUymz6BL8t6w/hOEf7ujX5KLU
        +2D7OLrys/MmgDoVY+4RyHx83MQVoIEKvPM6gwr/Oz74i0G2RvVoE3my4aiz7J+f
        VwO67EYJy9H/WavpqIZlr52GStXBvCdk0I+6qpOyb5mvlAnh64LeKNF8iarpURjI
        NxUkKYCrS+iPXzZqpvkz4nfCICrUYd2eNsvccTYFejxelDdIyFy55bHDYhOKNAM4
        PU+VnVcgoK3ez96vAu547EpEZ2LGY68wRy+1JKNqD2mMrjF/wp6Is3UFQwdD8GPa
        bvWnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=AR8KqUnGVjK7QTE3PI1CuQvIC++1Koq61ifqJ5NJF
        Gw=; b=KP1aCXG5RggBrmp3+c/mBqi1wqnuKBKIhCEVYjfcj6BCJrnz4fQI80Vgw
        aCrA2iQHzKNu1urp0laqPnqQL36ryNuwiG+O0N/gLBIAWCwooEJHLXspxIrwHZDA
        p7ISgX7emb2qZIMhfTZcSWMTOqNQxz6FsCuziUugeV8QfdyT/jvPF90kiCkSLpPR
        oWeIrRegSrkC0oqSdFpKiqUMe+ndnMIklE59gTLE/bP+ENL0DLXDFPfZR1QnCa1v
        mp5gLwFcrGcDSFLs2/5JXqavnRY8NlQTGGk4jao4UNlinrHsKa14e8RETdsLZ0ai
        FbST8Sc6igcEQ42lYMvHZlVePRvnQ==
X-ME-Sender: <xms:PZclXzTItlu3x_0usgXA3tCWVs2TGIf9hRQ0gN47Z9Wl593srCt4ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjedtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:PpclX0wSmDTsB-4Vm2mHLkv3l4Vnzs56xWSWEuw0kcekKLhteBMrew>
    <xmx:PpclX41qoMKau78iZuzqyUY4AJ1xPNIWD0IhiJdVtu-3Wqe9hoF-4A>
    <xmx:PpclXzB458IDE7z96JztAZsHNYlSrNL93QoZN7aOCSZLAQSvt9WxNA>
    <xmx:PpclX_tuzntJvLFJ12UTLSME0EcPj4Y5Imn3zk00GoVOBuRiV9vKNQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A28453060067;
        Sat,  1 Aug 2020 12:24:29 -0400 (EDT)
Subject: Re: [PATCH 1/2] Bluetooth: hci_h5: Stop erroneously setting
 HCI_UART_REGISTERED
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200801154346.63882-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <789a7d61-bdc0-19a2-d4e0-03b2f89bb516@sholland.org>
Date:   Sat, 1 Aug 2020 11:24:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200801154346.63882-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/20 10:43 AM, Samuel Holland wrote:
> This code attempts to set the HCI_UART_RESET_ON_INIT flag. However,
> it sets the bit in the wrong flag word: HCI_UART_RESET_ON_INIT goes in
> hu->hdev_flags, not hu->flags. So it is actually setting
> HCI_UART_REGISTERED, which is bit 1 in hu->flags.
> 
> Since commit cba736465e5c ("Bluetooth: hci_serdev: Remove setting of
> HCI_QUIRK_RESET_ON_CLOSE."), this flag is ignored for hci_serdev users,
> so instead of fixing which flag is set, let's remove the flag entirely.
> 
> Cc: stable@vger.kernel.org
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/bluetooth/hci_h5.c | 2 --
>  1 file changed, 2 deletions(-)

Sorry, I didn't see the other patches that were just added to -next.
I'll rebase my additional changes on top of them and resend.

Regards,
Samuel

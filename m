Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B2CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEC52078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="sKI4Et+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WToDmaP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGJHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:06:11 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55845 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgGJHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:06:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D41BFD2F;
        Fri, 10 Jul 2020 03:06:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 10 Jul 2020 03:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=HO/5yx1Yq2XQxTjYZFrMfuCGuRU
        oRG2hoIxUXXLvm/s=; b=sKI4Et+UqfYd0KlSXytkcV6QI8xF+avGYxXB2xnOh0f
        9oNNCq121LG1y5inX2dftISlMREOCYHcrFDTukeH5uiHjc9gk/WH0VDLZ4QP/PQt
        +ESuouO+xs77aGVRSXDwLiekLCz1yz2BiY8jZCGDIAzGGqYUdC24SPoVVF+o/Qj4
        QacQJr1MZtlQiF+x2UhGOOHOsQi6ARK4MiX40m3rTi7wcr5U54YEn8EGKvAFdKeH
        TeSZk9C5glMeT/PxHUtC8QqTP0M1+sqqiW1JP6edHLip5ZpC3Rrb1qfpypKwutq8
        AGJ3tMsMFQ0NqATYqY99IVayzyFy13GPZQWdB38cysw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HO/5yx
        1Yq2XQxTjYZFrMfuCGuRUoRG2hoIxUXXLvm/s=; b=WToDmaP30+LX+hZTvgZM9R
        EhXDr5fVOSxbL5ajdf8RURRVPQU/ZYL4pHh0xhfcryh5iP9oWYyGkE1/Wp7rD1Pv
        zwvBRCvb6OUINmJFjJ9h34ycyZVPOhG1TkJL1bd57DmUxy6ghxkHasF8HHxpyOUE
        zs7WUAlCWpArg46siwcVY7nKxd+LIO4ZrE60K8bpQga7LLp+HCUwjs7vT0UL8x7A
        BHObelQAxGW/sCEKTZ1tS/r2o3XNap1JfrIo0hGrZNGUY1hB18jYrEmnLzhtfoKV
        BRfvNhDKWA+bgqJ7t5Ubt+PK2Wnx2LGOqm0DQczu2QO7zntqL2loxv2m7X3wWRqg
        ==
X-ME-Sender: <xms:XxMIX9KZmAwslcApuUu11iA_J0hEpe0oUXvD4KGlHimhYfxC9Lidxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddtgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepieevhffhiefftdejveekledttedtteefheeileevvdehue
    efffdtveefkedtgfeunecuffhomhgrihhnpegsghhnuhdrohhrghdpsghmohiiihhllhgr
    rdhorhhgpdhklhhimhhovhhgrhgrnhgumhgrshhtvghrrghlvdhklhhimhhovhdruggvpd
    hlkhhmlhdrohhrghenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:XxMIX5JGuqgL1hFSaD-O7b_K5BN-lG0lJ7vMAB8NSiKiZnFySTxJkA>
    <xmx:XxMIX1uQr9TCVCwIgZv65nfMNxJqUicL6Rk70FGpgVR0_H39a6CKwg>
    <xmx:XxMIX-akOY2phj-XlL2MbVoUXqs7sSHBLNMum6O9p_ntTv44IoG2cw>
    <xmx:YBMIX8GtUvu1iD4BuBULxstqkYiGAQBZcTfa3k5Is63nXf2tb-Z4pw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A37B30600A6;
        Fri, 10 Jul 2020 03:06:07 -0400 (EDT)
Date:   Fri, 10 Jul 2020 09:06:13 +0200
From:   Greg KH <greg@kroah.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     chenyu56@huawei.com, wangbinghui@hisilicon.com, kishon@ti.com,
        vkoul@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB IP DRIVER FOR HISILICON KIRIN: Replace HTTP links
 with HTTPS ones
Message-ID: <20200710070613.GA1176018@kroah.com>
References: <20200709210933.27359-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709210933.27359-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:09:33PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.

Again, please fix your subject line.

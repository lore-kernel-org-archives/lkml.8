Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DBDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59E12076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LvF5D1R9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7fiQswa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEOO3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:29:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53459 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgEOO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:29:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 59CA85C00B1;
        Fri, 15 May 2020 10:29:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 May 2020 10:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ENf2VykawarrI6+ThDLsGlF0jo7
        wyHbRUSfCvk9dWEo=; b=LvF5D1R9/RN2SoQfGtlmJzV3Yfg6A44xIfPKkTWQiaH
        jrNbl3JrY4IuhZibteziDhsHrReJDBAW9ohWZsMJgAhRScQSgAATu6+ltCBiHdAS
        JStzcNx4/oH/ybr9EgIbaUsfQQ0CfPoKaa6tYLFaNqsy1hVuFXqcP8PDtn/TAfgd
        EZzAC3ASM1uWvIbNMhq1tNjir8834OwUCM7YSrR5+NYFXl/8/2cfr0ofYQLRfGsy
        XWIZYA6Kcg8hpU/fSIwkHkStZf2SslPpHxfxYeX4Xn6ONWTVau1I9423KXEIaJnQ
        wYuha117JZqwwxj1l465OqTt1SOvN67/4nwWr5sb44A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ENf2Vy
        kawarrI6+ThDLsGlF0jo7wyHbRUSfCvk9dWEo=; b=X7fiQswaI4xM66NOJoDDHE
        y5MRWIY2zJ/85vO363tVczF0jJqP459sBjPMl5VMhnai6pneAk6KnD7hEERFo1Fl
        g/fDA6wyjyLgLVcdfy7a10hz7gWTfb+GlGlojpRdx7gR+fz4/tcHMM4b2O/cpaDy
        vdMSZyGJ7yE6QVFjs8Hg3xV7/AdEe/DfYoQu7yUiQwKbJ4QRn6Vf1+KWFyo1JjH2
        YeV+OLIyraSpCnS+btx5z4i6EVm/kf5ffZauehyuUP8J2fmmOhJMq5zhgjYK7zeo
        4BzXUscseZdBDJmOO0IYaB1ajUI9wa7WMR+PTH0Zzyz1B8Ekp8TZmYdUjespgCZw
        ==
X-ME-Sender: <xms:Uqe-XjhrWlj4ZQukpdCit3TYm423yZLtPK-AkRqwuWNPQjSZmWD_Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:Uqe-XgATaorwb7dNNjmQvb1U-I2Sym99bRCN3fbj_KpsvTsqkeq0kA>
    <xmx:Uqe-XjFvnLcvjd4UA_qAmUCIVS5louA_SwziMYbozi4ANLybNlPaSQ>
    <xmx:Uqe-XgTKkP1ay9tn2-9UnHlvGymIj3vLobE4Ea1Uxx5Ciw6lvivT3A>
    <xmx:VKe-Xmbhm33NJcvDZpz0w56AQ3q8XFTcZ7NvZMg0mpDJq3U2Fdx2PQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B37E3280059;
        Fri, 15 May 2020 10:29:38 -0400 (EDT)
Date:   Fri, 15 May 2020 16:29:26 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     rdunlap@infradead.org, zbr@ioremap.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/9] w1_therm: adding code comments and code reordering
Message-ID: <20200515142926.GA2438037@kroah.com>
References: <20200511203535.409599-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511203535.409599-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:35:35PM +0200, Akira Shimahara wrote:
> Adding code comments to split code in dedicated parts. After the global
> declarations (defines, macros and function declarations), code is organized
> as follow :
>  - Device and family dependent structures and functions
>  - Interfaces functions
>  - Helpers functions
>  - Hardware functions
>  - Sysfs interface functions
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
> Main motivation on the first patch of this serie is to clean up the code,
> document it and reorder it to prepare the next patches, which are clearer
> after this.
> 
> One main point is to keep all device/family dependent code gather at the
> beginning to ease adding new devices if required.

Thanks for sticking with this.  Nice work, all now queued up.

greg k-h

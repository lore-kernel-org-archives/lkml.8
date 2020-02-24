Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E0AC35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="pMIvQxSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kl9m75Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBXAG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:06:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55471 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbgBXAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:06:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C30F20A4B;
        Sun, 23 Feb 2020 19:06:55 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 23 Feb 2020 19:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=zjhLqXsGdwHmDXQ4loElGl5IBhTi4NI
        teyaEj1OhzX0=; b=pMIvQxSM7Sx8a5nkQzbt7ZFK/MAHlcTi1D3f+ks+P/0EKLo
        6SAqSKgyK7eLnr9gb0WRoCjmsYSevkz8doLPRU1crKf5iem3xkd91XjVTtfyed2s
        UbmZlOaMOEb59rUmSADPxSLYxolVKZoVbLe37IJ5wPtR9xDI5YCK31SYR4xq2Rci
        ki5Nio2Ku7yuTJp5vz0QYgmRkmbr8xQgEivf7MMb5CdGnzUF8gIPfzyCe62xojx6
        8o5bo/Mht62rUZRbcPQuvEw2skBtB5C8IcZFPteC19ML2U7GcJQ0ppMkRxQjbVs+
        x7m9qqyhICAxmAiCZS/lgflQwPX0tSrkAAS0x1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zjhLqX
        sGdwHmDXQ4loElGl5IBhTi4NIteyaEj1OhzX0=; b=Kl9m75Lgt1kvotcVMiTCEa
        JFVqY3d6ZyBArGZn0X/iKGaAt5+J2Cb747X2tw0H5gVULjjSILHn+yVRBwMZpKOY
        omSWqe+HmTx3Ie6sjlPNWbb/gSWajKydpCgmKodvgaIgQFtPT++1JbTOc2VretjJ
        uevH6h1m+YOWSDuXPZbOHvnL6rqrlGLqKL6+7VDmmPgSr5wPzwPTrdUZ3arjA2/E
        plgeoIKlvPk1hB8roLOrX8o+HSTsgctZC9bIo3maQpEh6P1I6XqFwPaVXnsC7VrS
        gYdbyKc0NuEvflaGG8hn21IuEVmU2Tlf7km9ao34juMTsOu415lpyzU83XkJzjPw
        ==
X-ME-Sender: <xms:nBNTXlGexT6W00zZwqe5NhyI45Mm3-x-EfUkj2m1tCDBTPa45nLLkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeelgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:nBNTXoDnePLBa_Y_9k7NJkxs4WhfSQp8lTAkWuV86lg67zuSOFyFNQ>
    <xmx:nBNTXhko0weVkNUI0dB4G_laWk2E0gIVeuw7fS2hjoyfGZk3yLZYsg>
    <xmx:nBNTXjSqxLmg3j9fEEBlhoG8sA6IUJPl3sLCZdb3uQrjMKSS4GwFZQ>
    <xmx:nxNTXokN7xZ8q4h5XmrjbQQZMMPf4p_hbjDdjrAiAWe_PRVXSUi1Og>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3486E00D1; Sun, 23 Feb 2020 19:06:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-802-g7a41c81-fmstable-20200203v1
Mime-Version: 1.0
Message-Id: <020e9eb5-4fdc-44d0-b00e-42b6e6435110@www.fastmail.com>
In-Reply-To: <20200222235152.242816-1-megous@megous.com>
References: <20200222235152.242816-1-megous@megous.com>
Date:   Mon, 24 Feb 2020 10:36:47 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ondrej Jirman" <megous@megous.com>, linux-kernel@vger.kernel.org
Cc:     "Joel Stanley" <joel@jms.id.au>, "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR ASPEED BMC GFX" 
        <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: aspeed: Fix GENMASK misuse
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Feb 2020, at 10:21, Ondrej Jirman wrote:
> Arguments to GENMASK should be msb >= lsb.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> I just grepped the whole kernel tree for GENMASK argument order issues,
> and this is one of the three that popped up. No testing was done.

I think someone's sent a patch previously, and last time it turned into a
discussion about how the macros aren't actually used and could be
removed.

Regardless:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

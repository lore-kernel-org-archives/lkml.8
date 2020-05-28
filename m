Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC530C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32702053B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+6c+/zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404793AbgE1Pyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404774AbgE1Pyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:54:40 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D25EC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:54:40 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r11so6847969vkf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eD9Q69yAidIqs4JbIyrQRrLyc1rX+qPaojDMR0joP5U=;
        b=C+6c+/zy8X6oTdVUsHMPt6wtqdA0tC4QkpLSWdowQI9DkamTI3pEeTTNwx05CUF3Ck
         j9QffXYNwLwSAwzGnNt5/ybY54h7uLZdbuPeEvcHeqdlowZRVJZ2u0Z8z9fGW66IR/Ec
         g1E8wcwTUs1kkq97e0xEC+nhTHjbKMwHHKRvv2bi+dJDaUvPB6Eyi5bItg1rvvrgB26l
         1pPdNkR6iMiN1GoI7/dpaQeKS3596mUhoP/w6UbOIPxD2QsREiYbX/29PTbKxGMG/Gtr
         voApI0UepKgzJ5C9/b+P2vRerTtJqf0vDAVf1Oo7UvGcpfMU4ZqjBtYzbYTZLa/rS/fE
         b/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eD9Q69yAidIqs4JbIyrQRrLyc1rX+qPaojDMR0joP5U=;
        b=RxkjLz8J7Wxke2xY10N6gCktze5tFS4tR9MkNLF4oUYg8eLZQlKKxaPF91jCey69Yx
         0AqNJbqdVz0/X/7GajQwBB8N2qmLmw//r8ScdgYUUkpTzt+YyPuBd5otkL2orFrzLuUs
         P6orfGtX4roxRps6Yrfv01tqJMf86SR14k+R2ksMEEwmbamN/7anDSiWB8hHonT4lA6g
         hgAMnrDj0+5JDSIN9e23gmE0skefgYXhRKdz3uQQ/cuCDpCeTk/tk+eibdTzBJw5XRFD
         N7k+PK+WSKEKULCNRHhx/TnpsSoQt8r2/EBoEQ3N2ysQIVkfQ307UieW92WOEnfM/tgi
         aDyg==
X-Gm-Message-State: AOAM530Wu302h7gg55qiMVfnZOxIsSbDVAcyU2UpqFzzO4eicsP0G/uR
        TNMgmCbpyQQ0biFZkFe/rTRAFnYfp5/n0Zs/uow=
X-Google-Smtp-Source: ABdhPJw8Xk8oV6L3uEur2x175XF+krnVvLBDXMAI0SFt0rkatKFthbfQqghuLCvU+aV4LiyrGoasfZr/GxwSNaGmR1s=
X-Received: by 2002:a1f:a3c1:: with SMTP id m184mr2268337vke.38.1590681279501;
 Thu, 28 May 2020 08:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <e9bc87e240b62c80617ea7825144121a470a2d44.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <e9bc87e240b62c80617ea7825144121a470a2d44.1590594512.git-series.maxime@cerno.tech>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 28 May 2020 16:51:31 +0100
Message-ID: <CACvgo50j1t5VtMgE7-pquuYRaC_ku5pZ2aBVoD-MCCktfPm-VQ@mail.gmail.com>
Subject: Re: [PATCH v3 066/105] drm/vc4: txp: Turn the TXP into a CRTC of its own
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Have you considered splitting the series into several parts and
focusing on merging one at a time?
IIRC this the longest series _ever_ submitted to dri-devel, plus it
seems to be growing with each revision.

Due to the sheer volume, it's likely to miss various points - large or
small (like below).

On Thu, 28 May 2020 at 08:47, Maxime Ripard <maxime@cerno.tech> wrote:

> +static int vc4_txp_enable_vblank(struct drm_crtc *crtc)
> +{
> +       return 0;
> +}
> +
> +static void vc4_txp_disable_vblank(struct drm_crtc *crtc) {}
> +
Core should handle if these are NULL, so the stubs should not be needed.

HTH
Emil

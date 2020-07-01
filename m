Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F36D20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le/SOV5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgGAQDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbgGAQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:03:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E9C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:03:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y22so8434945oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyqqoU43QY3DailQWnD9ZPGpahswy6mkqS67kbUZfaU=;
        b=Le/SOV5qRC746f+1Be4jz7UNkzudA5yDLBvhExxmi9OUAP1bKgFv+nOKQ3pg3wbpnJ
         mZ9Sh2iOMjq0rDLMTDsv5FTRz8x5kg+G+GpSDR3FsmB7XBxaAiGLDraHQu06MKrTn/2q
         60W04dUEmtRtON1wgw+qKmOawpgDYzqNuiL35Pu/C2jMLNpGMjzE50MKK+ENBRUCRoIg
         RsuGG9/9rpW5xOXK+V3xgeD2H033BaVqsdOAuufu8icDMs/MP1JnA2OPNVmThWpBWjhk
         NotZuyUOF81dbQ6ga/cbRSku//MBTfBclakIwbHmcYCFxeYfEBSuojeZbAXh3A9PKYxV
         /6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyqqoU43QY3DailQWnD9ZPGpahswy6mkqS67kbUZfaU=;
        b=QACpYQ6bAdWvN6LUnnYd4Elr8f1Thi0RMNbTiHsbhuvO3u0vB+xSb/SPEG15uBszhX
         vB06DypPORPbz0cO9s8gXYoO/E/NgqEQjCy065r27ZPskB2X17TG+R2p78a2XNuoGY+g
         XtOWNo0V5bNSeZLFve0as9b5A7EQQe44RV3QF6aIsItuKrK0gqygwQ+wB5w0xo1IwiSq
         63ysf5J2q3XrMrBeFFg9hH1CzZenqOKIpaMXRrC4U0aJxvx8VO6MGyqEYyN3KZGjIjYf
         zo4Cz16k+p50QNh20jq8i3DDJYzYYmQefjTSawu6nrCxgJRYkFcNKB9cvZ5hQFK/RZ7p
         4dLg==
X-Gm-Message-State: AOAM530LlUyh0IAq7qbXGHDwhCUHqmBcG5tcKXdaVY6NM0XcHTynwJ/c
        w04vdvTtUPf6+6Z+AY877o1UBQTTZOeKlP979RM=
X-Google-Smtp-Source: ABdhPJw4bKqlS34uca7Mjy9efaGo4eTqH93rFy3bV2x1L5461qN7L8hj6lRQMc/QnxPemH+hyBnKX5GxNLztvm9bS+M=
X-Received: by 2002:aca:efc5:: with SMTP id n188mr1796727oih.77.1593619412923;
 Wed, 01 Jul 2020 09:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
 <AM6PR0402MB3607986330B844B161E271FAFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B-XVaZ-t2T7UBdCqqde3bJREiQhR71ET8p=9EHJ-DQbA@mail.gmail.com>
 <AM6PR0402MB360717519B42A48A754691C8FF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5CZMBeSY=0sa39wJsZpaCqWeCb4-HG4jjXO5pGeW64azg@mail.gmail.com>
 <CAGngYiWV93yWY-mWM-1YcRU71iWnP=qsLSD6Z5dZkz=Zb+iqRA@mail.gmail.com> <HE1PR0402MB3612B2111833521E571DC207FF6C0@HE1PR0402MB3612.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0402MB3612B2111833521E571DC207FF6C0@HE1PR0402MB3612.eurprd04.prod.outlook.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 Jul 2020 12:03:21 -0400
Message-ID: <CAGngYiXfY0SBEm=H8KMTR+0ztLTEQ+bpjPpquac+igoCLHM=0A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy and Fabio,

On Wed, Jul 1, 2020 at 11:30 AM Andy Duan <fugang.duan@nxp.com> wrote:
>
> Discuss with Fabio, an existing(old) dtb in mainline has to work in future kernels,
> without the need of being updated, so to add internal pll support for 6qp rgmii gtx,
> and not to break 6qp old dtb, add new property is one solution.

Andy, many thanks for your time and attention on this issue, much appreciated !

Fabio has already indicated that he's ok with adding a new property.
Fabio, is that still the case?

If so, I will re-spin the patch to use a new property.
Hopefully Rob Herring will be ok with this.

Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD40C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6634206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gck+FqS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgIHRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbgIHQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C4C061290
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:01:33 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so19988558ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ROFMex6SmeQcgvgfjI5Vchgvc+G2tj/iCxGO6nsxuo=;
        b=gck+FqS4TFd5ioreMir7T2hmA8fOv7VmNt+UEdcoNlHpyopB61mqzfwAgUgzpnzI1M
         awXeDvbGswaVG9tiaeMeWaU39z+IibLEQ+XqA6dnfa0fojUufDKdMMk1Cf3PgB6k6MD8
         jr/nL7gXzFGPBVryCkZTzvftcp8o6uyy5VwP3T5/xlmEVZ0ICQT66jYZJ2dm0Qsu+KO4
         OZANzsYGJ2FdjcMvOaH17vORAB6hK/dCqCiIA2790Wa7sTbCy6mb16uHiI7SK3HbLHxU
         gGT61gn0NiPQwyQewP2S+WzKFszo3IFb/LbbilVCN7YK4fhSGXVMm1FM4hBkhd3sDSGz
         OjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ROFMex6SmeQcgvgfjI5Vchgvc+G2tj/iCxGO6nsxuo=;
        b=Ma6rvF8h2N2mLG9xSRek3Lr/xljgBJR/WyDitv5BZapVKuwK7zvRqA9tI/NXivvmtn
         uz0d1EbkY88MsETKOAw7Va1XqHXgpHz91SYm0DUl4dHCuovQyaC4nsT/WkYmvuO7H6mq
         UF2NIlYB/dVP5yBq3O8FvxfgCADJXbMeHCBbp/H5gbAcxs+9O1QrTZazPNrz0fGhenll
         Jptvyi8qiWIgefP/DSpRwrbNatoQ/9yPrCUoxl48xOpPHwVoE1gxdCW6eeC46XwA2CCL
         qtZ07B575Clz4G7G1BDGJ/kUsNKkk1VZaBl/sNK1gX81Tei8QwrkHC6VjEpLRsmF0dMS
         3+tA==
X-Gm-Message-State: AOAM531XHBnCnm8kRWU9MIFwyBJznQi/5QzksCdSYL8IMC3wNer5Szmu
        93sMTJa7NzUL7CZp58qXeqnAhratogeW8W/UDGQ=
X-Google-Smtp-Source: ABdhPJzNCPOWmmxsXcRfVxojDQus+EStgmwv1gk8/iTKXOq4a7uo6VFLWq6gOeHI82RqCdy4Fdrc7ekP8uPBAtxxulA=
X-Received: by 2002:a2e:9899:: with SMTP id b25mr11694176ljj.178.1599570091951;
 Tue, 08 Sep 2020 06:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125558.256843-1-stefan@agner.ch>
In-Reply-To: <20200908125558.256843-1-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 8 Sep 2020 10:01:20 -0300
Message-ID: <CAOMZO5Amaxi-rU44b_q4+6k4vtOoCOmbKgiDJ0r3tEi4zkZB=w@mail.gmail.com>
Subject: Re: [PATCH v2] drm: mxsfb: check framebuffer pitch
To:     Stefan Agner <stefan@agner.ch>
Cc:     Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, Sep 8, 2020 at 9:56 AM Stefan Agner <stefan@agner.ch> wrote:
>
> The lcdif IP does not support a framebuffer pitch (stride) other than
> framebuffer width. Check for equality and reject the framebuffer
> otherwise.
>
> This prevents a distorted picture when using 640x800 and running the
> Mesa graphics stack. Mesa tires to use a cache aligned stride, which
> leads at that particular resolution to width != stride. Currently
> Mesa has no fallback behavior, but rejecting this configuration allows
> userspace to handle the issue correctly.

What about adding a Fixes tag so that it can be backported to old
stable kernels?

Thanks

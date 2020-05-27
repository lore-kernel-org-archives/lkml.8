Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A2AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B8B2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="hPL8fiE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgE0TkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgE0TkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:40:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84EC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:40:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m12so28018322ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoA+ltY04rTbNuPqoR5f7m96ZZzh4EiSS3yqsY7/Fkk=;
        b=hPL8fiE399pTijYYRRViKesbZjUEdR+1xrxi15mivx2UishaS/MyGdfufOhOuh4nJC
         9DUnu5lvoCIClNGhanYt78Spn/6lz6zJeb3f1R1yoUauNsfdQgAnT10eHlqd3dA2XxFA
         Wg3afUHR2XHL8Zs4PeqBof/vcTQa6b4reFBUU69cmsy3v+WHduqyYbNr7/uT0POOWyIb
         Pd9gtwh9o1vSLmlP5F8Wg9VveNOpMqacFmDDbP1kCj2b8X4Yz6f0DWDOd4IXybnXLHMc
         rqQth6s35/EOBBV/PYDci0vcE4tOXgfTbpJtEYpdvdMfOxYYHPxZ/7V0n7zGJrXURm7J
         siEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoA+ltY04rTbNuPqoR5f7m96ZZzh4EiSS3yqsY7/Fkk=;
        b=VUCupWIgnnbNHt+4n8zi/j8I3UJYVHrptz8uyPZmT4LCu/CDLreM/q6A8+k8SmhemU
         w9xC4K+/dvg1OaFlxyuh0B2zONr+wkEk9M8n+wh9ifZWVynCfq1iZ0H0YOmMOwEaW/TH
         rNlW+XWG3pqxs7rui33JLfybboeYriJwGShj6TU2d6j5nKP/fc1sKn3W12kmYJnsKD9D
         rrs9k+PWvjmo72zn2wS1Ey2C2MwyJuAQg++aidzhY4DHLHXCDL8STttnkzy8tatoAjZy
         +cgTbOFMC6CiR9LDNIrW9hZIhGn56CWBgsTyFATFUmu+nC1FVSOc1zWJDkmackQ/CNxp
         CWNg==
X-Gm-Message-State: AOAM531qMRbOCcVULaJJnm1uaunkUiYkkSomJAjlSYP0cZoalO4Nq3O0
        aiOt5HbZ1wBoWXNxGMPDezYyW/g0XWG//G4e28rNiTNG
X-Google-Smtp-Source: ABdhPJzvKaopQeuSH++NfG6+ePzdECIe55mSMz1vGorLjrgnNGhLypFBTCO3NOV35EuZEgNnmnk7AN6/T2UVknXBfxI=
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr4027321ljl.367.1590608413785;
 Wed, 27 May 2020 12:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <f1b1737fe0665e7191c3d2a3cd9bfafb831866be.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <f1b1737fe0665e7191c3d2a3cd9bfafb831866be.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 12:40:02 -0700
Message-ID: <CADaigPUpH4DuK_FSVGmq-ZPPCtvxOcdq881h9h3NE1_ODJ6tuA@mail.gmail.com>
Subject: Re: [PATCH v3 055/105] drm/vc4: hvs: Introduce a function to get the
 assigned FIFO
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> At boot time, if we detect that a pixelvalve has been enabled, we need to
> be able to retrieve the HVS channel it has been assigned to so that we can
> disable that channel too. Let's create that function that returns the FIFO
> or an error from a given output.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

> +int vc4_hvs_get_fifo_from_output(struct drm_device *dev, unsigned int output)
> +{
> +       struct vc4_dev *vc4 = to_vc4_dev(dev);
> +       u32 reg;
> +       int ret;
> +
> +       switch (output) {
> +       case 0:
> +               return 0;
> +
> +       case 1:
> +               return 1;
> +
> +       case 2:
> +               reg = HVS_READ(SCALER_DISPECTRL);
> +               ret = FIELD_GET(SCALER_DISPECTRL_DSP2_MUX_MASK, reg);
> +               if (ret == 0)
> +                       return 2;
> +
> +               return 0;
> +
> +       case 3:
> +               reg = HVS_READ(SCALER_DISPCTRL);
> +               ret = FIELD_GET(SCALER_DISPCTRL_DSP3_MUX_MASK, reg);
> +               if (ret == 3)
> +                       return -EPIPE;
> +
> +               return ret;
> +
> +       case 4:
> +               reg = HVS_READ(SCALER_DISPEOLN);
> +               ret = FIELD_GET(SCALER_DISPEOLN_DSP4_MUX_MASK, reg);
> +               if (ret == 3)
> +                       return -EPIPE;
> +
> +               return ret;
> +
> +       case 5:
> +               reg = HVS_READ(SCALER_DISPDITHER);
> +               ret = FIELD_GET(SCALER_DISPDITHER_DSP5_MUX_MASK, reg);
> +               if (ret == 3)
> +                       return -EPIPE;

Oh, FIELD_GET is new to me.  Looks like we should replace
VC4_GET_FIELD usage with just using that header, and also
VC4_SET_FIELD with WARN_ON(!FIELD_FIT()); FIELD_PREP.

Could you follow up with that?  Other than that, 54-67 r-b.

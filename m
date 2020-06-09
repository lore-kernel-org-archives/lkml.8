Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8BE20853
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPvH/CmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgFIMso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgFIMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:48:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB07C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 05:48:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so13921554ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCNDWi4W86xASW8FtuEfEJaeXXXa1muCZ0DikS2IxmI=;
        b=mPvH/CmSSgHpsp6C/uqGy+AZnrwq9ay/aD+xL69u0ckBRA03GUU6MFGxmh+3CM1tav
         AfWDP7Q9/kw8uNorr4dLbJuH/FugHOrbW0L1kLqWhDSSadhfoReraccYGm4jgU7kawd8
         RGjIDKBu5LhPtGQKJgD/ULY4bXazpgO9iA14JBJv66Y3rQpom722EcFJrvzFlju4+PPd
         63XOl+NUFcOXugFmtxpKQxHGSYD0dz7w2Cx82vNQ64DciwKJ7UBf4oAtnd9ez4db6tPv
         EbJNPf78cg6H1YxzFFexQgQPzILS0+t7j4K95pw+fRVIfPDJAVT7HG2C9pHJDGj5daVO
         vuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCNDWi4W86xASW8FtuEfEJaeXXXa1muCZ0DikS2IxmI=;
        b=oRAZZMc1cesJyCGh0/sYMl4ZMk3DrHOPSrHGGv/T1Mmd/zStxKpGNc5mYExSAkrpoN
         SBS65ZqurnwxAc2GTqnNduQNLsevrQkyWTPlvqu2s2Y9CKyQVJvDfB7xAnlzm8Jf5/Qf
         l8HS+/EjsJMkDFZBR180Xkm6oTSKuqu4UFkBBLRWcgZsFpRtnVxIkHHuRIIXX0/B9PNB
         Dngh+IoKctI0BRIR0NPNCWjSYqmne6J3Pl5jOchxDsZnBF6mS02qxDPVJaPIZfpf6LIk
         Mh0HfCzZUfldfJtXQthJoGrHRJjti97SRv7OSubXyyV2gjyOl5N7gbpgzKubQe/Sxczp
         l9Dg==
X-Gm-Message-State: AOAM533p6sL8N3BgG5gVMvt6ztMpUJnow9T5pxckvRiO16bpzgn3GOmX
        mbjFV8dEyaEnaqV8IS8L/QDYafkA3GVhW9JGAkCsYQ==
X-Google-Smtp-Source: ABdhPJy/jDW/k8Iu7wTAdiTg2q3uE99N0IA6oABBl2JcyK9DT3ERhQ6uhNzdJoff9mYZXt3GW+4EBXl7qqFZLpBxRpQ=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr14419265ljn.286.1591706918718;
 Tue, 09 Jun 2020 05:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191458.1260397-1-arnd@arndb.de> <CACRpkdYQJocN_-i07J0fFC16pDUfb9o0mzRF0YRO8UMrE=Suxw@mail.gmail.com>
In-Reply-To: <CACRpkdYQJocN_-i07J0fFC16pDUfb9o0mzRF0YRO8UMrE=Suxw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jun 2020 14:48:27 +0200
Message-ID: <CACRpkdYUTujUX7FdwFjehFVAOLz_w6epXRzYc8e8yB=zDsRCyw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix link error without CONFIG_DEBUG_FS
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 10:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Apr 8, 2020 at 9:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > I ran into a randconfig link error with debugfs disabled:
> >
> > arm-linux-gnueabi-ld:
> > drivers/gpu/drm/msm/msm_gpu.o: in function `should_dump': msm_gpu.c:(.text+0x1cc): undefined reference to `rd_full'
> >
> > Change the helper to only look at this variable if debugfs is present.
> >
> > Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This fixes a compilation error for me on the APQ8060.
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Could someone be so kind and apply this fix to the MSM DRM tree?

Yours,
Linus Walleij

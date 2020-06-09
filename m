Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91E0206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK+8RlDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgFITxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgFITxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:53:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86875C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:53:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so44478lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUWfuhibOgc2qDuR8j6PZRsitIEa5AgrV8pmEG0P02Y=;
        b=sK+8RlDjikgHEuA3/kcxNekFgXz3Mu5DR09v16l8o+7xRQjax6TDincVJct+FsWt0/
         IncvasH0MP32OvvhlGAjndRmYWzo/PA5Vt7aikyqeE2WCYB9RbkWH09rczh6i8LwgOEF
         oR0AfEzkVg3A8q5iWCLYhVtz6dADYE/m8058DSVyr6w6Voc6edxVj1IPARx5HoawvfIz
         8BUoMJfqmOh/nHtady0/cPmbRrLwAqGbdozHp1gXUvKYiXoiPMh0ZMuj51TFU+bbkj/o
         Zfmkk9VrVGZ9k5fKv7JZnnLg33MBw5eaPWctnqDHeFnmUtNWwUaH1rIcIPYUsXcvXD9/
         el9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUWfuhibOgc2qDuR8j6PZRsitIEa5AgrV8pmEG0P02Y=;
        b=kMIoBEiGYpUoa3I8iUldMCJK5kcS870aut3dP35tP/JzZq1uweDpUC39l2aWBuU2VS
         Tj9AOuAFm87PpoCTpURwIvS0JX414HPB2JJ81IhJCIoA6Lm95XZMaOs3uG1LU3UgxvfP
         LgGGX/BNYJ/Z1HA28+f9z68ieC6XZ+7Fja1bmRLH6hr5uDt4AKTA+x4cjbi3a7b1JOhm
         xSwvsU/QNOyJdY1yunaQTaErqcnjxopvNF0R8EXEaGV9xH14neq0orwK/43AtyWWmTtl
         GHwz3Cdmbs+rXqwtp5EhHhfZ9V/IZlLBIUXqA+QzS9347SHtANZX8x58PVjjwy0vGcYB
         J39A==
X-Gm-Message-State: AOAM532voFcw3wTN/A6Q015DNPYUmJQKhs4MFCbUXTkDGI4OmZkTWMxM
        MufYYB6b1c6DnNNI9WCRyLM6cTKK70Lhj7Lzbcn91A==
X-Google-Smtp-Source: ABdhPJwe80eLeSB161s6pLsJ9M/dSqM3rMPgLB0OQVvgMZYcddUazRxjNwbPDc8UxolcwAuZqNy8k+4V9D3RHC/fBus=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr16162946lft.194.1591732390917;
 Tue, 09 Jun 2020 12:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191458.1260397-1-arnd@arndb.de> <CACRpkdYQJocN_-i07J0fFC16pDUfb9o0mzRF0YRO8UMrE=Suxw@mail.gmail.com>
 <CACRpkdYUTujUX7FdwFjehFVAOLz_w6epXRzYc8e8yB=zDsRCyw@mail.gmail.com> <CAJs_Fx4V9JkwATGeY8eV=Z1khr6z=OVd+B=YRJ1RY7xxxM47_Q@mail.gmail.com>
In-Reply-To: <CAJs_Fx4V9JkwATGeY8eV=Z1khr6z=OVd+B=YRJ1RY7xxxM47_Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jun 2020 21:53:00 +0200
Message-ID: <CACRpkdadv9+Lu7f9uRibhdnd41rX2n_H7AUSzmXc_Dn_EYs1eA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix link error without CONFIG_DEBUG_FS
To:     Rob Clark <robdclark@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
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

On Tue, Jun 9, 2020 at 4:04 PM Rob Clark <robdclark@chromium.org> wrote:
> On Tue, Jun 9, 2020 at 5:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, May 5, 2020 at 10:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Wed, Apr 8, 2020 at 9:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > I ran into a randconfig link error with debugfs disabled:
> > > >
> > > > arm-linux-gnueabi-ld:
> > > > drivers/gpu/drm/msm/msm_gpu.o: in function `should_dump': msm_gpu.c:(.text+0x1cc): undefined reference to `rd_full'
> > > >
> > > > Change the helper to only look at this variable if debugfs is present.
> > > >
> > > > Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > This fixes a compilation error for me on the APQ8060.
> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Could someone be so kind and apply this fix to the MSM DRM tree?
> >
>
> This should be fixed by 20aebe83698feb107d5a66b6cfd1d54459ccdfcf in
> msm-next/drm-next, are you still seeing this issue?

Oh nice this works too, I was just rebasing my trees and the patch was still
there, of course I didn't see that anothe patch fixed the same issue already.

Thanks Rob!

Linus Walleij

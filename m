Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B825DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938DE20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WcKt86PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgFIOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbgFIOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:04:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF6C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:04:23 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r77so9878246ior.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M11TlZ8BCkkiyM14zjB6SRMJjOFPdi0sycPDLMDZtzg=;
        b=WcKt86PI06koGDiMZklr+HDKxwBnBrf72EEYGJhlLB2eLfI7DuOgfRzmxlQpnDf3P+
         xcqPS5N2kWZzPQLjpuC6LQTeBJYkCixcYSwseGmp3ZHoktGwLwjZDAryXzofcxVTm7tI
         +ZeDAoYJLmTSokrxd3haNf0dUpgnAdHtIhxPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M11TlZ8BCkkiyM14zjB6SRMJjOFPdi0sycPDLMDZtzg=;
        b=NHjfBsgUbSk9drJseYk2+u+gmjgwQ3WTIUIaJq/S2r/Vp/GUuqUBMMoflrUeix+Xhs
         bFxTisPkXN8hw8h02jJwhCa5GmTP2O7v0Qpm3CEVupbffj1aS5lpEghI+3njwUs1gGrg
         fJoNw8fuNu0LvHx2LYDpZ5Ncz4Q+2NhH5bO0ZTtxGgOXki8bArgKan5SKa2xEysF7/g3
         C2GQ0jpyOMo/AoRxiRQMSH3+0nQYs1c7Wwk8FxfCUQAEIfUe2kuPmjEj+af9J+BjunV2
         KV4KvsZEfbvXl0tLagcn2xBCY8AbkpjPAkrzlP3ydxbRjR7nslFOZ6PSBICpwkCgxJts
         1oyA==
X-Gm-Message-State: AOAM532dEsumvr1viiNzkkJLmA5EzcxCUgA+ChpC19YD8JcWJcoRRMfz
        b8Q+M4tBgzE6+xDDt8idavWvs8KmG0uXlD+JZQJJCQ==
X-Google-Smtp-Source: ABdhPJyG91jHkheJimS86A26g34xw4jYgUCjF+/j9VS/jduQO60MV/ip1Uo+HQrXE9vAcZ0eYj2cAUokFLTwKjv6VUk=
X-Received: by 2002:a5d:858a:: with SMTP id f10mr27458957ioj.184.1591711462114;
 Tue, 09 Jun 2020 07:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191458.1260397-1-arnd@arndb.de> <CACRpkdYQJocN_-i07J0fFC16pDUfb9o0mzRF0YRO8UMrE=Suxw@mail.gmail.com>
 <CACRpkdYUTujUX7FdwFjehFVAOLz_w6epXRzYc8e8yB=zDsRCyw@mail.gmail.com>
In-Reply-To: <CACRpkdYUTujUX7FdwFjehFVAOLz_w6epXRzYc8e8yB=zDsRCyw@mail.gmail.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 9 Jun 2020 07:04:49 -0700
Message-ID: <CAJs_Fx4V9JkwATGeY8eV=Z1khr6z=OVd+B=YRJ1RY7xxxM47_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix link error without CONFIG_DEBUG_FS
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Tue, Jun 9, 2020 at 5:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 5, 2020 at 10:27 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Apr 8, 2020 at 9:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > I ran into a randconfig link error with debugfs disabled:
> > >
> > > arm-linux-gnueabi-ld:
> > > drivers/gpu/drm/msm/msm_gpu.o: in function `should_dump': msm_gpu.c:(.text+0x1cc): undefined reference to `rd_full'
> > >
> > > Change the helper to only look at this variable if debugfs is present.
> > >
> > > Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This fixes a compilation error for me on the APQ8060.
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
>
> Could someone be so kind and apply this fix to the MSM DRM tree?
>

This should be fixed by 20aebe83698feb107d5a66b6cfd1d54459ccdfcf in
msm-next/drm-next, are you still seeing this issue?

BR,
-R

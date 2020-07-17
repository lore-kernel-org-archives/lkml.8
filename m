Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03430C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50A8207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOcdUWmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgGQU3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGQU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:29:33 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:29:32 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p25so5504260vsg.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLpVMDYrwWJk9a87cWOg2bUrC1EGuGNsrDX+jB50X64=;
        b=QOcdUWmVYO1ruHidjb3BSZV+nTbElxTyRNbKn8qrlYGKW/hsoUgNhdQV35VwVKTeCK
         cLuBXa3aF18NO7qBg+2XtVH09Gnp+OP/6/WjY2PVwrY0zQuGLT6HFiEd6w2HW4jkN+kO
         uAGvcAq319nP7pcGzfoiqyaBryN0jxK7I9qTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLpVMDYrwWJk9a87cWOg2bUrC1EGuGNsrDX+jB50X64=;
        b=XFTWPTk3Joky21Hbrihf42YsVphLvLiB7EkvqmYB6zDuFR+cdBrvOosyD1B7YKsdIq
         Ndje97+Dt4ZoBGFLm2BTAL0eEONLda+XGLNXPAxeYiuDKrVKnPlkj2xW70hEwgeETfpk
         9xvh5NYvkTK1z7JL5noy3NhiNrPFyYpqa3/f14yfCy9nNU8hqvJ4JbpKSM3IWF4lPsyb
         KrwHItVXeASiMJsOZUkEtm0HlgRWT9Cvflnc2toB75FpWgzLSs7uzsAL/9FZBWGpsFjj
         DhCl3vYTmPvr5WpdWulikqyJP86BgUfylOa0Oka1gr8XWrkUyJqihdEgDcr/wYkGp+qI
         C8cQ==
X-Gm-Message-State: AOAM533fc6E3zXuaDhW/fIoT3jHIi6ajdLMZt6xt8tUHXBkeBF6C9L+z
        p3GeAfIkwxg61lnv7dUh06Bfbtte6yY=
X-Google-Smtp-Source: ABdhPJxF2dU2pX98wpjeFMDIC6Mqt0SeXCyVaUAvR2oAZFvBoghArYqKht4IHCrKlR4Vbtmh1SV0oA==
X-Received: by 2002:a05:6102:201a:: with SMTP id p26mr8306811vsr.50.1595017771310;
        Fri, 17 Jul 2020 13:29:31 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id x25sm1184741vsg.21.2020.07.17.13.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 13:29:30 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id h18so3260385uao.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:29:30 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr8909789uan.121.1595017769995;
 Fri, 17 Jul 2020 13:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <1594996458-15529-1-git-send-email-akhilpo@codeaurora.org>
 <20200717144607.GA16703@jcrouse1-lnx.qualcomm.com> <CAD=FV=Vdg36wBJiYM9bxGy-8hjxEf85aYAGuqR=Xh_oM0pLt0g@mail.gmail.com>
 <CAF6AEGvY9qxpi8rqL4Lef+Qs1yc20K3jEewK+9mWuTdhkLDKkA@mail.gmail.com>
In-Reply-To: <CAF6AEGvY9qxpi8rqL4Lef+Qs1yc20K3jEewK+9mWuTdhkLDKkA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 13:29:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VjTzD_Swcbuk8o20tGkkx1EtPF-CT74wZYBnB39-xLUQ@mail.gmail.com>
Message-ID: <CAD=FV=VjTzD_Swcbuk8o20tGkkx1EtPF-CT74wZYBnB39-xLUQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: msm: a6xx: fix gpu failure after system resume
To:     Rob Clark <robdclark@gmail.com>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, Jul 17, 2020 at 1:24 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Jul 17, 2020 at 10:39 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Jul 17, 2020 at 7:46 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > On Fri, Jul 17, 2020 at 08:04:18PM +0530, Akhil P Oommen wrote:
> > > > On targets where GMU is available, GMU takes over the ownership of GX GDSC
> > > > during its initialization. So, move the refcount-get on GX PD before we
> > > > initialize the GMU. This ensures that nobody can collapse the GX GDSC
> > > > once GMU owns the GX GDSC. This patch fixes some GMU OOB errors seen
> > > > during GPU wake up during a system resume.
> > >
> > > > Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > > > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > >
> > > The Signed-off-by needs to be at the end but I think Rob can do that for you.
> >
> > It does?  I've always been told that this is supposed to be roughly a
> > log of what happens.  In that sense you added your SoB before the
> > review/test happened so it should come before.  I know some
> > maintainers seem to do things differently but that seems to be the
> > most common.  In that sense, I think the order that Akhil has is
> > correct.  ...but, obviously, it's up to the maintainer.  ;-)
>
> yeah, I chronological order was my understanding too.. but presumably
> the Reported-by happened before the Signed-of-by (which is how I
> reordered things when applying the patch)

Doh!  Yeah, I somehow read that as Reviewed-by.  Thanks!  :-)

-Doug

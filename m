Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B19C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723022071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow6IQKyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgHaSj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgHaSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:39:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:39:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so3491239plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJN4MJCj6Pjg+uwt4f3ml6KYFLqzh8Jk41iwpyLU3Mw=;
        b=ow6IQKyIJLSJBzYpYXZ3p2h21/2zo0rNu+6BgSyrmsI+fkPkNnxcT2qqDeEMWA3gEJ
         bWdsNeSXqko14vOuPfPN5c/O0as/itCxlhZl/PM8jJIlJrq3eG1JDVEZ2L7dSXFiBiX5
         tehKF4C/NjFYOHKqfekO7WTGk9GcLmpINDZMVerWZXNYmH6DR2UZ/m+N9HVsXdjZj+cx
         7ybAZRXR77kKkbnhQPt0ixU154RY5Mw4QjWxjPinBYdBvIXrklkVRgDcuTFchalWrE/7
         aVRYQ+w9RiUq6exwI8Pq+fLZ3V9GMMKSaL0H+ggLvtNqEG4lAYV5fZk5H/G20QrxQaIO
         VnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJN4MJCj6Pjg+uwt4f3ml6KYFLqzh8Jk41iwpyLU3Mw=;
        b=Z00qg9akI2qnozZDIWvLTdC0yaVU0HFN6QAs4rVGgpvcy9NIHzWpmfRvMiHcGlX3UM
         b0rrEq5B2PLxQvH6OHCYnbInmiNdmUEq+uNUwqKS+MyOF5mZ+uAzGfLbOUnzmxil2o2o
         ckLJE+FEQCf71nRClsD00skaIeOB97q6pakt6FmzAd4MtFwAsDfSUmJjbkqEOdbumPHh
         kzFR/A+5rRmQk0anGsib09SERNmKW+nGf1AWrT9XGPGRmQFL/F0yUkEmYABJsrTeD98C
         pGAGYvi2WRcTgsOiFiVR911GWtO0x/9AlWU60NJb2ULm3wCOfnFtTP+PjJvtdr3CGm4e
         vp+A==
X-Gm-Message-State: AOAM532IGvP4BHWhOeuxTU0bwv+CJct5wwPoPdbpORoNAtOvHTZSvQIK
        AVgQZtgYq1jZCSMZMPDPjFuSI1pl5UjcmUmqvjd4yA==
X-Google-Smtp-Source: ABdhPJx8jmeDuqI3ddtnIQ73j4Oysz/hWduc1h6iUSovGQYoe4WKdkmXDjPKBpZrfy3a2DbH8pbnYy2olWyUgVeJezs=
X-Received: by 2002:a17:90a:fc98:: with SMTP id ci24mr600333pjb.101.1598899165891;
 Mon, 31 Aug 2020 11:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200829153515.3840-1-trix@redhat.com> <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
 <CAKwvOdnn6eMqJsL=aJ8n5dWWoHjXUL0LBSyVwZPGCKpkBSLHXA@mail.gmail.com> <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
In-Reply-To: <5f9c8819-cd0f-6fb9-1b0f-b34f390ae65e@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 11:39:14 -0700
Message-ID: <CAKwvOd=D=LWeSGYekOc9qs_aVOD_jpM2DVZO7=n_2L75Ad3Nxg@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix error handling
To:     Tom Rix <trix@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>, yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:20 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 8/31/20 10:48 AM, Nick Desaulniers wrote:
> > On Mon, Aug 31, 2020 at 10:47 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >> On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
> >>> From: Tom Rix <trix@redhat.com>
> >>>
> >>> clang static analysis flags this problem
> > Also, Tom, please use ./scripts/get_maintainer.pl on your patches to
> > CC our mailing list; clang-built-linux@googlegroups.com.
>
> gcc is still doing the building, so it this appropriate ?
>
> Asking because i have been sed-ing clang-build-linux out.

ah, right, you can use `--use-cc=clang` for analyses of builds with
clang.  It doesn't hurt to include our mailing list, since we'd like
to know if issues get reported with the analyzer itself.
-- 
Thanks,
~Nick Desaulniers

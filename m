Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C1BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9DE20760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHhNRa8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFKHwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgFKHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:52:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF18C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:52:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m21so3227112eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=infCVxRBFq8wcPbhY9NtQOYTjb0b7Xr0kvySKO6/Bf8=;
        b=bHhNRa8JV/1DPjXZSUYmndVbsxCvamN9ht7/kqUeQI0A+5jGWD8l3LqfKkKxlEwZqd
         ojD/p761Q/GqIu6EnaldNC3MExdBcc5E7/WcQIJP/ds7TnfPJYpVXxhTeFPQA8q9Qdfc
         CHI4Flr+Mah6/SJkT3mcqdoqHTneUkr9vmuy6vYu9m4+6Bep2m3a98bbmA29wu7uzjVo
         xNCKDSwktlUs+8YEuKmgFrXo2UEKCcvs9sD3LRvHs9ALPSqcd3dMoYnWgTeocsTI611A
         4eE5VqPcS4Dt6o867TGHKaeqVlaPhLoNOz/QY7uS+TGLbH0zG4t8bt086zzaVW4bft/S
         JqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=infCVxRBFq8wcPbhY9NtQOYTjb0b7Xr0kvySKO6/Bf8=;
        b=t0KUV3bcmigeW0nKuESxr1rth2q+sG7zqYrvS7eFzlmdD0uZ8xzlcWTyJfRDhIcR9P
         yVBRCeu05XwgPP+cOGkNXrvJpujIBVgHDN48UMCooNYJrcjnhcvsYeyDmwpxzO5zm0Mb
         10eZZ9VzePkfgQgF8bQd3ec5gDvFeQkbo2dL7z7SgagREOqyYtvPyJ353iJd3MB2AiTb
         Z/cRdZ/PNWr7lQpY3Tn40M9dPdyonCL1e/+/96HFdimHI46MX/2/E7kmUgXzBxi7sb9J
         fDcOfvsTFZdNGkNHR2m65CBS1qInLhJgI6S4JtYV4ApoXoQl0alVDSh2YjNEJeijNmh8
         0emA==
X-Gm-Message-State: AOAM532jTuiC3ldVqYOt9cdZuqcz2OrWgTYzwRhP6HXny0jD47mTkgmJ
        L6PSP2J1Gfq/o00dBey7eYMmU6wZ3Dq/whyyS4g=
X-Google-Smtp-Source: ABdhPJwnX0YDM2BHMYIRO8m7ItOvNpONSCGfBYPDq6B5P14y7Ybu1YyQaJs1FffHxDvXRGAmSf18qGgGM4zkfI9T/aQ=
X-Received: by 2002:a05:6402:c06:: with SMTP id co6mr5700483edb.298.1591861953758;
 Thu, 11 Jun 2020 00:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
In-Reply-To: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 11 Jun 2020 17:52:22 +1000
Message-ID: <CAPM=9tx_F=dePpDWsmNP4qSCO9mTN37RMYWojdhy7pWswu3WHg@mail.gmail.com>
Subject: Re: [git pull] drm i915 fixes for rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 at 13:56, Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,

Hey actually skip this one in favour of the later one, one of the ast
fixes needs to get into stable as well.

Dave.

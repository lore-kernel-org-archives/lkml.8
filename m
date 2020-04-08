Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFE22078E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="RR3inxHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDHXS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:18:56 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:32938 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgDHXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:18:56 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so8502823ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIQm6fd8XzuEF+zm8pOL7pNaI9rUwGZpiWPVM8H1bSE=;
        b=RR3inxHNUItmUkfN6BIANFJr5kU1yf5GC8vhL8B+NMY7ovOMiXXmaF3Og/C7qSnUzt
         YKfEmLLfMm8RLstk1uRScsR279J+7GPXncEpu3UrO6NEGN+m0bPVlcdRQnQlfOk674qo
         +JMnVpY4lYtYwUq3+rAqxr9kPhTKkH6ROO/jQ1rCh2Wj1r+c4rL3GuT7c0mDqzVYmrCh
         FnbrrIH7DkAcNOlqSwgSm8RQKxoTvpOB2wmA1JoK9zlbRcw0O16NMd68q1pvmuguFjU0
         09wHePpXkryGQ8UZFezGovxC+hWSNPz0dC83e92HLT+RkNsVHc8Z2M8atHdycjYmcqyx
         afbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIQm6fd8XzuEF+zm8pOL7pNaI9rUwGZpiWPVM8H1bSE=;
        b=tOcyICqjOkYHclR/zIRKFNdJeztIdcAMsJY520zKzEEszzlHF+YE/+BqcPX1SZWL1h
         PIXQw+xGy3hFTP8Pe1WlVEFR0BYqJeIHK/w5TA52Cbc+ssuTWhBkMRrVSZ2fh+5HgQuN
         CeR6QmVD23YT/LeNuoCzmtiC8ZuoNnKnTjFJ36t5FBdBCGxuAmCRex0ab6Ya5pjvdh39
         SxF1dGBnDCeMtHQHERyZZuAhkk8TAY3ZmD7MwKt2U+S3Crmd8K8N20RyAbcOmhJXbFcG
         fpEYMmbY6VN+OLPISZzueHqvhk4BDhvCy1NbRkWAEzaXc9JINc92PyWX7eOYsefHbkfK
         Mkmg==
X-Gm-Message-State: AGi0Pubw1hOoAjEVSmrhl1NbdoyRiJBPjIRngM6BQ4JhgmerWPJ5dT4E
        Q8MmU6X12Li18vRzlM/l0fuh3cVIn/s2eHbAHOGeCA==
X-Google-Smtp-Source: APiQypKEwbFd6R9kEli2dzEGIji7GKMCjLR71i+SQ8NDaynvVQfLOCGvH4kxXequfugwVmVUaRoYsPr0x4OsopRMnPk=
X-Received: by 2002:a92:5e14:: with SMTP id s20mr10401973ilb.210.1586387935478;
 Wed, 08 Apr 2020 16:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200408133735.7679-1-mail@aurabindo.in> <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
In-Reply-To: <bfa1a07f6f2046d5edac80d282cc710328d84d72.camel@perches.com>
From:   Aurabindo Pillai <mail@aurabindo.in>
Date:   Wed, 8 Apr 2020 19:18:44 -0400
Message-ID: <CAMu4TMv5DuAW3WtDOFx2xoQc_EYURZjnF722QA9mMCdUFGkBBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add prefix for pr_* prints
To:     Joe Perches <joe@perches.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Apr 8, 2020 at 11:37 AM Joe Perches <joe@perches.com> wrote:
>
> All the embedded uses of "amdgpu:" in logging
> messages should also be deleted.
>
> $ git grep -P '(?:dev_|pr_).*"amdgpu:' drivers/gpu/drm/amd/amdgpu/
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PT BOs\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:               pr_err("amdgpu: failed to validate PD\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:                       pr_err("amdgpu: failed to kmap PD, ret=%d\n", ret);
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched on\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:             pr_info("amdgpu: switched off\n");
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:                        dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:          dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:          pr_warn("amdgpu: No suitable DMA available\n");
>
>
>

Thanks for the heads up, I shall submit another set with those changes
you suggested.

-- 

Thanks and Regards,

Aurabindo J Pillai
https://aurabindo.in

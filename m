Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC698C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5d/i0E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgAQUsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:48:11 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38251 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:48:11 -0500
Received: by mail-vk1-f196.google.com with SMTP id d17so7015444vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kvYoN4fXranoTX+Qa5a0sJ3/lj3Hn7yx+pDCue4/XE=;
        b=k5d/i0E8CkSojnVTZut2knWfj21OwOXmdo8M42Tg7VctwZXbTz4V/giKwj5QPWrtND
         5lOgNmPuGjz/W9R+Rgl1Ed1GeyFLknOE8yyOucUTpUTfCFTa0Ej0N3Uu52sgf5B5uFF0
         LKSmm921h73ejQAO7KNBMDsqVHZBI0Bgkn5e82q3JZPCa2904XduX8eOA3UXQ0o0Iolz
         fwNhnpiaNL2MTEsqW9Pq05ZTmOEeKXEHpihRitgcsMhci1bd9WdzZmsBhwW198PAtMU1
         dGgPKK4Ac2bpqOVnmEAMbh+abS13iZ5jFWrhOzktZdlFDOombq44J05cjnUbE/RgQpz1
         6D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kvYoN4fXranoTX+Qa5a0sJ3/lj3Hn7yx+pDCue4/XE=;
        b=mlc41L1v8SuqixZt7QtlpYmY5PUebUGwqkUTYgGt3twcwDApJ0P4+NjRH005E2br6a
         ltWbWIqOcygYhkgdX0vjazk+JlCwWjQJlyZ+RKonTwzL2rHN0CCm1U5RwCLPloiaXv2q
         nfFmBt+TlG6YwYNdxvI21KfyPfP2OAi8Xt2x5FGmiBuepVxpbLhc1ft7664Pq9/q6Gmw
         XgsubhluYEiez9efqOPN53uWc7ToopsCjvou6ndX4rlI4Lx6h8xFRY6KC8GI3IeScTfd
         ZAyWCGY6QP69+8tMsC+yW2pbPstEBWaDXYydzjDVj4L1HLMZOZ9rTpB3LldFdlJm2ojA
         S4Yg==
X-Gm-Message-State: APjAAAXrO5VmKIokxSeiVHQn+2qenh3zc0X0uCiTGcX9X1m8aqE1qSyO
        Q7TUsHYz34olP5eCvTAPu6idx5Es3WB4bACiXyUX4g==
X-Google-Smtp-Source: APXvYqz+kmGzGuNvOvVxhPATYhmcnsL6GJHTgKQ9ubRXxPOlN1Q7ZFiZ1Z8r9MVbFsMAsMjwDFzboW2Vqzv8b8zV5ew=
X-Received: by 2002:a1f:5e54:: with SMTP id s81mr25168776vkb.78.1579294090074;
 Fri, 17 Jan 2020 12:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20200115205649.12971-1-brian@brkho.com>
In-Reply-To: <20200115205649.12971-1-brian@brkho.com>
From:   Kristian Kristensen <hoegsberg@google.com>
Date:   Fri, 17 Jan 2020 12:47:58 -0800
Message-ID: <CAOPc6T=bfEt3=VbzAQGtFi01oDgcxgrZLkMb4QWO1WWEou3_Ww@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/msm: Add the MSM_WAIT_IOVA ioctl
To:     Brian Ho <brian@brkho.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        hoegsberg <hoegsberg@chromium.org>,
        Rob Clark <robdclark@chromium.org>, jcrouse@codeaurora.org,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:57 PM Brian Ho <brian@brkho.com> wrote:
>
> This patch set implements the MSM_WAIT_IOVA ioctl which lets
> userspace sleep until the value at a given iova reaches a certain
> condition. This is needed in turnip to implement the
> VK_QUERY_RESULT_WAIT_BIT flag for vkGetQueryPoolResults.
>
> First, we add a GPU-wide wait queue that is signaled on all IRQs.
> We can then wait on this wait queue inside MSM_WAIT_IOVA until the
> condition is met.
>
> The corresponding merge request in mesa can be found at:
> https://gitlab.freedesktop.org/mesa/mesa/merge_requests/3279
>
> Changes in v2:
>     * Updated cleanup logic on error
>     * Added a mask
>     * 32 bit values by default

For the series:

Reviewed-by: Kristian H. Kristensen <hoegsberg@google.com>

> Brian Ho (2):
>   drm/msm: Add a GPU-wide wait queue
>   drm/msm: Add MSM_WAIT_IOVA ioctl
>
>  drivers/gpu/drm/msm/msm_drv.c | 61 +++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/msm_gpu.c |  4 +++
>  drivers/gpu/drm/msm/msm_gpu.h |  3 ++
>  include/uapi/drm/msm_drm.h    | 14 ++++++++
>  4 files changed, 80 insertions(+), 2 deletions(-)
>
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>

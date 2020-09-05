Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8736C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6543F2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukx6fPK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgIENYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgIENYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:24:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6609C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:24:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so5764929pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MIB+UBZFOOBgK1ZZjQbbWacd4uOacu/apLAxUjh2HeY=;
        b=ukx6fPK6xJPjw0J89aFeu8RRL6gfR6rHg+4xp8CcdqYuVnK/v17V1ceAdDaCUz3STy
         KJMyyaYjW355ntF0pUY7cSyxVrXjLQ5D9tSv/ZACDEVk6xfMpLiPqbQGyWu8FN50E5SG
         LvrUT1q4A1x60bn8qfBSi2NOP03cziylYa6MapilxsB+gbok76401hfxNcU6ppkHSvW9
         2NSbWrxM3ecanWm8LWoM7AgRrMQyqi0tQzPZnc2kHHEzjhrbLm0HlsKAW1xCUrvE+yX0
         w2/Vh1dVlhH019fuHq7HnDJkiUSB1S4BS/SyP4XX1bGo8oQ8qXZEgocNnbWpuMLj6r/b
         E0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIB+UBZFOOBgK1ZZjQbbWacd4uOacu/apLAxUjh2HeY=;
        b=ryzjJa6EjipoyMaCj0AaOleNLROmCgdqIiWGU4Y+RVTz8POKq//DspyFXud3XlRoxi
         OIHWw/uvXiR/61UAWjaI+LXeX1ATVv3lcsGLLytNCdBwwJ+EHWHaCFcR4rtCvoBMXA4t
         8/ighAb+T2XCdYYay7W3AAPoErSKQ88ZDacr9BqgfnGvHyBEcZPYVPgFcWuq1GZPaUsu
         vGLYD+PK7bgBrsb94ekQbgMorhIB9z2Fp3SlJHcJg3eCZosEU8+3rmbQgftPf7RSZsV4
         bCZdULb+MpEWVtPjiC2bqNB43BlJuGKcL4wVBEx2g9U2b7iqtfQRGr48cNK8bHU6YojM
         z4EA==
X-Gm-Message-State: AOAM530IDh/aSFfDWg/wGRNaFZnios+tiVRIa6axkazJEO2TDHsS/O5z
        NihfzusDAeHiJr9E0R0IkDOBcqQuzDs=
X-Google-Smtp-Source: ABdhPJxm26tumvGuDf6XfdE/HIS+KKTTjeeUkaj4Wwxqa0m9GZ8gz5fK8BLGtrL6WzcvPh4nqnX9RQ==
X-Received: by 2002:a63:1f42:: with SMTP id q2mr10579931pgm.265.1599312247938;
        Sat, 05 Sep 2020 06:24:07 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id o30sm8734945pgc.45.2020.09.05.06.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:24:07 -0700 (PDT)
Date:   Sat, 5 Sep 2020 22:24:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] OpenRISC fixes for 5.9
Message-ID: <20200905132405.GG3562056@lianli.shorne-pla.net>
References: <20200905131935.972386-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905131935.972386-1-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:19:32PM +0900, Stafford Horne wrote:
> Changes since v1:
> 
>  - Now a series, v1 was only the "Reserve memblock for initrd" patch
>  - Added fixes for compiler issues pointed out by the kbuild robot
Forgot to mention:
  - Updated "Reserve memblock for initrd", as per Mike's comments

> This is a few fixes found during testing 5.9.
> 
> Stafford Horne (3):
>   openrisc: Reserve memblock for initrd
>   openrisc: Fix cache API compile issue when not inlining
>   openrisc: Fix issue with get_user for 64-bit values
> 
>  arch/openrisc/include/asm/uaccess.h | 16 ++++++++--------
>  arch/openrisc/kernel/setup.c        | 10 ++++++++++
>  arch/openrisc/mm/cache.c            |  2 +-
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2
> 

Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C7C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F48C206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+5xeZhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgELN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:59:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:59:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l12so6185998pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/rSnXf/LR2mEg6YBHE96iKMOvPT6rw9BrJsNQPuqh+I=;
        b=G+5xeZhp79EgQEfRC9B4mRED7ZcB4fv3ORF2m5YjrWT3/S6x8H6qYt9BnXCNyUmmSy
         AX1Im/G5JxV87HD1/1Pg5cJ8zIAx5F2ZGksW/fuhZL+H5Ht+jNLbKOv2ZBPywRtyMqxw
         grOaa6Qz15snhJAWd4a5gSqNyjCydNDwWmkcPTm2ICselBSGwYa929/D326T12lyHHiC
         XNlHB8NL5PwdkVpa+EIowRf0hHNgTPRwoCqRQmncRbiOQVakZkdS5ykXretlVymSd3cY
         0IwQ6NEL+VvymgiLExSfF+O6jfCvaQsbilc8XnCdvL5vTFDOZ9oYmGu9yjmB177QYWqh
         cPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/rSnXf/LR2mEg6YBHE96iKMOvPT6rw9BrJsNQPuqh+I=;
        b=ebpHS/Wl8qezq1c92VPSINUoYF02XtMT/hIBTFB4eS3lcgMR5kcqLLsYSgaBkrsDOm
         02S4QaZRs4/NQ0d3sclNTVi3FV/hdI1ABEhmavY29PO3W3aCbcYXrqVjXmvmj9mZGTPg
         Bh+pd/2LaXKotHB1UJWxt4FUyjMBi1FXNW+4EgiwIyoRRwJhyKOxKEgYxhaqAGa5RqhB
         ueNBkkTQge6ujKAFQOJZYkUVNJi8lCvZ3y7J/X24Hxs7YlS9xodvSKojtHgqJFgvGdFb
         LIY0HsIUx2Sw5cdeOsSRfu1P1/Z35CaC741yTNUl28HwuI6KLmg+oFbhzJHfn59YCX2T
         KM9A==
X-Gm-Message-State: AOAM533mUlQHglr/pQBtd9h4EhgU4nc5/3HS4xTaKXsykOS+KSpZM8ai
        lmZwwcibT0FImhWSwsKqe/srRQ==
X-Google-Smtp-Source: ABdhPJymlc4g8AwytnuWMBdPjQzNPQw9vQwsIPI1BvYOSYxy4P8yAcJCciDAB/7ihk/wxDV9wyzBsw==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr3404268pfl.116.1589291948432;
        Tue, 12 May 2020 06:59:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l3sm2177892pju.38.2020.05.12.06.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 06:59:07 -0700 (PDT)
Date:   Tue, 12 May 2020 21:59:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, sandipan@linux.ibm.com, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf powerpc: Don't ignore sym-handling.c file
Message-ID: <20200512135910.GB20352@leoy-ThinkPad-X240s>
References: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509112113.174745-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:51:13PM +0530, Ravi Bangoria wrote:
> Commit 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> removed powerpc specific sym-handling.c file from Build. This wasn't
> caught by build CI because all functions in this file are declared
> as __weak in common code. Fix it.
> 
> Fixes: 7eec00a74720 ("perf symbols: Consolidate symbol fixup issue")
> Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/Build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index e5c9504f8586..e86e210bf514 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -2,6 +2,7 @@ perf-y += header.o
>  perf-y += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
> +perf-y += sym-handling.o

My bad, thanks for fixing.  FWIW:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_DWARF) += skip-callchain-idx.o
> -- 
> 2.21.1
> 

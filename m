Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7FA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MpLAr6Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbgG1St6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgG1St5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:49:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C712C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:49:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so369789pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TaFsAVS0lZBW1E0K1tJXZw+X9y9cUqIZOaViTh1v9Co=;
        b=MpLAr6SeWtwR4OcpgIILP/A5hI3CfCLGNwNMziorMDAK4dN1Apnl5tsYKGjrPFdGbI
         1TV987WZwJLg+gnsZBxQ46a8/7uNLnITCm+1xdsYUZ3xkZHZV1c/Wrbz0gXmlCPqQtRd
         /xn4hPaYnRKvLMF1Pz/NiIay42ZH0xqcJ/kSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TaFsAVS0lZBW1E0K1tJXZw+X9y9cUqIZOaViTh1v9Co=;
        b=THsaxRIG1R2y9o5gRnWlG4bpiCe69go99hayC+cqkgl7j9jHO3WYORR2CbAmOiJ5c/
         LOrbeqW5YQn4jiMA6zivv2wORmxaqihs1mTUaCAUU5032wh4FvOS+SWm+t8cp1jylylA
         Ur+V2JEYBF0poohXPr3HFPHf/Hgl54VUuHhCHiW9yczcrtetrNnDOaE3Cc1Bh7d1uDlF
         gP984p8aVA3JnvA3TjFSlJCuazn8t0XwX9VWMTb4QGpIgSNpnBM50rsVf5B2UkuPC5sO
         rTePqm/yenhwr4HzoeYN0acde4Fhl3l43IWjKhDJOwUTgPfJvmWceCJiPpz9ZXD87TcT
         0GWQ==
X-Gm-Message-State: AOAM532A97+Wi3hJ4Um9fwDT/4qeWNboKkzQiRBXTqba7aa/GruCPrxE
        9nQxogaOGCusrJTfV2picJp2XzbcrTI=
X-Google-Smtp-Source: ABdhPJzFPzIBq5GyMsMG9TplCJvhPWP413+ahfV1CeFYBM3hnMet6MM2PCqYZO2b+KHfq9C+SbX67Q==
X-Received: by 2002:a17:90b:138a:: with SMTP id hr10mr5633535pjb.161.1595962197185;
        Tue, 28 Jul 2020 11:49:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24sm1377812pfg.113.2020.07.28.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 11:49:56 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:49:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] x86/kaslr: Initialize mem_limit to the real
 maximum address
Message-ID: <202007281133.739AAFD2AF@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-5-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:57PM -0400, Arvind Sankar wrote:
> On 64-bit, the kernel must be placed below MAXMEM (64TiB with 4-level
> paging or 4PiB with 5-level paging). This is currently not enforced by
> KASLR, which thus implicitly relies on physical memory being limited to
> less than 64TiB.
> 
> On 32-bit, the limit is KERNEL_IMAGE_SIZE (512MiB). This is enforced by
> special checks in __process_mem_region.
> 
> Initialize mem_limit to the maximum (depending on architecture), instead
> of ULLONG_MAX, and make sure the command-line arguments can only
> decrease it. This makes the enforcement explicit on 64-bit, and
> eliminates the 32-bit specific checks to keep the kernel below 512M.
> 
> Check upfront to make sure the minimum address is below the limit before
> doing any work.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

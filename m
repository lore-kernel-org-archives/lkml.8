Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E53C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0270C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CohcHiDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgG1S1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgG1S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:27:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D10C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:27:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so1383459pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXZG8BYjPil19llmJAZPbDGrivY4sl2bmMKwQ2+Gh5E=;
        b=CohcHiDjJevVL3xTskTg8UI/7ACymEi0XnGBqWgyAIVYZQnk4hvgWyJCymlDwSor41
         x4ier7vzVCcGTyX6rJLNjK7mI5gPb0b3+4+kElVEMaYIrCvs7GLB/RaJ+x39nC3ZB9yi
         Ff4oH3xaxJyK1I5ymnSdzMFXHosRqYRP/mxjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXZG8BYjPil19llmJAZPbDGrivY4sl2bmMKwQ2+Gh5E=;
        b=cLKFlbqC0V7WzuMdmtaDLqfiAzVnxQBTMNF4Rx2I7WBhddRH2DiZfXzyVAGLbfbsaH
         6ZQqUWBscPiFdTGuIfDMs5McjRkS/njCzTbK1kTeUV9ADB9QPuLsxdwtckPlwunY4j8g
         bu0kKwrqgyO1oh2Y+jOalzC9RO/Y4j1DTxiQwqK9MC0EhKb3K1PtBhzoNsm7AIlTcCyE
         jkYqvqXmFBY3bU54kclmXTD6RBCCn+8uS/ypEuC9CQidTVOMKm7yb5v5mWj0e5hwgMts
         HbCbE3lxM4KMzjYT9vdP7vG4tZxyYg95REmLZ9Km6vYm5eEhQqEbsYznLGryfr1Rafah
         GywA==
X-Gm-Message-State: AOAM533ICibmV8KR5ebpZd+573cC/nlStA5xngd/xM3IPBX8sX6uhOTG
        wPK67kMvYQ9gRcF4Zk9h5ccrVA==
X-Google-Smtp-Source: ABdhPJyoEyDAAVOhd2IimeOEfN3i+Sp+hkHDjvzOUSLChfMH0zbvyIMvK3ntRhgaACY6MIAtawuarg==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr25103003pgh.285.1595960849137;
        Tue, 28 Jul 2020 11:27:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e137sm2475286pfh.7.2020.07.28.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 11:27:28 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:27:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] x86/kaslr: Fix process_efi_entries comment
Message-ID: <202007281127.D3E4F41C@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-4-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:56PM -0400, Arvind Sankar wrote:
> Since commit
>   0982adc74673 ("x86/boot/KASLR: Work around firmware bugs by excluding EFI_BOOT_SERVICES_* and EFI_LOADER_* from KASLR's choice")
> process_efi_entries will return true if we have an EFI memmap, not just
> if it contained EFI_MEMORY_MORE_RELIABLE regions.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

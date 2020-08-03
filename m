Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C946422B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6QLhlkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHCRpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:45:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:45:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z20so420106plo.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VKCoo7Vmd7+mSWuTkGx9LAevVUhaDOReRxys5hawyY=;
        b=g6QLhlkTh78wPq19hgd3aCUUx0Imw7hHpDpHRoUNeo8fIu9NRFI4aUriW0Z9BZniQG
         YzPHxc2H1xDFqOxe+EWig27ebzxgINQXziK4Nb917fzY4xDxIZ66ACPlaTcIxxII7O3R
         WglKCd8y5damXG5BfnBTutACt6Bn2FSIsAjWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VKCoo7Vmd7+mSWuTkGx9LAevVUhaDOReRxys5hawyY=;
        b=DDzrdoYzeP6UdWWE/Hd7CA5pkRpjk3zxvwH+nJglOtPz2lUEgocBnUqC0pRatpdw+/
         Gm/tbpWNtoPd7chHfQwVWilGR8K+VLkIGjIYZJsIrBe90CXJ3ZRdSVkpqvEogOdtx9Ue
         BWL1dvcC+pXt6+ilolxhWH87imLe7wQweAzEgN4kDm78nW8JUeKPjPjW4mDa8spd+2aD
         5ly73EegcEX0r+SJlmKOV3jCqH96YnbI1vapDxSNKkoX3OwOR81NpnYmJePtBtaRhc8j
         hN1hyEds2Scb44pq+rJhRmT8vhhLUSF3njoSLUDr4Gz/fRfLFsb3UBGYMF1cuY91du+y
         CkTg==
X-Gm-Message-State: AOAM533MVWEvnEqXxCEGutwhJiuRzW4SRSrISYB3mf+FvNc6Zkp9z+YC
        HRSDVpGs0sQrG9YZfrdi4NMKFw==
X-Google-Smtp-Source: ABdhPJzGj8xXq4IjYCLnxux+Nc8xy7BtserkIGiDWL6WvrAEGhBWNwOQEcukf/40EE3PYPMrIuBRGw==
X-Received: by 2002:a17:90a:ca85:: with SMTP id y5mr430416pjt.87.1596476737437;
        Mon, 03 Aug 2020 10:45:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4sm21161622pfd.92.2020.08.03.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:45:36 -0700 (PDT)
Date:   Mon, 3 Aug 2020 10:45:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        live-patching@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202008031043.FE182E9@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
 <e9c4d88b-86db-47e9-4299-3fac45a7e3fd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c4d88b-86db-47e9-4299-3fac45a7e3fd@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:39:32PM +0300, Evgenii Shatokhin wrote:
> There are at least 2 places where high-order memory allocations might happen
> during module loading. Such allocations may fail if memory is fragmented,
> while physically contiguous memory areas are not really needed there. I
> suggest to switch to kvmalloc/kvfree there.

While this does seem to be the right solution for the extant problem, I
do want to take a moment and ask if the function sections need to be
exposed at all? What tools use this information, and do they just want
to see the bounds of the code region? (i.e. the start/end of all the
.text* sections) Perhaps .text.* could be excluded from the sysfs
section list?

-- 
Kees Cook

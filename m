Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD39C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63BA207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFSTO+U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgEVDB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:01:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE21C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:01:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so4297497pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11dG9PEoV3wf+UvltnJpE6YCCFo+AkuBxx0Uh1epyW8=;
        b=mFSTO+U1AdIXstE4FPu4IrX9krnbPJI1UwEd/NFyHQEkjp0NWzPjPYMF+bJUa/DdQE
         Y9oenRABP+tyS0RQg/M+SBckFv+C8AM/gT9vwTj5E59CLzW4B0emNS4yz3c5R7gLEJ19
         f9snByrZJlD04TkBLOe+sGplhsPTzhM8aMtw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11dG9PEoV3wf+UvltnJpE6YCCFo+AkuBxx0Uh1epyW8=;
        b=ennbGz/O3bcChjQQJK4HsB5z4AlWpPMej9KEfgLZzlyfWaN7JV4qVaYwdIIXkQ1NeV
         ecH8+0nyUby79l0GtKhnB1YFIrcgPrE0KdhmYvdtPq/WA/24akKOK8rVgniR++KiZTbX
         7XO3U9KxR8zPZZbw3T3ajdLbZzxVVCp0PiqZLvBQLkF/Fw60y13mQMmX3QWoS3AmHWRv
         qL6UB79pSnyXPCL2SWghxeAfq3vFu4/tSFuVsio3K1pSavjX6FTFb8jdGmqL5WP2s7lb
         OgvDAQFlKBUlxoLOnxHVtPotx8jOwdTHLx84jyOz5K3dEHlDZmM9G0UMFLQDb2Otb6Wx
         +/tA==
X-Gm-Message-State: AOAM5307yGdWNt9pFzxco56FngM4zYCN2Qh8HuvfefA1y2uCFXgQXAJr
        aAUwrn8EvrjxA7slUOWNNgwApQ==
X-Google-Smtp-Source: ABdhPJx1U5V5Jfl/NgxmZJ7wtt8+x1uXW6sBJMURJZobe+S6nyjAMFyIFihw3HhmWAk18QXkuf6chA==
X-Received: by 2002:aa7:9532:: with SMTP id c18mr1800933pfp.255.1590116515654;
        Thu, 21 May 2020 20:01:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n23sm5151785pjq.18.2020.05.21.20.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 20:01:54 -0700 (PDT)
Date:   Thu, 21 May 2020 20:01:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <202005211950.D56130B81@keescook>
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> The typical usage of unmap_mapping_range() is part of
> truncate_pagecache() to punch a hole in a file, but in this case the
> implementation is only doing the "first half" of a hole punch. Namely it
> is just evacuating current established mappings of the "hole", and it
> relies on the fact that /dev/mem establishes mappings in terms of
> absolute physical address offsets. Once existing mmap users are
> invalidated they can attempt to re-establish the mapping, or attempt to
> continue issuing read(2) / write(2) to the invalidated extent, but they
> will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> block those subsequent accesses.

Nice!

Reviewed-by: Kees Cook <keescook@chromium.org>

And a thread hijack...   ;)

I think this is very close to providing a way to solve another issue
I've had with /dev/mem, which is to zero the view of the first 1MB of
/dev/mem via mmap. I only fixed the read/write accesses:
a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads")
I.e. the low 1MB range should be considered allowed, but any reads will see
zeros.

> +	unmap_mapping_range(inode->i_mapping, res->start, resource_size(res), 1);

Is unmap_mapping_range() sufficient for this? Would it need to happen
once during open_port() or something more special during mmap_mem()?

-- 
Kees Cook

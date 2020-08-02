Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB762076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="TGrwu8PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHBVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHBVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:07:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1CC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 14:07:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i19so19422095lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Br9WBHvsc6w7gfIRxLUPjWIrrFDRQfIjkhX5MpKC26I=;
        b=TGrwu8PFTt5ADvHUupXm43txcdcj/MOTw3/GG2N+j55vWLHExqdPSEiBM6m/9/qeqq
         iMu1Po+7/ghlQCw4RyC+FrQDs+PfS+FuMeSY82MkpANZ2pbi6mJlz+3lGrDhunt5fd6y
         XIi6GaGbSy3jb66H7E/DK2GOnjUZjZPkx5Aj/5ukL+Cb2OnLmPVU9EQUTDr+qzKpuxnN
         nmjfXsO9R6r+JlHblMLt0qmwH3W9UOmEE6/ZeLpt9PJXIWzGNTZP96Vk48y3MQWLEfro
         eQ0Z8kQA8f99wIG8rdUvGAZg+6kDLtVeEctGPAqo2NCqeXcWF7ocxCn+eLVMnR/6ROOG
         K1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Br9WBHvsc6w7gfIRxLUPjWIrrFDRQfIjkhX5MpKC26I=;
        b=e+vCxbVUcMHWzx5bVbt16EiBsovZO1Pg9BQCaS9NzF7WZf5BOcalMpqRJJltYFHJ0A
         qDuaqS9s7c1Um/1CfWREZw1ScQg1WMqTc7JVbKod9oP7L+faLyaByz2YOxGIhcOgFnFn
         dI7WxcgN4rrugSjMPnCNJXm5IpX4J7n2x7y93ZEIGD/okBVm5JnLjGNBUJ5R++A/a12q
         J8aicUZXsiZBpFvY3Wo8qvJPDubpktUOiR4bYtGx2nOU0BUcJ1eWw+OuRq01tXUrC0Kk
         eT1gFgCxrS5x2AXdA8Pvh+d8Spcf4JHBNJcyUN491DNnm8RQ7c1pqjtzYa1JXE4lbqUd
         8tKw==
X-Gm-Message-State: AOAM533FhcCqtN7ETCfwCR6LuN1NNRL8R709D97gGAE3+xLq8YyvFQ1x
        y6YhJLad0bljaous3aEcAIp+rg==
X-Google-Smtp-Source: ABdhPJyqItrUYT8TuY7fCMbpiw2SHaP3eeKiZrf7fDwwCxf0wqJ0jbCS162jxBlV8JVQF+gb8ElfzQ==
X-Received: by 2002:a19:228a:: with SMTP id i132mr6800287lfi.178.1596402452874;
        Sun, 02 Aug 2020 14:07:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u5sm3944730lfr.3.2020.08.02.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:07:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C63CE102BA1; Mon,  3 Aug 2020 00:07:38 +0300 (+03)
Date:   Mon, 3 Aug 2020 00:07:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] khugepaged: collapse_pte_mapped_thp() flush the right
 range
Message-ID: <20200802210738.i4trrpq5b77yaxzw@box>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 12:12:42PM -0700, Hugh Dickins wrote:
> pmdp_collapse_flush() should be given the start address at which the huge
> page is mapped, haddr: it was given addr, which at that point has been
> used as a local variable, incremented to the end address of the extent.
> 
> Found by source inspection while chasing a hugepage locking bug, which
> I then could not explain by this. At first I thought this was very bad;
> then saw that all of the page translations that were not flushed would
> actually still point to the right pages afterwards, so harmless; then
> realized that I know nothing of how different architectures and models
> cache intermediate paging structures, so maybe it matters after all -
> particularly since the page table concerned is immediately freed.
> 
> Much easier to fix than to think about.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.4+

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

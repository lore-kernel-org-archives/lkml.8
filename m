Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E85FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C3E2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="yIM6IlRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbgDCO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:26:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39888 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:26:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id h6so5963186lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OAww5f2PQSKNiKQxC6Q2b34/fMVZhJRuAf3EIGrKKDw=;
        b=yIM6IlRDpjUTxRN2ABwudgNvuXxV8ur0voMSFh49m24e5bS6b4hFdSM516ZyJeeg7H
         evkNzojnT9xnH24E7aWSxFIGep7Mxg3TEY4Htir7orYaNW5jyC3eUIRqZj/W+B3arjbw
         xTgCfttLJJaQAoMywHk3e/+3c10sxIJ/afKuG9bo2GoOwnTZoT63AKJeFyDWbOidAe7s
         qe0bNXp0f0QGwCMIpoQ+CoI2UFFvDRgtMViWBHq9ja9XQ2ORyhmOVPf2YJykbLpS78tC
         cfI0A+e2NJKmpYd9abFAJijRNaGIzxU5hMERjQrG5qgodSE4niyNz65lm1Msisqdhfx/
         ggoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAww5f2PQSKNiKQxC6Q2b34/fMVZhJRuAf3EIGrKKDw=;
        b=Y4JBgngFoSAKpEH0Om5iiolUG56voi0cGYGDthGHkTZZ1mhesOxwDWKivNeeK0W8XT
         zklZg+DMIAE+NqxEZ4MgPDMYxDsHgcnVYIbrPv7ebJmFHsol5KMT8sSK2vnEqSBNX1EN
         rOcP0zZdJtiGtMPE2qg+6OSSHYvHcZRDOHUKAxEr8AZQ6JhxItHlOQPd7lGtiozBB8HT
         me47cxruYq90Wo31uuhbOYxhW0302LJiRdn2UWz+fLsQJ/MRqJ4+iJ+59XM1ARlwE4dQ
         sd4CUiulcTEUjxdvCe0idzDytsFNcTGbAAlEzPVRrzHFRA9Db+cXfy9tf1n8av08ND6j
         Aujw==
X-Gm-Message-State: AGi0PubkWg7GzMrvKPJSUhV3mO12fjW8gWYZ1FXJ81GrtPI6pUF7bcaK
        fu7LOj+1yOHB7CPaKyXKdgkHUA==
X-Google-Smtp-Source: APiQypLJ9JloMpkY5sh8QUo1w9ptYVtRAzL1TavE8LmnGcuFFnwdH2rsswsjalOTbmn+uCUby9oGrA==
X-Received: by 2002:a05:6512:3115:: with SMTP id n21mr5687418lfb.51.1585923982850;
        Fri, 03 Apr 2020 07:26:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f9sm5200343ljp.88.2020.04.03.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:26:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 894F3100F13; Fri,  3 Apr 2020 17:26:21 +0300 (+03)
Date:   Fri, 3 Apr 2020 17:26:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V3] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200403142621.o6yqrdfdmqkagvif@box>
References: <20200403123059.1846960-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403123059.1846960-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:30:59PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> To test the patch, we run pmbench to eat 400 MB memory in background, then run
> /usr/bin/migratepages and `cat /proc/PID/smaps` every second.  The issue as
> follows can be reproduced within 60 seconds.
> 
> Before the patch, for the fully populated 400 MB anonymous VMA, some THP pages
> under migration may be lost as below.
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              407552 kB
> Pss:              407552 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    407552 kB
> Referenced:       301056 kB
> Anonymous:        407552 kB
> LazyFree:              0 kB
> AnonHugePages:    405504 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> After the patch, it will be always,
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              409600 kB
> Pss:              409600 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    409600 kB
> Referenced:       294912 kB
> Anonymous:        409600 kB
> LazyFree:              0 kB
> AnonHugePages:    407552 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

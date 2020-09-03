Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E53C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F01206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kyWZd6uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgICNTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgICMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:54:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DC8C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:54:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m5so935685lfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=onLl8rTDQyvNpKgJJE9dFmq94UrkQmRn/zbTPNdul+w=;
        b=kyWZd6uSWtnkPJPjNC9/5GmYksI/3zvd739yEGMNVYRRPQ+obtq6kc0P1lySF1wLna
         /9pVxkncaXRcO2tuJq3pvnexLY4/WEYs6tUJiejalUKE87aVDxTtE8HGZioi56/HtvGW
         yphbM/vIdOQS1E8H5tT9vqdWIBrlZSJthYKw99V3Br+Jb4Wy1/Z14Ngc4JlLjaNb+iBN
         xdzS5/4L9tad8h/PIo9T2VsXCmgBMNtPZPjyG+MR2avtJUVy/CwEcgRJqvxxJyZ5cc+b
         kVEFsNzOzEK2uw81sjvtX00wvqAEmpeahxzGvmJf2FDEtGdxJK92HT48bXtJyIME/kON
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onLl8rTDQyvNpKgJJE9dFmq94UrkQmRn/zbTPNdul+w=;
        b=uavog567IatFqpcP/oXG3VYq8YXiNYAypEBZb6X44YQrizrWeah7+MIHL8on2In4aC
         c9Athof+pJzdvn/T/1GyChYRjIGcYiLqO5Rk02DNE4Xq+XtDreD3LHNAtPtFPedRag2y
         Jvcu6DpX8k9rKtLUF3UwPC2mXSwGFazOi1hhOQkT0GA/xNIFB24rF8VZcuiyffqES4s1
         t8HZBDF6u5DSoVo8jLO5WJ94N812L2bCmhDEr+7JZteuy1+KTEjCrdwAWMCYzhprRjEe
         1nwCMg9fyIXMx5hZzBP3An8RuxQ5c5kuny6USejp1wRdzTGYtKBLSrX6NsAWPGXe8J78
         xLDQ==
X-Gm-Message-State: AOAM531ipbrGAwbaEZ+cMimhYFy2ZpNdXrWIqkTbOUThPJerexpgcsnf
        wa0ZcgdaDIHCKDbYZRW6JQkw0g==
X-Google-Smtp-Source: ABdhPJxLwRZ25xqjpghlAiLuT8OszHqy2R0uqqhz3VeP7cshAVmBhDNDZKmnWNKpKHq5Fjz6I8h+WA==
X-Received: by 2002:a19:40c8:: with SMTP id n191mr1267052lfa.29.1599137681414;
        Thu, 03 Sep 2020 05:54:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l16sm595692ljb.72.2020.09.03.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 05:54:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 321BC102212; Thu,  3 Sep 2020 15:54:42 +0300 (+03)
Date:   Thu, 3 Sep 2020 15:54:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/7] mm/thp: fix __split_huge_pmd_locked() for
 migration PMD
Message-ID: <20200903125442.4no5dq7mzcdllery@box>
References: <20200902165830.5367-1-rcampbell@nvidia.com>
 <20200902165830.5367-2-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902165830.5367-2-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:58:24AM -0700, Ralph Campbell wrote:
> A migrating transparent huge page has to already be unmapped. Otherwise,
> the page could be modified while it is being copied to a new page and
> data could be lost. The function __split_huge_pmd() checks for a PMD
> migration entry before calling __split_huge_pmd_locked() leading one to
> think that __split_huge_pmd_locked() can handle splitting a migrating PMD.
> However, the code always increments the page->_mapcount and adjusts the
> memory control group accounting assuming the page is mapped.
> Also, if the PMD entry is a migration PMD entry, the call to
> is_huge_zero_pmd(*pmd) is incorrect because it calls pmd_pfn(pmd) instead
> of migration_entry_to_pfn(pmd_to_swp_entry(pmd)).
> Fix these problems by checking for a PMD migration entry.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Hm. Could you remind me what codepath splits migration PMD? Maybe it
should wait until migration is complete? We could avoid a lot of
complexity this way.

-- 
 Kirill A. Shutemov

Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D4C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E331206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="K4vLOeea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:12:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42703 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgBTNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:12:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so4140628ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GzNziDqoL/AUz4B68gds+Nqpq3Cs5xfNdbm3Hr7a7BQ=;
        b=K4vLOeeal5lD62N5rp44dErrQJ/7YZhgd+S/o071QQuMO+lR5PNq/f5PuECNd0Ps3q
         MDFxOM9hsuf/2N8nr6xRpX+q6eUKzDiIkACheNgp/epR22Dmsj6kg8hPT4IwAhrg8sbM
         M0bnueZA88O5tbgFHu7UMcdwte23Yrr86E+JTLO6xc2nyJ+8KfdBxRJg11VJZH75W1re
         8kRQR5K14xPczsg/eeg+nRKKi/7Q/pQvxSwxysUCo9U+MQXU7KAK7C0QW+pT/70uCUEC
         m9P+xnzLHWkfhXmLd2mAV3KkScTdnSq7bGUrpKqXVUYVmieqMtdIFTNImeyN6SDIM+Bx
         6Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GzNziDqoL/AUz4B68gds+Nqpq3Cs5xfNdbm3Hr7a7BQ=;
        b=R9pm1hg6gSPZzPqhSm+L3suU5cilAOsDLy/lMZ0mfgiSaHyx1A6W9E/acQXX0FL34Z
         y63F8Kb6xEQNbmeiwf2eoylNNbbquuDv1yWInbdX0H+u7/DCnY/dVzbXfXjCvxP9FSDt
         s0W7yHPkJjbUFsJjYv+gQUf9Uk4RhEq6K5ou5jJME9zN7m0rm/06sj1xSm8qkiL5rQAI
         WlW57wybqFcLlUadQ0gApYKBe1Xb4P7UA88f5XI4zrB10nROAKUKikFT5k4DBQDcABB8
         GCqzz0XwTUYlx/OEO+ONnl8QUkFsBojezLuT9s4c65c8Hleg0N9MNc0AG12TvKU2eMpf
         4dow==
X-Gm-Message-State: APjAAAWazj13mAHo4d+Bln2jO4NSmVNjWNoM9sX2emc/cBt0faoY16wk
        0AZ2djUmIVfpjXr9M5xh3wNlFA==
X-Google-Smtp-Source: APXvYqwaE144CzFHNPc2ptsLvuY5jTWwyOCULsFygaInuVevwoDVdizIDXa1G2ZI2dDqhPsffLZD1w==
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr19216575ljk.174.1582204376901;
        Thu, 20 Feb 2020 05:12:56 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n11sm1851850ljg.15.2020.02.20.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 05:12:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7F899100FBB; Thu, 20 Feb 2020 16:13:25 +0300 (+03)
Date:   Thu, 20 Feb 2020 16:13:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: Fix possible PMD dirty bit lost in
 set_pmd_migration_entry()
Message-ID: <20200220131325.e56ttzhjcvxyic7i@box>
References: <20200220075220.2327056-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220075220.2327056-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:52:20PM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In set_pmd_migration_entry(), pmdp_invalidate() is used to change PMD
> atomically.  But the PMD is read before that with an ordinary memory
> reading.  If the THP (transparent huge page) is written between the
> PMD reading and pmdp_invalidate(), the PMD dirty bit may be lost, and
> cause data corruption.  The race window is quite small, but still
> possible in theory, so need to be fixed.
> 
> The race is fixed via using the return value of pmdp_invalidate() to
> get the original content of PMD, which is a read/modify/write atomic
> operation.  So no THP writing can occur in between.
> 
> The race has been introduced when the THP migration support is added
> in the commit 616b8371539a ("mm: thp: enable thp migration in generic
> path").  But this fix depends on the commit d52605d7cb30 ("mm: do not
> lose dirty and accessed bits in pmdp_invalidate()").  So it's easy to
> be backported after v4.16.  But the race window is really small, so it
> may be fine not to backport the fix at all.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7DC2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="09rI4km/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgEYEon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYEom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:44:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:44:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so17146586ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6jtbeZwsvOZY+pgkpyuXhsDWBq5iskp0QmwZ/y8vek=;
        b=09rI4km/OQky2Hmq6IxNeoiKo6N0pt5n/f/PKfR13+ShQ85KtKze6oAlKD20TZz3uG
         hK5itjdR+DGUWy/ck/g9o7zoYj1sAuEP/l/vuQ8JCscuFmDGnBGFvXFadRkAawaWY0sJ
         0GRmmleoZL098cmRsHe9hqsJZPjZedVJdbOuQg+rsr1tUNBhltwHGHylxhgppz2OZR+/
         zMrJ5vxrxqGrV0sUX9B94ozLmcIf/Dc80Xt4z0bGSMn8sMtdhstvP4oVMijucS84XTKf
         mIbFWn7F5XzMuJCCV2ik6sf3HKVDp8MW9hA8nR88LHJLbytPYmBBk2Qxvpsxuh0TQhyl
         R1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6jtbeZwsvOZY+pgkpyuXhsDWBq5iskp0QmwZ/y8vek=;
        b=qxd6PvqrSwBhR+21UXK6sjd1fRN+50hpQConqJ6uIx0BKul/WqSP3qCdDRf0qAv0DY
         2PpkHhkPDomrVXc+fW+X1BjfOQ9LRdBeOoWgLjwvAi9WMtqK91gZwpCD+Oy0lkq2UGzz
         XGiAm7uxOJVeP04JtzknL1HuiAJo3ovCi4HDzdG+oRU8PRxeizV4o+rI2TJwsJjYaoUd
         0GN8aD3+7wrODdf3QZHQzmkOAf9KfsK1vsErtbpNg84ABCW+3TtxUMxXrMWC3dQrv4ML
         YF8MLvrEmGFN1ZM1fT11uVkFKRzqyrI3+8DKRN0UJN3ovJQ7/9r2iRmM/auFKPX6FZZI
         vwtQ==
X-Gm-Message-State: AOAM531k7bZ8/gwS9ewtPuTBe+3/ymJX2zFN6wkfXMDsxWFYtQ5rqtgY
        f1izdlGI4dlNsbikDNWkzsTRZw==
X-Google-Smtp-Source: ABdhPJw50Z60Kd3jiZW8ttE5tCSoWdYL5faK1qntPLqAT1rgXHSslGhNq6uCYyWrH2iB5zTGkI3frg==
X-Received: by 2002:a2e:8997:: with SMTP id c23mr13748654lji.22.1590381879513;
        Sun, 24 May 2020 21:44:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h2sm4733454ljb.45.2020.05.24.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:44:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 72CDA1012E6; Mon, 25 May 2020 07:44:39 +0300 (+03)
Date:   Mon, 25 May 2020 07:44:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm: remove VM_BUG_ON(PageSlab()) from page_mapcount()
Message-ID: <20200525044439.f433y6enrpehdmid@box>
References: <159032779896.957378.7852761411265662220.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159032779896.957378.7852761411265662220.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 04:43:18PM +0300, Konstantin Khlebnikov wrote:
> Replace superfluous VM_BUG_ON() with comment about correct usage.
> 
> Technically reverts commit 1d148e218a0d0566b1c06f2f45f1436d53b049b2
> ("mm: add VM_BUG_ON_PAGE() to page_mapcount()"), but context have changed.
> 
> Function isolate_migratepages_block() runs some checks out of lru_lock
> when choose pages for migration. After checking PageLRU() it checks extra
> page references by comparing page_count() and page_mapcount(). Between
> these two checks page could be removed from lru, freed and taken by slab.
> 
> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> Race window is tiny. For certain workload this happens around once a year.
> 
> 
>  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>  flags: 0x500000000008100(slab|head)
>  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>  ------------[ cut here ]------------
>  kernel BUG at ./include/linux/mm.h:628!
>  invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> 
> 
> Code in isolate_migratepages_block() was added in commit 119d6d59dcc0
> ("mm, compaction: avoid isolating pinned pages") before adding VM_BUG_ON
> into page_mapcount().
> 
> This race has been predicted in 2015 by Vlastimil Babka (see link below).
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
> Link: https://lore.kernel.org/lkml/557710E1.6060103@suse.cz/
> Link: https://lore.kernel.org/linux-mm/158937872515.474360.5066096871639561424.stgit@buzz/T/ (v1)

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

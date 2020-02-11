Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF983C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CA520675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SEjkpW4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgBKNYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:24:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40303 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgBKNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:24:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so6999416lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CzyQ7mq5ghTZ5xEThA6Ei5Juwb2NrNUehuG+dmrZpzc=;
        b=SEjkpW4UWIzqRSvYDXsP/MCzrSB8iaydRpotrd4hRSCFYSLIQljvUtObehx0GhDJOo
         djsrIQm3V4q/onh+FRWn6pRjJIgCw29GCPAiDQB683wNJE536vkGlOSsBLYb+MuzhrZl
         n6icHfoKVg3L6CN4R+n1Ee47GcK79QbthOkTutb0slayCzIkDphEI26o70aj3/SYVvS4
         ofHpZzy2C9NTqQW9fUeR753Vraoy+RSEoa68MxhhJBH7nZOp4bzvUFUcNewkqFfe7OuG
         VbIKiXKKHpZBnIsJKMbChEa2QFEY95Lor99Ip20UwCSwd49bq1yCaAYDcbDeq78gf3TE
         YK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CzyQ7mq5ghTZ5xEThA6Ei5Juwb2NrNUehuG+dmrZpzc=;
        b=lpcTCMbpAc8TEXfsfGZhCqJggXnqZXcvdD9/n8elI2xsnEc+szxIYdeVuJDnahnnYp
         a0bJgQUppl3wEm+P45V+0ZIeA7BbcubowJeGY+IARoUyp5wZ04yoU4dYoQQ7piTwXIge
         IU46V++hgTwc7cKL2fNEZhdhqOPsD33550d9mAe7tVQxXSjDMD0aNjzAvbBcy0iHR6Ct
         Ba1B3Q+pI85BoY+vFYbeiTwofojPEEre8goNsVRAPRTkvsr3bI/HoMVwUcj8welHhuEX
         kpT/HAvmHMPvmegS0qRAj32TGM0hy3wplZRs58VVrC/JX/dcQXzZa77IJSZd81e1QZgU
         7z8Q==
X-Gm-Message-State: APjAAAVEtlxKXHTFxnpdI9kDd5lVUnYHDzcKh+hdA2NGsEm+c4rgd+Ew
        akOz+/hrHCA0zGFDu1h8zyvGoA==
X-Google-Smtp-Source: APXvYqxlKj3CQFqFaZuwztEevYydMW5Fb8mKtS0DRyHpzvNf53lkneGX+jdyLqQQXslCCEjTI2Uggg==
X-Received: by 2002:a19:550d:: with SMTP id n13mr3695093lfe.48.1581427479014;
        Tue, 11 Feb 2020 05:24:39 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f8sm1813962lfc.22.2020.02.11.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:24:38 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 46EEC100AFB; Tue, 11 Feb 2020 16:24:57 +0300 (+03)
Date:   Tue, 11 Feb 2020 16:24:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200211132457.uhkbh6hyljry4zpo@box>
References: <20200211030134.1847-1-cai@lca.pw>
 <20200211034900.GQ8731@bombadil.infradead.org>
 <2EFC8936-4569-418F-82EC-6F7868BEEAE2@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2EFC8936-4569-418F-82EC-6F7868BEEAE2@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:55:45PM -0500, Qian Cai wrote:
> 
> 
> > On Feb 10, 2020, at 10:49 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Mon, Feb 10, 2020 at 10:01:34PM -0500, Qian Cai wrote:
> >> struct file_ra_state ra.mmap_miss could be accessed concurrently during
> >> page faults as noticed by KCSAN,
> >> 
> >> BUG: KCSAN: data-race in filemap_fault / filemap_map_pages
> >> 
> >> write to 0xffff9b1700a2c1b4 of 4 bytes by task 3292 on cpu 30:
> >>  filemap_fault+0x920/0xfc0
> >>  do_sync_mmap_readahead at mm/filemap.c:2384
> >>  (inlined by) filemap_fault at mm/filemap.c:2486
> >>  __xfs_filemap_fault+0x112/0x3e0 [xfs]
> >>  xfs_filemap_fault+0x74/0x90 [xfs]
> >>  __do_fault+0x9e/0x220
> >>  do_fault+0x4a0/0x920
> >>  __handle_mm_fault+0xc69/0xd00
> >>  handle_mm_fault+0xfc/0x2f0
> >>  do_page_fault+0x263/0x6f9
> >>  page_fault+0x34/0x40
> >> 
> >> read to 0xffff9b1700a2c1b4 of 4 bytes by task 3313 on cpu 32:
> >>  filemap_map_pages+0xc2e/0xd80
> >>  filemap_map_pages at mm/filemap.c:2625
> >>  do_fault+0x3da/0x920
> >>  __handle_mm_fault+0xc69/0xd00
> >>  handle_mm_fault+0xfc/0x2f0
> >>  do_page_fault+0x263/0x6f9
> >>  page_fault+0x34/0x40
> >> 
> >> Reported by Kernel Concurrency Sanitizer on:
> >> CPU: 32 PID: 3313 Comm: systemd-udevd Tainted: G        W    L 5.5.0-next-20200210+ #1
> >> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> >> 
> >> ra.mmap_miss is used to contribute the readahead decisions, a data race
> >> could be undesirable. Both the read and write is only under
> >> non-exclusive mmap_sem, two concurrent writers could even overflow the
> >> counter. Fixing the underflow by writing to a local variable before
> >> committing a final store to ra.mmap_miss given a small inaccuracy of the
> >> counter should be acceptable.
> >> 
> >> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > That's more than Suggested-by.  The correct way to submit this patch is:
> > 
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > (at the top of the patch, so it gets credited to Kirill)
> 
> Sure, if Kirill is going to provide his Signed-off-by in the first place, I’ll be happy to
> submit it on his behalf.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

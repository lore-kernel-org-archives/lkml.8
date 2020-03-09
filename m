Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B76CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642020578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YeZJOaBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCIPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:48:13 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:37722 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCIPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:48:13 -0400
Received: by mail-lj1-f177.google.com with SMTP id d12so10484925lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jLofNn5qpSrLQRtfD1EwGyzB1Lhve2KpO5PXEfPUq5Q=;
        b=YeZJOaBVkiXVfs+D9QtkZpXnQncn6cQi6ttJO8GeDr/u0vs5Ok6D71vFPTbDaSrOSU
         a9vwiyAxGdd0jOPbAWRDxgQ/dVaWxrVoe46Psg3MiFYj6KPcMIJ4sjItaMalHGo9tC7r
         nyjbHigjgQzZcxdVvtJBHh6hNSUGhAl0ydVpCvN+KWP3/HSx50Z1TLzQ7Ut1tSmFiO3s
         eD8QkJqOAB/I8mPL1wRQv4qqSb5sF2dPDZE6sA+/YT9biwdnXeGxIfQd459PlU+HDMnC
         H3c/Iyrli+xZ9UctINSRWGEVnO97rNrPAS7ZJfRJI/twc49hhWGLZUjKLJUuwSTaliYS
         PWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLofNn5qpSrLQRtfD1EwGyzB1Lhve2KpO5PXEfPUq5Q=;
        b=juOJTTCGL/KCRVSFlbdrS0BCrkuWz1RkMlEEAx/eBIqzfEt/Ex61aAzLB+ncAVK99L
         AjE4Rjs2qYZ13yNM4ee5WNhsXoU7NhW11Wit39S91kZ0HthK/GDup2lKLAyF+6CYHPfm
         kVfy+MgTTx9GeT0yKGiGmYN8okre0sySrFpqzGKDuwla+TINGr57QYg9TWZD++TAqGyZ
         jUrExeT2QTUgmgEd87KukekzdYjBltBc/QeyTQKSzrRuzzH8OxCml33TsMH2LzdUQstz
         nEdt8TngqLaOWGUMim5Hg1Cz1S6Xdzn3zgVqJvw+kXDDnjVmWRUZvvtukF0pLI1jd0Cp
         ONrg==
X-Gm-Message-State: ANhLgQ2gqHRqyc2nPb6VAvLoUTznzt/oEDT1whCikNFjeCDAS42LosWd
        Gjw1wNpLECtgkolqbI8tl1fAug==
X-Google-Smtp-Source: ADFU+vuj8tlb8v26bk/4k8K0XSFLhHmuNKVELyWTxsk4bDFJDUNxDGlblztnptVJt3IAVmZYmV9KRg==
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr6809006lji.277.1583768891451;
        Mon, 09 Mar 2020 08:48:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t3sm11168342lfp.81.2020.03.09.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:48:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 977EB1013CA; Mon,  9 Mar 2020 18:48:10 +0300 (+03)
Date:   Mon, 9 Mar 2020 18:48:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [patch 1/2] mm, shmem: add vmstat for hugepage fallback
Message-ID: <20200309154810.7cp5e57y3jymhluz@box>
References: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:22:32PM -0800, David Rientjes wrote:
> The existing thp_fault_fallback indicates when thp attempts to allocate a
> hugepage but fails, or if the hugepage cannot be charged to the mem cgroup
> hierarchy.
> 
> Extend this to shmem as well.  Adds a new thp_file_fallback to complement
> thp_file_alloc that gets incremented when a hugepage is attempted to be
> allocated but fails, or if it cannot be charged to the mem cgroup
> hierarchy.
> 
> Additionally, remove the check for CONFIG_TRANSPARENT_HUGE_PAGECACHE from
> shmem_alloc_hugepage() since it is only called with this configuration
> option.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

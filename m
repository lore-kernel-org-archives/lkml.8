Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C812054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UZhcD8yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHCPTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:19:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:19:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so35413509qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TuKFm7Rh0S4l+lGaNZYInwprO71g9I3NdKf0S6gxSPQ=;
        b=UZhcD8yzCmeTcCYDNEi04gVAtmj3AqeIP/Y3EL99Ok0jCxTCZEPa2f1PRBP72HtIy4
         zPXxGDma2JLgTJmFkFQwujLz4RqCDUW8Th8XYdDv03bTnHWlrURgqGbU8KjapEqTVb0w
         xzihIZNV+19j6ZIUOqg0h/Zy0PV4dBCx/yd8JIz4OtAKRAv90md1jzn5ZDsJoz2m43gs
         GNJfq6QBVHM2eO1jlvnQd3BYVhnm1Q9g3matFyHQBd25rkRkuJx/iNQrcgkZh/qAAz3s
         SVE0ngB6jXUUtl8P3uR5PIEjVvrjri+MTuW2SS466KVMKoxNdXxcvBxv3n/JeiBq1t0+
         Ydpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TuKFm7Rh0S4l+lGaNZYInwprO71g9I3NdKf0S6gxSPQ=;
        b=AYBkfHnCtMzpHHlcTc567/dCfro/rqO6FOnlh2+MXpvB8/O3FZ0BCFWicwLpyILTDj
         hqcsglSbK1C9l7FHAImFF32Zpt7U/vmDdjiFSaWxOtsSkGYTpdceKISrvAs9Um/F6Q4X
         zhMqhvhvBWYzcWxPUqLQQyPpUGRQejRFIcKPBsJkFnsfTZIsls7LysBCfYhyAecqLm/C
         KjTHW13wNgAfVjYMf/QgWtggqvi71ScIO8+XVpZgXXBI9G7Xz5nuybo0Z9dXz1QdyqJK
         ZNO5oS6RRRXC9dQ60rVNf1nlyKdqhlmE2bUa4c023bThiyssRJ7CAEtqfitjN+BNQkES
         5RDA==
X-Gm-Message-State: AOAM530JMAUdaDXaez6Guk4mMN6SxPUhMrc+8VdMK0Eho5gOhE7iQCGc
        TcYCrHeX/X1b5TSKA84/inINHQ==
X-Google-Smtp-Source: ABdhPJxVO5RQqCUhq5qqYGIRV4OgOx/Epz4ztN0J/sK8mrWtvZeBXYQUCVtB9xUOvvvZVaJ4szaCPg==
X-Received: by 2002:a37:9b15:: with SMTP id d21mr16090997qke.87.1596467955915;
        Mon, 03 Aug 2020 08:19:15 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e129sm16600379qkf.132.2020.08.03.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:19:15 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:19:09 -0400
From:   Qian Cai <cai@lca.pw>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Message-ID: <20200803151907.GA8894@lca.pw>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803123954.GA4631@lca.pw>
 <20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803133657.GA13307@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:36:58PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> Hello,
> 
> On Mon, Aug 03, 2020 at 08:39:55AM -0400, Qian Cai wrote:
> > On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wrote:
> > > This patchset is the latest version of soft offline rework patchset
> > > targetted for v5.9.
> > > 
> > > Main focus of this series is to stabilize soft offline.  Historically soft
> > > offlined pages have suffered from racy conditions because PageHWPoison is
> > > used to a little too aggressively, which (directly or indirectly) invades
> > > other mm code which cares little about hwpoison.  This results in unexpected
> > > behavior or kernel panic, which is very far from soft offline's "do not
> > > disturb userspace or other kernel component" policy.
> > > 
> > > Main point of this change set is to contain target page "via buddy allocator",
> > > where we first free the target page as we do for normal pages, and remove
> > > from buddy only when we confirm that it reaches free list. There is surely
> > > race window of page allocation, but that's fine because someone really want
> > > that page and the page is still working, so soft offline can happily give up.
> > > 
> > > v4 from Oscar tries to handle the race around reallocation, but that part
> > > seems still work in progress, so I decide to separate it for changes into
> > > v5.9.  Thank you for your contribution, Oscar.
> > > 
> > > The issue reported by Qian Cai is fixed by patch 16/16.
> > 
> > I am still getting EIO everywhere on next-20200803 (which includes this v5).
> > 
> > # ./random 1
> > - start: migrate_huge_offline
> > - use NUMA nodes 0,8.
> > - mmap and free 8388608 bytes hugepages on node 0
> > - mmap and free 8388608 bytes hugepages on node 8
> > madvise: Input/output error
> > 
> > From the serial console,
> > 
> > [  637.164222][ T8357] soft offline: 0x118ee0: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> > [  637.164890][ T8357] Soft offlining pfn 0x20001380 at process virtual address 0x7fff9f000000
> > [  637.165422][ T8357] Soft offlining pfn 0x3ba00 at process virtual address 0x7fff9f200000
> > [  637.166409][ T8357] Soft offlining pfn 0x201914a0 at process virtual address 0x7fff9f000000
> > [  637.166833][ T8357] Soft offlining pfn 0x12b9a0 at process virtual address 0x7fff9f200000
> > [  637.168044][ T8357] Soft offlining pfn 0x1abb60 at process virtual address 0x7fff9f000000
> > [  637.168557][ T8357] Soft offlining pfn 0x20014820 at process virtual address 0x7fff9f200000
> > [  637.169493][ T8357] Soft offlining pfn 0x119720 at process virtual address 0x7fff9f000000
> > [  637.169603][ T8357] soft offline: 0x119720: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
> > [  637.169756][ T8357] Soft offlining pfn 0x118ee0 at process virtual address 0x7fff9f200000
> > [  637.170653][ T8357] Soft offlining pfn 0x200e81e0 at process virtual address 0x7fff9f000000
> > [  637.171067][ T8357] Soft offlining pfn 0x201c5f60 at process virtual address 0x7fff9f200000
> > [  637.172101][ T8357] Soft offlining pfn 0x201c8f00 at process virtual address 0x7fff9f000000
> > [  637.172241][ T8357] __get_any_page: 0x201c8f00: unknown zero refcount page type 87fff8000000000
> 
> I might misjudge to skip the following patch, sorry about that.
> Could you try with it?

Still getting EIO after applied this patch.

[ 1215.499030][T88982] soft offline: 0x201bdc20: hugepage isolation failed: 0, page count 2, type 87fff800001000e (referenced|uptodate|dirty|head)
[ 1215.499775][T88982] Soft offlining pfn 0x201bdc20 at process virtual address 0x7fff91a00000
[ 1215.500189][T88982] Soft offlining pfn 0x201c19c0 at process virtual address 0x7fff91c00000
[ 1215.500297][T88982] soft offline: 0x201c19c0: hugepage isolation failed: 0, page count 2, type 87fff800001000e (referenced|uptodate|dirty|head)
[ 1215.500982][T88982] Soft offlining pfn 0x1f1fa0 at process virtual address 0x7fff91a00000
[ 1215.501086][T88982] soft offline: 0x1f1fa0: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
[ 1215.501237][T88982] Soft offlining pfn 0x1f4520 at process virtual address 0x7fff91c00000
[ 1215.501355][T88982] soft offline: 0x1f4520: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
[ 1215.502196][T88982] Soft offlining pfn 0x1f4520 at process virtual address 0x7fff91a00000
[ 1215.502573][T88982] Soft offlining pfn 0x1f1fa0 at process virtual address 0x7fff91c00000
[ 1215.502687][T88982] soft offline: 0x1f1fa0: hugepage isolation failed: 0, page count 2, type 7fff800001000e (referenced|uptodate|dirty|head)
[ 1215.503245][T88982] Soft offlining pfn 0x201c3cc0 at process virtual address 0x7fff91a00000
[ 1215.503594][T88982] Soft offlining pfn 0x201c3ce0 at process virtual address 0x7fff91c00000
[ 1215.503755][T88982] __get_any_page: 0x201c3ce0: unknown zero refcount page type 87fff8000000000

> 
> ---
> From eafe6fde94cd15e67631540f1b2b000b6e33a650 Mon Sep 17 00:00:00 2001
> From: Oscar Salvador <osalvador@suse.de>
> Date: Mon, 3 Aug 2020 22:25:10 +0900
> Subject: [PATCH] mm,hwpoison: Drain pcplists before bailing out for non-buddy
>  zero-refcount page

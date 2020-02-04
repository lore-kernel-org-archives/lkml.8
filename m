Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8EFC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF932166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q00Ovhlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBDUdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:33:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43782 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:33:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id u131so10231107pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ctEXrh7BheWQOsS9Kl/bOhHMUGdv4AM8Ap/ACYvJln0=;
        b=q00OvhlhixeaX1IT00zVHR5jmcaOH/fOdcX8kV2LK0YG2A8I0S2OWy4BsTBFtZvIIL
         xntzdnhYSAE3F9v7o8nLt/7oUpCmpkZF1AKAsmoCu60PHWNgcDO85m07ufwSCpdRzRuC
         IpEQQisJ7h89UPomw6Q67b/7NTnjfQe0lKLmhbPDhLreFgr3bM8l6bkgFut579vJhbAH
         SkX6gIoLyQJpnCNuuHnSsCHLg6asDoppXthcaUHikMavXF+5ZzejrUjciB/1GgaErf3r
         ztYBMK2N69qKObS6hBkuFU2LNwuPt8UPxqo5JhEITvA6TIPsiPk/Ka0pcL8HiBHXoLpH
         F+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ctEXrh7BheWQOsS9Kl/bOhHMUGdv4AM8Ap/ACYvJln0=;
        b=mIzvMvZBKSLbpYYSLybSZkfWwB6+6ki0++mOjkRlnkoG8B9lSJUSlfeQc+J2+TeMPo
         S8eX17pLmhtApCA/QP4yrLidLdo6VB35OGik55KE2Zsvi2V2JvJtsaH9AhUzYKZuAenL
         5D1dxQver0+G+2EZqdvU9DTZkhC+wvJ6ku4rCGhHVdmDHfVcesRM2mTZgfPaHQg6pMZG
         HZtw0t2XskQX7DYApHGP8oLesWmnVb9RpdRyKz860/m/qhlS8KVQrJzx/uQtM1Qrs0bT
         J5hhfil3OXyT5vFewT65gywV8JOgxlYINdE01RNKluqvz3c6N/nqDGmIFcZmus5CHYf/
         1DOw==
X-Gm-Message-State: APjAAAWT/ErbUfNPE9WWSCJKtbnpnCkW6vt2IOUFfWg4EMK7V8r8zv7i
        Ph9kg+0dcPk/clWvl6FXX+EKCw==
X-Google-Smtp-Source: APXvYqyVowEoWNfmXXNoW76yvtJ8Y52eMGNdxHCQ/baVIi8dgLfmRQxel7PBirdIkNiTaVvs+R4TQg==
X-Received: by 2002:a63:d157:: with SMTP id c23mr33139327pgj.242.1580848399755;
        Tue, 04 Feb 2020 12:33:19 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j8sm4605432pjb.4.2020.02.04.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:33:18 -0800 (PST)
Date:   Tue, 4 Feb 2020 12:33:18 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
In-Reply-To: <20200204194156.61672-1-mike.kravetz@oracle.com>
Message-ID: <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020, Mike Kravetz wrote:

> At system initialization time, min_free_kbytes is calculated based
> on the amount of memory in the system.  If THP is enabled, then
> khugepaged is started and min_free_kbytes may be adjusted in an
> attempt to reserve some pageblocks for THP allocations.
> 
> When memory is offlined or onlined, min_free_kbytes is recalculated
> and adjusted based on the amount of memory.  However, the adjustment
> for THP is not considered.  Here is an example from a 2 node system
> with 8GB of memory.
> 
>  # cat /proc/sys/vm/min_free_kbytes
>  90112
>  # echo 0 > /sys/devices/system/node/node1/memory56/online
>  # cat /proc/sys/vm/min_free_kbytes
>  11243
>  # echo 1 > /sys/devices/system/node/node1/memory56/online
>  # cat /proc/sys/vm/min_free_kbytes
>  11412
> 

Ah, that doesn't look good.

> One would expect that min_free_kbytes would return to it's original
> value after the offline/online operations.
> 
> Create a simple interface for THP/khugepaged based adjustment and
> call this whenever min_free_kbytes is adjusted.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/khugepaged.h |  5 +++++
>  mm/khugepaged.c            | 35 ++++++++++++++++++++++++++++++-----
>  mm/page_alloc.c            |  4 +++-
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index bc45ea1efbf7..8f02d3575829 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -15,6 +15,7 @@ extern int __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  				      unsigned long vm_flags);
> +extern bool khugepaged_adjust_min_free_kbytes(void);
>  #ifdef CONFIG_SHMEM
>  extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
>  #else
> @@ -81,6 +82,10 @@ static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  {
>  	return 0;
>  }
> +static bool khugepaged_adjust_min_free_kbytes(void)
> +{
> +	return false;
> +}
>  static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>  					   unsigned long addr)
>  {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b679908743cb..d8040cf19e98 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2138,7 +2138,7 @@ static int khugepaged(void *none)
>  	return 0;
>  }
>  
> -static void set_recommended_min_free_kbytes(void)
> +bool __khugepaged_adjust_min_free_kbytes(void)
>  {
>  	struct zone *zone;
>  	int nr_zones = 0;
> @@ -2174,17 +2174,26 @@ static void set_recommended_min_free_kbytes(void)
>  
>  	if (recommended_min > min_free_kbytes) {
>  		if (user_min_free_kbytes >= 0)
> -			pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
> +			pr_info_once("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>  				min_free_kbytes, recommended_min);
>  
>  		min_free_kbytes = recommended_min;
> +		return true;
>  	}
> -	setup_per_zone_wmarks();
> +
> +	return false;
> +}
> +
> +static void set_recommended_min_free_kbytes(void)
> +{
> +	if (__khugepaged_adjust_min_free_kbytes())
> +		setup_per_zone_wmarks();
>  }
>  
> -int start_stop_khugepaged(void)
> +static struct task_struct *khugepaged_thread __read_mostly;
> +
> +int __ref start_stop_khugepaged(void)
>  {
> -	static struct task_struct *khugepaged_thread __read_mostly;
>  	static DEFINE_MUTEX(khugepaged_mutex);
>  	int err = 0;
>  
> @@ -2207,8 +2216,24 @@ int start_stop_khugepaged(void)
>  	} else if (khugepaged_thread) {
>  		kthread_stop(khugepaged_thread);
>  		khugepaged_thread = NULL;
> +		init_per_zone_wmark_min();
>  	}
>  fail:
>  	mutex_unlock(&khugepaged_mutex);
>  	return err;
>  }
> +
> +bool khugepaged_adjust_min_free_kbytes(void)
> +{
> +	bool ret = false;
> +
> +	/*
> +	 * This is a bit racy, and we could miss transitions.  However,
> +	 * start/stop code above will make additional adjustments at the
> +	 * end of transitions.
> +	 */
> +	if (khugepaged_enabled() && khugepaged_thread)
> +		ret = __khugepaged_adjust_min_free_kbytes();
> +
> +	return ret;
> +}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..a7b3a6663ba6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -68,6 +68,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
>  #include <linux/psi.h>
> +#include <linux/khugepaged.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -7827,9 +7828,10 @@ int __meminit init_per_zone_wmark_min(void)
>  		if (min_free_kbytes > 65536)
>  			min_free_kbytes = 65536;
>  	} else {
> -		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
> +		pr_warn_once("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>  				new_min_free_kbytes, user_min_free_kbytes);
>  	}
> +	(void)khugepaged_adjust_min_free_kbytes();
>  	setup_per_zone_wmarks();
>  	refresh_zone_stat_thresholds();
>  	setup_per_zone_lowmem_reserve();

Hmm, if khugepaged_adjust_min_free_kbytes() increases min_free_kbytes for 
thp, then the user has no ability to override this increase by using 
vm.min_free_kbytes?

IIUC, with this change, it looks like memory hotplug events properly 
increase min_free_kbytes for thp optimization but also doesn't respect a 
previous user-defined value?

So it looks like this is fixing an obvious correctness issue but also now 
requires users to rewrite the sysctl if they want to decrease the min 
watermark.

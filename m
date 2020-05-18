Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C553F207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589841507;
	bh=Sd5ezXE7qYEtfRiNzmhu3tUhZvaqR/4PPRmzDGYu5Ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JcOQcWOIU8K81jfTHvNaftfQ6XGMRCTZ2M+tlFTH4F0V2ApkkyjGn3FusOvaMe+wh
	 msAn+DgsPxfMel5vug65ARXfLFPJKmeDchd8B5ONVnsja+0QNJ7L3Qtte8GeJffhBl
	 uSVG29X6Soyr1pVi3unxtZiYKv7bw4vdfjbDNGqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgERWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgERWi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:38:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D63A2075F;
        Mon, 18 May 2020 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589841505;
        bh=Sd5ezXE7qYEtfRiNzmhu3tUhZvaqR/4PPRmzDGYu5Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=okjC93SPhXqlfE2cPpgu+8/zjH2CSFa7zpgRSSymDQGvYbn3J11Qud0fdC/Gi+2xJ
         HK4aT+bUN4P6Egn1DpDqPUS7UurC04TtA/ZNXtlEoGi8Flak8fH9QxWnmWgd7SLJ8V
         eZSlOZkxAjWY5WGl3br278Q61PyPtim2AXI8jeCA=
Date:   Mon, 18 May 2020 15:38:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-Id: <20200518153824.e4e57a651c6ca69fb8776dbc@linux-foundation.org>
In-Reply-To: <1589611660-89854-4-git-send-email-feng.tang@intel.com>
References: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
        <1589611660-89854-4-git-send-email-feng.tang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 14:47:40 +0800 Feng Tang <feng.tang@intel.com> wrote:

> When checking a performance change for will-it-scale scalability
> mmap test [1], we found very high lock contention for spinlock of
> percpu counter 'vm_committed_as':
> 
>     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
>     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
>     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> 
> Actually this heavy lock contention is not always necessary. The
> 'vm_committed_as' needs to be very precise when the strict
> OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> number for the percpu counter.
> 
> So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy,
> and lift it to 64X for OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS policies.
> Also add a sysctl handler to adjust it when the policy is reconfigured.
> 
> Benchmark with the same testcase in [1] shows 53% improvement on a
> 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. We tested
> with test platforms in 0day (server, desktop and laptop), and 80%+
> platforms shows improvements with that test. And whether it shows
> improvements depends on if the test mmap size is bigger than the
> batch number computed.
> 
> And if the lift is 16X, 1/3 of the platforms will show improvements,
> though it should help the mmap/unmap usage generally, as Michal Hocko
> mentioned:
> "
> I believe that there are non-synthetic worklaods which would benefit
> from a larger batch. E.g. large in memory databases which do large
> mmaps during startups from multiple threads.
> "
> 

This needed some adjustments to overcommit_policy_handler() after
linux-next's 32927393dc1c ("sysctl: pass kernel pointers to
->proc_handler").  Relevant parts are below.

--- a/include/linux/mm.h~mm-adjust-vm_committed_as_batch-according-to-vm-overcommit-policy
+++ a/include/linux/mm.h
@@ -205,6 +205,8 @@ int overcommit_ratio_handler(struct ctl_
 		loff_t *);
 int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
+		loff_t *);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 

--- a/mm/util.c~mm-adjust-vm_committed_as_batch-according-to-vm-overcommit-policy
+++ a/mm/util.c
@@ -746,6 +746,18 @@ int overcommit_ratio_handler(struct ctl_
 	return ret;
 }
 
+int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret == 0 && write)
+		mm_compute_batch();
+
+	return ret;
+}
+
 int overcommit_kbytes_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
_


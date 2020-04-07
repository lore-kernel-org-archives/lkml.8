Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F593C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC31320768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDGSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:19:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:52939 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgDGSTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:19:09 -0400
IronPort-SDR: CBgkUhMsTzaB2+QZBsUBwD0XqM42ZvThBvRoWxen6rQqLwRQVxPrkxXhYbXCO0TseomAXWX3t7
 5b68GO3DoHgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:19:08 -0700
IronPort-SDR: hrIdburDaMCzTAQyPcSF6hxKn0vdzYIyj0JgJyyQtUugCGrjCw8SK7PRdi+nBnpzQcRmt5bpho
 ZdVHFyZ+P7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="451317416"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 11:19:08 -0700
Date:   Tue, 7 Apr 2020 11:19:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm/gup: fix null pointer dereference detected by coverity
Message-ID: <20200407181908.GB94792@iweiny-DESK2.sc.intel.com>
References: <20200407095107.1988-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407095107.1988-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:51:07PM +0800, Miles Chen wrote:
> In fixup_user_fault(), it is possible that unlocked is NULL,
> so we should test unlocked before using it.
> 
> For example, in arch/arc/kernel/process.c, NULL is passed
> to fixup_user_fault().
> 
> SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
> {
> ...
> 	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
> 			       FAULT_FLAG_WRITE, NULL);
> ...
> }
> 
> Fixes: 4a9e1cda2748 ("mm: bring in additional flag for fixup_user_fault to signal unlock")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  mm/gup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index da3e03185144..a68d11dc232d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1230,7 +1230,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	if (ret & VM_FAULT_RETRY) {
>  		down_read(&mm->mmap_sem);
>  		if (!(fault_flags & FAULT_FLAG_TRIED)) {
> -			*unlocked = true;
> +			if (unlocked)
> +				*unlocked = true;
>  			fault_flags |= FAULT_FLAG_TRIED;
>  			goto retry;
>  		}
> -- 
> 2.18.0

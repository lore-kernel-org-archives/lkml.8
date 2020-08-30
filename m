Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976EC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E72208A9
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRJZiql1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgH3U7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3U7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:59:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BBFC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:59:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so5491908oid.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QBRmCzycKmVnu23sFsGovUalfChtQnjWcQWYwI41Axs=;
        b=oRJZiql1EBss2KvDcVmuLG7L3aCyu2+FBgk3j1giZZqACibEjKQb6SkstVBGYZU4QK
         bRrTWKp2d3YEVyAooD3KGlCqvmb6iSkk4Me6fnFWAAquDC1qrySjhUCG2z/DiQ3qN7qh
         mWKoNV40sLxpuJbCb8yMKMfwcLwJtPPdadVpvHiX/sUfeVrFocScInFqHGt2zKRCHjLD
         hXWib8afQ6yXkkv7yDORDIYjd42qidf6OqaPSyyRGcQIAXEIQPbSC17BKRwiURY+uoLm
         TiKpyPEFCFrS7VE1GQ1LnEdUuPjBlcxhYR5ZNIaPhWTWW8O252C6J+xMDzYWhX7KV7el
         PU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QBRmCzycKmVnu23sFsGovUalfChtQnjWcQWYwI41Axs=;
        b=WRwjWA+xjzIAGuVkvJQLX/v8rRjbL1c4jUt13VXYE2BAfSIl4BY5XGjk1eX6NkQt34
         2xRfNxXfh3klci7nCx7RJe/XD8/8vDdOl6cTz+I9ZYJiCzlxjlvh0aXePGVERtEVIs+C
         7jmX1V2rUx7tnPZm/Ik12hM3Yzfeg7NShL6/xkE8VYCUaTZZ3UhAt//3+lJC4d1QdCUM
         6Fkt7mqyAQZYS79AR/YqjrUCcoTa7GrmJ4jB5bYAqJT0OmqOUFmCjbwTK+l0E0xuFYw8
         0EZXfDwDWgpAKlCh028kyV//w9QBEjTmCSo/IWQM/cpgrvn2g/wZBBYBocl3/5hC9Id0
         v90Q==
X-Gm-Message-State: AOAM531M7FDhznARkPwEFzs9/uk54WSSXpjwbygPIHiBJ3k5FW1Ihgq4
        mKBc1IAzcWqg67yafh/Am+KK6A==
X-Google-Smtp-Source: ABdhPJxxjozAFzN+mLHtGpaXsRTl7d/7QcyQjmZRGz/hgM/tIVGeTiFgtm4/XScrqZiVh2LIn3H+bg==
X-Received: by 2002:aca:1904:: with SMTP id l4mr1911081oii.67.1598821178001;
        Sun, 30 Aug 2020 13:59:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w136sm1256385oif.14.2020.08.30.13.59.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 13:59:36 -0700 (PDT)
Date:   Sun, 30 Aug 2020 13:59:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/5] ksm: reinstate memcg charge on copied pages
In-Reply-To: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008301358020.5954@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 5.8 some instances of memcg charging in do_swap_page() and unuse_pte()
were removed, on the understanding that swap cache is now already charged
at those points; but a case was missed, when ksm_might_need_to_copy() has
decided it must allocate a substitute page: such pages were never charged.
Fix it inside ksm_might_need_to_copy().

This was discovered by Alex Shi's prospective commit "mm/memcg: warning
on !memcg after readahead page charged".

But there is a another surprise: this also fixes some rarer uncharged
PageAnon cases, when KSM is configured in, but has never been activated.
ksm_might_need_to_copy()'s anon_vma->root and linear_page_index() check
sometimes catches a case which would need to have been copied if KSM
were turned on.  Or that's my optimistic interpretation (of my own old
code), but it leaves some doubt as to whether everything is working as
intended there - might it hint at rare anon ptes which rmap cannot find?
A question not easily answered: put in the fix for missed memcg charges.

Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.8
---

 mm/ksm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 5.9-rc2/mm/ksm.c	2020-08-16 17:32:50.645506940 -0700
+++ linux/mm/ksm.c	2020-08-28 17:42:07.967278385 -0700
@@ -2582,6 +2582,10 @@ struct page *ksm_might_need_to_copy(stru
 		return page;		/* let do_swap_page report the error */
 
 	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
+	if (new_page && mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL)) {
+		put_page(new_page);
+		new_page = NULL;
+	}
 	if (new_page) {
 		copy_user_highpage(new_page, page, address, vma);
 

Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76482072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaWatV1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFJUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:49:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCBC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:49:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b18so2864088oti.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=EVxKu+JQQ0AaGxjH7fjwRdxLG0JYbBBXs2fIjSw2Wtk=;
        b=RaWatV1sTeTqWcbTgYCsWky/yn3DSdIV8wrejh2LPMIh4GKeFW1iUp8V9/UIYZTzpL
         FHt6rBwFlkXlnuVmDDJesuJTdx9sHJaZPktK+aaCCIvERQlCuUKQgq3lrxLK+cJRhMUc
         RJJyGhvueSnRqjpAwIUnosfdaV4tNWwMWCre+GSkYfX7LQRWkecaYghD71N+E5a/N6eW
         4EeVF6+yICAX7MYrZKlUFKCpG6OfFB8kupjG8YxXnjb9gOFXlDvK7kyg3MdsZLo5aECu
         VG9Y4CI9k/feSusFbU89Fkha5jNo9lzxTx3uY0aEbxh+7LQaW7g/gICYF3C9k25RJa3l
         HStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=EVxKu+JQQ0AaGxjH7fjwRdxLG0JYbBBXs2fIjSw2Wtk=;
        b=NShZwE6ZD9DGGug3L0P6hYAhnFls5Rr57IX9bJ+wzTiDwMhAkvTdsy6nq047OqWIIj
         BwOKE2Fpsj2RB//x+mU6ot9zgXFrO7zJwrruZLCYQSWOvpmpdWZoRx/KZWYNz4+5XCny
         WvhbMBlQATTGDkY8CH/NdoU6L57gfo70YPZuVpPPmWyTxW0+2b8ny/CZqxH5XRskHIu/
         Rabm2hO0XzX24y++648pYplAwT1bBw8kJdI+PYE/mDvVsH7SWdXOSnmDkJdzJogoPLL7
         PK936l9ijG/kaMJZSBLxl+4GBDDa1yMKnt5KtHbOEb6XSWHiXJJYapxDlsf8/u0FN/aG
         zl0g==
X-Gm-Message-State: AOAM531D+vbYjn0ENFAnJoB9FHYPGKnBPHD0C4caaqzmD4EVUV7nkRu1
        Vtl/BFW1XpRgX6B0dRtePrzXtQ==
X-Google-Smtp-Source: ABdhPJxs13x8C/VK5321zEF/iFQMfsx+z7VP3oruxCRutwqhy4mKzxt3MxEGjo4e13oQO/JCNZBv4g==
X-Received: by 2002:a9d:6394:: with SMTP id w20mr3885173otk.71.1591822155954;
        Wed, 10 Jun 2020 13:49:15 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h189sm209731oif.10.2020.06.10.13.49.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2020 13:49:14 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:48:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Li Wang <liwang@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm, page_alloc: capture page in task context only
Message-ID: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While stressing compaction, one run oopsed on NULL capc->cc in
__free_one_page()'s task_capc(zone): compact_zone_order() had been
interrupted, and a page was being freed in the return from interrupt.

Though you would not expect it from the source, both gccs I was using
(a 4.8.1 and a 7.5.0) had chosen to compile compact_zone_order() with
the ".cc = &cc" implemented by mov %rbx,-0xb0(%rbp) immediately before
callq compact_zone - long after the "current->capture_control = &capc".
An interrupt in between those finds capc->cc NULL (zeroed by an earlier
rep stos).

This could presumably be fixed by a barrier() before setting
current->capture_control in compact_zone_order(); but would also need
more care on return from compact_zone(), in order not to risk leaking
a page captured by interrupt just before capture_control is reset.

Maybe that is the preferable fix, but I felt safer for task_capc() to
exclude the rather surprising possibility of capture at interrupt time.

Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/page_alloc.c |    1 +
 1 file changed, 1 insertion(+)

--- 5.8-rc0/mm/page_alloc.c	2020-06-08 14:38:47.298625588 -0700
+++ linux/mm/page_alloc.c	2020-06-10 12:12:34.982950441 -0700
@@ -814,6 +814,7 @@ static inline struct capture_control *ta
 	struct capture_control *capc = current->capture_control;
 
 	return capc &&
+		in_task() &&
 		!(current->flags & PF_KTHREAD) &&
 		!capc->page &&
 		capc->cc->zone == zone &&

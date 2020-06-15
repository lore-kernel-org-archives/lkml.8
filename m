Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74346207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fush9xXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFOWQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbgFOWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzPNsEqfmCz68HTb30cqD8DxFLmMqEZzWOV3nPixDso=;
        b=fush9xXfLB1fH9yC4BCpQla7SA1WwbGaJ3j/09lrAGQs7mmSnc4E9XKGKi5CwqHQ/Q/rc4
        5DOvjp6oiZxOhb3AvauK5Tgo2Wg1l8dtyFxBfPiOv83tMT6z+/ZFnBWLrL7rUPhKNdlwWX
        sW8ewE14kzorSm5iA+V94F5EFkz07ZI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-YtzlweNZNp-vQBXzAx2adQ-1; Mon, 15 Jun 2020 18:16:12 -0400
X-MC-Unique: YtzlweNZNp-vQBXzAx2adQ-1
Received: by mail-qk1-f197.google.com with SMTP id t18so15365065qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzPNsEqfmCz68HTb30cqD8DxFLmMqEZzWOV3nPixDso=;
        b=iVIq/2ahf5hUPdSkwy0Psz2w8V3ITEtAt3phj1ctqIG6SPFw193Xpi19bGwT2HaQQV
         mSEz5RgKle3Fi3QyPfS3VDlK33B0v5Q3XNm8alGPgBz2fl6AaV41yWspcLZ8AlSNbkzv
         jqHsHf+nq0HOPrMpRSa6iB4HXtx77vWuxZV275g0Id+y4GUl1ChzkcybChHvc6qv3105
         wlVFVpcgBxwI7lPDCoM/CD8Zve3ZL6Tnt9kHj15PSovm1sdDiPBpOor4kCxXeRMQ7mPM
         oXVhkfh/FJ+9PbKzJxPoe+tYcZDdKrr3otrO7oQ2S2T8DeETka/lL+/F97pzjz8KKvCw
         XMGQ==
X-Gm-Message-State: AOAM5311h5ksq8j0luwA836xt08WxcVXjw9OkY3lfx7lOdCwy36PjE85
        n1GY8S+D5t8lHplYWWgM6FntGt3Wpe2LzVm0f2ei1H+5Tmltwl4B3/VbPT54aLbIgfX69cQMWzj
        Wa5ggj1Jvoh2f3YaXGbUdh7yO
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr18158623qtm.7.1592259371448;
        Mon, 15 Jun 2020 15:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjWHjA14T4Y4WZBmEAu49NUsGG1HATDJAyvaPb65GPWGK47SLWF39nWaQ5Lrof2QgDYc778A==
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr18158603qtm.7.1592259371221;
        Mon, 15 Jun 2020 15:16:11 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 01/25] mm/um: Fix extra accounting for page fault retries
Date:   Mon, 15 Jun 2020 18:15:43 -0400
Message-Id: <20200615221607.7764-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page fault retried, we should only do the accounting once rather than once
for each page fault retry.

CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: linux-um@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/um/kernel/trap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8f18cf56b3dd..d162168490d1 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -34,6 +34,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	pte_t *pte;
 	int err = -EFAULT;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+	vm_fault_t fault, major = 0;
 
 	*code_out = SEGV_MAPERR;
 
@@ -73,9 +74,8 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	}
 
 	do {
-		vm_fault_t fault;
-
 		fault = handle_mm_fault(vma, address, flags);
+		major |= fault & VM_FAULT_MAJOR;
 
 		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
 			goto out_nosemaphore;
@@ -92,10 +92,6 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			BUG();
 		}
 		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_MAJOR)
-				current->maj_flt++;
-			else
-				current->min_flt++;
 			if (fault & VM_FAULT_RETRY) {
 				flags |= FAULT_FLAG_TRIED;
 
@@ -103,6 +99,11 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			}
 		}
 
+		if (major)
+			current->maj_flt++;
+		else
+			current->min_flt++;
+
 		pgd = pgd_offset(mm, address);
 		p4d = p4d_offset(pgd, address);
 		pud = pud_offset(p4d, address);
-- 
2.26.2


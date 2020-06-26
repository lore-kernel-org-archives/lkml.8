Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D108B20885
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUSo34w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFZWbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:31:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50236 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgFZWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX5XNFqam9mdd/6wKfca40oUCGNepMLO5UWfniIypyY=;
        b=HUSo34w6hmt0tt/21qy+DZsim4eu0Sml0G/IsNnfnKYvFkFWReTSyOPfzWq9MlHL5/+oRi
        XsZaL4isLXJrFv0PtewgI+vyD8kjZ0QxZU6fG4gGzvtj4r6z25NHA8LlEBv9JJkGi0BpO3
        yjL46/S/pXgtrsRkf0U4oLHTGt2V/SA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-T52QjwUqMWas3RQPZCHI9A-1; Fri, 26 Jun 2020 18:31:36 -0400
X-MC-Unique: T52QjwUqMWas3RQPZCHI9A-1
Received: by mail-qv1-f72.google.com with SMTP id em19so1624124qvb.14
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QX5XNFqam9mdd/6wKfca40oUCGNepMLO5UWfniIypyY=;
        b=AOJpJhWvqPkeTQD8+2Lpo1pzj7UwBIrIPvwj+e6mKrDN6cJ4MdMLeNzdzgg51ZHTaC
         qdd9SAaMduo1SMovOsNUJ1y5W4Lgm1aICahlbwtl95Ui1GaTbqfLBAQkTtAl9SQ1WsGD
         fLYLRifxeGYZ3A779qCJRGIUJ9PrdJMFHNuZGQbktt+No5W4wOndcpahuViMCEnnE1qy
         AvVByTN78vcJDklNqF23ROc2U16doGZdaL0Kw4OE5cN6bD3nI17t4HYFiuU/bLs/Uj+r
         u2YJVWwyk2IPU5DdEpnAx3QF+RGmaxYQKCLIRHGCD7l4Ej5Ypief/jydes9XPwg6963b
         oS6w==
X-Gm-Message-State: AOAM532bLX4Q8fiOVVt5Dy/Q78hqcezKlIaeyr9HENEJLDL1BIoeOuus
        9T8sUw7JffFz3JNqt1/DT8wlOAKT4SJiSD35FgsXKTGjGPU/ncrLP2gGTuGNiPjBO/kMM5ywSDx
        GdVnp+vG27yV3O4h8qcANMpjm
X-Received: by 2002:ac8:2201:: with SMTP id o1mr5258768qto.68.1593210695573;
        Fri, 26 Jun 2020 15:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7yWTEPryaGHfpSKL2GWGcCnPfmI9k8i2GBPufBTdDPbzspX0WX/DcpjvFiBdcbf/0mG7GHQ==
X-Received: by 2002:ac8:2201:: with SMTP id o1mr5258746qto.68.1593210695355;
        Fri, 26 Jun 2020 15:31:35 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 02/26] mm/alpha: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:06 -0400
Message-Id: <20200626223130.199227-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().

Add the missing PERF_COUNT_SW_PAGE_FAULTS perf events too.  Note, the other two
perf events (PERF_COUNT_SW_PAGE_FAULTS_[MAJ|MIN]) were done in handle_mm_fault().

CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: linux-alpha@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/alpha/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 82e72f24486e..2e325af081bc 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 extern void die_if_kernel(char *,struct pt_regs *,long, unsigned long *);
 
@@ -116,6 +117,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 #endif
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -148,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	/* If for any reason at all we couldn't handle the fault,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -164,10 +166,6 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
-			current->maj_flt++;
-		else
-			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2


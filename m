Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C1DC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F91420772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufg7F3nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgF3Upx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47833 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730274AbgF3Upu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ynnJMHDkmLB1gpQYI5LlP8bTNHn29Vusf9IRRJFn7yI=;
        b=Ufg7F3nmvBga7La4MrAhniboqGrDqLHrpaVEn8Ni10clofwftR7Bymxa/C282Z2AlpkIc2
        2PDaPNxLmlDneI22MQ/Vh15BKkbEvMpgm0P7TbkuBZhVqH75JGRsV/4v1C3CHC5DQQX8Ey
        qjvphRLkLdGIoXrjDwnLugx0PR4+c/Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-GUA0D--FMtKQDLcN_My_kw-1; Tue, 30 Jun 2020 16:45:47 -0400
X-MC-Unique: GUA0D--FMtKQDLcN_My_kw-1
Received: by mail-qv1-f69.google.com with SMTP id 59so14672951qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynnJMHDkmLB1gpQYI5LlP8bTNHn29Vusf9IRRJFn7yI=;
        b=S0Fu04o6PPhDFjluxnZSKhZyoUmicvpykayf8Z1aurvto6fAlRhwA3M3ZRMUMtC9hL
         1ZknDQe6ayCWtUtWZ1qSMCwprYbKQwI31QGG3E5uBsJc/E9dr89vvn2vCHLhOB7Szvn5
         6fG9l25Kbu2tCYxcu/ROwHLgVFYAOWmRMLJGm7bQHb81AIQyanZm6nV9tBe4ey+Rg/Jw
         0yVMPI5ZhJCO190uqfIiFRHIA0ZRyvC6ffb4ejPduFikqnrIk4qi+cEgFwJbgHFO1cSE
         dM/tpKmp44PFRaNbpZaKBYRgCsrKofEgN2/X8LXWB0jkp3gay5DEjaGlBPW4QzubXrKb
         HN3A==
X-Gm-Message-State: AOAM5335FD1pXUN3eT2pVVvzepsORp2orevsUXGBf7MOPuq/VNEm5E6V
        KnKvg6VPAsS/4flkxUU1zSZX49jv+4xxS4p35GNAnCqhJJUWIhGe1x7ntD1eiHtF1anH0w31p5q
        qTzI/G3yD4hKOFiZyi11hBg2Z
X-Received: by 2002:a37:6382:: with SMTP id x124mr19156398qkb.13.1593549946777;
        Tue, 30 Jun 2020 13:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYJzOveTh/zHsoqWyRhvWa6nes5qts8kYD9+VOymtjnIw0C/lNBXFLIHdqm4iSlLEtMxrrcQ==
X-Received: by 2002:a37:6382:: with SMTP id x124mr19156332qkb.13.1593549945576;
        Tue, 30 Jun 2020 13:45:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y40sm4291853qtc.29.2020.06.30.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 16/26] mm/powerpc: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:43 -0400
Message-Id: <20200630204543.39245-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().

CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/fault.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 25dee001d8e1..00259e9b452d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -607,7 +607,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	major |= fault & VM_FAULT_MAJOR;
 
@@ -633,14 +633,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	/*
 	 * Major/minor page fault accounting.
 	 */
-	if (major) {
-		current->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
+	if (major)
 		cmo_account_page_fault();
-	} else {
-		current->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
+
 	return 0;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
-- 
2.26.2


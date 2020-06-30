Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF38AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC10720663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5T2Ab1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgF3Up6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:45:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40767 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729988AbgF3Upw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mfudH1gu1GL1LZqxVEZK8L9MFfxsg/gHPxv1OKTQK3E=;
        b=I5T2Ab1L9wfKsjpMXq9gIZCBtz2KGS0SfTrBAo7U2ExcGsGTFiAdFvYToJkUEIFhhq1o0A
        Jk1TfT1+HmGALtgSFisJX/etTbYIlwO2vvIiEr+tktW0SctL9I7h0LTtotum50ShfoaMHc
        vSrS9zwXWJ3oN8eWYxxyZkH/Yam4eLE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-8vzzgbZSN-iTBXb_pmrGqA-1; Tue, 30 Jun 2020 16:45:49 -0400
X-MC-Unique: 8vzzgbZSN-iTBXb_pmrGqA-1
Received: by mail-qt1-f198.google.com with SMTP id t32so15320397qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfudH1gu1GL1LZqxVEZK8L9MFfxsg/gHPxv1OKTQK3E=;
        b=as1G8YKREeiiDV6ByrAcWuyQ9zjTZwz+o3fRsRwAhDW2qPX76h3ei5nCiXTVg2c/nV
         hKQ5aSfAEKSXJr7PWrkIDM/DH7fESiiTHPN3Gcx+vKFx66m9iBM/bXjuINVTlEUSu4L1
         VRp/DGP0ugJQahXYFft9X6DrlN8toqmYAS7nrmvCmb9YrdwixREuBxvVf3pEYQR6mO0n
         9DjqRh0nibskjmtA7jXra5Ai/9dJ+Ad0xIEmFaEjYOluh/QePraOsNq2HsFNbt4U4i/+
         nCszHVj88PmhDoNomH3TogwIiXrh37WTckhg2+7mcfSEP46VtYLRo0GZ5IhIu1J+G8iy
         phBw==
X-Gm-Message-State: AOAM530Znk96P0ixE1tLUDOyriVbBOdZYXBwtYUzEojFr4TKnMHJx3XV
        Nxf5CBczc2wQPqpwnRUxlZVRhpjiNag9jU2BXUAXxGF4OktfbWG1rWKiH6Cm0m6eIfcEGpiUxsd
        VW+iOeLT2nmcLde4fAkfi9vzl
X-Received: by 2002:a37:5c7:: with SMTP id 190mr21417903qkf.479.1593549948401;
        Tue, 30 Jun 2020 13:45:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyumlFzo2DUqNktzirguzAlyAPQFn8TaOIfLX5bHcMtCXo263dv1sp1iQI8Cs0ZPWsxzyNVig==
X-Received: by 2002:a37:5c7:: with SMTP id 190mr21417870qkf.479.1593549948141;
        Tue, 30 Jun 2020 13:45:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p63sm4107348qkc.80.2020.06.30.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 17/26] mm/riscv: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:45 -0400
Message-Id: <20200630204545.39293-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: linux-riscv@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/riscv/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 50a952a68433..e72cec09d55b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -110,7 +110,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, addr, flags, NULL);
+	fault = handle_mm_fault(vma, addr, flags, regs);
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
@@ -128,21 +128,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		BUG();
 	}
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, addr);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, addr);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2


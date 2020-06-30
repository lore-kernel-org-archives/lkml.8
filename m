Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A5120663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9i97eOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgF3Uq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:46:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730025AbgF3UpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7ODhBJEySE25lLdIL36bUDM3v/f2DyEns/dEg5PpJb4=;
        b=X9i97eOSaM7f8AHEbT2WJuVItaQLrRsPSCpMXptIhKOZeZGy8QJ0CshukCUPOTD1Uif66r
        kdhIDPVbxBN0dsxZxufgcwq4Buety130gEHTdEcn2h6E3XZWEGRFmdbq12x0AapI90LUd7
        2nfhiT5xORDnXKFtjk3kLn/9Cukpk1o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-aQIOdWxhOeifP4dj577dPQ-1; Tue, 30 Jun 2020 16:45:22 -0400
X-MC-Unique: aQIOdWxhOeifP4dj577dPQ-1
Received: by mail-qt1-f199.google.com with SMTP id e4so15310031qtd.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ODhBJEySE25lLdIL36bUDM3v/f2DyEns/dEg5PpJb4=;
        b=bBpyFgPqvvSgIsWfHuaIkZa+uvM/Xaeu1NQEJczSrhXBD14ef18rQazUrO4+yfaUuG
         6PugcXMpSOLe8JSHTAPQRhj5XBxSsRsZk86Xvyn2MbcCp6ncX6wKP0rKCn6hKnCDySCq
         PE6Qa8g6TvjaJ3Y1+mgAsBeBrob95Qsw1IM3l068qYnhpl9kn4aspu0E3ULLT98CMvss
         PxYND+Pi34hET41TgI0ch72aYhJbEncnxdmhQoHsy4SbAV2SZi8F2JcxGKYVTMs2hC+c
         9AzHMyD3tfYXyEOLzgJ4XFVqBes9hiFy8e2cK+lOtbdVZdjLnC/vrgtvFOBsVAObzuuJ
         w6mA==
X-Gm-Message-State: AOAM530z+1laZF2r6MeuUFPnBpZkH6rk42a5sjDG8QlEbp+jafW6c7Wn
        nXaqqRwUtrQSGmLAadqetd1MFpCZQyr6/IEiJWNUCYFaeYl/NRpPUPquKXp9/8VzjHUsaRQAnEG
        GpXkphvsNbIZvoxAtDo/WwxIX
X-Received: by 2002:a0c:a306:: with SMTP id u6mr8860905qvu.88.1593549920886;
        Tue, 30 Jun 2020 13:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ZC/3hV5sZ3jrFOaj/HrUvlBV2LSVm33S24f5OpZpmLOt/vUUR0YiRw9Ypkc2T/z0QGSYbg==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr8860803qvu.88.1593549919465;
        Tue, 30 Jun 2020 13:45:19 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y16sm4443907qty.1.2020.06.30.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH v4 06/26] mm/csky: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:17 -0400
Message-Id: <20200630204517.38760-1-peterx@redhat.com>
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

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7137e2e8dc57..c3f580714ee4 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
-				NULL);
+				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	mmap_read_unlock(mm);
 	return;
 
-- 
2.26.2


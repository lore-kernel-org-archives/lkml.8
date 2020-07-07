Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B4DC433E8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E3720738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlhzM7j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgGGWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54253 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729064AbgGGWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goLnSgg43tg59jYNEWM6oaQtVeQ81wyjekL4b1iRhCw=;
        b=dlhzM7j75D1pS1ALpSoY87CQWZw9pKvjN6HBy+TwBkT6JNjkkoa1PS0BgpG5xSFcJqPo8K
        IBNxQdcDOKmhYkhsrFRGo4pYfzwRN4KI+nDsIO9+7V11EzuN2lZK2n1QLsYPy/9X/E/oxE
        LYWSWvsKZnyz65W/zYWKbxEnbYN/ToI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-2vzrVka_NqaQIzdlSHH2cw-1; Tue, 07 Jul 2020 18:50:58 -0400
X-MC-Unique: 2vzrVka_NqaQIzdlSHH2cw-1
Received: by mail-qt1-f199.google.com with SMTP id z26so13360262qto.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goLnSgg43tg59jYNEWM6oaQtVeQ81wyjekL4b1iRhCw=;
        b=kN43JkUAG6e1TWB9KFlO6Q5TlFZ+Wa91O1w0KRzLMZr1oZft9Me966AbzxT2RRkegn
         tvssR5442Zmz1dUDXH29botxd9dxwOxg2s0K5L9PBY4B/rrdVoq52aeF6rcmC2QyhvCr
         OUOm2K9BE0i8+0vjbO4RsmCRpUcCkxip7ZSbOjU58XURM9W2zlHnHQDWmVaNgagHCsrn
         keOU3NjmsrqzoH4AlallwmghmoYEDe7QK7raFQGOSyRit5Jv2z+fRiD65k7bTf4fvskJ
         iAweKOouzUDkZvKgos71AYAARG9asy5L+Db94u7HRmptMR6Fk0pTwFVPGAgubc3DHLmb
         qzug==
X-Gm-Message-State: AOAM533DighMnV7iGRo/eb6dM61P4A/AR3hNH070RFiQzX0gMWQasYjV
        ZnQqEhAhAJaOE1iBFBtJTO49ZF+UGK+XBpc9+rufIanGkZov2DsCUYcrqwH4DUdnC6NjoVgR0Vu
        hHrlu4yxE6lRrO302KaZmDTBI
X-Received: by 2002:a37:c246:: with SMTP id j6mr51752080qkm.444.1594162257353;
        Tue, 07 Jul 2020 15:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/jy6TEpSsbY6d9HXsHHh/wU6lHsQhKJI3A8F2vFrC2VOLnGIMx4NbmWJ0GFeoTMgVhdK5UA==
X-Received: by 2002:a37:c246:: with SMTP id j6mr51752065qkm.444.1594162257119;
        Tue, 07 Jul 2020 15:50:57 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH v5 20/25] mm/sparc32: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:16 -0400
Message-Id: <20200707225021.200906-21-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_32.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 06af03db4417..8071bfd72349 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -234,7 +234,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -250,15 +250,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, address);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2


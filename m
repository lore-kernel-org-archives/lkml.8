Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604732168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brCeUYEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394393AbgFSQNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:13:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391485AbgFSQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qSToaPYAxy41TNCcRoZVJZv9P7/HBXlbwWJ2Rk2g+I=;
        b=brCeUYEuGUc8O0y0d0KLSHPvLjnttWqnVwVNsXG29Wd9/k+3bRhDCa1mdV2PJvjpkN51hJ
        /8wkYuVUlDKOka8QEyv7VYti8FqyKxVRbKMN2LK36YVmkdKBU0aNwNXYUskQ8Uox8tq3Mv
        FO2dY7BLPJBn28hl8CURyvax+BON6rE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-lQ_fRiqJOWuYszhH5N8upg-1; Fri, 19 Jun 2020 12:13:32 -0400
X-MC-Unique: lQ_fRiqJOWuYszhH5N8upg-1
Received: by mail-qk1-f199.google.com with SMTP id w14so7560834qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qSToaPYAxy41TNCcRoZVJZv9P7/HBXlbwWJ2Rk2g+I=;
        b=eeyIAVkb90zGRS4qQzgZ54XCXLgXSHGeGAxArd6W+mj5O/QMppyP1kJDGgRzviwYS7
         6mF3OuCvzVFcudF6qrPY86Kwo/XLAgAZKUHYuaNUZk4vE/6dtaA0lTGnoggke0xTL5V2
         uslPBjT45s1u4e1dJrHGO/RZPHXxiBj+JYDnh0jHTycbgXbHBMne4Aw/WX5OilGpk9wP
         OnQnsWDsc2Hz4qp60ndsGuahSRFEb5HPPN0DJRdq29YCOJJz847+hgu5f1+td72w1ZOm
         ZlNbymBjrG7Hyw8La5wfRIFZHE8eDXNBflsy99x4TC4m+Famq2XIDwFP6XgUPAoZp1e/
         TFnQ==
X-Gm-Message-State: AOAM531BDb+HDCKxg77Arn09ND7P/+bQTfXcJf8trpQ9KrJ1BY9fmmxA
        LezLWr1D4gjzY3iZ1Bv9FAb7G2MST7+5KwEOiN4I8yfLljgotWdk7YyjSkqhIag3KffXJ9fKuxc
        4DCyqOIHzRtAlcG79S1haY7AW
X-Received: by 2002:ac8:46d6:: with SMTP id h22mr4171913qto.145.1592583211270;
        Fri, 19 Jun 2020 09:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPf3L9dwnzhcKrCo1xqDr8zLwbACSJhy9YaZ+W+WiIy3zkGSSlH37gZSMbp9D62VN2NzGxsA==
X-Received: by 2002:ac8:46d6:: with SMTP id h22mr4171872qto.145.1592583210896;
        Fri, 19 Jun 2020 09:13:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s52sm7597075qtb.3.2020.06.19.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:30 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/26] mm/powerpc: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:27 -0400
Message-Id: <20200619161327.9564-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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
index 992b10c3761c..e325d13efaf5 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -563,7 +563,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 #ifdef CONFIG_PPC_MEM_KEYS
 	/*
@@ -604,14 +604,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
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


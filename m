Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E3B208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0Mg5X4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgFZWgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFZWga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qSToaPYAxy41TNCcRoZVJZv9P7/HBXlbwWJ2Rk2g+I=;
        b=b0Mg5X4/cBZ6ucue+LJjSlQwp/YSRGaC2id6G5ExWiijVzTSduwBNuwQGgcsv3AUj/eVd4
        uEVs6345LLMeltJBwEL8iRNXTxa6c9yzJBP0RIqvND1/dDlgbLJn0YCv01gO7VvJFGPQWD
        ueNN8wCcxD5dfo7X/blwoxUgx+FGOrw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-2RLil14vNwqfoAimg9bKnQ-1; Fri, 26 Jun 2020 18:36:25 -0400
X-MC-Unique: 2RLil14vNwqfoAimg9bKnQ-1
Received: by mail-qt1-f197.google.com with SMTP id o11so7503615qti.23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qSToaPYAxy41TNCcRoZVJZv9P7/HBXlbwWJ2Rk2g+I=;
        b=EDL0INCKj/3QOi3l6U8jnYwPJN/VPwB3vohEODdekZOUmPphB5xbNFg92o9NFZA2n6
         BCUVHcHKiAYjpXfHxN/Mu8EoJRNgOnFy22Iy8D63p7BS9O0v8o0QAMB0rLHd5UgT0/vB
         QGdmsskPbWyqCTLgnPV9M30eSPBDXQVpBh6nvwrRJTZ2unIprg5fBkKFN/VhHbHnukMK
         9+ie/JM9Q9s0G19W3iAboMfkN8hPLsFfxcK+jRaKJ+kZH57eR0kAzixZd+sURxw8JIFj
         PDf/Vwo3tI1P1COdpDkDNYmDTgpjb/RHkwPJMQ0nWh15fGz6eZe9RynS+utuz54pTNsv
         EmaA==
X-Gm-Message-State: AOAM531H6nPXt4eWqjMzXU/do26X11tAmcuyWbJCDVNt76bnHJCBBVpF
        MlzoBEFx8kv8bx2PmQlmQNsOSCPpRuOYSg493u4WXlvzN7mY8kD1Blaq3VO5jvasoadOko5US9n
        B+POsqSBEo7A89CEH6/E/p1Mc
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr4839641qki.393.1593210985200;
        Fri, 26 Jun 2020 15:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCBCcJ2UOlHKiOErZOy/wQGbA8OVSFmjMRFnS3kp8IUFptdYH3jiRcE+pFBOUD78E2vWdkxQ==
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr4839619qki.393.1593210984950;
        Fri, 26 Jun 2020 15:36:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p125sm9108324qke.78.2020.06.26.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/26] mm/powerpc: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:22 -0400
Message-Id: <20200626223622.199765-1-peterx@redhat.com>
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


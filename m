Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A59C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B061120B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbl3X+rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgFZWgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:36:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgFZWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T4PahBLwp+qMqIXI+a8sKJL/5YpPnDyt5GJ45wieOk=;
        b=Bbl3X+rve91/4f1eQdhvyX7GQiB/1WhukmX1T5gjWtnFssT+87pJ/zIVTWH4rnreBhmz/s
        5s+owkIPdeymoGM/9R6xn7EYobebqlHSQ6aJgaR9kWTaD29Zn0ytUhfAMzZJyyx9nXH4hg
        gIJhxp1DpMq0gwqt7P5iVmLzdmRk9mA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-C8l5OkmCOjOGkWUkUe5DTw-1; Fri, 26 Jun 2020 18:36:36 -0400
X-MC-Unique: C8l5OkmCOjOGkWUkUe5DTw-1
Received: by mail-qv1-f72.google.com with SMTP id s20so7362280qvw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T4PahBLwp+qMqIXI+a8sKJL/5YpPnDyt5GJ45wieOk=;
        b=dCPXn/1SZfFYSbRzfZ21DSMh3XzAOG6s1/UUvNxJUNvy+UaFnD8T6P9hlepjJdyt37
         rVyXScixc4v8ACdY+paHRLL2paZKSF8GlePf3XswlDDayVY41Pw/kEHgzoz8qTaetbE7
         1V1RM8km8ZoDY2G1Xyp7VG4waQIDy/nFgkjKH/Yt8R4pjosnqzb2n9/NDZ/lGuvr4/2N
         kQoEDCWNcTS2S5l1giVm+10kmZXdbMOZAabSs9NHO+OCky2JXp5rv1zvUpsLtUR6c1Hx
         7Ry0YzIJq70aiLbKNiVJ6Jds4ILDVE0cM9llWH9Xu99Ili6K0YAIhk02sr+VadcPr8f8
         01CQ==
X-Gm-Message-State: AOAM5310pjtGXMiIUFdGAXeTfnZjKGaeMh5Udv2W1+AjcvYcJvn8jcHX
        NNIi8emxbTFI5+EYyBh6iAoxdtuBUm7aAT22EbLtAu+xyCPsxFFFUmto0ALr2QwS0OlEgazV3OM
        5Wwdkbpv28o7x9nqPXiOMrc/c
X-Received: by 2002:a0c:b5db:: with SMTP id o27mr5409112qvf.205.1593210995312;
        Fri, 26 Jun 2020 15:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlD82Q8cmc5NmNE8445OCDFJdhANJej0rzVbZKfEZCyzpK7wCQulyA+sPy13MiOQo1jaWdnA==
X-Received: by 2002:a0c:b5db:: with SMTP id o27mr5409095qvf.205.1593210995113;
        Fri, 26 Jun 2020 15:36:35 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s71sm9636682qke.0.2020.06.26.15.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: [PATCH 20/26] mm/sparc32: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:32 -0400
Message-Id: <20200626223632.199958-1-peterx@redhat.com>
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
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_32.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 61524d284706..542bf034962f 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -235,7 +235,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -251,15 +251,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
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


Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC1C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E262075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQxYnMV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgGGWu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:50:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729695AbgGGWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmLZf6AJOqhj6CgptEYub+5PD04MI0cndAP6UETZVFY=;
        b=bQxYnMV0Lxf/qfyEhKxwWWNddQYdKhJxMYXUHzpoHmD4EVi93vosUyOFuHPaMkB7o0X2UG
        uegVZVh1JHEIVUSgWLML6vSvCCi8cRJpZTnMS//bwRgbRni1Ei5u7n2LNPdDA3JraMcOWT
        hH60p/SpoCf3XG/Vgly+GRVm9YPjt0Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-5ZE68IXIPeKS9SwCriX4wQ-1; Tue, 07 Jul 2020 18:50:51 -0400
X-MC-Unique: 5ZE68IXIPeKS9SwCriX4wQ-1
Received: by mail-qk1-f199.google.com with SMTP id a205so29579375qkc.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 15:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmLZf6AJOqhj6CgptEYub+5PD04MI0cndAP6UETZVFY=;
        b=ojcr8/nXLH7p8qcx0B+j0bV7Tk64BeNKNFL42F8ipqO+vVpQGllUbF2J4MxjLIVi6J
         9x+zONg4HkPwAar2LOC8GPGgBxh7r98u5m8RbluWl55eQSMWkxrOhyiolo3BxvH5iIQp
         uroha4oVteWwYgqaNvPKj9RuNjb/DBp8uWonygYb44WvXHnoja6CeX5v6DPU9XKsalzp
         Sqg8SWWoCXJ8fzSG6v4AwKwzaCZzp35syqTVy304NGtkk18n0+GTFLs2UAmpMTypzvxq
         bdUO+ttOOLc2exh5dMp4AMuOKf2mjo7N/+jS2YrfQuQEFW5VGsIeS3adkBYZJ9CSM+f9
         5omA==
X-Gm-Message-State: AOAM530nFGiCuB2oIVGZ9Mtp0hiegankpzmpwaP5BH96/EE3sotEMfOM
        oIefahotTQ3PX7jfwJ6jGC/215lhEN8bkXwxp0VTPhFbmsaj6hBjZj0uNiMwvQghnDLLj8iJEnK
        8EeONaX8uuvwyZb7q6Ux+lgqJ
X-Received: by 2002:a0c:b88d:: with SMTP id y13mr48924488qvf.82.1594162250470;
        Tue, 07 Jul 2020 15:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiL/ertHlMtVAwiEgBsckzbOTj5OmrrUyC7CcF266qmLzt4w9AsKT415R55VH7drOKCUmHHA==
X-Received: by 2002:a0c:b88d:: with SMTP id y13mr48924470qvf.82.1594162250236;
        Tue, 07 Jul 2020 15:50:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:49 -0700 (PDT)
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 16/25] mm/powerpc: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:12 -0400
Message-Id: <20200707225021.200906-17-peterx@redhat.com>
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

CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
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


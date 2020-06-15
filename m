Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B56207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSM47lf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFOWXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35549 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726586AbgFOWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PArYWb352L+DXtBq06f75Fl1n2OZ3XFiT47vlDcADhg=;
        b=aSM47lf1KfcEuK/VLXfZUUEWv/uL8YMpoGJjhSAv/nhM7W+c5tGuTLcleZqesS1qqBP8la
        icD6m8xCHyx4AP5pvt+NTyL8vlo0TCgkwIz+gEetcIjDAKjIqKUNGKQLMNlQiXCn4XLfpz
        aIH17ZofzB8SBbGML+NB8/Zk+J5WJqc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-NiK-pjnfOWaXD0JaNFlKgw-1; Mon, 15 Jun 2020 18:23:27 -0400
X-MC-Unique: NiK-pjnfOWaXD0JaNFlKgw-1
Received: by mail-qk1-f198.google.com with SMTP id l184so15436859qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PArYWb352L+DXtBq06f75Fl1n2OZ3XFiT47vlDcADhg=;
        b=YuvhECjDLRAHATUhoIx7ajMe6FH+DK8jWI8uylIjX3yN87ovkbk9gjAJwCIBX5V5FN
         ZFV0RVnoQKRhhQAChQnXIC0AfNNysEZgr4jMRYZy0JkK4sbKw4CaDbtZQTqucpgy9yZD
         u3M6g1jto9K1Gg0f+t+ETUZLFOdwIzN314Ra7wH1K707LKdiZFltOvPhBqeSZ/BuKCtP
         iIAJentdTYLV8nrtk0MAo1A7a0t7981AzKPqd9PbHnrQD2KZJFmzp6GzO2xLyv6vdPVD
         aKCDs8azfRc7ryywAXIMjfkKc7JvH3YuYrAGxL3iHz6JTcEZ6Rjai531anKnggg/TMc0
         EHyg==
X-Gm-Message-State: AOAM530wHqN7TMrRzgfsBr/OXzA4mvxfiFISZATAM6VSrkV9SbTWLsLR
        z+yNuxHK5AxZIz9PCv0I9A+fAevVZ6i2YbpQb/6mPwpsYTcqfpAteTepLxfvWhrZcuTUIhlhA6+
        xQ4WMgBjsEsf9lWTxyXYPn1vP
X-Received: by 2002:a37:a8c4:: with SMTP id r187mr17219548qke.69.1592259806899;
        Mon, 15 Jun 2020 15:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqzLJ4nMx84B84gaHqUo/mvW9t/ICqjrZOeoiG79cBgInmIk8QWfRcMAT7nn037h3mNflcvw==
X-Received: by 2002:a37:a8c4:: with SMTP id r187mr17219521qke.69.1592259806700;
        Mon, 15 Jun 2020 15:23:26 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i3sm11867984qkf.39.2020.06.15.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 24/25] mm/x86: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:24 -0400
Message-Id: <20200615222324.8697-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: x86@kernel.org
CC: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..28635b4e324c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1365,8 +1365,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 			local_irq_enable();
 	}
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	if (hw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (hw_error_code & X86_PF_INSTR)
@@ -1493,13 +1491,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Major/minor page fault accounting. If any of the events
 	 * returned VM_FAULT_MAJOR, we account it as a major fault.
 	 */
-	if (major) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
+	mm_fault_accounting(tsk, regs, address, major);
 
 	check_v8086_mode(regs, address, tsk);
 }
-- 
2.26.2


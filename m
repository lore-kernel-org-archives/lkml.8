Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790AC2D0E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDD208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="W08QSBFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCZDYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40516 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgCZDYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id c9so4190853qtw.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=d2Tg6DUqu4h4AoeF1TJqlJ7g20oT0br2Hcwg7d/p1G4=;
        b=W08QSBFeQAtNj54YvzgesJNcVcH7833kHC2Us83ZevVOe7Do2dNazfnDt+CowHHQIC
         faz2AvdaBb/yLUxNw0/J44AfAn28mCBeR6ZDqxdwi8lE6AphaLIb5sZ6jxgB7vY9oOIk
         WirTf2XUGuqGE0ims6heIVFQaZ1NjjK4vA/HACW8LgMbhJcnRZ8fO4gf3Ukmff15jWgO
         itOmuS1IhfrI1BHKq+fLFhc1JPpepcBtDb/iE42VAxTYZOSl8arS8TAxmsuXEpTMt1T1
         QX+gB0l2JZ6f1BbyCORa0271cXO+lTRznlXSB/d/5l8qUgKci6e0pTZFXHFGgQZwxPKx
         G61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=d2Tg6DUqu4h4AoeF1TJqlJ7g20oT0br2Hcwg7d/p1G4=;
        b=h7r/nOo5DWtQFQILeBhIlyLixNxmcBd4H3uNPXdUp0DlroFLfRDW9rRCKKGH65Cx16
         RcVOMH1HYs9Lsdaz8Ljj8ZaSuduIDeiJzPFmqHja3fX0XOHNL/j2uD1TYTVc92QYn2/I
         86syD44JCYsACy+hksTc7Vqk4ikHr4W7Wrhqci7B4JJvNZUVyNZK20nch4e6Wpg7ZlgW
         q4Hi5MAEzbns/Tg2Ns1lh+r9P7/F2r6gei/E5CKFto6DJdl2JEkyMzHJLHA3lTL6Z8mF
         5zJBSuRSPqFAsEYf6SI7Giul/yMbF0HaIWqB6rcSWzvccOR8WnpILyGG3wLzJ5Ji/AQ1
         eVkg==
X-Gm-Message-State: ANhLgQ3Cz+cbf+BXcw4Zu/InQrC8YVrh2PbIaAZpgdYO0xG7Cdjr3aJu
        1vpvZVfiRvQxkju/U23D/DQQVA==
X-Google-Smtp-Source: ADFU+vtNI1N6KYYNTKClbFa5p1eL7S/68psb1NMui9aroUYD5+m0J4zDvXEIXwzpeJXNUnHnRvaNyA==
X-Received: by 2002:ac8:6edc:: with SMTP id f28mr3781501qtv.271.1585193078245;
        Wed, 25 Mar 2020 20:24:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:37 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 10/18] arm64: kexec: cpu_soft_restart change argument types
Date:   Wed, 25 Mar 2020 23:24:12 -0400
Message-Id: <20200326032420.27220-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change argument types from unsigned long to a more descriptive
phys_addr_t.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/cpu-reset.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..38cbd4068019 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -10,17 +10,17 @@
 
 #include <asm/virt.h>
 
-void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
+void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
+			phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
+					       phys_addr_t arg0,
+					       phys_addr_t arg1,
+					       phys_addr_t arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
+	phys_addr_t el2_switch = !is_kernel_in_hyp_mode() &&
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
-- 
2.17.1


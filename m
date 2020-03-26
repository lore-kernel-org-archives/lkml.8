Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32DFC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE32074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YNFNHzcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgCZDZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:25:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46297 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbgCZDYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id u4so5057153qkj.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BKhAx6BebFw/oEITnjoM5nL1ibAHOPqPAiH4c9gaYa8=;
        b=YNFNHzcL8opCZWUO6XnLzhdlsu4Yy+Rizy9yCWVbFy3ZRpvtcZv2puWnEOvUC3b1Vt
         XHs+hMfat0AMwYaJFwe1RjtrQM1/uslxPjzHvIs14d1/5BioLW/YL75JijXhWEBD/9yF
         5sEve9b8u+au7l1RKRTggSnH7moh6udjbiEcmw0ePceWaMVwexeB6yeHT0HIof6DX8JL
         fQtTMoJKaZnvMyOB2sU5splZqi4JPAZcRlyG/7Pf29MOG3wsql0XOZOoGU/cimjTj6y2
         2DVjOG87kdt+O93WALQb53VWLj/tVNY4j/j+Wlv7R+JedlxC22BoesYGUjxdDwJ3uBn7
         zG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BKhAx6BebFw/oEITnjoM5nL1ibAHOPqPAiH4c9gaYa8=;
        b=F1Y3kg5XYIUDjQ97k9oCMYASC+10ecS4yluNAzZWhQDCNWRqjkZiBsAvLkPgUsMeEm
         A8ibVOlk8GCHOJf59wtp4w5B8ZaaOtU+jnoIWRKRdX56ZEfuma0yMJgD9tkrUxkKnItA
         VEjf7W96D7UCczMxjqscvmmrk57Gv7WNpXePSDk9KoEtAbP1kQq0APHF0cAKekdChC0d
         6S0UZmCGCgxr/5hl6x9XHJTw43YuwCk09GV/W3KaeUcmP8uvZestd85IY/AgZrOS7Rk0
         XQ5URGQHG9mT0tXszT/fhWnXSq+JBNRun7n7LME7yKk1xZif54rXrqc+HQ34HvsWU6pa
         vvxA==
X-Gm-Message-State: ANhLgQ3U+ozrYiNydl1V2/xacrI45ECKHIoEIadkdpj3VWeDK7CXJiL8
        m7Atu4t+vsNVZAdFt1f1CRE9Lg==
X-Google-Smtp-Source: ADFU+vsaZX4t6NPWbuLtjOb6I822H6afCjwQpAn6wOnDl28ywTXqmlBMj7nd/Y69a1G7LrS1oIl+Zw==
X-Received: by 2002:a37:a543:: with SMTP id o64mr6053234qke.460.1585193072231;
        Wed, 25 Mar 2020 20:24:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:31 -0700 (PDT)
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
Subject: [PATCH v9 06/18] arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
Date:   Wed, 25 Mar 2020 23:24:08 -0400
Message-Id: <20200326032420.27220-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Because only the idmap sets a non-standard T0SZ, __cpu_set_tcr_t0sz()
can check for platforms that need to do this using
__cpu_uses_extended_idmap() before doing its work.

The idmap is only built with enough levels, (and T0SZ bits) to map
its single page.

To allow hibernate, and then kexec to idmap their single page copy
routines, __cpu_set_tcr_t0sz() needs to consider additional users,
who may need a different number of levels/T0SZ-bits to the idmap.
(i.e. VA_BITS may be enough for the idmap, but not hibernate/kexec)

Always read TCR_EL1, and check whether any work needs doing for
this request. __cpu_uses_extended_idmap() remains as it is used
by KVM, whose idmap is also part of the kernel image.

This mostly affects the cpuidle path, where we now get an extra
system register read .

CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3827ff4040a3..09ecbfd0ad2e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -79,16 +79,15 @@ static inline bool __cpu_uses_extended_idmap_level(void)
 }
 
 /*
- * Set TCR.T0SZ to its default value (based on VA_BITS)
+ * Ensure TCR.T0SZ is set to the provided value.
  */
 static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
-	unsigned long tcr;
+	unsigned long tcr = read_sysreg(tcr_el1);
 
-	if (!__cpu_uses_extended_idmap())
+	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
 		return;
 
-	tcr = read_sysreg(tcr_el1);
 	tcr &= ~TCR_T0SZ_MASK;
 	tcr |= t0sz << TCR_T0SZ_OFFSET;
 	write_sysreg(tcr, tcr_el1);
-- 
2.17.1


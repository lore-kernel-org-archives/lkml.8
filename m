Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD510C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B41220771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5pdJaOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406838AbgDPF1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406517AbgDPF0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5EEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so946492pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+clC7a2/1FEkxH5L412Da4FtFwUsVwwlBRiREeEjlLw=;
        b=V5pdJaOvRn+DHbnxN6QoJiCMe7RWYYKUXbeReCoVSsHWYcF7ML2ovCf36gqPglEB9T
         X2kXrmroM/bHXrc6F+99r+yIBpvSN6LNCnCCcDE9JhkfhYH6VP4fouEiOyHGKPj9sK9w
         SVvNje5mZ1JA3oz7WM7MST0a7UMZSg3EwpWthfJ5TjTF5mcpsQA7QvDDAo62sb3WcjxL
         PJ6/cbRib1prgDgG5P/7bLl/IFbnTGC6bRIy+zrBmQ8TvdCOxiiAnsGZg26r5KXeq75M
         byXsvMAXEPvE4lNzgUEX0DA6kD9HCEg6xVHwwVjjpAKwScHqYa6Gar6yoSmNkjEX3t3B
         ObFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+clC7a2/1FEkxH5L412Da4FtFwUsVwwlBRiREeEjlLw=;
        b=JkoPbM1043YAMLqW7PIK90wPev0rQCillrhmnbeWApChI2yBcCAn3ZfaF1XCNoP1jG
         72kMbswqVap8cgHE2B8ZgkUTxXNhltdyxqe+AcROIzrFS3Trx1tgNy6aqu5m0Fu5lBSc
         56j0I6T0gZ824xtf41S7cxAbwvtOg7kLn0yfdVqZg9TEnfmfR81G6MB51FSG1Xlg6IF/
         LGAyPUKWGGaDZtCecZzFQkfbSwd3RCz+V0o5/5DW5YGVcqb/lD1q5iGMBdqDC6EKyN1D
         5FWkM3oYiIPob4mv/luYAI7sb2QJyPjYuc2ubvwPdDdypp/Vz2b3xXONkznnSeOs+SzI
         Cl2g==
X-Gm-Message-State: AGi0PuYdx+Yyk82eKKNN6KhGP8IcjPeKA0dpjdNqDIR/Q0aB7wxFNOet
        d6pN/pc/0GMc0Wg7Y9rZpAk=
X-Google-Smtp-Source: APiQypJYSDvwlGCvr5dvbD0A+DHSbieYwKyY0491/Fvf4ywv0PRbK0VmBw+hCLL1KjNWod/U2Q8B/A==
X-Received: by 2002:a17:90a:1910:: with SMTP id 16mr3074324pjg.119.1587014809274;
        Wed, 15 Apr 2020 22:26:49 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:48 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 6/6] arm64: enable time namespace support
Date:   Wed, 15 Apr 2020 22:26:18 -0700
Message-Id: <20200416052618.804515-7-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_TIME_NS is dependes on GENERIC_VDSO_TIME_NS.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..68619faf0838 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -110,6 +110,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
-- 
2.24.1


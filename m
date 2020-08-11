Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5541C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B9720771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="FkfQGzpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHKSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:25:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA228C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:25:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so12395186wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg0VF6ErX5lT4lkgbP5PbpghpVG9uMhPSEFo6VamS/k=;
        b=FkfQGzpI44fbqgrcOaj1mgkIjSMLmbJv3+916pIl7eKyrNEb/q5Qf6pcbttxCIlXMC
         soo0SglK/yG3GOLxSmMNYjNLmD7B9jzwqC5PD5sxiif9EaDqEngFD8CtscBayUAhhNdK
         yzJHHOxgnoLpCozUcFjyDe3yvHFeV7Fn3ESp+MZ4cQDAjhBDUgjr02p9Q0Y5IoSjPOQF
         zL0/wsPE7hZnmXCGQsn0tHiUM6Mqa2SMZqVY9ojuftOmgiDa6D0KYCDXNku/nfRfNG6/
         rulqM/TzsVmO14H6DC6ye4zfwGMM3nqJRuTAR9EAcJgD8CBbRPrAElqfkAHRmLM2ctPW
         +A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg0VF6ErX5lT4lkgbP5PbpghpVG9uMhPSEFo6VamS/k=;
        b=EUqyYnvGTvHMLIQXBzOyK5fF6AmKct1krD46SgufRJtLhrnyCOEdu+VH8/aNT/doZh
         yY5pW0EuoFA9zkjlof69IWq3LxstgmeCB20heCsFOmot7ugCDnri2CKCryLnBm4z5+Qf
         sYWPewhYVo22v0QJR7nid46HcUFKt5hHNs8kXs2FHlCpoMO7eC6QY+F/R0gpqLz2qm8f
         jpt3RNka+lXG9CBhZqkljZ5+5TUoaS7Up+lHZKrVdEIzIPK4DAKt0sSG2aVxNGLT4G/D
         sNs8cPGAQnGLVcheRuEszCfPG1I9YQ87QbAx4okbCUp8cUB/MZhg+bx9Oj8sebl5jiTC
         q9eA==
X-Gm-Message-State: AOAM531BdiqJNeDcj8siG3nKakG0tbfc8WZXeBuUxJZoQ3nozjekbpXw
        TDmOsLJkZBNy1ar3UuD8xsp1RQ==
X-Google-Smtp-Source: ABdhPJx3xd5kWvkA/X2/NFNPoUCPO1s6nR2S1WU2LkG5uY9O7IMEyCUYrD8bC3Aplc8N5CFwdop0eg==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr29945727wru.222.1597170335629;
        Tue, 11 Aug 2020 11:25:35 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id i4sm28401118wrw.26.2020.08.11.11.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 11:25:35 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
        id 6EE9C207EFCE4D; Tue, 11 Aug 2020 19:25:34 +0100 (BST)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Scheiner <frank.scheiner@web.de>
Subject: [PATCH v2] arch/ia64: Restore arch-specific pgd_offset_k implementation
Date:   Tue, 11 Aug 2020 19:24:57 +0100
Message-Id: <20200811182457.57957-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <fe587e09-2835-87b9-ceed-89cdb81f327c@physik.fu-berlin.de>
References: <fe587e09-2835-87b9-ceed-89cdb81f327c@physik.fu-berlin.de> <fa71f38e-b191-597a-6359-502cba197050@physik.fu-berlin.de> <AA5E212C-56ED-4DB9-9CC1-EB13745DD5AF@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA-64 is special and treats pgd_offset_k differently from pgd_offset by
not including the region number, and init_mm's PGD is such that it only
points to the kernel's region's PGD. This was broken in 974b9b2c68 which
unified the two and therefore included the region number, causing it to
go way out of bounds of the kernel's PGD, which made the kernel hang
during early boot. Thus, permit pgd_offset_k to be overridden like the
other macros and override it on IA-64 with the old implementation. Also
update the comment to clarify that this is not just an optimisation but
a required implementation detail.

Fixes: 974b9b2c68 ("mm: consolidate pte_index() and pte_offset_*() definitions")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
Changes since v1:
 * Fixed typo in commit message
 * Slightly reworded commit message to sound less weird
 * Included Adrian's Tested-by

 arch/ia64/include/asm/pgtable.h | 8 ++++++++
 include/linux/pgtable.h         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 10850897a91c..2ac2199d99ce 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -366,6 +366,14 @@ pgd_index (unsigned long address)
 }
 #define pgd_index pgd_index
 
+/*
+ * In the kernel's mapped region we know everything is in region number 5, so
+ * as an optimisation its PGD already points to the area for that region, but
+ * that means not adding the region here is required, not just an optimisation.
+ */
+#define pgd_offset_k(addr) \
+	(init_mm.pgd + (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)))
+
 /* Look up a pgd entry in the gate area.  On IA-64, the gate-area
    resides in the kernel-mapped segment, hence we use pgd_offset_k()
    here.  */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 53e97da1e8e2..73c64fe098ba 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -117,7 +117,9 @@ static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
  * a shortcut which implies the use of the kernel's pgd, instead
  * of a process's
  */
+#ifndef pgd_offset_k
 #define pgd_offset_k(address)		pgd_offset(&init_mm, (address))
+#endif
 
 /*
  * In many cases it is known that a virtual address is mapped at PMD or PTE
-- 
2.23.0


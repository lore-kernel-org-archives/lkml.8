Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B44C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ADA206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNxBBtQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgBWQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:56:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 11:56:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so4033241pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XO/sXJfBbNEYg2i8BDzFxjIgOlJB//vgC4CZTQZkcBA=;
        b=rNxBBtQQ1h5eC9GnaO1XpnGSAjJa4rsyMbEEzEVTUc8l1CUM0ZZ3ngDfRF8PwBRzN2
         Yji+hNUzryaURte9YdjZk86z6uPbnY1szJ5McZdvntrRy8r+P0Yv/JPWNq8V0SvaSvU6
         vV6T1JAxzpg95RMTwg9bg3wyjvQLQpNNQdedXg6xEgpYy2zf9tvt2qUHhsDK0Vc9vkcu
         XtQiGCLdd6ucO56lFizA2Rlk9e+QkIK6hH1K3kGB6jemkc5I9nyn7vQjcLVS8ilTEjdo
         G+cuLea2aa1wuPomW/yi6JtUde3y2Bq8MDrA1rBqzpSk5V3MTQxx18F3ToUbeOz/V/Vs
         0eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XO/sXJfBbNEYg2i8BDzFxjIgOlJB//vgC4CZTQZkcBA=;
        b=DaoIjgPmoi7vRjdhZOHmh9CL8cRV9j0Z9d+F6bmi0bB3PpYGIFlf4g0Anm2j8Gb8WK
         FUMxsJoaP/5ZbPpp7ZS3bGXSsdr9W0mPQDukdOZTZH1SiFhWdYoosCMkpXzZ1kBhbKql
         N7612j0QEAv+sSx4N22ZgWIrxhEm6TRF/LJRAxO6s4kw9aFk6njPfrNU2FTCv3HyW3hR
         KccYa32nBVCo3OZgnS6O3V2Ody5++gTWJLVi/CKxyb6m2zWnTS2vBjhHeyMjyh6tYOlw
         FvAkg8YIfLSTE/ZzRqn8JVayBHzbrRZ+0fzztTb0W1Ho3zQVFRM+wR9fc1mwcYc0C/M1
         aUmA==
X-Gm-Message-State: APjAAAUSRVBL1YtHJjAXJ9MRrK/lwJyKrIpUPEvmE9cSVXUHSyI32B4J
        kpdO+It8+RWV1ehv/txG6AY=
X-Google-Smtp-Source: APXvYqyvnAQXYZAiSHcAnr/jKPHoPF8Iqskeukk8OF7zchfnsQWbllUez8qGeMaCz0/RIlFJvn6mXw==
X-Received: by 2002:a63:d10c:: with SMTP id k12mr3913240pgg.392.1582476988971;
        Sun, 23 Feb 2020 08:56:28 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.33])
        by smtp.googlemail.com with ESMTPSA id w8sm9482995pfn.186.2020.02.23.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 08:56:28 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH RESEND] iommu: dmar: Fix RCU list debugging warnings
Date:   Sun, 23 Feb 2020 22:25:39 +0530
Message-Id: <20200223165538.29870-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmar_drhd_units is traversed using list_for_each_entry_rcu()
outside of an RCU read side critical section but under the
protection of dmar_global_lock. Hence add corresponding lockdep
expression to silence the following false-positive warnings:

[    1.603975] =============================
[    1.603976] WARNING: suspicious RCU usage
[    1.603977] 5.5.4-stable #17 Not tainted
[    1.603978] -----------------------------
[    1.603980] drivers/iommu/intel-iommu.c:4769 RCU-list traversed in non-reader section!!

[    1.603869] =============================
[    1.603870] WARNING: suspicious RCU usage
[    1.603872] 5.5.4-stable #17 Not tainted
[    1.603874] -----------------------------
[    1.603875] drivers/iommu/dmar.c:293 RCU-list traversed in non-reader section!!

Tested-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/dmar.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f64ca27dc210..712be8bc6a7c 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -69,8 +69,9 @@ struct dmar_pci_notify_info {
 extern struct rw_semaphore dmar_global_lock;
 extern struct list_head dmar_drhd_units;
 
-#define for_each_drhd_unit(drhd) \
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)
+#define for_each_drhd_unit(drhd)					\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())
 
 #define for_each_active_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
@@ -81,7 +82,8 @@ extern struct list_head dmar_drhd_units;
 		if (i=drhd->iommu, drhd->ignored) {} else
 
 #define for_each_iommu(i, drhd)						\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (i=drhd->iommu, 0) {} else 
 
 static inline bool dmar_rcu_check(void)
-- 
2.24.1


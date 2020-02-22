Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07864C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD6320707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJmGn2jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBVRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:03:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgBVRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:03:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so2980506pfy.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XO/sXJfBbNEYg2i8BDzFxjIgOlJB//vgC4CZTQZkcBA=;
        b=PJmGn2jApbOjslqr8jSDJI6wgkUPvtJw+T1CKTeT7HgtsLJPEzjkhoAJt0d5kMaAg1
         1wUpg4ZzCivc9q/Ma0ZnjuzyhAiYmmC83H1XBgFzQ8IlM25FN0pqjduiRNAijPxfVBKO
         ZdwNLf++C3filmTuiH4b5cPn3Tb0PH7nKLMh8dqGwvrHpTY7tR3iUEOqZLIPJkhN5onm
         GPlV8ugIs/Hp3NfC0ZcUTkmNAedBOgXOg/+UD+7j/jYwEo6Dl0ZLTIFoxNGsgM1h0rI8
         OOdJBAYJaUYXVINQYY+xhJHOKvliSwRdQEshUKSZ2azB2KzwUNjPR3byMUa9afzAQztK
         0klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XO/sXJfBbNEYg2i8BDzFxjIgOlJB//vgC4CZTQZkcBA=;
        b=P1b4gVj0w9gRto3XPqSPHGPrzW98nwPzMpoFo3eIIWNcvbD93e0tRaB0SS7npdUNlK
         UetLTWJ8HptrmB1gprCZdysVNleArNbtTWhMHimgceRUEWiPeAn0if7pUI3BRjxodEOS
         wx2G/NGH+MayIgMyd1QSIvIIpPYbh+oi9Doe5yaVJeE6dbtG2JuGyiGOFdIvVgQStVk8
         JaJS4IEa3xfz8UfD8Bdi33aFvXw/KvHkTeQEiPX2JwWKNxZ68yDuySbrGeOs3PHzzzS5
         10lqd5H+BncoLThrJ8BEKmROY9Tce2FCG0Yk8Gk9rQgI47xi9KzOmuaCehbYq2vm2is7
         4Drw==
X-Gm-Message-State: APjAAAXOv47WlQN2pxwuVRW45KEBdCU+j9awEfEu77l1ZA4/mJU42Kci
        WSqo03WmpSy9opvEXuoKV0M=
X-Google-Smtp-Source: APXvYqxOsT7MWSDKmWYMFdKJpmiJl9IDPRCtUX0zHZya0dBoV+yHgENdK086iULD2/pZnYfgXJinww==
X-Received: by 2002:a63:5d47:: with SMTP id o7mr10454009pgm.327.1582391035691;
        Sat, 22 Feb 2020 09:03:55 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.201])
        by smtp.googlemail.com with ESMTPSA id z64sm7286220pfz.23.2020.02.22.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 09:03:55 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] iommu: dmar: Fix RCU list debugging warnings
Date:   Sat, 22 Feb 2020 22:33:33 +0530
Message-Id: <20200222170333.10570-1-frextrite@gmail.com>
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


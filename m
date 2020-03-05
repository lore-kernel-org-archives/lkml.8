Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E87C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F695207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EozR9uSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:15:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42623 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:15:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id r6so31807qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lsTlhJGBqft/K5JqQFXCrVXt13xPv+FZ9nKG6t7UOmg=;
        b=EozR9uSiJiM39xnIz4HVrzXuclwRJ8+ZZWJqMpNzGsvACotrZKpiUdmxNGGOd4Zf4c
         uZMnz5PgJrNe2sDXh/C/iKo7dev0UQl+t1n4s4xFFJDtQ9JGSgFlt9LPlemc8RR/QGjQ
         xQ9EYr5qy3G64IR3Z75yZYReixPS3W6+7w2oo5wU11XvorZQsbQZmXVEUU3UqP6rdjvz
         GHFOoyklE45X30nXTExNtPA1sVRNHLl+N0L5iw2pjJL3H/AuxdKGcQ/mRpXZwHOxq3l4
         nqdrWH4IAvurhiRjxe2SJWT1DzbFHWyHqfdlfY+b1YE/srNb8V9NxWxarem2B5G2V0Xu
         mEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lsTlhJGBqft/K5JqQFXCrVXt13xPv+FZ9nKG6t7UOmg=;
        b=iKOC1blWO94nqmdNwzkQIF+hwY14Wbc7V4o46bziBMFkT3M7/M8HC42GdBkbIxEY7N
         2ibdWmZY6iMpx/QEcbk9mXuqy6ySNNjiCESempKO/Tya2MNMV/0pTiV2aoJP8uMbeUI1
         NTFHdDUa/6GWpoEFV7jYXXBjT8eL3kusAMCKDMT5QDujY7zTqZAyLL9yYfLxtCz9YtYE
         /X7k+1PumpW9yp7CuuagDp/eqSuyUUL74vSQw3Oz2BVVVTCQfQ538I/WYnGQccgvIt34
         QqM47jW0Q2lOx8f9ojCAT30sJnqmy81Hzgf4K/HygAN0bzc/yJaorJbt0zP55qt4qEIY
         C4KQ==
X-Gm-Message-State: ANhLgQ0qQYiJEMhTT2ePeWOY6Y4Ne0nvlWfqRgbRR/ROyDJHoZpYd+m4
        YFApSNakdIM0ZgyfI6t99oHh6g==
X-Google-Smtp-Source: ADFU+vsb7AANSdnCAfTh/bngRu53s2/B2h3q2rb2sPLMZz471ReHsGfGqA8mIvynejrExfdyPbRMnQ==
X-Received: by 2002:aed:218f:: with SMTP id l15mr399544qtc.247.1583439310499;
        Thu, 05 Mar 2020 12:15:10 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z6sm16254300qka.34.2020.03.05.12.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 12:15:09 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] iommu/dmar: silence RCU-list debugging warnings
Date:   Thu,  5 Mar 2020 15:15:02 -0500
Message-Id: <1583439302-11393-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the commit 02d715b4a818 ("iommu/vt-d: Fix RCU list debugging
warnings"), there are several other places that call
list_for_each_entry_rcu() outside of an RCU read side critical section
but with dmar_global_lock held. Silence those false positives as well.

 drivers/iommu/intel-iommu.c:4288 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1ad/0xb97

 drivers/iommu/dmar.c:366 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x125/0xb97

 drivers/iommu/intel-iommu.c:5057 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffffa71892c8 (dmar_global_lock){++++}, at: intel_iommu_init+0x61a/0xb13

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/dmar.c | 3 ++-
 include/linux/dmar.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 071bb42bbbc5..7b16c4db40b4 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -363,7 +363,8 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 {
 	struct dmar_drhd_unit *dmaru;
 
-	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list)
+	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list,
+				dmar_rcu_check())
 		if (dmaru->segment == drhd->segment &&
 		    dmaru->reg_base_addr == drhd->address)
 			return dmaru;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 712be8bc6a7c..d7bf029df737 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -74,11 +74,13 @@ struct dmar_pci_notify_info {
 				dmar_rcu_check())
 
 #define for_each_active_drhd_unit(drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (drhd->ignored) {} else
 
 #define for_each_active_iommu(i, drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (i=drhd->iommu, drhd->ignored) {} else
 
 #define for_each_iommu(i, drhd)						\
-- 
1.8.3.1


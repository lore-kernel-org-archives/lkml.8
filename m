Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F6C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2767020714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443103;
	bh=bqm0Y8tO/dFhUHmulnxoCqYXix/ToV0sUlKmOmGJm5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DY21jZm+54AePoqvI0dfiuBfdu4zEU5FeT9M+eZciw30xpfdQAvkNiLbfm8Kn6OQ9
	 jmq+fY4J9mJ/wJ8dpDASOY+MS5KST/pVdNnef64EcvXBIFSKqs+bEulijBoKejJDkM
	 Dg3QtePE17InU2cPjQ7tqekn6xB0HgAP1nv2RUyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgCQLFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgCQLE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:04:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB88720771;
        Tue, 17 Mar 2020 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443097;
        bh=bqm0Y8tO/dFhUHmulnxoCqYXix/ToV0sUlKmOmGJm5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aj4f8b3xiFeDE/2s5XGsJ/5b4ReGhfjfcv1jrgoY4F7R0lDMQEXONDCDjuBWgSgLl
         DivMX+k0+uwSX1u8heg64nkPY5niWqt1izMvpTSjMBWCnBmblgL+ACPN9CTT4rCjKx
         txjfV2bqm2rZ6n/I4VmRHV0EbPsHJNWs2ZIrxgUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.4 095/123] iommu/vt-d: Fix RCU list debugging warnings
Date:   Tue, 17 Mar 2020 11:55:22 +0100
Message-Id: <20200317103317.500427525@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

commit 02d715b4a8182f4887d82df82a7b83aced647760 upstream.

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
Cc: stable@vger.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/dmar.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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



Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF01C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597D4207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TjhvBKvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389646AbgFXHRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:17:53 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:19320 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFXHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592983072; x=1624519072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=T/RrPEOuZL0V8yVDfilBQLhHwRf2AVG5WsrPELty+0I=;
  b=TjhvBKvDhOwWnJl82T+m1TyWW06YkeBgQeHvy2n9vyuVmgHF59QBLp1j
   xqyZk5bsDoqMA3hB3Tt4WPtlFxK66tgrYScN2n0fYBfD4bSWpHiDulPR5
   jym9scerHLFH3mMOpuhtYNujpZfIOOFy0KrHUg4wwNbMD+iydVvpd7two
   g=;
IronPort-SDR: iMaIzfj6jPUVra8XiwdW7DyCYPXmIV7gxqkQgarHk/ZGbURi2LzKfFhfWMMVt/DurLztiJj/ZR
 X/rnfPwRMEjQ==
X-IronPort-AV: E=Sophos;i="5.75,274,1589241600"; 
   d="scan'208";a="46485639"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Jun 2020 07:17:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 72A9AA0561;
        Wed, 24 Jun 2020 07:17:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Jun 2020 07:17:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.180) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Jun 2020 07:17:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <sfr@canb.auug.org.au>
CC:     <martin.petersen@oracle.com>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2] scsi: lpfc: Avoid another null dereference in lpfc_sli4_hba_unset()
Date:   Wed, 24 Jun 2020 09:17:04 +0200
Message-ID: <20200624071704.20408-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624071447.19529-1-sjpark@amazon.com>
References: <20200624071447.19529-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D07UWA001.ant.amazon.com (10.43.160.145) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit cdb42becdd40 ("scsi: lpfc: Replace io_channels for nvme and fcp
with general hdw_queues per cpu") has introduced static checker warnings
for potential null dereferences in 'lpfc_sli4_hba_unset()' and
commit 1ffdd2c0440d ("scsi: lpfc: resolve static checker warning in
lpfc_sli4_hba_unset") has tried to fix it.  However, yet another
potential null dereference is remaining.  This commit fixes it.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: 1ffdd2c0440d ("scsi: lpfc: resolve static checker warning in lpfc_sli4_hba_unset")
Fixes: cdb42becdd40 ("scsi: lpfc: Replace io_channels for nvme and fcp with general hdw_queues per cpu")
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/scsi/lpfc/lpfc_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 69a5249e007a..6637f84a3d1b 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11878,7 +11878,8 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 	lpfc_sli4_xri_exchange_busy_wait(phba);
 
 	/* per-phba callback de-registration for hotplug event */
-	lpfc_cpuhp_remove(phba);
+	if (phba->pport)
+		lpfc_cpuhp_remove(phba);
 
 	/* Disable PCI subsystem interrupt */
 	lpfc_sli4_disable_intr(phba);
-- 
2.17.1


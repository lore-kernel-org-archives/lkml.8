Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835FD22202
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587218963;
	bh=2t9JhdTexDKfy3vJF9n4wUfNR/wrU2njNHPwpTWhbTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyvS7Jee0pbpfm7EWez+gVTC9bj5N7izfrWUZhUPNM5rI45PEIKOKXNLpzN+Alk3p
	 wqyffZGEe7r+4QU256QnQ47JZenMCDh6Y2Uu878MCEnJpl7+/V7HncFKRJIumh+SnV
	 pkj3094MKGSqsotBh4WPHuXR6U02xisnkmwa/C1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDROJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgDROJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F83A21D82;
        Sat, 18 Apr 2020 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218959;
        bh=2t9JhdTexDKfy3vJF9n4wUfNR/wrU2njNHPwpTWhbTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFgUwt0Vs1PvBkv7hjeLt6r2p2RrCbjn66T4hmJcsHVmpZm9O3D1+rOA6dtWcLJDk
         AdWUPd8EBbyttalG4kbwVHfLV0rc8B6HDBHOTo98tc8NoApLvHfAz5W/3wfTYY0Rda
         hfH1YpfRP16OimJ8LTzA+QsVL9IBtt3jlwqTJSpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.5 07/75] iommu/vt-d: Fix mm reference leak
Date:   Sat, 18 Apr 2020 10:08:02 -0400
Message-Id: <20200418140910.8280-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 902baf61adf6b187f0a6b789e70d788ea71ff5bc ]

Move canonical address check before mmget_not_zero() to avoid mm
reference leak.

Fixes: 9d8c3af31607 ("iommu/vt-d: IOMMU Page Request needs to check if address is canonical.")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 5313d043a6cf2..1d3816cd65d57 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -583,14 +583,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
 			goto bad_req;
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/* If the mm is already defunct, don't handle faults. */
+		if (!mmget_not_zero(svm->mm))
+			goto bad_req;
+
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
 		if (!vma || address < vma->vm_start)
-- 
2.20.1


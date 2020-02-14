Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F40C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6514C2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701458;
	bh=bxhyd2uGL6csS55UfWR1JBrMopyybW97a+Q4pm8a5Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcFvAM0t1WHxU2Cdp4ev1m98Hz3TqtRE5T+kVApHSaCYxie09i6fOkSIIJnrNaNFO
	 3RptU1O5zfPJRZh2Apgqq8se1qH06qR+wHbT3SqZBj9hQ6wcA2ou14yPfsuYmH2yHv
	 71oyF4M7bgeZp4YWm5A+n/wf8YNzrJl0pdUWMFIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgBNRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:30:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390631AbgBNQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC03B206D7;
        Fri, 14 Feb 2020 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696438;
        bh=bxhyd2uGL6csS55UfWR1JBrMopyybW97a+Q4pm8a5Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMnm+dc/SYh1z3Wv94xj1DTx0S95QFm6OCy34IqtIMPhvYnC1Et4t5XujGOI4wfYT
         URpp9hmPhgRh+TRReWZgJ8A3fZBj+30RTID9ZhIbnYpDDBlEh0gaOFVhZv4tq+4zGU
         TvqI69hesm5188vJDGBPaDTx11gMFBv0hDUAYZNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 254/459] iommu/vt-d: Avoid sending invalid page response
Date:   Fri, 14 Feb 2020 10:58:24 -0500
Message-Id: <20200214160149.11681-254-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 5f75585e19cc7018bf2016aa771632081ee2f313 ]

Page responses should only be sent when last page in group (LPIG) or
private data is present in the page request. This patch avoids sending
invalid descriptors.

Fixes: 5d308fc1ecf53 ("iommu/vt-d: Add 256-bit invalidation descriptor support")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index ff7a3f9add325..518d0b2d12afd 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -654,11 +654,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			if (req->priv_data_present)
 				memcpy(&resp.qw2, req->priv_data,
 				       sizeof(req->priv_data));
+			resp.qw2 = 0;
+			resp.qw3 = 0;
+			qi_submit_sync(&resp, iommu);
 		}
-		resp.qw2 = 0;
-		resp.qw3 = 0;
-		qi_submit_sync(&resp, iommu);
-
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
-- 
2.20.1


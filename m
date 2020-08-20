Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC8CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B6A22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916027;
	bh=yXQvIeh6zMjicGaFl3Np+uvH08uFB6zeEjIw7UUyD0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTc1JuaoMmBQH4Zae5iV72vRUZ0IFPkTLvQEM0VrlPV25iCfx4AyU264U/EgbYO12
	 4WSrAxBDq+Fo0f5AcA0tAqfYamQxl4bntz1G5VauZv4btWYwPYsHx1UuYWdUgJk0uV
	 vTpp+R5ZcWVbMf03Ip4gdL7kI+1yadAHzu7kTejs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHTJdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgHTJb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4656322B43;
        Thu, 20 Aug 2020 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915918;
        bh=yXQvIeh6zMjicGaFl3Np+uvH08uFB6zeEjIw7UUyD0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sa9gfU/BLaZXHb2ttuChyK8+VGNVnICfPl6ZMk2VIMETqt9WJMVotXPSZUSp6h2EU
         /uUu8PaVtqXrp2qANsb2tma8W6W8W9bKj2awrZXvXByG0VnNbQYx2ydAhYCDN8TOMt
         vKtyp/y2XxxnRESpQhTL7+wvlNktIeHnze3rJFNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 180/232] libnvdimm/security: ensure sysfs poll thread woke up and fetch updated attr
Date:   Thu, 20 Aug 2020 11:20:31 +0200
Message-Id: <20200820091621.523221974@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>

[ Upstream commit 7f674025d9f7321dea11b802cc0ab3f09cbe51c5 ]

commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
operation has completed. But the notification is issued before the internal
dimm security state and flags have been updated, so the userspace poll thread
wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
the command returns instantly.

Link: https://lore.kernel.org/r/1596494499-9852-3-git-send-email-jane.chu@oracle.com
Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/security.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 8f3971cf16541..4b80150e4afa7 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	else
 		dev_dbg(&nvdimm->dev, "overwrite completed\n");
 
-	if (nvdimm->sec.overwrite_state)
-		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	/*
+	 * Mark the overwrite work done and update dimm security flags,
+	 * then send a sysfs event notification to wake up userspace
+	 * poll threads to picked up the changed state.
+	 */
 	nvdimm->sec.overwrite_tmo = 0;
 	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
-	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	if (nvdimm->sec.overwrite_state)
+		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	put_device(&nvdimm->dev);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
2.25.1




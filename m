Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D057C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E0206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648603;
	bh=f09a1w7fNlXQ8Ts8ys9hzmXwKs22qUSqpWGXW9bs7b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXl8TMg/GbrXah8Mqkp2a6Vgci5POAC4OoEDql/pTMCRIRXzzfuRmwnVPAEY3uIVl
	 0BE5f+uqV8olBpkLCIy1Vdq0afHnmkE2Fy1FnlrOFt7oah4l423oqMlfiiRO0rFk0d
	 wbhqyqstUAe0BaQKabmQ9Pn8O6sNIB5Wi8wZcjco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgDKXnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbgDKXGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B213821924;
        Sat, 11 Apr 2020 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646381;
        bh=f09a1w7fNlXQ8Ts8ys9hzmXwKs22qUSqpWGXW9bs7b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhfIw2LKYniMN2Ogk88+g1jg8fdNj2zFLKzJ3H07ZgfFepf0WSIScmwRocNosC1H+
         jeorckTFuIc/b71nx5FZvqLy39jdgSa1l/tkUNztjIk4u/AeuB3SJF8SNPyhcdes5k
         hIlZWBmPh5ssS9+MjpaALrttNiF+maLjXDzFEC0s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 122/149] dmaengine: idxd: check return result from check_vma() in cdev
Date:   Sat, 11 Apr 2020 19:03:19 -0400
Message-Id: <20200411230347.22371-122-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit b391554c61cb353c279523a706734b090aaf9000 ]

The returned result from the check_vma() function in the cdev ->mmap() call
needs to be handled. Add the check and returning error.

Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
Reported-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/158264926659.9387.14325163515683047959.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 989b7a25ca614..677ccbe6261f4 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -139,6 +139,8 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
 	rc = check_vma(wq, vma, __func__);
+	if (rc < 0)
+		return rc;
 
 	vma->vm_flags |= VM_DONTCOPY;
 	pfn = (base + idxd_get_wq_portal_full_offset(wq->id,
-- 
2.20.1


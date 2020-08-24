Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4372087D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258576;
	bh=3nDsga2bpnQ7gibh7J1sl5vVziLsJsa7Ai2+ydM4siQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCKmktNFwHEBynQm3g/sDrOs2T6tEAJKGop2HfBNKZTNEPUBtnVKQEZQkVDuUgxdu
	 XN+jC4tq8m1D/asUWCLe6lcCC5De1N27fVg/QtYCSCYO4BWQb+58ZDaEQBWGIC1dix
	 R4HfYP3820qW+CCJSLyq4lkYh+7W2FhZFRRmrRXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgHXImy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgHXImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8DC2075B;
        Mon, 24 Aug 2020 08:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258568;
        bh=3nDsga2bpnQ7gibh7J1sl5vVziLsJsa7Ai2+ydM4siQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je/j17Sq+t/j5sydvEwZvJlDq/GUJqsmzQmPkWgjBViMN2FPQq6tAAoDs5W4bBp0G
         nek109R5dyRqrj70mvScTQKPXY6ZvA1qZHUNF4ZgM+MZfmI5IaN67fbLYJRqUfmbT+
         7SXZVOdp+aLC/Dve51IGSZBWtUGp5G6CsA8YSRUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 092/124] scsi: ufs: ti-j721e-ufs: Fix error return in ti_j721e_ufs_probe()
Date:   Mon, 24 Aug 2020 10:30:26 +0200
Message-Id: <20200824082413.946229004@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Xiangfeng <jingxiangfeng@huawei.com>

[ Upstream commit 2138d1c918246e3d8193c3cb8b6d22d0bb888061 ]

Fix to return error code PTR_ERR() from the error handling case instead of
0.

Link: https://lore.kernel.org/r/20200806070135.67797-1-jingxiangfeng@huawei.com
Fixes: 22617e216331 ("scsi: ufs: ti-j721e-ufs: Fix unwinding of pm_runtime changes")
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ti-j721e-ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ti-j721e-ufs.c b/drivers/scsi/ufs/ti-j721e-ufs.c
index 46bb905b4d6a9..eafe0db98d542 100644
--- a/drivers/scsi/ufs/ti-j721e-ufs.c
+++ b/drivers/scsi/ufs/ti-j721e-ufs.c
@@ -38,6 +38,7 @@ static int ti_j721e_ufs_probe(struct platform_device *pdev)
 	/* Select MPHY refclk frequency */
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
 		dev_err(dev, "Cannot claim MPHY clock.\n");
 		goto clk_err;
 	}
-- 
2.25.1




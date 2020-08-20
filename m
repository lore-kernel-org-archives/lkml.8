Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1687C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882104;
	bh=7BLz4oHXor+cAmkcYWWb+qAE5oH/+YW+t/smg2v2l1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdJIl462MCmjES21LDpVC/hmhfMTglvHlPlD1FuLPf6lGlDU+N6hJ7iKOREf1fAX0
	 1j29h9QgPcB8IWqlyPcOjI3vT1hrvz9Tlh0lPyaeTDSiOg32DcxS5FkyZ1+J/ybGch
	 sYBMMxRFZKNHNfh2G62BozMHr/Eaf84Oo83mJ7Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHTAIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgHTADH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:03:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55848214F1;
        Thu, 20 Aug 2020 00:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881787;
        bh=7BLz4oHXor+cAmkcYWWb+qAE5oH/+YW+t/smg2v2l1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Di3OQ9bqSicXx66Uj4eUe525DnrJ11xYv6Tah8gIs1YJFPsVzEf+WSPotYxEfFBBL
         cSA86/z9FvRjAuIPgUQinecaMu5ry38tol8HvIXdinRD+89h9SVA0rX/4vL6LJuLLb
         bvWu6Uep35B/nJNcluSBJuwVy9W0YQ+sGnWOSTJg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/18] media: budget-core: Improve exception handling in budget_register()
Date:   Wed, 19 Aug 2020 20:02:46 -0400
Message-Id: <20200820000302.215560-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000302.215560-1-sashal@kernel.org>
References: <20200820000302.215560-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit fc0456458df8b3421dba2a5508cd817fbc20ea71 ]

budget_register() has no error handling after its failure.
Add the missed undo functions for error handling to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/budget-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-core.c b/drivers/media/pci/ttpci/budget-core.c
index b3dc45b91101d..9b545c7431685 100644
--- a/drivers/media/pci/ttpci/budget-core.c
+++ b/drivers/media/pci/ttpci/budget-core.c
@@ -383,20 +383,25 @@ static int budget_register(struct budget *budget)
 	ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &budget->hw_frontend);
 
 	if (ret < 0)
-		return ret;
+		goto err_release_dmx;
 
 	budget->mem_frontend.source = DMX_MEMORY_FE;
 	ret = dvbdemux->dmx.add_frontend(&dvbdemux->dmx, &budget->mem_frontend);
 	if (ret < 0)
-		return ret;
+		goto err_release_dmx;
 
 	ret = dvbdemux->dmx.connect_frontend(&dvbdemux->dmx, &budget->hw_frontend);
 	if (ret < 0)
-		return ret;
+		goto err_release_dmx;
 
 	dvb_net_init(&budget->dvb_adapter, &budget->dvb_net, &dvbdemux->dmx);
 
 	return 0;
+
+err_release_dmx:
+	dvb_dmxdev_release(&budget->dmxdev);
+	dvb_dmx_release(&budget->demux);
+	return ret;
 }
 
 static void budget_unregister(struct budget *budget)
-- 
2.25.1


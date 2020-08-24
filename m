Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D54C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570E6206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259677;
	bh=7BLz4oHXor+cAmkcYWWb+qAE5oH/+YW+t/smg2v2l1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EjrvgqMT6UHrF+nLGJ9GJUzPm66d5NyfY2SwUb1dHw+JgQ/jpn7t9Xpegw9MFpFia
	 Tu/Gj5AplQq3SNBW2FG1yLOBv5QJqi7X+Ts7vLkWBMbBh2xIbTOQZmvi+xSO5I87tc
	 k8FJXR0HXhRUYhCcr5oIE8jCTTW462UZXkuFIm3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHXJBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730618AbgHXI5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:57:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA10C2087D;
        Mon, 24 Aug 2020 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259421;
        bh=7BLz4oHXor+cAmkcYWWb+qAE5oH/+YW+t/smg2v2l1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLCv8rZymk7FTvuir/628ohzeotyVgpAJkYxIaW9UcpQ72QPwIPsjVvOWZ8wjK1j4
         wLOhRt779OsZMTIBYb4NhksRKRNyzeh0ROsUGhRT+rv0ohnLb+gI9wc61dfV+EzAhV
         mO+jfZv09mYVGuhZHRfzZQJk5UnNanSM96mNBb1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/71] media: budget-core: Improve exception handling in budget_register()
Date:   Mon, 24 Aug 2020 10:31:14 +0200
Message-Id: <20200824082357.043186332@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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




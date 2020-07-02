Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682ACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381B72085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653467;
	bh=MSXNpAEhno4g986D8o9A5a+ESTpY1tYD20T+D+8C4+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dEe2vm6GImYqxOdEFgyYv94GzyTIt7ncgiOqBRtXYcVev3gqn8dsmfxhLB6g+c0Yp
	 IHGfYEeOkwBbxIDlzP7W2cqkd1vvXJr3hBQYXMt1MSoAB/gIe3TXRLhpdrwgseYIxs
	 L9/mq0O15s32jMWqcLQjZPTCkjvE59nKjyNV9Z2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgGBBbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbgGBB0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D19820748;
        Thu,  2 Jul 2020 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653204;
        bh=MSXNpAEhno4g986D8o9A5a+ESTpY1tYD20T+D+8C4+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qV+PrXrRji4Rblx7Oiyf8szpi2GWir0LjCpjzVI9Z88lQGZLjORkxcr/sL/pco1iE
         wt02atfxZpTUzAkP/yTretEyajAOZxTF3ySSaqyfTwdYCpxUrRiiypJXZtV6j07ixr
         iXmxNYl1V2qccm720UUoUjqen1hELQYHhEzUrPQM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/27] usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work
Date:   Wed,  1 Jul 2020 21:26:11 -0400
Message-Id: <20200702012615.2701532-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012615.2701532-1-sashal@kernel.org>
References: <20200702012615.2701532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 2655971ad4b34e97dd921df16bb0b08db9449df7 ]

dwc3_pci_resume_work() calls pm_runtime_get_sync() that increments
the reference counter. In case of failure, decrement the reference
before returning.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index b2fd505938a0c..389ec4c689c44 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -204,8 +204,10 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 	int ret;
 
 	ret = pm_runtime_get_sync(&dwc3->dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync_autosuspend(&dwc3->dev);
 		return;
+	}
 
 	pm_runtime_mark_last_busy(&dwc3->dev);
 	pm_runtime_put_sync_autosuspend(&dwc3->dev);
-- 
2.25.1


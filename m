Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52692C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D76A21532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498385;
	bh=yyEZWvrG6Ps+vh06wIqJrGmjs4DB/lv8CpIooGvNgxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQ4cCI5a2BZTxZO89ZC7e2lxls88GL/CB9EZtsxdys1fYtHrxnJlm+3IEy1R5dPGl
	 gxErmmxDNEWwjxvbH9Dfx6ED82oUylh2Kf3M3hfoRfZYmCdE3pTOJsTxb4IGh12BGR
	 SVOr1sFioIkzgqK0Dz0fGgRuQZAumww6PA/MYer4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgIGRGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgIGQc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6748021789;
        Mon,  7 Sep 2020 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496377;
        bh=yyEZWvrG6Ps+vh06wIqJrGmjs4DB/lv8CpIooGvNgxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoxaMkvyScI6/vmMmne7jPGTdmkHhXdqvORdX3F7Vh3P75UQ3mVKLag6rLUzM/wT2
         AkbRsdkXfvbdXl4TWHW364/y2mMXatbCgDrc0Q6CIjXmVc2F3wMRc02cYnRYeB/XNG
         PvVOB/13ZgPSXvPsHYp4YhlanpnvSsfHvsI5DUEY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 28/53] nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
Date:   Mon,  7 Sep 2020 12:31:54 -0400
Message-Id: <20200907163220.1280412-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit d7144f5c4cf4de95fdc3422943cf51c06aeaf7a7 ]

NVME_CTRL_NEW should never see any I/O, because in order to start
initialization it has to transition to NVME_CTRL_CONNECTING and from
there it will never return to this state.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d62334..32f61fc5f4c57 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -576,7 +576,6 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * which is require to set the queue live in the appropinquate states.
 	 */
 	switch (ctrl->state) {
-	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
 		if (nvme_is_fabrics(req->cmd) &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
-- 
2.25.1


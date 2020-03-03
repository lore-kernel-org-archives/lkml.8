Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F752166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203945;
	bh=DTvAi7nyZ5pVZtpqgp5278khv2aoMnUfNo+fbEEUtWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yMBLrpw5tfCZDCFrXVtqu85jT6DdTRd09ZHcf2cMUZFcarSBke9U0iLh2X1WzovFO
	 +7lbSPPD/chx9yNoo3xlz5R0cdpdLKqZOBsNAyQwfrsGH7G/lTZX560y0NDQ3ywiRC
	 q8XRnOJmmh7ivX8Xc3QeEmb8A/obxfTDYE5YkG0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgCCCuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgCCCt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC57246DD;
        Tue,  3 Mar 2020 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203798;
        bh=DTvAi7nyZ5pVZtpqgp5278khv2aoMnUfNo+fbEEUtWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2YAY/2gGxYGA9j17fjWtsFNM4OvJ0nT8NCGdCUKdy5BeZcGtYY+MKzz7CI9fM60s
         IlcYVbljk2rvDrk/D6JLLV8P/gD2Q3VR/J9Jdc07ippYzptQrIJT0BYEKJC/5ivH+7
         TsXINpZYRstskHYelHQIO46Ns3QqUYFx8Z2ndMCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 19/22] nvme: Fix uninitialized-variable warning
Date:   Mon,  2 Mar 2020 21:49:30 -0500
Message-Id: <20200303024933.10371-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024933.10371-1-sashal@kernel.org>
References: <20200303024933.10371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 15755854d53b4bbb0bb37a0fce66f0156cfc8a17 ]

gcc may detect a false positive on nvme using an unintialized variable
if setting features fails. Since this is not a fast path, explicitly
initialize this variable to suppress the warning.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f543b9932c830..a760c449f4a90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -889,8 +889,8 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
 {
+	union nvme_result res = { 0 };
 	struct nvme_command c;
-	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-- 
2.20.1


Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52865C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2500A20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265351;
	bh=5sfnqVV9ku5qP84kmI7b3D7XMM7EK2iyfhs3Bg7FGtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jPEE+TmEu59fOEEVUdTaRWXHyj0LpuzHtvCzHTeGBAMBoYD1YjNA4IhNVA5UEhS+g
	 HRJumf9KnotJ98DrUshx3AUnR02bnNlZ6iROfbaF5f9pK8b6JDXgHMFsPd0wGSXNeQ
	 HnxhHNOWBnQjE3bqEKFHaGyVhS2A6vBgNmq1gQpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCZX3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgCZXYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE8C206F8;
        Thu, 26 Mar 2020 23:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265062;
        bh=5sfnqVV9ku5qP84kmI7b3D7XMM7EK2iyfhs3Bg7FGtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHKrJN0ZMtEHXWMDJlkjmXLqeRZsl4vvBRpIGdwWOr5Bnp6ev3qIqNZ+usW48vBLA
         3ixE1A9X1dhpw92egubZmG2h0VKiqK0tR8+LrgezSdJkQuH/esf4PCCX9FF9vOxA9b
         E7V6TkZCGRhAoqurrOXkeTbCJfa2SVopCkQpFzJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Mark Wunderlich <mark.wunderlich@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 21/28] nvmet-tcp: set MSG_MORE only if we actually have more to send
Date:   Thu, 26 Mar 2020 19:23:50 -0400
Message-Id: <20200326232357.7516-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232357.7516-1-sashal@kernel.org>
References: <20200326232357.7516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 98fd5c723730f560e5bea919a64ac5b83d45eb72 ]

When we send PDU data, we want to optimize the tcp stack
operation if we have more data to send. So when we set MSG_MORE
when:
- We have more fragments coming in the batch, or
- We have a more data to send in this PDU
- We don't have a data digest trailer
- We optimize with the SUCCESS flag and omit the NVMe completion
  (used if sq_head pointer update is disabled)

This addresses a regression in QD=1 with SUCCESS flag optimization
as we unconditionally set MSG_MORE when we didn't actually have
more data to send.

Fixes: 70583295388a ("nvmet-tcp: implement C2HData SUCCESS optimization")
Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index af674fc0bb1e4..5bb5342b8d0c7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -515,7 +515,7 @@ static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 	return 1;
 }
 
-static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
+static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	int ret;
@@ -523,9 +523,15 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
 	while (cmd->cur_sg) {
 		struct page *page = sg_page(cmd->cur_sg);
 		u32 left = cmd->cur_sg->length - cmd->offset;
+		int flags = MSG_DONTWAIT;
+
+		if ((!last_in_batch && cmd->queue->send_list_len) ||
+		    cmd->wbytes_done + left < cmd->req.transfer_len ||
+		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
+			flags |= MSG_MORE;
 
 		ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-					left, MSG_DONTWAIT | MSG_MORE);
+					left, flags);
 		if (ret <= 0)
 			return ret;
 
@@ -660,7 +666,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	}
 
 	if (cmd->state == NVMET_TCP_SEND_DATA) {
-		ret = nvmet_try_send_data(cmd);
+		ret = nvmet_try_send_data(cmd, last_in_batch);
 		if (ret <= 0)
 			goto done_send;
 	}
-- 
2.20.1


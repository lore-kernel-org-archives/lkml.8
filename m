Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C92421941
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496654;
	bh=DN1QFIiCGUOZpIUU7k3WwUP4VFVGGomKaZtle0ZutOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1slKxJSbJfRMpiLBKnTP8EUIa8BbueYw3pMoYhzdc2Y3u+bXoZwNxfgxxSJoH/o5
	 +RNYzbDzLjpQ8v+vjZkexOI0kNqXbvMoyJ+0LF8X1qUe5nf2a/IKoqphavXFaxHvck
	 FqJjXGxwjXk80P7Q6QIfWCqjfKWNFfbFmFuXTnxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIGQhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbgIGQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA33A21D20;
        Mon,  7 Sep 2020 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496436;
        bh=DN1QFIiCGUOZpIUU7k3WwUP4VFVGGomKaZtle0ZutOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EC6DneCCulBbdQkpcJm+EyuL5M3z4r/8AjFZnUOVquPCQc+71Y6T9ywivth3lLMqB
         Hr3jkgO3RkwspRPpYPjdQmW1azCKOQ+dFIUGxaNKATUndRuB/RJdTdJmF5nQYWC6Df
         M57zt3IemngP2Qr23FcDmioacQ6HZYfPRY/9XPUo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ziye Yang <ziye.yang@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 20/43] nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu
Date:   Mon,  7 Sep 2020 12:33:06 -0400
Message-Id: <20200907163329.1280888-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziye Yang <ziye.yang@intel.com>

[ Upstream commit a6ce7d7b4adaebc27ee7e78e5ecc378a1cfc221d ]

When handling commands without in-capsule data, we assign the ttag
assuming we already have the queue commands array allocated (based
on the queue size information in the connect data payload). However
if the connect itself did not send the connect data in-capsule we
have yet to allocate the queue commands,and we will assign a bogus
ttag and suffer a NULL dereference when we receive the corresponding
h2cdata pdu.

Fix this by checking if we already allocated commands before
dereferencing it when handling h2cdata, if we didn't, its for sure a
connect and we should use the preallocated connect command.

Signed-off-by: Ziye Yang <ziye.yang@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 22014e76d7714..e31823f19a0fa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -150,6 +150,11 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
 {
+	if (unlikely(!queue->nr_cmds)) {
+		/* We didn't allocate cmds yet, send 0xffff */
+		return USHRT_MAX;
+	}
+
 	return cmd - queue->cmds;
 }
 
@@ -847,7 +852,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	cmd = &queue->cmds[data->ttag];
+	if (likely(queue->nr_cmds))
+		cmd = &queue->cmds[data->ttag];
+	else
+		cmd = &queue->connect;
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.25.1


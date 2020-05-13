Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77630C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C2223127
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363560;
	bh=997yCqMNX4KxpweHvk3j8zDPvvDW9cjqo7KuuBv9lxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wTxGUjAqBtTds7RuO/LVavSGVHENSylyap1GYjJP+cH0GQoFWAhOclHJOSbLp0ALp
	 GFL84qAtKMjJEIdWaID9J8r9zdk5GMbfj0VbWX8Zn6MaNezROo2VKLbjilp1DuK8mn
	 SZ0ASNDYj/NaP3AAnmSQ7hiwKTHmXYU/98vibWDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgEMJwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732718AbgEMJwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE50620740;
        Wed, 13 May 2020 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363553;
        bh=997yCqMNX4KxpweHvk3j8zDPvvDW9cjqo7KuuBv9lxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQdUUQoSji4Cdk8CQQ9frpGl5LSCHue2PEi0hyCQrTvdU6nmACKXipDjVk74maRCI
         NnTd/W7XZth/VobqO/ygNROzzlJNz7Opt4SHbQ+xWlB61vMgL3WzA2xUHMD1jIfNhv
         ykrYV5iuW+uJ2+fQbbkcALMPczG/p/n9dYe0mWtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 009/118] nvme: refactor nvme_identify_ns_descs error handling
Date:   Wed, 13 May 2020 11:43:48 +0200
Message-Id: <20200513094418.481181484@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit fb314eb0cbb2e11540d1ae1a7b28346397f621ef ]

Move the handling of an error into the function from the caller, and
only do it for an actual error on the admin command itself, not the
command parsing, as that should be enough to deal with devices claiming
a bogus version compliance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fb4c35a430650..545e9e5f1b737 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1075,8 +1075,17 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 
 	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
 				      NVME_IDENTIFY_DATA_SIZE);
-	if (status)
+	if (status) {
+		dev_warn(ctrl->device,
+			"Identify Descriptors failed (%d)\n", status);
+		 /*
+		  * Don't treat an error as fatal, as we potentially already
+		  * have a NGUID or EUI-64.
+		  */
+		if (status > 0)
+			status = 0;
 		goto free_data;
+	}
 
 	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
 		struct nvme_ns_id_desc *cur = data + pos;
@@ -1734,26 +1743,15 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
-	int ret = 0;
-
 	memset(ids, 0, sizeof(*ids));
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
 	if (ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
-	if (ctrl->vs >= NVME_VS(1, 3, 0)) {
-		 /* Don't treat error as fatal we potentially
-		  * already have a NGUID or EUI-64
-		  */
-		ret = nvme_identify_ns_descs(ctrl, nsid, ids);
-		if (ret)
-			dev_warn(ctrl->device,
-				 "Identify Descriptors failed (%d)\n", ret);
-		if (ret > 0)
-			ret = 0;
-	}
-	return ret;
+	if (ctrl->vs >= NVME_VS(1, 3, 0))
+		return nvme_identify_ns_descs(ctrl, nsid, ids);
+	return 0;
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
-- 
2.20.1




Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C6B2078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588390;
	bh=eQe1wYGLHkgxe6Ouy//U4712xeQz8re6/WlsK2ceVuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l32vJrIkr9TlEY+EbVwxCiWQDPQdfbKFC0FR7oby/rs4GkBTpYxt85ikvyxKq9A2q
	 cZkwiUMEVxDGirip7P3+0BpvEjWQUgnsR2NQ+8QeZKJGNJ/N1mNHFAdlnKDc/tNty+
	 QaG4ywfjGt/vIanP6E8KUzsiZm9QGkr2W0AadvOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgIHSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbgIHQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A011247D4;
        Tue,  8 Sep 2020 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580291;
        bh=eQe1wYGLHkgxe6Ouy//U4712xeQz8re6/WlsK2ceVuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+wRlImRNKLDhI9HWjUYdgpHxWtvcBYhxXt6PRIe4n4M5WKpp+1M/CAeVRjid7fJ3
         QpNtvsmMNqpDRiUs2qQevFE+ogOkD7efbvTomwRTQiEalsTAshtHtNdQL6IAW49bQe
         x1EbutwVzhntQpVq0FOsZvK9/YLHM7Z3lJxYoKfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Engel <amit.engel@dell.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/65] nvmet: Disable keep-alive timer when kato is cleared to 0h
Date:   Tue,  8 Sep 2020 17:25:51 +0200
Message-Id: <20200908152217.351593528@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Engel <amit.engel@dell.com>

[ Upstream commit 0d3b6a8d213a30387b5104b2fb25376d18636f23 ]

Based on nvme spec, when keep alive timeout is set to zero
the keep-alive timer should be disabled.

Signed-off-by: Amit Engel <amit.engel@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 09a39f4aaf821..d0be85d0c289a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -208,6 +208,9 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
@@ -217,6 +220,9 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
-- 
2.25.1




Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6841E22B4B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597086708;
	bh=Y7FLL9CrPKnGZCPGfu9yZYBPkWT6HM7M3CvL0nstTao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWNvZzqOuU7hZOs5vchf7DTIihgLW5pNaJfXBvEoZlZht37RWqhfg1i9/CguHk57K
	 /KBGhU0c0dYgwmeOTGUetc6LeN3zmjo5utUa440ifQ8Zpz3cUG0yWTr6e4+s3b7BUZ
	 RpOHsCUwjLibBYvjqJk5Ue/dYGLyJt5nQST8OsuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHJTLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbgHJTLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:11:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6E422B49;
        Mon, 10 Aug 2020 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086691;
        bh=Y7FLL9CrPKnGZCPGfu9yZYBPkWT6HM7M3CvL0nstTao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsTDJQuPYXQrIuqSbdtBpIo35N+uMwAtcNpD0M8q1MKTUSxaGkRpr+kH0Zbb45mPB
         TaPKnz6Iq2huDt/7O61Gp6CgHl8uVpO2CaqICvspINtykAf8+5u7KpPUAnKwjMze8y
         HDOO20bbvZMEJKPN/lnvtmKajg/FPM6mgmc/zGQs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shannon Nelson <snelson@pensando.io>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 45/60] ionic: update eid test for overflow
Date:   Mon, 10 Aug 2020 15:10:13 -0400
Message-Id: <20200810191028.3793884-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit 3fbc9bb6ca32d12d4d32a7ae32abef67ac95f889 ]

Fix up our comparison to better handle a potential (but largely
unlikely) wrap around.

Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 337d971ffd92c..29f77faa808bb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -709,7 +709,7 @@ static bool ionic_notifyq_service(struct ionic_cq *cq,
 	eid = le64_to_cpu(comp->event.eid);
 
 	/* Have we run out of new completions to process? */
-	if (eid <= lif->last_eid)
+	if ((s64)(eid - lif->last_eid) <= 0)
 		return false;
 
 	lif->last_eid = eid;
-- 
2.25.1


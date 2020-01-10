Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C2C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0DC20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578694134;
	bh=V9Pvsg3kJvQ6CcsuGArezxaMyrjVXaeOk3QDZVn6TeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=um6xBmpRsZGJD3FULvxlaQAy2zvwmWkHsWng0kLY7PBkSC8CJCnnoASntIJnBsw+x
	 qrU/bwlXddBfNiiMmDupYnirLRWrMy52nE78rnW3qAiNgSgEPXmIHvWQZZE3T8m9Kk
	 woUTe6er2JT4+OiN0zc848OFGczoPZiwJ3r10OCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgAJWIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgAJWF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCC920721;
        Fri, 10 Jan 2020 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693928;
        bh=V9Pvsg3kJvQ6CcsuGArezxaMyrjVXaeOk3QDZVn6TeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fw0uX575wYtJonVXR5y/CxyP9DUwc1nXbbg34loE05AK7pHMOXjuHe/YuUYxnZBd6
         GhkiKLJuj3+XfEMiiD/xf3Bk9fQIcQ+0n9LHaVamxplCtj/9wwUbrjYXNQTD67QjEr
         j8IVojzELcQaGNEpsToh4Y6CTHOMaj1odGePB3Ho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/26] s390/qeth: lock the card while changing its hsuid
Date:   Fri, 10 Jan 2020 17:05:04 -0500
Message-Id: <20200110220519.28250-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220519.28250-1-sashal@kernel.org>
References: <20200110220519.28250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 5b6c7b55cfe26224b0f41b1c226d3534c542787f ]

qeth_l3_dev_hsuid_store() initially checks the card state, but doesn't
take the conf_mutex to ensure that the card stays in this state while
being reconfigured.

Rework the code to take this lock, and drop a redundant state check in a
helper function.

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c |  5 ----
 drivers/s390/net/qeth_l3_sys.c    | 40 +++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c444210d563b..7320a187d66a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3378,11 +3378,6 @@ int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 			goto out;
 		}
 
-		if (card->state != CARD_STATE_DOWN) {
-			rc = -1;
-			goto out;
-		}
-
 		qeth_free_qdio_queues(card);
 		card->options.cq = cq;
 		rc = 0;
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 2f73b33c9347..333fd4619dc6 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -270,24 +270,36 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
+	int rc = 0;
 	char *tmp;
-	int rc;
 
 	if (!card)
 		return -EINVAL;
 
 	if (!IS_IQD(card))
 		return -EPERM;
-	if (card->state != CARD_STATE_DOWN)
-		return -EPERM;
-	if (card->options.sniffer)
-		return -EPERM;
-	if (card->options.cq == QETH_CQ_NOTAVAILABLE)
-		return -EPERM;
+
+	mutex_lock(&card->conf_mutex);
+	if (card->state != CARD_STATE_DOWN) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (card->options.sniffer) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (card->options.cq == QETH_CQ_NOTAVAILABLE) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	tmp = strsep((char **)&buf, "\n");
-	if (strlen(tmp) > 8)
-		return -EINVAL;
+	if (strlen(tmp) > 8) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	if (card->options.hsuid[0])
 		/* delete old ip address */
@@ -298,11 +310,13 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		card->options.hsuid[0] = '\0';
 		memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 		qeth_configure_cq(card, QETH_CQ_DISABLED);
-		return count;
+		goto out;
 	}
 
-	if (qeth_configure_cq(card, QETH_CQ_ENABLED))
-		return -EPERM;
+	if (qeth_configure_cq(card, QETH_CQ_ENABLED)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	snprintf(card->options.hsuid, sizeof(card->options.hsuid),
 		 "%-8s", tmp);
@@ -311,6 +325,8 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 
 	rc = qeth_l3_modify_hsuid(card, true);
 
+out:
+	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
 }
 
-- 
2.20.1


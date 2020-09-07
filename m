Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED212145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgIGT6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:58:41 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:42078 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728834AbgIGT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 15:58:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8A7DC18029125;
        Mon,  7 Sep 2020 19:58:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grain32_5a0cd44270ce
X-Filterd-Recvd-Size: 2196
Received: from joe-laptop.perches.com (unknown [172.58.35.143])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 19:58:38 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/4] drivers core: Convert class uses of sprintf to sysfs_emit
Date:   Mon,  7 Sep 2020 12:58:34 -0700
Message-Id: <16656a69b04161d30077456e62d578e1b2392460.1599508517.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1599501047.git.joe@perches.com>
References: <cover.1599501047.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the sysfs_emit API.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/devcoredump.c              | 2 +-
 drivers/base/firmware_loader/fallback.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index e42d0b514384..9243468e2c99 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -123,7 +123,7 @@ static int devcd_free(struct device *dev, void *data)
 static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", devcd_disabled);
+	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 7e9598a1577a..d60e6d8c967c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -124,7 +124,7 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
 			    char *buf)
 {
-	return sprintf(buf, "%d\n", __firmware_loading_timeout());
+	return sysfs_emit(buf, "%d\n", __firmware_loading_timeout());
 }
 
 /**
-- 
2.26.0


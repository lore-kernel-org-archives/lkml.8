Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBFFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E97206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217310;
	bh=X5PyMUU+RG4IUsY1i6M/W1WoIHZtq2RRh1byEbhrB2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXduVCYaKppjmCJjMK6aVOh1en2MIxkTIM8Kb3PzlKGfXTyYR2UECBn9o6WO8SLFn
	 Lq79SHMdKgJGIhV+EvXStSOrNTBJBleHS+8TSYj2P9zo5kiwpsa0Ty4HjHYUwrlLRI
	 yDOxqT64YFAdYvgcqptb8zSY+6sTMByYrN7DBs/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbgAPX23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:28:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390142AbgAPX20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:28:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A930120684;
        Thu, 16 Jan 2020 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217306;
        bh=X5PyMUU+RG4IUsY1i6M/W1WoIHZtq2RRh1byEbhrB2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvoZqzVOubs47D0IFPbCeLBiSqVIm3RGg5YYedTqh92KdxTZhC/WnqNkERLLSBLwE
         elPNb8IDFYqjRLLY4kCnQiEx6DmUSNdsNmfg3loC43+CxQX1UUgUwKShwHb/+Mrvbh
         dRSpyDiGXRfnlHJE5zK0NaZk6G7uL44qCCDMvUHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/84] HID: hidraw, uhid: Always report EPOLLOUT
Date:   Fri, 17 Jan 2020 00:17:37 +0100
Message-Id: <20200116231713.677596697@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 9e635c2851df6caee651e589fbf937b637973c91 ]

hidraw and uhid device nodes are always available for writing so we should
always report EPOLLOUT and EPOLLWRNORM bits, not only in the cases when
there is nothing to read.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: be54e7461ffdc ("HID: uhid: Fix returning EPOLLOUT from uhid_char_poll")
Fixes: 9f3b61dc1dd7b ("HID: hidraw: Fix returning EPOLLOUT from hidraw_poll")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hidraw.c | 7 ++++---
 drivers/hid/uhid.c   | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index a025b6961896..c4ba2d28dd73 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -257,13 +257,14 @@ out:
 static __poll_t hidraw_poll(struct file *file, poll_table *wait)
 {
 	struct hidraw_list *list = file->private_data;
+	__poll_t mask = EPOLLOUT | EPOLLWRNORM; /* hidraw is always writable */
 
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
-		return EPOLLIN | EPOLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	if (!list->hidraw->exist)
-		return EPOLLERR | EPOLLHUP;
-	return EPOLLOUT | EPOLLWRNORM;
+		mask |= EPOLLERR | EPOLLHUP;
+	return mask;
 }
 
 static int hidraw_open(struct inode *inode, struct file *file)
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 8508dbac2657..29e63330c1b5 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -769,13 +769,14 @@ unlock:
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
 	struct uhid_device *uhid = file->private_data;
+	__poll_t mask = EPOLLOUT | EPOLLWRNORM; /* uhid is always writable */
 
 	poll_wait(file, &uhid->waitq, wait);
 
 	if (uhid->head != uhid->tail)
-		return EPOLLIN | EPOLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 
-	return EPOLLOUT | EPOLLWRNORM;
+	return mask;
 }
 
 static const struct file_operations uhid_fops = {
-- 
2.20.1




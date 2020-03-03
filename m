Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276352166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203903;
	bh=A//OTV3+t80o4DfPxG+5T9Nazx04EEHsGGsu+omI/XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kG5VUOm0ueGlQOtXcz+Xvixj4jFTYq8NLIPX5q4QNMnenJG6Lq6FA+GJWoZVKgTG2
	 rI22XKDDHZBlG+4A7DZWP1EIaOKJy3rj+1tCaO0KgQKATX3iMZ2gbwj6EVTvMGeUcV
	 6emUiwraskhG5r7/EO9eeVu54n8kWUPnkH2qUrN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgCCCvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgCCCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D12E246EA;
        Tue,  3 Mar 2020 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203819;
        bh=A//OTV3+t80o4DfPxG+5T9Nazx04EEHsGGsu+omI/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwFkSFX1YVOCb8ua/bW0hlvRG96GBVn+NFLUgn32H4ILJLvMmBT/lLcKt8mUWLzmm
         nJPfWIDxCbJrocI6eW/xT2Xp0APbyTY4OUMtb0fJY0RBOIe/uQ9yQ9p7zAyb4xXqlA
         F5JD4OVf8Wu7i8bU/81uWGBGgfi1CvCZO1in4fh8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/13] s390/cio: cio_ignore_proc_seq_next should increase position index
Date:   Mon,  2 Mar 2020 21:50:01 -0500
Message-Id: <20200303025002.10600-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303025002.10600-1-sashal@kernel.org>
References: <20200303025002.10600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 8b101a5e14f2161869636ff9cb4907b7749dc0c2 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Link: https://lore.kernel.org/r/d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/blacklist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 9082476b51db9..4e9f794176d35 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -302,8 +302,10 @@ static void *
 cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
 	struct ccwdev_iter *iter;
+	loff_t p = *offset;
 
-	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
+	(*offset)++;
+	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
 	iter = it;
 	if (iter->devno == __MAX_SUBCHANNEL) {
@@ -313,7 +315,6 @@ cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
 			return NULL;
 	} else
 		iter->devno++;
-	(*offset)++;
 	return iter;
 }
 
-- 
2.20.1


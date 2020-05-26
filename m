Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF37C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF5E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519627;
	bh=LD/o2ex+Rt0c8iOqqjBxp9ea9Wl/TTj5tKRfuQmvYvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjMAGLSe5Zh5wYf8sCdWtnVMhoZCnsu1uOZPPdkk9sENDJYG7wJimZoBMIZbkUepo
	 KfOmqQwRpJMTI5ZaKj8yQUo+Zg8sCe/U+yv6fFElGMBL1IEfHvwBn5fRc/Binhe5Sa
	 83FqqyzW8sjCMJba4wREbkmgYacvXCh9sZd3rbzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390736AbgEZTA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390725AbgEZTAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4037B20873;
        Tue, 26 May 2020 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519623;
        bh=LD/o2ex+Rt0c8iOqqjBxp9ea9Wl/TTj5tKRfuQmvYvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYo1aNISYvy8tl+Ry5xRm/Z15q7A8Plz3uFKlHOsVnCK3eCzdm+w3LJpFefvXKEZm
         IZYf8aS1JZpgxVje/keIh7Eq0XHS9lCDn5e5P+7XyxeLs8DjFnDFav8wsr4jnBu0Gr
         e0HN7Go+sJblF8qnVRSoWBhiyn2W4dZUzmXI6xMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/59] ubi: Fix seq_file usage in detailed_erase_block_info debugfs file
Date:   Tue, 26 May 2020 20:52:57 +0200
Message-Id: <20200526183912.327039242@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 0e7572cffe442290c347e779bf8bd4306bb0aa7c ]

3bfa7e141b0b ("fs/seq_file.c: seq_read(): add info message about buggy .next functions")
showed that we don't use seq_file correctly.
So make sure that our ->next function always updates the position.

Fixes: 7bccd12d27b7 ("ubi: Add debugfs file for tracking PEB state")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/debug.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 7bc96294ae4d..b108e1f04bf6 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -405,9 +405,6 @@ static void *eraseblk_count_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct ubi_device *ubi = s->private;
 
-	if (*pos == 0)
-		return SEQ_START_TOKEN;
-
 	if (*pos < ubi->peb_count)
 		return pos;
 
@@ -421,8 +418,6 @@ static void *eraseblk_count_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct ubi_device *ubi = s->private;
 
-	if (v == SEQ_START_TOKEN)
-		return pos;
 	(*pos)++;
 
 	if (*pos < ubi->peb_count)
@@ -444,11 +439,8 @@ static int eraseblk_count_seq_show(struct seq_file *s, void *iter)
 	int err;
 
 	/* If this is the start, print a header */
-	if (iter == SEQ_START_TOKEN) {
-		seq_puts(s,
-			 "physical_block_number\terase_count\tblock_status\tread_status\n");
-		return 0;
-	}
+	if (*block_number == 0)
+		seq_puts(s, "physical_block_number\terase_count\n");
 
 	err = ubi_io_is_bad(ubi, *block_number);
 	if (err)
-- 
2.25.1




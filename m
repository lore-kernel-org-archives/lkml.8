Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="ITMK8LOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBLMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:24:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45866 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:24:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1154918pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x/nxEaTTP4mdZANLaqJuiHgW2OIpQlw3HGG1GiDrG8k=;
        b=ITMK8LOAm4w9qmTRfMOeA37gwDDOLpQQ/8a2Z3SRrSpfdlsQ0/vxwhtmYgNTGgR1Cz
         tlws5/87h5rm8Z6PQJxpFd3ov2vMJxFSM6bJG79plkbEjDjDO+E3/CHiUJ+n6tI/QUhI
         FUTwdI6r/grSgrkn7EX0gxaQ9scjqFcMdX++7fjMNzPIZ6jPcAGLq2Uiwy7OC8o+nUzE
         FCNvivZNq57PWuE1TFEhD1sbp0hJSUSxcwXUIfRKVayNitJ5/uS5XbA9EDDaXizHEcWo
         3lQukAIR08TiHoHzX4cy9Y1tBOHDl6ebDOCZ0NwN0duE2dhdG4LMiV1x2EO+aVhdgR5q
         c4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x/nxEaTTP4mdZANLaqJuiHgW2OIpQlw3HGG1GiDrG8k=;
        b=p1oFkU0XxERrT9MufpVmHjBwkxk6ZUtraHmS5zPkfABbriX7OZooM+LntbOk6uwwq5
         Xe/AQ6s02WRKdDorwgHySVLOfIkh1j2g7yRHqeUfPWhkzgI1ARfCjcVKwhKbpGUqZFG1
         4DcmNnRTL00PWiSCig4OjRrpgQcxBUUqmYvj5POjIUkqp4/mxnm7iNlwj37121r8PQPb
         mWNJ9+oAVDQ7zp5ndJe2FUy/U2czJJfeYlOpFLTZKGt906OxdfZiuabjkcYXJrTrSqRP
         IaJiB+dKPaQMrDNEZ59ZCbmXf3GPtpoaBogat1uo4tuzz6tr0H8BQXnl9Uk5P/tSu+tk
         dZ9Q==
X-Gm-Message-State: APjAAAU+p5aKIdyl6Gz6EFbeOC1KEHTnLelyi+J/ijCqv7HZR5KAUAl3
        3w57CsDUHs6XKII7fyMDeGRT4Q==
X-Google-Smtp-Source: APXvYqysE1YVsfpW0EEtBngwXNN8YrDBSGQFG6DRR+1GbiUVSMIP4hN73LTI1LYnKzhSGHsq4BtxZg==
X-Received: by 2002:a63:8f49:: with SMTP id r9mr12333824pgn.190.1581510283487;
        Wed, 12 Feb 2020 04:24:43 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id l69sm313535pgd.1.2020.02.12.04.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 04:24:42 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:54:36 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging:gasket:gasket_core.c:unified quoted string split
 across lines in one line
Message-ID: <20200212122436.GA25104@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver tries to map a region, but the region has certain
permissions, or when it attempts to open gasket with tgid, or when it
realeases device node; the logs are displayed in one line only while the
code has the strings split in two lines which makes it difficult for
developers to search for code based on the log messages. So, this patch
fixes three warnings of 'quoted string split across lines' in
gasket_core.c by merging the strings in one line.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/gasket/gasket_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index cd8be80d2076..411aaf248b37 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -692,8 +692,7 @@ static bool gasket_mmap_has_permissions(struct gasket_dev *gasket_dev,
 		(vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC));
 	if (requested_permissions & ~(bar_permissions)) {
 		dev_dbg(gasket_dev->dev,
-			"Attempting to map a region with requested permissions "
-			"0x%x, but region has permissions 0x%x.\n",
+			"Attempting to map a region with requested permissions 0x%x, but region has permissions 0x%x.\n",
 			requested_permissions, bar_permissions);
 		return false;
 	}
@@ -1180,8 +1179,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	inode->i_size = 0;
 
 	dev_dbg(gasket_dev->dev,
-		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
-		"fmode_write: %d is_root: %u)\n",
+		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, fmode_write: %d is_root: %u)\n",
 		current->tgid, task_name, filp->f_mode,
 		(filp->f_mode & FMODE_WRITE), is_root);
 
@@ -1258,8 +1256,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 	mutex_lock(&gasket_dev->mutex);
 
 	dev_dbg(gasket_dev->dev,
-		"Releasing device node. Call origin: tgid %u (%s) "
-		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
+		"Releasing device node. Call origin: tgid %u (%s) (f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
 		current->tgid, task_name, file->f_mode,
 		(file->f_mode & FMODE_WRITE), is_root);
 	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
-- 
2.17.1


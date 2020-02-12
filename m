Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D799C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116E20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="QRBFUXic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgBLR6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:58:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40025 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:58:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so1202215pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H8IUcvssdhDR1K1EUyWj6oufs8d+vYOMkMY7VxxIHZM=;
        b=QRBFUXicYklwb5F8vRR8BdDvRkILMu5Hvt8UtgaBcPwVK490Owa8JbsB3DL+n1H9fX
         0Pf6mQRh8MvIi96J5YKMSk/BCVDYTq0Se0Elkd1KmPZi7Hj9Jw/VhFSyam+k3wkoHyH2
         xKjbfKQnCLkRWzilxyNZSjMEg6imwLCsrdC51YK25wF93qf4O8ARaKPF/MYc+4qOVrV0
         JU/I26UOTMrbVW+Y+33u7IlYlL2RWcz4P9Knn8W2hPQmTNS6sCtJO1Pmh4nKfrkjsD5i
         DdZZUH72dLS+AH3EDxhbPgojLi1ArTzL/fbT/bwHaJZieOmfHKxoNjLz4PBazm4QzWGU
         rd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H8IUcvssdhDR1K1EUyWj6oufs8d+vYOMkMY7VxxIHZM=;
        b=LSGAjB0is/aNyOKLvjd+bCgSIzSgdpCuq/5CybREKdfP0mEcPqwY+bQVxY+SyWpuei
         x8mTZIe8dlcsw/cl0eGaexAITKWhXC9cdGipSNEUd9QCxJ3NMOH1LMUB3nlN80rljJgr
         VGeULbsiHTfBQ5PilK27g3TPEmDrZxOHxzBsGrESaHF5sB5KHP0Ls/pCREkEHFzAGzaQ
         IeLbPzrrphPhUy/FOaj2lNXi2oO2EP9Q5+9qJz1rHTjzxAgPP4CBum7Tm1RazoX5BX0R
         mpKxZx5ODYG18lFluEZwavqH7s7cQkv7EBtZAV1JK3nw0lK5cmp1yaBQFLx8tEu4+MlP
         Eg4A==
X-Gm-Message-State: APjAAAUTjh3c37zuQ0UPztakGma/71cjH9R9pernvF0TlCZDbbKkpcFX
        oenjYTEpyDt2YiMNefZFa2wdrA==
X-Google-Smtp-Source: APXvYqz0PFBr0ahFdwvSeVJO82ZYpsUmIMUpWVH696GQewdig1fJ4fE2nyV/g9k8QDSMneyW8+ixqQ==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr237947pjo.79.1581530313215;
        Wed, 12 Feb 2020 09:58:33 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id d14sm1156786pjz.12.2020.02.12.09.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 09:58:32 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:28:26 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] staging: gasket: unify multi-line string
Message-ID: <20200212175826.GA5967@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix three checkpatch.pl warnings of 'quoted string split across lines'
in gasket_core.c by merging the strings in one line.
Though some strings
are over 80 characters long, fixing this warning is necessary to ease
grep-ing the source for printk.

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


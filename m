Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C42C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F0320678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=daurnimator.com header.i=@daurnimator.com header.b="WEk/2JRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgDMJEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbgDMJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:04:41 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:04:41 EDT
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EEC014CDB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n10so4248242pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WjND0ct9WXfnmUwrPTBzmeuopYzO4yH6lk3AAONsNw=;
        b=WEk/2JRpJ4RFJsvyAWO9EICaAyMaTsqpoYex5Fe9WikBDqfQsj3Ujrar0RXoKWweXF
         t9PESt9EfmZuQCBz8auC08Oh0YKGi2DPtN+yK+yRCRaOiDCH19VPpxmPMrTDD98uhRmw
         OrlOVgQhX22mG3fbDBoG835NgT3zWT1tSVCNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7WjND0ct9WXfnmUwrPTBzmeuopYzO4yH6lk3AAONsNw=;
        b=PIxBtIJvA1SzWrLJhbfoQm0BSkVmIxw/+yq1K7ABbGqnrH2LJHiAFEOqVGw+79yysO
         LeRynpo+RuxI/FL1Bgdd6FCFsCB5i0fv7MipP8SdQecZUqrVCvAsOnwrJvKadhdwFvBJ
         +rdNaUzZAGymGoHHXsAPFMjX2WmMeD7cExYbdeeWq3X3SPGYuT1eOLxPUUn8dqw13x8T
         JKXmVNNOg2Eb2zQKlH1HUNCcuYvvnBpPEvMp5G3RK/sOBGYq2oX2JLrxsoFuLYBnF0gD
         Fpp+Qxsju+hw5QP/s+CDpokO6EKswRpEuLoOqcWx9m7FpqiJl/wB8bE8hCy43i09s7Ks
         QdGA==
X-Gm-Message-State: AGi0Puaoa17/JtLIfKguP/1g4F7KTBzBTRPEgyjQeuRyh0aAAW/mLEGj
        agUcW136wuqcfi/a1OgYkIETqUbfdco=
X-Google-Smtp-Source: APiQypIRHXKeVfsDa4U96lR30IMY0mcfMZCpcMgXv7bKpkfMzxj9H3vfBpjfyAT69mkBbx/v+2GVhw==
X-Received: by 2002:a62:2783:: with SMTP id n125mr17816801pfn.133.1586768266373;
        Mon, 13 Apr 2020 01:57:46 -0700 (PDT)
Received: from localhost ([124.19.8.131])
        by smtp.gmail.com with ESMTPSA id a2sm315136pgk.90.2020.04.13.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 01:57:45 -0700 (PDT)
From:   daurnimator <quae@daurnimator.com>
Cc:     quae@daurnimator.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: only pass valid chmod mode_t bits to security_path_chmod
Date:   Mon, 13 Apr 2020 18:56:45 +1000
Message-Id: <20200413085645.135829-1-quae@daurnimator.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chmod only pays attention to some of the flags in umode_t, don't pass
on irrelevant flags to security_path_chmod.

Signed-off-by: daurnimator <quae@daurnimator.com>
---
 fs/open.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index b69d6eed67e6..a2d8bee88a3c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -551,12 +551,13 @@ static int chmod_common(const struct path *path, umode_t mode)
 	error = mnt_want_write(path->mnt);
 	if (error)
 		return error;
+	mode &= S_IALLUGO;
 retry_deleg:
 	inode_lock(inode);
 	error = security_path_chmod(path, mode);
 	if (error)
 		goto out_unlock;
-	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
+	newattrs.ia_mode = mode | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	error = notify_change(path->dentry, &newattrs, &delegated_inode);
 out_unlock:
-- 
2.26.0


Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9989C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62D020873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519675;
	bh=Bh+4jULTa5d3rs6IKvG71GMmRZmRBPtpFh60phO/o4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b1XvF/EJCd1B/ht+AxbZgVYkhecgxiwSH9cCPv2yhzq1JBleKLfBLMHJo77XUj55m
	 +CdwobcFPZb3Zlb02ZJ1zlRzMotNr0MuFqZEHEMjinV+TZwUrQLJAT68muwHWlMtrf
	 wFM9YdqKUbl/5wfEy7V3/AEZQwIjHdRIbOMg/5cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390909AbgEZTBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390901AbgEZTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C092086A;
        Tue, 26 May 2020 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519671;
        bh=Bh+4jULTa5d3rs6IKvG71GMmRZmRBPtpFh60phO/o4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+L1sIoY/hEA5y5pBWEj4jdriRM0bR9WlE727KQRFYb49Sfhggb7lXtTDSsTcbep3
         unuDy1A91Q86PqMDFMOMUJNtAwdXcLfWS1EXQQk1Sfm2OojJNiN/ydGDqSVYv9gVCm
         4yf9FSrlbWhR0HGIxoc9KiCzCxsHdj8JwBc0txv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/59] ima: Set file->f_mode instead of file->f_flags in ima_calc_file_hash()
Date:   Tue, 26 May 2020 20:52:51 +0200
Message-Id: <20200526183909.120611336@linuxfoundation.org>
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

From: Roberto Sassu <roberto.sassu@huawei.com>

[ Upstream commit 0014cc04e8ec077dc482f00c87dfd949cfe2b98f ]

Commit a408e4a86b36 ("ima: open a new file instance if no read
permissions") tries to create a new file descriptor to calculate a file
digest if the file has not been opened with O_RDONLY flag. However, if a
new file descriptor cannot be obtained, it sets the FMODE_READ flag to
file->f_flags instead of file->f_mode.

This patch fixes this issue by replacing f_flags with f_mode as it was
before that commit.

Cc: stable@vger.kernel.org # 4.20.x
Fixes: a408e4a86b36 ("ima: open a new file instance if no read permissions")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_crypto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 06b0ee75f34f..7b16e54f01c6 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -432,7 +432,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 	loff_t i_size;
 	int rc;
 	struct file *f = file;
-	bool new_file_instance = false, modified_flags = false;
+	bool new_file_instance = false, modified_mode = false;
 
 	/*
 	 * For consistency, fail file's opened with the O_DIRECT flag on
@@ -452,13 +452,13 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 		f = dentry_open(&file->f_path, flags, file->f_cred);
 		if (IS_ERR(f)) {
 			/*
-			 * Cannot open the file again, lets modify f_flags
+			 * Cannot open the file again, lets modify f_mode
 			 * of original and continue
 			 */
 			pr_info_ratelimited("Unable to reopen file for reading.\n");
 			f = file;
-			f->f_flags |= FMODE_READ;
-			modified_flags = true;
+			f->f_mode |= FMODE_READ;
+			modified_mode = true;
 		} else {
 			new_file_instance = true;
 		}
@@ -476,8 +476,8 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 out:
 	if (new_file_instance)
 		fput(f);
-	else if (modified_flags)
-		f->f_flags &= ~FMODE_READ;
+	else if (modified_mode)
+		f->f_mode &= ~FMODE_READ;
 	return rc;
 }
 
-- 
2.25.1




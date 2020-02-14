Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF411C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696041;
	bh=xMt+/WZJ7JX4l2wXXyGzZfDgtpkGtXEWwqSlZvxiJAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ltg00WkQjIOO/oB9ppjJeybObSMc1RqGEx2bl+XzRTMicPcVJiMThkuObCIbhNEgl
	 7W913I/7CJvGSiRBBpA8PtmxZcmjrfhIbpz3kjF0CUh75ykCK3Ntu09K0I8zHbhdjL
	 cuHhawxHrqGyGLHKNObIRt+Zvo+w3os6O1RwtYlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbgBNQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388865AbgBNQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:00:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE62A24681;
        Fri, 14 Feb 2020 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696024;
        bh=xMt+/WZJ7JX4l2wXXyGzZfDgtpkGtXEWwqSlZvxiJAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rx6mkqGWxAHwdCNRTfdUGPJadnEtgMPpi0d6UMgE8reZWCyt9oOtxeOj+diLI3U09
         mR8X+DbLPcX37szpOTYS9cf/mipxe/rh6+vsHadmsgEr1EgsePw3TXwMlQuhVM6JoM
         IXAbIdN+GuDCt0WShqaWnzJGE5/V3qqTV1IPvIaY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xiao Yang <ice_yangxiao@163.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 539/542] fuse: don't overflow LLONG_MAX with end offset
Date:   Fri, 14 Feb 2020 10:48:51 -0500
Message-Id: <20200214154854.6746-539-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 2f1398291bf35fe027914ae7a9610d8e601fbfde ]

Handle the special case of fuse_readpages() wanting to read the last page
of a hugest file possible and overflowing the end offset in the process.

This is basically to unbreak xfstests:generic/525 and prevent filesystems
from doing bad things with an overflowing offset.

Reported-by: Xiao Yang <ice_yangxiao@163.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 695369f46f92d..3dd37a998ea93 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -803,6 +803,10 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 
 	attr_ver = fuse_get_attr_version(fc);
 
+	/* Don't overflow end offset */
+	if (pos + (desc.length - 1) == LLONG_MAX)
+		desc.length--;
+
 	fuse_read_args_fill(&ia, file, pos, desc.length, FUSE_READ);
 	res = fuse_simple_request(fc, &ia.ap.args);
 	if (res < 0)
@@ -888,6 +892,14 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	ap->args.out_pages = true;
 	ap->args.page_zeroing = true;
 	ap->args.page_replace = true;
+
+	/* Don't overflow end offset */
+	if (pos + (count - 1) == LLONG_MAX) {
+		count--;
+		ap->descs[ap->num_pages - 1].length--;
+	}
+	WARN_ON((loff_t) (pos + count) < 0);
+
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fc);
 	if (fc->async_read) {
-- 
2.20.1


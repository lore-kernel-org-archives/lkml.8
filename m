Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510DCC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDC22525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzQWKRSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgATUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:51:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37529 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:51:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so936079wru.4;
        Mon, 20 Jan 2020 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i01IMAk+P2q7SvWiDx3PdS1EE3a64YeasEvWKGdKL1w=;
        b=TzQWKRSyVsxrIwMZNWdMr6MJBcxe3ZsJiu2gbVDHwCpZjAA4F1/jPdhfy/M2lEr3+D
         jKbfhS+Rc6ysIY3y/Q7bQ5TP7dcojMbBdRVK2BWfBFRiLJKjEwyoNrGKRM4udQ/0MIsH
         FW/QtcreChkB5fQO2CiDHLWdem7aH+uIWNt223/YZdjyic+WwrM+vO1KEtt+STLYa5YP
         nm49mpSN6XDe2BcAfX/CYNjBA6lgtLlx9nciHcjx6z/FlBd+Cx98eGDh9Ydmjg4yMBrQ
         IKrPPCkWXTQFUyZUBa6Zb2qXT1KnNtOK5px4a2tZogx/rK14lqAkKYg+o9uPv7ih/wo/
         77aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i01IMAk+P2q7SvWiDx3PdS1EE3a64YeasEvWKGdKL1w=;
        b=FEqDP2dqZbvzkjmeJ6pNffd9w+8OyluYRdz2DRPMAWZcQnw02Eqzba5grJmRQ7R6EE
         JApLMudi73ukdiL49XX4wSjMqVEYhq96jlmRozUP1ROW9m6sPEaYwalDvHTjoVqSoSaT
         KVM6SAhW3tUtf3B2Y2QXonpVolTq7eZ956nZ+FTN3GK8jsDeHuDCdQNk2UeaN7GvpDNc
         zl6sZqjdQWGCia1B9qlrFLt+6+YN+OPlXMm9fmfX7cIx0RU+IIE+0yveTCPvz6bLjEET
         IQY4DwjrZjGXnFWJu2v4blAVPJQ40zxsMKTwV9KPji1qNejUBv3XJblQKLdRXefenmN9
         hD0A==
X-Gm-Message-State: APjAAAWm+iVabhrENhBr+K/BVdromnuhcYAUf3VAENy3MVV64MjFKnV/
        VsTwb9R0c1yRsnyUvPfZYef7ASqn
X-Google-Smtp-Source: APXvYqz0IHYH6HCD0/MIWo8ETFdvbDo9RpsboH2TPyu6qjcSVlXnvSD5LVUoIizkv9Py/PcxuzWx9Q==
X-Received: by 2002:adf:d183:: with SMTP id v3mr1373052wrc.180.1579553464249;
        Mon, 20 Jan 2020 12:51:04 -0800 (PST)
Received: from localhost.localdomain ([109.126.145.157])
        by smtp.gmail.com with ESMTPSA id r15sm771757wmh.21.2020.01.20.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 12:51:03 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] splice: direct call for default_file_splice*()
Date:   Mon, 20 Jan 2020 23:49:46 +0300
Message-Id: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirect calls could be very expensive nowadays, so try to use direct calls
whenever possible.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/splice.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6a6f30432688..91448d855ff0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -852,15 +852,10 @@ EXPORT_SYMBOL(generic_splice_sendpage);
 static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 			   loff_t *ppos, size_t len, unsigned int flags)
 {
-	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *,
-				loff_t *, size_t, unsigned int);
-
 	if (out->f_op->splice_write)
-		splice_write = out->f_op->splice_write;
+		return out->f_op->splice_write(pipe, out, ppos, len, flags);
 	else
-		splice_write = default_file_splice_write;
-
-	return splice_write(pipe, out, ppos, len, flags);
+		return default_file_splice_write(pipe, out, ppos, len, flags);
 }
 
 /*
@@ -870,8 +865,6 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe, size_t len,
 			 unsigned int flags)
 {
-	ssize_t (*splice_read)(struct file *, loff_t *,
-			       struct pipe_inode_info *, size_t, unsigned int);
 	int ret;
 
 	if (unlikely(!(in->f_mode & FMODE_READ)))
@@ -885,11 +878,9 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 		len = MAX_RW_COUNT;
 
 	if (in->f_op->splice_read)
-		splice_read = in->f_op->splice_read;
+		return in->f_op->splice_read(in, ppos, pipe, len, flags);
 	else
-		splice_read = default_file_splice_read;
-
-	return splice_read(in, ppos, pipe, len, flags);
+		return default_file_splice_read(in, ppos, pipe, len, flags);
 }
 
 /**
-- 
2.24.0


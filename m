Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDEC2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823879;
	bh=Lv0WdQHZZpH0+zsvuw1nREwCuf/qpR482iS0MwMpNcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBfQrM4Z9TYyPTtkmCVf0LmhAZ8ioEp5SR8UjRWnKoeWTQ4Hh8djMH/4BkzTGJrHN
	 sAf4An6HhKeBX6rC5Fi1Cl/SYi9fWpOnWoFD20Cf4rvP7hLdBFdYaI2FBxhUFXSmrl
	 bL++P9CANwtMpBh5wLiZMIKvj/ErSMRdsUiGgVCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgERRoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgERRo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:44:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE2B20715;
        Mon, 18 May 2020 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823868;
        bh=Lv0WdQHZZpH0+zsvuw1nREwCuf/qpR482iS0MwMpNcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCpy/SWl16bPPEUKkub38EPH4hru1CySi2yKEk5XmpZruo/HkDNncqYl4yQhiSfQB
         NAT0arNKzikww/0c5IZ/pR2EAQROVwsvdxCsmOHv5ik2QCgYAVtBaU291y2pzjsjIr
         WRoWFMvkQlPajH1Z+6GX0IuxWSuYfFs09yRVk3rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/90] blktrace: fix trace mutex deadlock
Date:   Mon, 18 May 2020 19:36:09 +0200
Message-Id: <20200518173457.510063696@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 2967acbb257a6a9bf912f4778b727e00972eac9b upstream.

A previous commit changed the locking around registration/cleanup,
but direct callers of blk_trace_remove() were missed. This means
that if we hit the error path in setup, we will deadlock on
attempting to re-acquire the queue trace mutex.

Fixes: 1f2cac107c59 ("blktrace: fix unlocked access to init/start-stop/teardown")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 55337d797deb1..a88e677c74f31 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -572,7 +572,7 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 	return 0;
@@ -618,7 +618,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		blk_trace_remove(q);
+		__blk_trace_remove(q);
 		return -EFAULT;
 	}
 
-- 
2.20.1




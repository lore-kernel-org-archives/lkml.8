Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B5E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865406;
	bh=w8I3q/H8D+xz74nVtTtd2Hsj1Psua0C3tPm6m8HhW4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcKQNn3xmOnsq6OZQE1SMoLYaf8rgWWnqQ27QNMckp7Wipq67yGNzR7QSJi4oOoyY
	 dHsFDCgFpYBXjao3Cfl0I+5esRDT6Uum86a2qyIjA5qtFnmm3P0+YEIkgo8oYZbQgy
	 jhIW5oUWSxUo1nEZU6JSKquTQY7ZU5qWFG4DCCwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404173AbgAXLaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404162AbgAXLaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:30:03 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F7B206D4;
        Fri, 24 Jan 2020 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865402;
        bh=w8I3q/H8D+xz74nVtTtd2Hsj1Psua0C3tPm6m8HhW4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yr0DUTRveu9vXgwxTtEe0BHkIop5MdqVynyMveh7C29WO2EpHInooFky8+IJBRCW1
         72E0T5UcTc/evJ2m5SAQ01Te/gWyN2qsh5r4eYXTCANlXFmmFgXirwB74kbtcwy0Un
         MOB/2Uw/pqgnFSYujX67zGg5D80m1bfHd90YQhCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 536/639] bcache: Fix an error code in bch_dump_read()
Date:   Fri, 24 Jan 2020 10:31:46 +0100
Message-Id: <20200124093156.146001293@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d66c9920c0cf984cf99cab5036fd5f3a1b7fba46 ]

The copy_to_user() function returns the number of bytes remaining to be
copied, but the intention here was to return -EFAULT if the copy fails.

Fixes: cafe56359144 ("bcache: A block layer cache")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 8c53d874ada4a..f6b60d5908f70 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -178,10 +178,9 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
 	while (size) {
 		struct keybuf_key *w;
 		unsigned int bytes = min(i->bytes, size);
-		int err = copy_to_user(buf, i->buf, bytes);
 
-		if (err)
-			return err;
+		if (copy_to_user(buf, i->buf, bytes))
+			return -EFAULT;
 
 		ret	 += bytes;
 		buf	 += bytes;
-- 
2.20.1




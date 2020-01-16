Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731CA24683
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194681;
	bh=WCiw39Tah59CdpVA/+EIm3RhSrKpRK61nNnaXUtKFDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MrDOBJ1I4r6byMnmv3cTIOKuEMTYVQJheW6e/1mjHW6TlBXfLgWIbjO1aL7At8ma2
	 eKHBvtitfCMCoJUwqkwA0kmsf7R4eThjUjKJIxRePlIpGgiGJsfCEfT01moqvWZMF+
	 buhx9c2fi6+l9tgPAR48oD5uOKZXSxla4v+C1FQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbgAPRLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390192AbgAPRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A30217F4;
        Thu, 16 Jan 2020 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194675;
        bh=WCiw39Tah59CdpVA/+EIm3RhSrKpRK61nNnaXUtKFDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKb5KuXjmp3n/qNUi9q9lVoV98aGv3kbDYWwHd6Z+ODmz1Ygf6wgviozUUrY9fIit
         pVzgSybJZF7JiARid9eIgCawzugDFHuSnpp8WnY9x33f6qrlu7/NAEDtv6xEhxtFMo
         neVojuXOUHKy43GxN7TsPNvRJMNz4fyRtY65r3sg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 522/671] bcache: Fix an error code in bch_dump_read()
Date:   Thu, 16 Jan 2020 12:02:40 -0500
Message-Id: <20200116170509.12787-259-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8c53d874ada4..f6b60d5908f7 100644
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


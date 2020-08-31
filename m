Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DC7207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jB0W7yIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHaRZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:25:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:25:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so5298271qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fnA8K+R9uRAtPbIClqpnQmt6aI2BGemHnr+qjEwk03s=;
        b=jB0W7yIkL0REurWxQ1jZXa0LpbHczNTZuRXFeoD7GZOgWmS7aYW8JljyxGfaC/MyAq
         K1Q9dxj7aerkz5nEh8T7JpCNNoxyun71YQO1ao8Sm4MDFrON5gkiYh3d9KlGJwrLZ9vD
         87+/fRnmLGozPS6XGVaug/SFVWq0mrq4Es+tuBbP/r20fAHAebsJYexMZblv4froMIeW
         z3PRxv4GfviGat0QvHkItzSsKihq+Qx4TZzBsEiOXJhkmRWeRGJxQHMIvcJo0vrqDQ7E
         nK6IYGAcy1fmf30b6YQrmNP+JiVePkFsJiA0yPi8t5NgXXbHPw2fKlf94Yl59524D+zh
         70GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnA8K+R9uRAtPbIClqpnQmt6aI2BGemHnr+qjEwk03s=;
        b=uWQtOAAptuPmc/LgWI6rqjfp2CFJGt4CW/g4/IX/HZ8z+tshapJ3ALOqqeU6gbNBX8
         A33DWjiqXhDpaDgwARLhxHtj9+NJCu51hjUGJJD/l2E4dr2cjFsKJb2RuRa/EQ0qWJ3Q
         OvG+B9131qanMCCjQS2rpMuINDYRnHDI1i7gPBrUWyiKCZ+JSfRAvGEgBvQGoP4q7g7P
         2psJlpiW7QsA+5NXpUDPrvGiyhQtVpS1ErvVYcawEsJXl5zb1kr4i0dKWFwk2e0wbZLj
         4iRS70E3JZWvpvNNguQpxJKsmWG+FEfeoGh9TP+GtId3qM7r9J8j+m0/T9aAXVP49PFu
         PsAg==
X-Gm-Message-State: AOAM532rMoogtO/mV1bNdou3vmNYlOW/7El3Pn1mMmKV3r9thxllIXwX
        l0Dw+k80LPVQz483VOaiBlixVQ==
X-Google-Smtp-Source: ABdhPJzndCINloToTJBaTxvizaZ7Y4/r3EDZ5f9QDqyzeqFaLlr2qrxR9CnOSy/h3pSwxfPRNB3Mzg==
X-Received: by 2002:ac8:581:: with SMTP id a1mr2285747qth.161.1598894745819;
        Mon, 31 Aug 2020 10:25:45 -0700 (PDT)
Received: from localhost.localdomain.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m66sm10143899qkf.86.2020.08.31.10.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:25:45 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] iomap: Fix WARN_ON_ONCE() from unprivileged users
Date:   Mon, 31 Aug 2020 13:25:34 -0400
Message-Id: <20200831172534.12464-1-cai@lca.pw>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is trivial to trigger a WARN_ON_ONCE(1) in iomap_dio_actor() by
unprivileged users which would taint the kernel, or worse - panic if
panic_on_warn or panic_on_taint is set. Hence, just convert it to
pr_warn_ratelimited() to let users know their workloads are racing.
Thank Dave Chinner for the initial analysis of the racing reproducers.

Signed-off-by: Qian Cai <cai@lca.pw>
---
v3: Keep the default case and update the message.
v2: Record the path, pid and command as well.

 fs/iomap/direct-io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..b7f3311569bd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -374,6 +374,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_dio *dio = data;
+	char pathname[128], *path;
 
 	switch (iomap->type) {
 	case IOMAP_HOLE:
@@ -388,6 +389,21 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
 		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
 	case IOMAP_INLINE:
 		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+	case IOMAP_DELALLOC:
+		/*
+		 * DIO is not serialised against mmap() access at all, and so
+		 * if the page_mkwrite occurs between the writeback and the
+		 * iomap_apply() call in the DIO path, then it will see the
+		 * DELALLOC block that the page-mkwrite allocated.
+		 */
+		path = file_path(dio->iocb->ki_filp, pathname,
+				 sizeof(pathname));
+		if (IS_ERR(path))
+			path = "(unknown)";
+
+		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %s Comm: %.20s\n",
+				    path, current->comm);
+		return -EIO;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-- 
2.18.4


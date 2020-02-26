Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1EEC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39A921D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgBZCby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:31:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729795AbgBZCbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:31:52 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 48639CE6B3828CDC0B36;
        Wed, 26 Feb 2020 10:31:50 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Feb
 2020 10:31:40 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [PATCH 3/3] erofs: handle corrupted images whose decompressed size less than it'd be
Date:   Wed, 26 Feb 2020 10:30:11 +0800
Message-ID: <20200226023011.103798-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226023011.103798-1-gaoxiang25@huawei.com>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Lasse pointed out, "Looking at fs/erofs/decompress.c,
the return value from LZ4_decompress_safe_partial is only
checked for negative value to catch errors. ... So if
I understood it correctly, if there is bad data whose
uncompressed size is much less than it should be, it can
leave part of the output buffer untouched and expose the
previous data as the file content. "

Let's fix it now.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c77cec4327fa..be8d9adef236 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -165,14 +165,18 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		ret = LZ4_decompress_safe(src + inputmargin, out,
 					  inlen, rq->outputsize);
 
-	if (ret < 0) {
-		erofs_err(rq->sb, "failed to decompress, in[%u, %u] out[%u]",
-			  inlen, inputmargin, rq->outputsize);
+	if (ret != rq->outputsize) {
+		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+			  ret, inlen, inputmargin, rq->outputsize);
+
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, inlen, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
+
+		if (ret >= 0)
+			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EIO;
 	}
 
-- 
2.17.1


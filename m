Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A420735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456877;
	bh=Z2Tr7SHgyJAdHR4e50WA2Y+RgbHkio00wtYGgYjmrXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHOke7gBUdKddithjoTY6gWnwNjR0swqJXLCueKkVIDbeq8J4B2fETOZOOOt3Oh11
	 olXYp1Zc5k2cjFpMgf0OKs+78n/pzLEqcRQDYrqTntltB39uG50rMkWnf9uZlKmV0z
	 Ql7GSlaPV4lDB2ZneOlyttiT0ilyXBXpGszRE4+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCQOyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FA920753;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=Z2Tr7SHgyJAdHR4e50WA2Y+RgbHkio00wtYGgYjmrXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lh1s79RO7iVtKUEU3KT+kuvlzhdKwwMTsrXtoJSF7HN+ww5IcRzuO757zhsPXQveC
         Nc3wSDtZzQQN7Umg16gnk4EBFPgbxMQHQR/kTsNY/n7ws8iqjyG1dIeZPxuZ7Hpu2R
         KEyqc9e+Rjcos+chlF7JUPKIB0s+QJhdJGKtcWtI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMk-KY; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/17] lib: bitmap.c: get rid of some doc warnings
Date:   Tue, 17 Mar 2020 15:54:17 +0100
Message-Id: <ac57e12e0b75cb723597db61296950ce2d6d8577.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ascii art drawings there. Use a block markup tag there
in order to get rid of those warnings:

	./lib/bitmap.c:189: WARNING: Unexpected indentation.
	./lib/bitmap.c:190: WARNING: Block quote ends without a blank line; unexpected unindent.
	./lib/bitmap.c:190: WARNING: Unexpected indentation.
	./lib/bitmap.c:191: WARNING: Line block ends without a blank line.

It should be noticed that there's actually a syntax violation
right now, as something like:

	/**
	 ...
	 @src:

will be handled as a definition for @src parameter, and not as
part of a diagram. So, we need to add something before it, in
order for this to be processed the way it should.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 lib/bitmap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa342d6..21a7640c5eed 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -182,21 +182,22 @@ EXPORT_SYMBOL(__bitmap_shift_left);
  *
  * In pictures, example for a big-endian 32-bit architecture:
  *
- * @src:
- * 31                                   63
- * |                                    |
- * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
- *                 |  |              |                                    |
- *                16  14             0                                   32
+ * The @src bitmap is::
  *
- * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is:
+ *   31                                   63
+ *   |                                    |
+ *   10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
+ *                   |  |              |                                    |
+ *                  16  14             0                                   32
  *
- * 31                                   63
- * |                                    |
- * 10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
- *                    |              |                                    |
- *                    14 (bit 17     0                                   32
- *                        from @src)
+ * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is::
+ *
+ *   31                                   63
+ *   |                                    |
+ *   10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
+ *                      |              |                                    |
+ *                      14 (bit 17     0                                   32
+ *                          from @src)
  *
  * Note that @dst and @src might overlap partially or entirely.
  *
-- 
2.24.1


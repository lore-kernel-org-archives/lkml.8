Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE244C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F320787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360917;
	bh=jd11BH+E0kQ4lfNrsHgxWhZfvWguP7UNkigN6xgvlsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnHNDSdMoHY7bgmw1YYNcbqqEAgZoX4kTclbEhLwkiZDSrhgAjyi/53uzmzdrM6v1
	 CzLfFlDuLdkTBHqaOMDrN3sQoa2bNfJ1Hzz8dcmWNsmKqiqZOCjVOm0ZnYALkzA4yL
	 Tgy0grpdnWlrCDMrvQ+S3jVpaHvTM35eyv33R7gI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgDHPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CD92137B;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=jd11BH+E0kQ4lfNrsHgxWhZfvWguP7UNkigN6xgvlsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkgPDUwIoYPkWOKoX+EAxrVtqxF39FbXCaCUpyZ3EhySp/uxKR2kqEhGeFE1L1s7C
         AM765Tj3q8VBNXNOrHpI919WbaOZcDjvvLwMh65mLW7530XSBikwF0EHu6hz/vpMAd
         FQMtRNh9NqclMd30TKvIVZh2yvQ+X9OQ0d56p96E=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBD-HB; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/35] lib: bitmap.c: get rid of some doc warnings
Date:   Wed,  8 Apr 2020 17:46:04 +0200
Message-Id: <0ca3f81a481469014d207535163294493a9d2eda.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
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
2.25.2


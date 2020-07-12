Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A9B206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+DKaYD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGLNAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:00:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728735AbgGLNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594558803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tP1p0y5VuFxAzgtXgy/goQauifZ0DIQKOQPjri03c2c=;
        b=D+DKaYD8t1JKCyL/XUXUKGtTQHbBMt3PBUHC89aO7BQpTDudPO5zIL+um0w2SQkvQzyDOm
        xjkVywbFHOximZ2sqCLrxwx72vZ6uCpB47hBf4QSWH4Lu3QA6hLw+f/uRzTzAjOUuRlii/
        qg8iiDXfGQQC4HZugZwj4QRe5XGgYSc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-MqFoSafQOrCaVd4cR1AbAg-1; Sun, 12 Jul 2020 09:00:00 -0400
X-MC-Unique: MqFoSafQOrCaVd4cR1AbAg-1
Received: by mail-qk1-f197.google.com with SMTP id j79so8656909qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tP1p0y5VuFxAzgtXgy/goQauifZ0DIQKOQPjri03c2c=;
        b=PZz78ZXo3L83WSN7S/2gEXsBYpAvR+R0gDKhEj2ZQiPbKCxHjnocb/XsIxsLvx645q
         c8Qnhdo6m0gEuSWO93TmOpgfP8b2V3dy+Bz3Q8uJUIksROHkfnjazS7csjdFEY5nNihj
         KMTEfu2fj5qNwMNrFqJMvKBdzcqqrzmrWdcFv062SQANArghsvbihouqrSNmL9xCm3w4
         N8nNhMCYs4Wbf365C+7MIbSamKiwlhwW2NXgIiZFzpiE0Cayl3JQ6Qvon/0k5cJPIkXt
         +nXgqNGlyXJ5aI6B+mN/bj4z2xBeTp2h7Lwgn6YeC0HWyX0ubniSajdAzy5m5tf6XkwT
         lBRw==
X-Gm-Message-State: AOAM5325sVl5p9e14QAhi/rr4N7APmxT5vRfe30i6j+cdzZY/+o5nXhg
        Qn526/TQskSXKZUyiWrWfyiXkjUtoSJK+7XhgUZyHWJEZ4P/1cKFrQkKJYKiZYsRh9lgA66zMdK
        rA+d7jAEEWNL55KrowobNUrHe
X-Received: by 2002:ac8:3544:: with SMTP id z4mr69890727qtb.68.1594558799663;
        Sun, 12 Jul 2020 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCFScybhjUoE2d3Vzjj9N9mrsMuV/Nq5PadBwjJZI0XXcjVFovcX7MaSls1X0DteDOlq8Amw==
X-Received: by 2002:ac8:3544:: with SMTP id z4mr69890709qtb.68.1594558799402;
        Sun, 12 Jul 2020 05:59:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 21sm15294425qkj.56.2020.07.12.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 05:59:58 -0700 (PDT)
From:   trix@redhat.com
To:     hpa@zytor.com, alain@knaff.lu
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] decompress_bunzip2: fix sizeof type in start_bunzip
Date:   Sun, 12 Jul 2020 05:59:52 -0700
Message-Id: <20200712125952.8809-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

lib/decompress_bunzip2.c:671:13: warning: Result of 'malloc' is converted
  to a pointer of type 'unsigned int', which is incompatible with sizeof
  operand type 'int' [unix.MallocSizeof]
        bd->dbuf = large_malloc(bd->dbufSize * sizeof(int));
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reviewing the bunzip_data structure, the element dbuf is type

	/* Intermediate buffer and its size (in bytes) */
	unsigned int *dbuf, dbufSize;

So change the type in sizeof to 'unsigned int'

Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 lib/decompress_bunzip2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 7c4932eed748..59ab76bda7a7 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -668,7 +668,7 @@ static int INIT start_bunzip(struct bunzip_data **bdp, void *inbuf, long len,
 	   uncompressed data.  Allocate intermediate buffer for block. */
 	bd->dbufSize = 100000*(i-BZh0);
 
-	bd->dbuf = large_malloc(bd->dbufSize * sizeof(int));
+	bd->dbuf = large_malloc(bd->dbufSize * sizeof(unsigned int));
 	if (!bd->dbuf)
 		return RETVAL_OUT_OF_MEMORY;
 	return RETVAL_OK;
-- 
2.18.1


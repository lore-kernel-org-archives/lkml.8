Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3603C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DC72075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kI/DmR2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHZPQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgHZPPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8ECC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a14so3150230ybm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=kI/DmR2cv1d9OJFdhnImUqHSGWV1ZqxdGqYUbrFMzIZoLjyBZUGrKg8nscJM4NLWSq
         aoE+SNTNoDERTGQQ81Jv2cVwHVUyQF4rCSPCBrfHjuNwC0mrKkXcOif6H4GqJ3ObCD1W
         ehHwAGA7xggv+ecKbvq/e9V08q0y/RhTUILd/sit7XJxc7N/40Scp5dgnxPvQs6qrvIc
         79svxj8OV2XyIQ/z/HVb3yBer3F95VUgY2wiLnnZkGmA8ejGcBjzRg0W57SvZTtUh/lg
         tHZ2FutPYjZ60wnBdq/W3QSQ7XEECKopv3MAPfeOlE+Y2386UV58ZZUOqTacbwL3yjIs
         jL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nVHuYaY9UtfQ5ceDG+IOgNARKDklUVVN28+71pW1fmk=;
        b=PzfbNOFLcP+4escUxn4Ft5XOSu4019BxTF8bal1IjmreJk53J3ebkYYMYax8FOnnlr
         wmiHBBf2efDTQH2aorTMFJsU6OmiKnHE0YLKWrcmA3+W8i8Ovlz8QcnRvkeMP3yedyU2
         cGcNWfWbHwEED5W6XFEIyDwrN/3NGg19FrD7hk/Wtz+Wmf/PgmrRXqDE+bfJ2O6po6wJ
         29R4sMGzaiQhR1/SKTwkgWTztZJotIC9rd5SuL4YYvFgrV8jSrsCC6Cuxq9ikme9MGWM
         TBJCVvy9t3PvTi5kav9hktPf3uVW7N2uxCJrrzoDRbiOpN/oF6F74UcfF8ICTLntZNdQ
         R8fA==
X-Gm-Message-State: AOAM532zMoQHDKfH1e+DpREokRWnR3j7iNKbC4XJ5kWbNC9t8r9sjZIK
        M/HzBrjh+UnkzP5Fq3JYmQuAnvirBQ==
X-Google-Smtp-Source: ABdhPJw/rcqGxzh/fmBX9LEz09Jq8CAXmzs2q38x7tBY1D1+LTR0sUBBqdFxw+NulLkgSDFNyvsboxvOcQ==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a25:3cc3:: with SMTP id j186mr21293924yba.208.1598454941009;
 Wed, 26 Aug 2020 08:15:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:45 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-3-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 2/5] coredump: Let dump_emit() bail out on short writes
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_emit() has a retry loop, but there seems to be no way for that retry
logic to actually be used; and it was also buggy, writing the same data
repeatedly after a short write.

Let's just bail out on a short write.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/coredump.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..5e24c06092c9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -840,17 +840,17 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	ssize_t n;
 	if (cprm->written + nr > cprm->limit)
 		return 0;
-	while (nr) {
-		if (dump_interrupted())
-			return 0;
-		n = __kernel_write(file, addr, nr, &pos);
-		if (n <= 0)
-			return 0;
-		file->f_pos = pos;
-		cprm->written += n;
-		cprm->pos += n;
-		nr -= n;
-	}
+
+
+	if (dump_interrupted())
+		return 0;
+	n = __kernel_write(file, addr, nr, &pos);
+	if (n != nr)
+		return 0;
+	file->f_pos = pos;
+	cprm->written += n;
+	cprm->pos += n;
+
 	return 1;
 }
 EXPORT_SYMBOL(dump_emit);
-- 
2.28.0.297.g1956fa8f8d-goog


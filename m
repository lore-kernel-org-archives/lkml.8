Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC54C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB31214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiXVr9LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgD2VuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727813AbgD2VuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:50:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FB2C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:17 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d35so4471242qtc.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JqiR2vOdqFfBqjhyMGJp8d/qL3dB8+X/PfK7MWBosOQ=;
        b=aiXVr9LW0+RfYp/BGKCZwf2eFb8u9bW41qbryYBrMOTMAxizbTvkyUsj2hMqoewXVA
         EbenkI3pjlj6j3Jz6v58GVbjLsRucPnyBIwyrf/cQxI7QYwEK5k1uOps+KFUBQSyYzSq
         4ScWZwqWRdd/I9EOQCike+A/g8LgBL08ZkugaoTqx2zKcpO0yY7MZeP+Y4VZXfi2opO+
         u0ixT5IVpYsz33tv0SuE/w161GkFjCv2PC0mWH6RqlvaBsCA3Nae7CGPq+IMF6tcDpg/
         xDEfx6+SvCzPkM2Gw22E+XqkcpxanCcgz9Szd+JSjxTdcGi6OboSgHQ79epRcTxfLjBk
         yKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JqiR2vOdqFfBqjhyMGJp8d/qL3dB8+X/PfK7MWBosOQ=;
        b=duRXNEZTlkSv4MtBnBF7mAJaLOeZ+cetsTOa2oibd/hcoB2xUb5yDKyRjpHnX3s9Go
         Xm6nuUqAk/6lfgp4dljGWVGzJOs6ZmRycdzyKSB5B/CSbjQlv2HAeSP9CkHUFOeORurz
         cCtBbxdOnHmemsyZ39+ABIYkBVHW3bqRYnBDi3S6mWAc+YA62RJspIfu2flDQEsb7hmC
         hCb4/wTlmVVRtHnwR54CUP6nWvF9HRt9iEpxwM4Az+QC9NSoqci0ojEWYk/81e4nz87c
         pncE5UU8hXu2nDavUqdOEqzEg4lZfmgQ5sPA6o1gNdu+COAKF0Fep5gZyJuj3vV3/1s7
         l9wg==
X-Gm-Message-State: AGi0PuZyhWbpl9BokZ2N1Ptfyw4ZjXL1IPdxgKs15x30j31clzor70sX
        MEU50Qm6WQlk/J9GWCQ10g+0rp2OUQ==
X-Google-Smtp-Source: APiQypIhYRdYrJfvjviu8u64QDDNe2LAeKB+wfqrsyuISOkwKNnezPoPTQS28YSpGgdHWAPJujbNXC6IaA==
X-Received: by 2002:ad4:49d3:: with SMTP id j19mr34024184qvy.78.1588197016281;
 Wed, 29 Apr 2020 14:50:16 -0700 (PDT)
Date:   Wed, 29 Apr 2020 23:49:51 +0200
In-Reply-To: <20200429214954.44866-1-jannh@google.com>
Message-Id: <20200429214954.44866-3-jannh@google.com>
Mime-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 2/5] coredump: Let dump_emit() bail out on short writes
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
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
index 408418e6aa131..d6fcc36a7db1f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -823,17 +823,17 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
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
2.26.2.526.g744177e7f7-goog


Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F2C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0420C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJkEz75f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHRGNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHRGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:57 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872FC061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:57 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c16so7468131edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GSVoeZY4VtJncRCsBDOJV6iGFCXNH029JG2AgbxMzIw=;
        b=mJkEz75fkVHT8du8gdQBjaw6pE2ldFlA4jAPMSL2QbrZWXnfCVbN0C+c08ERHBXu6g
         C2fnjAZnH5RpJUIy5bISJjpd5WjqtYLOVKzqSpZEUfB9oMJdSN28QzPbF9Nlo8946/Fj
         oMh5GZo83yuAfd3Li5R2BToVuUri/UWMuEmqmPuoHlnAFltI6gltdTVRb4pk9SMR8r3s
         VxGDiC/Qdhttg9SXgox69qIlULfK8Md8HEGzpeXVfTvQr/JMHA9T5dT2KQ+7AwF2YMXd
         KtyAFJ/QUHW796NNlto8dQliaZ6uR4Jj68ysPjJBEx1Nd/tzEky2FMVHrzXQJZ+L4CxF
         tGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GSVoeZY4VtJncRCsBDOJV6iGFCXNH029JG2AgbxMzIw=;
        b=WKVOgRq16YFY0SkdAt4KgSIzf4/ftWL/Ce8I/25BuCiR0wEF2jvDEcg9tPkDxzVItu
         dauNHSdZHyHZQYg2dFs4DbkLaFKs2MyeLs8mTmxtnIzwjpJ4gMEDkQiV42qa964d01Up
         MMhxFI+sxOBxcXAUu97pEdCFKAhdwSWnjdFp0gPcKP40utGjr3u8uIHuItbi1uHQ9Wtc
         sISSrIg+L61zSzPb6fgrtHsKAwN/a7GOPLSjBz/H/7GBodbaSMhAqVI4cNNuUPFmX1Zx
         ZOp3nZunMQrLnhyEs63qXUcgPNJNy1LuvA1cidJrQbtt59mca9JQYxL+IR7M2MKUKFNu
         M1Pw==
X-Gm-Message-State: AOAM530twCiVTpKPNwXeBT9gQymPkXdA8WpOeISi5R9rt2sei0oP9GW4
        UOkvmUh90E22Fsl15aad38qb3pb3UQ==
X-Google-Smtp-Source: ABdhPJw8kbNtK89Z+bGnNpE12khmVpUyK5YNskcMYl1yh5qw2UP1aNNDhMVoCYncY9CyFubOVCb/FD841g==
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr17620488edg.61.1597731173685;
 Mon, 17 Aug 2020 23:12:53 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:36 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-3-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
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
2.28.0.220.ged08abb693-goog


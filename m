Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9036214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al25Ucu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCBVeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:34:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44259 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgCBVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:34:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id v22so805589otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 13:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6ClrHJCDNehdRwS/y+69ocK05bWUHG0fpm4Y3ogQMg=;
        b=al25Ucu2Xvqlcka3jbLAcCOKotduTm2FFbbXOqn9KbMySnDy4wnIl+NPtL0S1pWkU7
         caNnGcCoHb/wAZVNKaYFlHYQw8t3Lviym7agQi5JyryS+mW3kXGsNT110isIDpycpI+s
         9U0B41qhuBQ0491XYM3K/Tq/B7/p6nnblL6xZ7gKB+CmQt9+2MzFFf7TleRsqCThQZHg
         IktBo4UMv1SdUNKacekdQpSspTS2mXuBcZfxIGLyTxRatn6dg1/jIqcXMtWXq8MJ7MiC
         wYDIMROKG1f0LOlZtTtQgZjwmDIZwojxsKjtz5SjuQidXnXSH/9qleZAMuWK6BwUeqZR
         jRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6ClrHJCDNehdRwS/y+69ocK05bWUHG0fpm4Y3ogQMg=;
        b=HsjUn7LfVTI0/ge9BQhtOmmNasqAH5Axq5CLq8DMV07rfVOn4aP9gGCzXC4VtYMUOp
         KklSACxU93b93gZRPOp821Ta2dDYXO4Qpu4f4Hn/doQqxG3DngZAo8F0xI8Npws55eoc
         OdYXkXoWHm3lIDffi5OD+XFIbjbEdQDC7vEQ7LS3EhOfddWimwHvK/QcvrPZQVe1W9pC
         BaMy6HArtg+xsps9yCHHpaZXIy4ZOIXgbZLm19fdSPZhvj48OsrYHDrRd2fARDFT9DKw
         cNx8B02kyvpR8S+RhAjqFgbgqW2dPfETW1U6obgybCuyKRnAeRnXxRq91oCiTA8JBORU
         nmWw==
X-Gm-Message-State: ANhLgQ1AxP2vbp6U5A64x77X6dazRQAO4ZCo83BlBkqMbBylusP6J+Tc
        JGJHGgTQ3f4JZ5G87SJHUBA=
X-Google-Smtp-Source: ADFU+vv/dsAfj+I3v6er9aIU2nKtO/wQ5/JQlq1sKIQOIzhf8z5bRmfp21cvf0h20av/H5hD/WHeDA==
X-Received: by 2002:a9d:3f5:: with SMTP id f108mr953744otf.103.1583184862374;
        Mon, 02 Mar 2020 13:34:22 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e206sm6809252oia.24.2020.03.02.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:34:21 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] coresight: cti: Remove unnecessary NULL check in cti_sig_type_name
Date:   Mon,  2 Mar 2020 14:34:02 -0700
Message-Id: <20200302213402.9650-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/hwtracing/coresight/coresight-cti-sysfs.c:948:11: warning:
address of array 'grp->sig_types' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (grp->sig_types) {
        ~~  ~~~~~^~~~~~~~~
1 warning generated.

sig_types is at the end of a struct so it cannot be NULL.

Fixes: 85b6684eab65 ("coresight: cti: Add connection information to sysfs")
Link: https://github.com/ClangBuiltLinux/linux/issues/914
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index abb7f492c2cb..214d6552b494 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -945,10 +945,8 @@ cti_sig_type_name(struct cti_trig_con *con, int used_count, bool in)
 	int idx = 0;
 	struct cti_trig_grp *grp = in ? con->con_in : con->con_out;
 
-	if (grp->sig_types) {
-		if (used_count < grp->nr_sigs)
-			idx = grp->sig_types[used_count];
-	}
+	if (used_count < grp->nr_sigs)
+		idx = grp->sig_types[used_count];
 	return sig_type_names[idx];
 }
 
-- 
2.25.1


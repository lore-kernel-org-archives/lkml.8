Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BCC4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A925A206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm3Y5RK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:57:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35697 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:57:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so1378007wrn.2;
        Sun, 22 Mar 2020 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUQo9FObQ1FgjFAGXhInSZHPZVn6g0FEvK2Y0V4ii4s=;
        b=cm3Y5RK61DgWTyAjUEHbhN4kf16h0FsjsXqX5Wi4X5whIT2SP4SdktnwB1jesX8aKQ
         tzqzci22S8NX105QyHJSiJLu+FRV5Ba4SfX5yFnz6ccIyIDW1PWvsMLg9r8xrhMqFK6o
         P/mPFg7lfPr+20+Hvo4DGbSaVc4l4bJe6PGv3bPESHghmSt2Yh92ha2kxNsRMlcCSMue
         +Y3zrB2Xi60lRou1SzOm+pU+qpq1VP5FPjer+W9z3WwbCpysaj5W6e6XOsI6DSpEBNHq
         DvUE4cMFexRKyp5N50ZLLKReIo6qW2vO1clbvnLuwO3q1BgwEN6cuH1Jbni9vIjnq3cv
         xQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUQo9FObQ1FgjFAGXhInSZHPZVn6g0FEvK2Y0V4ii4s=;
        b=iW85Pm/taJ1PPEDcsJQS7sGlCUOPxqZg+Yoi4U3MHpd6cYcm8Ryw9XRlH1m/8ktDtf
         GJ5+cIzrbUsXDV2G32ioOr4mJ8aTmMuf96TQVWhuTmjtbX5yPjEHNQf78tkUc9MWcB0E
         2QMdW1Y4PZ5Dlt7FUUIFSTGjlYC0zJB9LrGmg5/WVne7cZLFeyyYReAiMuwHQrWogT09
         W+MsZeLK3IiA2oUfh4hFhS+maIeeULpGicSNvgX2Sg6qiPeXd7cnQrIKmaLZ5ON4HINs
         W9Cc/4OF3z2VZOqyy2v2mQTIT0gZFoAGeHJtL/StvHz6ZqRdAEOPFa37if4UPzrxkrhF
         /BLQ==
X-Gm-Message-State: ANhLgQ2ndDq1p1KEfxI30QwjpsvvxMnvDXXuI20U0Rr0J3XdYfscF7Hz
        htAOQKBvzpwUH7onswdDlRU=
X-Google-Smtp-Source: ADFU+vv0O1PRSJTkoWSbd2kn8eMmyO5OQPBalAxMSJYJK6yNWO8ywwkAx6pb4+XopsfmHHm9FENUxQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr24635645wrq.368.1584896231295;
        Sun, 22 Mar 2020 09:57:11 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d25:ed00:30d0:a825:e837:3a59])
        by smtp.gmail.com with ESMTPSA id t126sm18806162wmb.27.2020.03.22.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:57:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nicholas Krause <xerofoify@gmail.com>,
        Duan Jiong <duanj.fnst@cn.fujitsu.com>,
        Sachin Kamat <sachin.kamat@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] err.h: remove deprecated PTR_RET for good
Date:   Sun, 22 Mar 2020 17:57:02 +0100
Message-Id: <20200322165702.6712-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, commit fa9ee9c4b988 ("include/linux/err.h: add a function to
cast error-pointers to a return value") from Uwe Kleine-König introduced
PTR_RET in 03/2011. Then, in 07/2013, commit 6e8b8726ad50 ("PTR_RET is
now PTR_ERR_OR_ZERO") from Rusty Russell renamed PTR_RET to
PTR_ERR_OR_ZERO, and left PTR_RET as deprecated-marked alias.

After six years since the renaming and various repeated cleanups in the
meantime, it is time to finally remove the deprecated PTR_RET for good.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Rusty, if you are still around, Acked-by is appreciated.
Uwe, Acked-by is appreciated.
Kudos to Gustavo, Nicholas, Duan & Sachin for previous cleanups.

applies cleanly on current master and on next-20200320
Jiri, please pick this trival patch for the next merge window. Thanks.

 include/linux/err.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index 87be24350e91..a139c64aef2a 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -62,9 +62,6 @@ static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
 		return 0;
 }
 
-/* Deprecated */
-#define PTR_RET(p) PTR_ERR_OR_ZERO(p)
-
 #endif
 
 #endif /* _LINUX_ERR_H */
-- 
2.17.1


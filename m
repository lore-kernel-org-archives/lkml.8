Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C41C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4oaA16x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgAJA5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:57:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35465 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgAJA5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:57:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so154664pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rM/owZAET4GCwQC0PC5PAHgpb0nHipQ20y8Z5JkX9es=;
        b=N4oaA16xRTKxdqEsXtr8WMVdmBz5oJi7V9/LjrnCfb29T/rGwDCeku9PY+iyy6oRGV
         f/IuwML/ffpUJ4706EUPAUORBI4vgaTE2ARCodD1oZCifXfovuhusOxdUmMXkJLEMfBs
         fHqWiq1FBuuxA97i6R8pAE9YvV7wzmoszfLAiPQb6sz5Cc3EqUp3zZtu4oYHT+Fcxgqg
         rNKC8akIEnv1AzWLEkS7LNwI3LDvudWvMp4hbobE56aqrRHJblLUMxf1+Y2mPwcw658K
         /0GMErnmi1D6/R/VTxw7CktiTIMSjW808dR2ZoGoUN/wPaz0vz8/qU4RSg8m+JrFM/+8
         USJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rM/owZAET4GCwQC0PC5PAHgpb0nHipQ20y8Z5JkX9es=;
        b=sDTuCY+y3dml12+PQwG0JSWwA2tkTOmdMSnW457PUzj+gRUz/Eu2nlpbKGmta4hLaE
         SBA2fjL/wjmmCxDFi0F3o51s1USwZCS3/MoM7uKoQWgVyPRL21oauFs9jWrFXB8EEUFf
         4AiDr+so70+B4DHEazvj1Oh1Khdnj9DyxBtrfs6Ag50R2/ZtHt6gSAYHVBqA/0hSwusT
         7A8a5TTE8oUE7G7JMAYEUKsAYV4ukPQ9TVXLZaFDnIkOJXunDfk/gMgq2vt6PaaBX8aD
         peNQaMlhJD/EDaH9MU1g59FwaKkle1XW/UxTJSUtUjSBJXPpO3ixmAEFFaMsTBGK+WY/
         0MfQ==
X-Gm-Message-State: APjAAAXkus1g3xkxA7E+h+FjUyIcxHyc3M5VBMwhlaTbu0mr58n5Ml2a
        RebQuSkqf036W3yG+HC+o1I=
X-Google-Smtp-Source: APXvYqyY0apVwayvUbKnFd3MSvOKpV+e1O+xO5OmaienrSj82+28Znc+zcN8JqnJDNItLsjBh01iOA==
X-Received: by 2002:a63:d14:: with SMTP id c20mr928870pgl.77.1578617829732;
        Thu, 09 Jan 2020 16:57:09 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c1sm259017pfo.44.2020.01.09.16.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 16:57:09 -0800 (PST)
From:   liuyang34 <yangliuxm34@gmail.com>
X-Google-Original-From: liuyang34 <liuyang34@xiaomi.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Subject: [RESEND PATCH] trace: code optimization
Date:   Fri, 10 Jan 2020 08:57:04 +0800
Message-Id:
 <27225bf0ec9b4e2f3d313456aee75e294361d550.1578561009.git.liuyang34@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578561009.git.liuyang34@xiaomi.com>
References: <cover.1578561009.git.liuyang34@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200110005704.uBMnxTvuVyW2xGC38tgnSxFophSupLbsUGYG1nSPEQk@z>

use scnprintf instead of snprintf and no need to check
the return size again

Signed-off-by: liuyang <liuyang34@xiaomi.com>
---
 kernel/trace/trace_stack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c557f42..7b15e9a 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -329,9 +329,7 @@ stack_max_size_read(struct file *filp, char __user *ubuf,
 	char buf[64];
 	int r;
 
-	r = snprintf(buf, sizeof(buf), "%ld\n", *ptr);
-	if (r > sizeof(buf))
-		r = sizeof(buf);
+	r = scnprintf(buf, sizeof(buf), "%ld\n", *ptr);
 	return simple_read_from_buffer(ubuf, count, ppos, buf, r);
 }
 
-- 
2.7.4


Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D407C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437F524125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI+QH8Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBRSmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:42:31 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45948 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgBRSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:42:30 -0500
Received: by mail-pl1-f201.google.com with SMTP id 36so10649782plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d2wRJbkLFbnX5h47+/KLKTC9EOu1JUk/eVuafQjYbHQ=;
        b=oI+QH8Mdb2jaFfP3q7AupqB0QhhC5C1B/q18uf5tlCkfj0fGYsfGN3WEhSgn8ktTye
         UiMgo+VvnJG1h3Bgz5YmaO1VlLK93iihg4L36/gRFJNb2Qd3D5Efu0r8r3znpxP83uCe
         JHZIezRmf7eCcLSzet3tsvEgcms82qlBc2J8accp8ALlkwXpz+nhXOQ15ndG0JuS9C+j
         b+vSHiWUr6dM8sbKQEbaEITysRx+/3XJNjx+f35KRLF7cucVH/OoTLPRV0xXAJgaawi1
         Kbsyhl9TtefwGkKkozcsvWIJnfYrtV9lmiao7Oz6XkOxa83P5/iqajKbDe+n0dWBB0jV
         2mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d2wRJbkLFbnX5h47+/KLKTC9EOu1JUk/eVuafQjYbHQ=;
        b=PuNJQS/hgoRFwRnGrncXMX/01jnTB7JCRFTjZbuZq2DNn0dfn+1261Muh5C+jClooy
         kCmQmPpexYMTHXvoxqsyNUTerbsumrtKWWyQf6D8y+5ZUYUt8NtpyMc6BTh0slN7z/kg
         yyrD5bwgWJLW8pzgU6GIFwUBCmCuvFmHeDwP7b1L574Jih7X1ZY+5lfrJTyR7lnyzg9K
         QONqWR6LdOGdwklU1iRUarD9Gq8cvIHKzJx8dMxzYgfHIgkZVr9+gs2Xdk1GE4pm/k8Z
         thmAWJ0P18aQneooRKXpNbd2O5uzqMC1AkGb8CRi4lr2V0/K8gnP9T2QPiV+8SOP7gqW
         yf3Q==
X-Gm-Message-State: APjAAAXI6P8ToePGW+jNMWWE0hH5Mh+oiCELlRn63o+BSNY94iGim4Tf
        W9oG44h1pIJkb+U/huhQpIlwL65jGwK9IMw=
X-Google-Smtp-Source: APXvYqybJhwnaBstjsEqK9dPPh5DMtXVQM3bbQkXsUXhhmQa5y81y2B1B6yYNSTQz30gxNcqcGYiP6k0NLPF8xd5
X-Received: by 2002:a63:455c:: with SMTP id u28mr24914926pgk.163.1582051348672;
 Tue, 18 Feb 2020 10:42:28 -0800 (PST)
Date:   Tue, 18 Feb 2020 10:42:16 -0800
Message-Id: <20200218184220.139656-1-jkardatzke@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] media: venus: add support for selection rectangles
From:   Jeffrey Kardatzke <jkardatzke@google.com>
To:     linux-media@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Malathi Gottam <mgottam@codeaurora.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malathi Gottam <>

Handles target type crop by setting the new active rectangle
to hardware. The new rectangle should be within YUV size.

This was taken from: https://lkml.org/lkml/2018/11/9/899

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
---
 drivers/media/platform/qcom/venus/venc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 453edf966d4f..73b3181eed9a 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -479,10 +479,26 @@ venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
 
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP:
-		if (s->r.width != inst->out_width ||
-		    s->r.height != inst->out_height ||
-		    s->r.top != 0 || s->r.left != 0)
-			return -EINVAL;
+		if (s->r.left != 0) {
+			s->r.width += s->r.left;
+			s->r.left = 0;
+		}
+
+		if (s->r.top != 0) {
+			s->r.height += s->r.top;
+			s->r.top = 0;
+		}
+
+		if (s->r.width > inst->width)
+			s->r.width = inst->width;
+		else
+			inst->width = s->r.width;
+
+		if (s->r.height > inst->height)
+			s->r.height = inst->height;
+		else
+			inst->height = s->r.height;
+
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.0.265.gbab2e86ba0-goog


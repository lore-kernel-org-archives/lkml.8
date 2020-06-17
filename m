Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FCBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B25208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzvQe3XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgFQQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgFQQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so2089885otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hrRgLXuRhMeQ6slbSOKJC3oaC69Z2SF3rsc7qez2XE=;
        b=HzvQe3XY2utflOg0HvS6MWNBANwSa7sL1NOqNtveiZ8KEicEUoKTea/M6qBwQgmgvu
         rgz36hkD3lUzeBI9hDQalRU1CKozULtTN/Dw/m7j+Wc/uK7uea+FL+3WUUkIzDR3mj3t
         lDcwWQhDImnve4Qex48kxHCxQ7L2kbXyM7aecvTcBUUVt44leDClTxIStN+q6SgzkTjv
         xREsRTM9q2pZFeH5yITwDPZOf1z8VCIVaJKujiDwm3WxgSxrU0Bt/GYvnlDtaRZ7PXl1
         4eNosi5+pJA9TXwUAHX9Oye56vwQS4xo/hQMh8HawaltAP7gySGlXLzX3+rtT26CWp1P
         Dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hrRgLXuRhMeQ6slbSOKJC3oaC69Z2SF3rsc7qez2XE=;
        b=jkEs9AnxiE9b9kyybSiMYRrCMSHfpCq8ZSovBjbqm/hv1iCDlgo9rjeb3n7Z5BHbzO
         c0VYPCJbsPihGJKZYECO/HUBsLXmJXzSNFUlZMHMnQcbyASeDDbt7FrbVWBTwn2GaM9A
         YAYXn0FlKKYH8GZUMds8SI1MRH+nR+JGe4Qpe44Mxzx8QR+TXvDd3TIeev0an1t9ZieS
         kZ+u0sgUqLYPvXlMmAtZyIcKIUqaheYpCzc1/30IJFOfNRMTE8byB/CgI+q0tkH+iJHO
         QLnzeTQMz3KLkXEYrO1/MtOq3eJDmc1QhBGf0h6ChSEtxG9D+LCzbnENlrG50sgsK7lQ
         Cj+Q==
X-Gm-Message-State: AOAM533UfGcw/JuyCmh2SRTz8hHMuj+KDqmdkaHfpd4bdxb10Wqta3rH
        ZpfvOKD/Gvy+q5GBb1M6txM=
X-Google-Smtp-Source: ABdhPJwRoYQ3cqC/VxFyhvWCwHvWxIvB8ZVqxOLtoPHUduYWXh+yujaxk+V5S7JmjdbT37oUewAseA==
X-Received: by 2002:a9d:32f7:: with SMTP id u110mr7486878otb.217.1592411189081;
        Wed, 17 Jun 2020 09:26:29 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 17/21] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Wed, 17 Jun 2020 10:25:32 -0600
Message-Id: <20200617162536.611386-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move flag-char reading and validating code to a separate function.

This will allow later reuse to read 2 sets of flags:

  1- flags to set or clear (after the [=-+] Operator)
  2- flags to require or prohibit before changing a callsite's flagstate

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 22335f7dbac1..8400e4f90b67 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -430,6 +430,26 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
+static int ddebug_read_flags(const char *str, struct flag_settings *modifiers)
+{
+	int i;
+
+	for (; *str ; ++str) {
+		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
+			if (*str == opt_array[i].opt_char) {
+				modifiers->flags |= opt_array[i].flag;
+				break;
+			}
+		}
+		if (i < 0) {
+			pr_err("unknown flag '%c'\n", *str);
+			return -EINVAL;
+		}
+	}
+	vpr_info("flags=0x%x\n", modifiers->flags);
+	return 0;
+}
+
 /*
  * Parse `str' as a flags specification, format [-+=][p]+.
  * Sets up *maskp and *flagsp to be used when changing the
@@ -438,7 +458,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
-	int op, i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -452,19 +472,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 	}
 	vpr_info("op='%c'\n", op);
 
-	for (; *str ; ++str) {
-		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
-			if (*str == opt_array[i].opt_char) {
-				modifiers->flags |= opt_array[i].flag;
-				break;
-			}
-		}
-		if (i < 0) {
-			pr_err("unknown flag '%c'\n", *str);
-			return -EINVAL;
-		}
-	}
-	vpr_info("flags=0x%x\n", modifiers->flags);
+	if (ddebug_read_flags(str, modifiers))
+		return -EINVAL;
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
-- 
2.26.2


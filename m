Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7CB2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usr0y1JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGBXLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so5576945eja.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbS74vQpmV1GX6dYv3vTq6zgY9FWesbjUccvShGMrLU=;
        b=usr0y1JWEsmR4UBmN+hQOLAJV1Xk8Z/LKn/VsleKQfr/vjqWicxOhWeEHMD8RvXmud
         Rbdu6Tgpm34+9OGPRy9SrHP5BLsxmRCuFCq5PvAVKScq90ZhYprJa98fzCZ2Yqz//WkK
         0DtGn/N4Y80kCeEIqrOgQyePM3fKD9xzvf6ISJf0NaWBX8h95pbi2Ar1IN8oxpKI5rYQ
         gGUGmwRmA95btQC6U/v0Mm2USI8phbbmXWkzQuHpggH4ZIUbp0KuqHdo+8whkXQgEFp7
         BwkDzxpepUSQLyzLw25pzq8Tl7HMf1QVsLNW9wgxpbkmoR9y6H1tJK43U4vzUYbfYYe/
         TWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbS74vQpmV1GX6dYv3vTq6zgY9FWesbjUccvShGMrLU=;
        b=p7ZjBbqXA8syNl1IenyvDBQ89HL5nN5MKz8r1WIq0/Mx+n8V7k0IZS6hkeijFkx987
         MQ4E1DB+K5Z8AZ20XpCfXxVxMZpDKxQiPLjA8Gfor4S2m3F18U68iOqdZpacfRdw6/ip
         cofUkB5MvBd5tjTVTSVz/ejbEn4498N55h56KO2/QtwcfKgy3PDPvuqlp5xi65/J/C2G
         Jy2k9MnbRxsk6kKwBQZ4pNcRfKqZD7X/aV4/L/jpiK04Zd4kiw/Z5I90YsBBJdbGmdjb
         nG7HZNnV7I8GlOqpnDatFqhP+plzYgaFyH/DoLO6aqZ4PROdf6I35nPvrXEsIKIp2VE3
         Sh8w==
X-Gm-Message-State: AOAM530mgOFnJhQScevssxK/CP0eqzFkzXN/ASYuS037L0D6Zz+8HNzX
        JLLRCrVW6aBAN4FgE4osUkudy/ua
X-Google-Smtp-Source: ABdhPJwdzEUcG0E2ev55+dDN+hNTDaHxHU55XjNMUDzAoRQMCilCc22JA7jrU9FZ+63/cqS+qHzWNA==
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr31181931ejc.56.1593731465973;
        Thu, 02 Jul 2020 16:11:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:05 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/15] options: let handle_onoff_switch() use null terminated arrays
Date:   Fri,  3 Jul 2020 01:10:25 +0200
Message-Id: <20200702231039.55015-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes things slightly easier to use.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index e56788260cb7..709dd5176112 100644
--- a/lib.c
+++ b/lib.c
@@ -529,14 +529,14 @@ enum {
 	WARNING_FORCE_OFF
 };
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[], int n)
+static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
 {
 	int flag = WARNING_ON;
 	char *p = arg + 1;
 	unsigned i;
 
 	if (!strcmp(p, "sparse-all")) {
-		for (i = 0; i < n; i++) {
+		for (i = 0; warnings[i].name; i++) {
 			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
 				*warnings[i].flag = WARNING_ON;
 		}
@@ -551,7 +551,7 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 		flag = WARNING_FORCE_OFF;
 	}
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; warnings[i].name; i++) {
 		if (!strcmp(p,warnings[i].name)) {
 			*warnings[i].flag = flag;
 			return next;
@@ -789,11 +789,12 @@ static const struct flag warnings[] = {
 	{ "universal-initializer", &Wuniversal_initializer },
 	{ "unknown-attribute", &Wunknown_attribute },
 	{ "vla", &Wvla },
+	{ }
 };
 
 static char **handle_switch_W(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, warnings, ARRAY_SIZE(warnings));
+	char ** ret = handle_onoff_switch(arg, next, warnings);
 	if (ret)
 		return ret;
 
@@ -808,12 +809,13 @@ static struct flag debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "ir", &dbg_ir},
 	{ "postorder", &dbg_postorder},
+	{ }
 };
 
 
 static char **handle_switch_v(char *arg, char **next)
 {
-	char ** ret = handle_onoff_switch(arg, next, debugs, ARRAY_SIZE(debugs));
+	char ** ret = handle_onoff_switch(arg, next, debugs);
 	if (ret)
 		return ret;
 
@@ -856,11 +858,11 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
+static void handle_onoff_switch_finalize(const struct flag warnings[])
 {
 	unsigned i;
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; warnings[i].name; i++) {
 		if (*warnings[i].flag == WARNING_FORCE_OFF)
 			*warnings[i].flag = WARNING_OFF;
 	}
@@ -868,7 +870,7 @@ static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
 
 static void handle_switch_W_finalize(void)
 {
-	handle_onoff_switch_finalize(warnings, ARRAY_SIZE(warnings));
+	handle_onoff_switch_finalize(warnings);
 
 	/* default Wdeclarationafterstatement based on the C dialect */
 	if (-1 == Wdeclarationafterstatement) {
@@ -886,7 +888,7 @@ static void handle_switch_W_finalize(void)
 
 static void handle_switch_v_finalize(void)
 {
-	handle_onoff_switch_finalize(debugs, ARRAY_SIZE(debugs));
+	handle_onoff_switch_finalize(debugs);
 }
 
 static char **handle_switch_U(char *arg, char **next)
-- 
2.27.0


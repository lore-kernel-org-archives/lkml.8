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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A4DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0178A20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn/arElG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGBXLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBXLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B36FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so15890107edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cF8b+JGj0G/772jPhd4SDBLuCY+ZY7XeryhECDKmgiQ=;
        b=pn/arElGtg5eB90cYPdDoALC1siCVqPz7KObfKp54Hjg7VKCnls+8NhfEhUcZvGanz
         EnH4I5N47gKiQSEo8/5PQdjdvHMwmQT7cHAhAAVgr+XdX2YL/KkUWlTvC+h0h1tQqIxQ
         6a4toepB5CyTd/MRubkykCS7DDjlzBuQJlO14Unu2xD4vllImDNrVz35RLBx5cXkHiu1
         p9rn773ksvy+3yG6+CI88ptHTf2YFW0x/S2yOP/ZwMdsvVO3LcmLfF1SQVoiaa42/WHZ
         zCjaxRIAE6+LhXagIEM2HHwIQPPQDmcP5pIdgVhtFN+DXxAQYCIdbMTQgpQGoKqHDvLF
         80hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cF8b+JGj0G/772jPhd4SDBLuCY+ZY7XeryhECDKmgiQ=;
        b=JBqssf8o7T1nGSSbQcD68mTHWpV3qbD81aKVeY6MyIq2q32HQCfXoCe3QEUOo6vBW3
         WRcY9pnt4aqODRII8A6HL2xYjnW7+L89PShFDJzTiEWKWiuJusTX1YtDTyQMKt/+GZlj
         r65HFYE+akasLIrC+PGtRXz5hVlC8Bh9vdujFx45exkiM+P4xhOqulix3mo7dUTG3n5+
         bN7SXCBJQ/nBG+A3NmAv4XBtrk0L8jDSr7Q7nXSiU3wEwZDex03OGyQb0rdToqu22aA+
         ebPjQbybW8ReiLS1Ei7DLqWr9e2uDEbQcl/dKMuCkqVK+zLQTLpPSoPXPcoHKiMs3QnQ
         qW5w==
X-Gm-Message-State: AOAM530BMiSgFGaJtJU3hodVAvjKwnB9xuRwpGkDh89c9sC6lFhYvEwp
        nmMyNorpTCBfaB7QgeMrrhsZ7e0F
X-Google-Smtp-Source: ABdhPJxSzehsKeD58/A6Om/ciYJAjaaUlpmPYcR+wcLSebDyLRwiioRHpUw5/Jyeo4swZ2pBUxXLog==
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr21213224edq.11.1593731466943;
        Thu, 02 Jul 2020 16:11:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:06 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/15] options: move -Wsparse-all's processing out of handle_onoff_switch()
Date:   Fri,  3 Jul 2020 01:10:26 +0200
Message-Id: <20200702231039.55015-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since handle_onoff_switch() can be used for other flags than the
warnings, the processing of -Wsparse-all should move elsewhere.

So move it into handle_switch_W().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib.c b/lib.c
index 709dd5176112..5128a5b64e9e 100644
--- a/lib.c
+++ b/lib.c
@@ -535,14 +535,6 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 	char *p = arg + 1;
 	unsigned i;
 
-	if (!strcmp(p, "sparse-all")) {
-		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
-				*warnings[i].flag = WARNING_ON;
-		}
-		return NULL;
-	}
-
 	// Prefixes "no" and "no-" mean to turn warning off.
 	if (p[0] == 'n' && p[1] == 'o') {
 		p += 2;
@@ -798,6 +790,14 @@ static char **handle_switch_W(char *arg, char **next)
 	if (ret)
 		return ret;
 
+	if (!strcmp(arg, "Wsparse-all")) {
+		int i;
+		for (i = 0; warnings[i].name; i++) {
+			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
+				*warnings[i].flag = WARNING_ON;
+		}
+	}
+
 	// Unknown.
 	return next;
 }
-- 
2.27.0


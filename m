Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8FE2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBAd0KoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgFMP7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgFMP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1824C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so9771425otq.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOXsX4jDdudWu82VRhvQA4en6zucAqSKOS8OzOhIogo=;
        b=uBAd0KoUC0r9JY2TVtl5EMxLNWkMKKKVdLyFXnisUrChu/8/IeytFtMLKLWDkd+29x
         9KDP0HGntS4HvDgKn6vJPi+MHzdoVJp199A/25ctnOV0uuXU9bxywkp+3hPX2gJPE+hz
         OI1+gRAUXaHJtoLfnPUPM2nYOWzaja8qA/GIrMgeHAGttlMP/4ejtK1DSPf6e8hpq5G5
         +ekWniaVEp/m1jDeVluWxBPI+1j/6pj6cI48p2bl5KsBA7BcpBKu1PE+60N4XyLL5oJB
         fes6PmRj5M6zx8aHQ4YqbXZc24IrpiNgiviJNOHkzYStBkFHpNYvLzyKq14thu2UelPl
         /60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOXsX4jDdudWu82VRhvQA4en6zucAqSKOS8OzOhIogo=;
        b=HmZlFW2f47A5fDiBjsIrF4kmYAqiY3zAAkPJxObYEAsVbyqPGuhwfWDF1FsjGKmL6x
         QTzNYKFndB1gZQsOILHlwRwYeTBrl1LNCAJFMm3PeCkWlnlroD1HTH5AJiq3bvGDpFOI
         JE3/iplBNyvL/j4GO3DAuD+3NBAQAiOP1KoMuw4vOOYiYh07dTiGxCFR/FOjBU7+2dxX
         wUIfpnl+ATPcW1YkmH/vHEL/nNSwPSLbtPL/CdvUxK5ZjYUJd9zJuHzpQbIVwp0m9vr0
         NEvwtNtwfibrl5B0RyB/lORcjHXIuJSrYBCEpFuc5CBDkU5VPLGjgpxbmbV6V2GVndUN
         jsAw==
X-Gm-Message-State: AOAM531g2NImZrAkyJthMGkuSOCO2PlwN76AEjH8MXMYlnIVYxj7BHAJ
        IuFRcynPWfDwZ6Mxt8y28EM=
X-Google-Smtp-Source: ABdhPJwiLPiogtwpFa+BatxBeFtXuHdbR5YJJ9eJGwu00DeQaHyQoPeon1WM+EP8MK2FlgHFykeHhw==
X-Received: by 2002:a05:6830:1d1:: with SMTP id r17mr15048093ota.19.1592063898053;
        Sat, 13 Jun 2020 08:58:18 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:17 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 14/24] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Sat, 13 Jun 2020 09:57:28 -0600
Message-Id: <20200613155738.2249399-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new local *filter variable to ddebug_exec_query(), pass it into
ddebug_parse_flags(), which fills it, communicating optional filter
flags back to its caller.  Then caller passes same to ddebug_change()
to effect the changes.

Also, ddebug_change doesn't alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.
---
 lib/dynamic_debug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8dc073a6e8a4..0f393a930fdc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -147,7 +147,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flagsettings *mods)
+			 const struct flagsettings *mods,
+			 const struct flagsettings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -445,7 +446,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
+
+static int ddebug_parse_flags(const char *str,
+			      struct flagsettings *mods,
+			      struct flagsettings *filter)
 {
 	int op;
 
@@ -477,7 +481,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 mods->flags, mods->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -485,6 +491,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
+	struct flagsettings filter = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -496,7 +503,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &mods)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -505,7 +512,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &mods);
+	nfound = ddebug_change(&query, &mods, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2


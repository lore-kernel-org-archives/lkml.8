Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F026AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBC52409B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcoPJH4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgFTSIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45930 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgFTSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so9823227otr.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=DcoPJH4Q08rquvLdZ+yODelNLKnWS/2EtgzYV0Pt14ZPPzKY4O6v0nWlCRqwy1BRKO
         csiWhQLxwrhxGE2BempDBRYoVYzwyok1rCX2X1CG6gD+3gXOeK0xwx7gFokoJFjpqIMm
         zZI1BYtleBU7lTWSu1xwtJ2mHvAAw0FCvJdtntm79rtFJqUVoGuF8XUvtPoaszZRv3Uq
         mZ5fq8yweLytDq6rJhYRy25tQ2xQTdx5HNi9G2gjlNWwYXayxaSdAC5qmNIhhLQe+NcA
         lUvxWff18dRl1l6aAifA42qwR23aI2ka6jiI7jmzB7egBrkoLyJ0vULVKbguBdNqlQCA
         vo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=PBXf1+u+v58b7W3bAzlnoe80QGftngC+3pzZ2hUzkEk1JxBcdXwksEp62MoFON0ld+
         FI2xGla+0SCHPsiR0dcMpZ95XENfEVNrGCipgHkCyG5NCMuF9wGywrxo7cr9K9Uv802/
         FUkr0ecln6xEWKimrKAJBUY2uxVbvkSUs6xVJy/laGlT4Cy6TreP2lDPRnJyRcm8ErX8
         4Gl7XVpnuOzjAXTAqVJ+edLCtr2dn3nkIO5kvNa1WGyqR7T8xEakeQVhgOpb5EPxvM9H
         XAL2nUCNlZRXkIg6r6I8uwE0CdYmk7sVjHFgASr8yuyOj8MWPGQYqqP5uctWY5Yy5gPU
         A7cw==
X-Gm-Message-State: AOAM532JGPmeHphWSkOZ3acnDHf9B1BEn7BtnVvqXiwqYKVqgIa8bPm7
        68YEWIMivftogiMhjyDQWhg=
X-Google-Smtp-Source: ABdhPJyqwFo2U1CYekSQM/p3kmh+Y/2dLorSFz2Ai5kY5OqcQoW/nd0us5fT+oSteVhvvUt3FloazQ==
X-Received: by 2002:a9d:5a11:: with SMTP id v17mr7883179oth.60.1592676431588;
        Sat, 20 Jun 2020 11:07:11 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 09/17] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Sat, 20 Jun 2020 12:06:35 -0600
Message-Id: <20200620180643.887546-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_exec_query declares an auto var, and passes it to
ddebug_parse_query, which memsets it before using it.  Drop that
memset, instead initialize the variable in the caller; let the
compiler decide how to do it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d25a846553b..da3ed54a6521 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -330,7 +330,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -448,7 +447,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	unsigned int flags = 0, mask = 0;
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.26.2


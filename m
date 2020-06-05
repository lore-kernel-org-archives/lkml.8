Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FFFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C950207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2zMPlv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgFEQ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgFEQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:28:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9BC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:28:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j189so8682353oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RE3ZTC1uKnp0KJXJWlYbd5oQY2S0Xfa/C4GEXt6hnI=;
        b=Q2zMPlv8fnoS4MyyIENAh9gYDyQI3ieSnmoc6Is3chUok3DrIgKb4aHhAeu+AyzN+y
         K/pDhxMxXSbB7OojbU2qV1J/iHR+ELUyuwlZDdlGmKX2z8vHu5zAGAb2psK7p56NGTEW
         Zx7ods7yczkDj1QM7rT+vwuMuUOuJTMySBRmThnu9a0ILaN95hMm3WiYyww3WPYNnAyK
         hfm8hxXs21kATUxkm6FCn3MygTZ8rlKSASD7WCVhcIwfwzvSCbQEymJ1ef+CsQoyTnEW
         xhJ0pVwHcZmMo2zIwejJhDRYR6llI6v3DfvNuGg2Js7BfZt62SHM1uin50EzcIQVzIP0
         Tw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RE3ZTC1uKnp0KJXJWlYbd5oQY2S0Xfa/C4GEXt6hnI=;
        b=RgYMfr9BuEYjEpvv+znh+01WGsaXGAreSUgTS9Wa/vXHypDPiY2heGuYTmlGQ2yXQ5
         75s7yEI+3Tvn2BAXuNUXe6mw0kMhpbX/UxDk9EGu9WbwyEzQLDuMMRzPMs9EGM7OThy+
         l3xW+Mxo3pGtTp8pPMoPtGJI7YR+Ua2/Ho6NnvcmkKsCZQp2v3in5/n7G3YIg20IYjmN
         ObM0W7c7eaVR8JobT8svUkN/lIR+PDCTHPXUg9csPF3R4eEtiE3BGl1GEmyE8vK4irOu
         PZgb86mUKBS5yN6/l9+nnbmDpKnPDHZAFU/mvT6VXdujhkyQXnjiucj9HDBdkAm91N0q
         iihA==
X-Gm-Message-State: AOAM531osqQCOWhGtXedTuUme73QsQFB009VQtDwPcaG4Jn3X9x92J4j
        6TCQvov1SA9h1M38lYgodlM=
X-Google-Smtp-Source: ABdhPJwN3us3PJBGrAiqwIcqPu+iC+WPnhJWZY3/ark5BRceL1iCGDT8v85jOEf4nXzjnyRy95zl8w==
X-Received: by 2002:aca:3d09:: with SMTP id k9mr2293908oia.160.1591374485755;
        Fri, 05 Jun 2020 09:28:05 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:28:05 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 14/16] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Fri,  5 Jun 2020 10:26:43 -0600
Message-Id: <20200605162645.289174-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop memset in ddebug_parse_query, instead initialize the stack
variable in the caller; let the compiler decide how to do it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 90061833ef3f..f0c0c31e91ea 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -372,7 +372,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -493,7 +492,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
 	struct flagsettings filter = {};
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.26.2


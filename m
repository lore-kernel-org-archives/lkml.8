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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB03F21789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njDEDuql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFQQ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFQQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10586C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so2079605ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=njDEDuqlUMYOPKbkoRh1o092okeNjqUn4nfvdK5jLwINgl2WD+fFzh/bYYQxcrcGaq
         0mQcT8MatlhIv2138jdN8gyIAxOJkjZV9hEjGMxzQ38FJQLQHvBSqxCULX39/XbjaN6h
         k41dWCsPSx88KW7cGFN3g3b2DZvOx2vaBJZ6ldSR5ZqXOxv2332vWaq36oWpDcaeOSdW
         g60jjj/L9M7UOWRmIDncpzAvs4hwsxfGDa46G1alCrQYIr94vUUdVo8UVk2tMtvupYDG
         +oW28kaGDAW4N0FPEDe1TO3q571OnxEBCw0IO0x71WmTGirp8acIzlhgzIQv/Ce4BR+r
         ei1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=RTUpKBDJiUq99mVTKwyJG0hmqxF9XxFKCKPe0O2c3sawreMKwbAf4PNiZmfUfyeYmE
         ZfGpDmw7kT3vseF8IKh5wXogW5wkgRz/golEEThD4kpsPorboVI6ORaJzRM8B2itIrs5
         oFhOXOPx6h2tWXGKRlAYcjp8cUBLY63w4TJvaeZTx+KKlr9ypZjZeF4eQ5KC+ytLHo/7
         /+bQQmbqlfp2ajyHAGtl+bq7eS6KgyryrbQgdwVKv3BklgPJ0WP25g0ua+cmwGHFMjyY
         3ROZn+llvuRS9VLNZ/jrOLNcDBZmPWMGfU3EWx0uNaOeHGSvNb8Acn9rjXePjaCLb58Y
         FiyQ==
X-Gm-Message-State: AOAM530oup9y7Hug7oQb5Rm2QPkL7EDC9L+G+n2fhRQQkKs9iiC5oirU
        2vzjQvRZJG8zVDLRFuntIfI=
X-Google-Smtp-Source: ABdhPJxlb/hO4p6b1Crt56Xs+Zhr80MammfE+z5jg1t96X4LN+aJk3VEt2Rd0MIWdAFabWx3RjIhUA==
X-Received: by 2002:a05:6830:242e:: with SMTP id k14mr7447805ots.36.1592411171393;
        Wed, 17 Jun 2020 09:26:11 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 09/21] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Wed, 17 Jun 2020 10:25:22 -0600
Message-Id: <20200617162536.611386-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
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


Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE275C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896402177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ModsBH2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGSXLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGSXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:37 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39FC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:37 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t4so12995649oij.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=ModsBH2fmSAIozyWyRpog6ScetmIJCaHqmR1jW3ObJoEZv4h67LVRYFOsByXw5BUK0
         iEZQhKyf+tPggGrirG+NOTJsnOdTNqQNeDncrit98VmvZchkgWHKize3EIJxM8uWqNZM
         ihpXmCTPl/L0VWms5O4YSiHjhbzcBaNwAapkgEWL3TYSF58vQNQu01uN7rkpDniz42md
         5cz1ZLRJPNZpcXBURAvt9LWEwhFCoMcgMu1pQ0nwhwHCev55Cf0wVT4Oi3JSBH5qiYMi
         8XCVTv2mm24Yk/ybs9uDOO/d9y7KH+u1BHR1f+acGx67UhX/sjZVKuDsHXjhZFA34dsD
         +DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dxLGInHWnF0fsK6AxTnYzixhFSHss/CD5LDV/6gHL4=;
        b=IdqaPMDOcwpqYxPiogncbBTJduZjN5ZBDv3FKDk7g9+uqDOKePAUrjkccPInNDtMRU
         EoVGk6B7y+ICqlJLYHWy2XzUiJe6wQdxPxlH6Isd6DyOoOYylkxiIARSfrmmq3M0wAeJ
         mVyjb+KESuOce77SZfSPj3c2JJIrHa9oHX5qUNRqBqew3+FA7zSFqOjLPicbinBZZzID
         67eQTGABGuf4H6efJB8KR7yT1iVm6/JiW74wRm8mkoF6vD70/mqTIj7kURbE2cA97VSX
         m7pu8VsBsgfMZYpPnCNKl+R0Oja53FWUWptij/UOjkTm1IYSFPr4JWRDYhTm37VzY2bC
         1STQ==
X-Gm-Message-State: AOAM533+zI7In2CRSYqvtu/OMeDZ2CrVbRiUwqXVO/jl/G2h/N8K4cbg
        tcYQvh6Va4XprAhpksG7J6hAyjT4Ylg=
X-Google-Smtp-Source: ABdhPJx3Dx6/OZRiByI1yuCbb2Oji60eBo3MYKSE5e9vGicjfafrEL3EAVxjY0ZpPnNbRfJXlEOa0g==
X-Received: by 2002:aca:544d:: with SMTP id i74mr16523297oib.105.1595200296706;
        Sun, 19 Jul 2020 16:11:36 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 09/18] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Sun, 19 Jul 2020 17:10:49 -0600
Message-Id: <20200719231058.1586423-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
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


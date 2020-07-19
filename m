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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F861C433ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DCF2177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH5LHoBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGSXLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgGSXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:48 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB704C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so10816891otq.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kK1E0vrnaopAH59gFVu/eR8mRLRCxGqAtmR4UyqSQU=;
        b=rH5LHoBGuI+oJg93txp6j617wjh6vHHYT4w4O0ENJbKSjdJXwWGAwMrZfgBgGJcVlm
         40D/2FEou/egiLG1XgSI6ZeX0HkNbHR2jjlV7+YppDBlrfdnv8muTL+TX3jZAamUgvOt
         Mha8ceockeGtHWFDZENDunMXPz4lrV/jSKxTAlelAf2m+kyz8XqKMa6SJbKHeHu68ynA
         3uF36AG31LGF7++z6YQEAJPtDBB3k5r4DrnHNeDRoEJgUVVVpbXhpx90hibD0C+Sgoon
         jlbFlFHtkftGZsWwbbJhImDJEB6/A9XEBL0GJmmwIoYMcCsxlbunsKqgXKupXELXIWce
         Lbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kK1E0vrnaopAH59gFVu/eR8mRLRCxGqAtmR4UyqSQU=;
        b=G5SNWnHuOcJ32u+tEuvpPAirFmkYJCMszwhSFwsNp6DCXhD3SS72ET9AOGz7+Op3rS
         W06DJSAt9/Om88uLMpltjMs8cK92M4i406AEdHIfq3N2pcw9hHlfOjbTuH50G28nm049
         i4hcWp+4myO2po6B1XLsRpe9RVJtb5TZWciP81y+m7RTdaJ8dRWNc3fJC9FuFF91yeNy
         7+INQlmdQ94kmayE2oJxsnQWau+tkmQrG4Eq8dkwuGq+g1FZKIbA0/Grltuu3dt4k/GO
         0qe4jmA9JaFepwOl6t3bmKWqje07j1xWyeRd5nCJKR+JTHH8Tfu8aXzd70sVwFdyDU0u
         Mt3g==
X-Gm-Message-State: AOAM531jq9ThnTQum78dm5BlEmUjSQEBHM2SDW/Dm2WV/1LblyNAZLlk
        Y1jej+kADUaiLsU9oY4Ti5E=
X-Google-Smtp-Source: ABdhPJx48aPexkw+FtsxgCHUWtEFbvwxGmdpE03ij9c4r7i2cgkD6lNLdDw81Z+kbcaw1VqOt/EmXQ==
X-Received: by 2002:a9d:3f66:: with SMTP id m93mr18465055otc.49.1595200307285;
        Sun, 19 Jul 2020 16:11:47 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 16/18] dyndbg: allow anchored match on format query term
Date:   Sun, 19 Jul 2020 17:10:56 -0600
Message-Id: <20200719231058.1586423-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should work:

  echo module=amd* format=^[IF_TRACE]: +p  >/proc/dynamic_debug/control

consider drivers/gpu/drm/amd/display/include/logger_types.h:
It has 11 defines like:

  #define DC_LOG_IF_TRACE(...) pr_debug("[IF_TRACE]:"__VA_ARGS__)

These defines are used 804 times at recent count; they are a good use
case to evaluate existing format-message based classifications of
*pr_debug*.  Those macros prefix the supplied format with a fixed
string, I'd expect most existing message classification schemes to do
something similar.

Hence we want to be able to anchor our match to the beginning of the
format string, allowing easy construction of clear and precise
queries, leveraging the existing classification scheme to enable and
disable those callsites.

Note that unlike other search terms, formats are implicitly floating
substring matches, without the need for explicit wildcards.

This makes no attempt at wider regex features, just the one we need.

TLDR: Using the anchor also means the []s are less helpful for
disamiguating the prefix from a random in-message occurrence, allowing
shorter prefixes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c983049e986d..c72bb4d2eb7e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -181,9 +181,16 @@ static int ddebug_change(const struct ddebug_query *query,
 				continue;
 
 			/* match against the format */
-			if (query->format &&
-			    !strstr(dp->format, query->format))
-				continue;
+			if (query->format) {
+				if (*query->format == '^') {
+					char *p;
+					/* anchored search. match must be at beginning */
+					p = strstr(dp->format, query->format+1);
+					if (p != dp->format)
+						continue;
+				} else if (!strstr(dp->format, query->format))
+					continue;
+			}
 
 			/* match against the line number range */
 			if (query->first_lineno &&
-- 
2.26.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC46F2415A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHoyjb44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgFTSIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41866 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgFTSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id a21so11623265oic.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnXT3PW8nTwygIS14g5I3CFsVSKz8zN/W+2aXewNcIY=;
        b=rHoyjb44kmA0/SQbwSkZqc5Qm1Yp9qMWr6j6kehPUPCyDPr4+gtmt4Q6j5xU62dPQh
         MAmVrwKk92NhwJLkks0yL2LuHUD7KI96+iJi98kXXqqzPajLRCHSsJ/iX+V1tG+7v6g1
         BQkTJsDn+E5iYPMWYnyLbjXk1B8aqTOrLpDztIBLhKclp1u/xneI6y3QIjT38/QjUrjF
         WMblwt3y8qdUANOP6bU/h9ADAowLEDk3nkwzc9K/kWjwHDuGOErSdg5AfHbRUcCnwPmn
         q6+ZHQ1b3NTlnHZ/PrHX+4Ck9S2bevFJJqCZIOhNeNBs+fviUl1E/CBbLsYE8vPYTLFE
         z3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnXT3PW8nTwygIS14g5I3CFsVSKz8zN/W+2aXewNcIY=;
        b=RHeeRpGeDhKY3sN1aQebv4v+f3bPkC4kPHRmyKDm7Yt5RnDqG3hqdXvG9ImvOWpD/s
         OS/GcKcBaXs2PD9COSalzxpbdkaD5dLnBEzmSEa9xXMyjktPwc+cXzMHi6prIXKuttxS
         yQ/aSM/RF+FcYZ02Sf7zUNMnZIpW3RQhlqT8K0VnoiVNIddC9QYFQjuIZXQosgP463iy
         gOxCjw6ypiFA/6UCWmmMWRBGu25bbcqLwPpa5R67tLWHrfwneTtOa5IjJoiCmAVFPrTY
         9Nlk91LHcat0hopFZeNnbOhEIRsaVWNZ4l+rqk5J0o/fQScskbTq1xrRyEiRAjOlILmO
         ibiA==
X-Gm-Message-State: AOAM530PhmG+FEnJEjWHD3PY5WbP5tHnFwBvr3LFxBUhzyZ/vmA3knL9
        KXqCoCMx2MchlKKbDJQkbLs=
X-Google-Smtp-Source: ABdhPJzedrGw43iRTmVspKepCdrW5aSLUjht0TlDD87cN4F3z9XRkUgxyb1iahM/t2HRJz4CDWHuQQ==
X-Received: by 2002:aca:5184:: with SMTP id f126mr4576653oib.134.1592676444603;
        Sat, 20 Jun 2020 11:07:24 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 16/17] dyndbg: allow anchored match on format query term
Date:   Sat, 20 Jun 2020 12:06:42 -0600
Message-Id: <20200620180643.887546-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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

These defines are used 804 times at recent count; they are a perfect
test case to leverage existing format-message based classifications of
*pr_debug*.

Those macros prefix the supplied message with a fixed string, Id
expect nearly all existing classification schemes to do so.  Hence we
want to be able to anchor our match to the beginning of the format
string, so ddebug_exec_queries() can be more exact.  This gives easier
contruction of reliable queries to enable/disable those callsites.

This makes no attempt at wider regex features, just the one we need.

Since this is a corner-case of sorts, lets examine one more, hidden in
the example above; note the "module=amd*" query term.

  // normal usage
  ddebug_exec_queries("format=^[IF_TRACE]: +p", MODULE)
  // wildcard 1
  ddebug_exec_queries("module=amd* format=^[IF_TRACE]: +p", NULL)
  // wildcard 2
  ddebug_exec_queries("format=^[IF_TRACE]: +p", "amd*")

Now, I doubt that "amd*" is useful here, but I dont see a reason
to preclude it; multiple modules with coordinated classifcation
schemes is reasonable.  That said, a single call can have multiple
queries, each with an exact module name.

I also see little reason to prefer either of forms 1 or 2.  Its
case-by-case, judging brevity, clarity, and query specificity and
robustness.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b00f536d6d12..d737c733967a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -176,9 +176,15 @@ static int ddebug_change(const struct ddebug_query *query,
 				continue;
 
 			/* match against the format */
-			if (query->format &&
-			    !strstr(dp->format, query->format))
-				continue;
+			if (query->format) {
+				if (*query->format == '^') {
+					/* anchored search. match must be at beginning */
+					char *p = strstr(dp->format, query->format+1);
+					if (p != dp->format)
+						continue;
+				} else if (!strstr(dp->format, query->format))
+					continue;
+			}
 
 			/* match against the line number range */
 			if (query->first_lineno &&
-- 
2.26.2


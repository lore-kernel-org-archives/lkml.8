Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C4C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A77B206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF/m9QcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDUAne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDUAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:43:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:43:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y21so10219832plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g7Mk/wSLC1J3xQn255xHIAcdYrmeMbJ4awyrSCcplYU=;
        b=wF/m9QcYx5PI7omBhCV4SYUQslpl+w8Hw+cV/xsckaiiIWuy+fxIpblsF/RuwFv+3B
         toWLr/derY1YCMfxs+ulY1w0LhkPpOOhsDTaV+KXc0TX2v6bO6PPDwh+hT0x1Vwd8kEf
         L7WY/WoONJBGycfw0girBGloyZThIlhwWkwblD9oPCEoD8UpgkX4Afigzo8r+8oKY/SC
         ITLlt9CVXz7dmobUupdPBG+0ysP+khxQ+7GqG1dQVLL54tHfk3djGMHh2cL37NRBkPDR
         72BXVE8XhSSNig4u9gTFy5vMxf7bmFbJj8AfhSq6z90igOXbenS3r0iBUK6mPrUQanl+
         QriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g7Mk/wSLC1J3xQn255xHIAcdYrmeMbJ4awyrSCcplYU=;
        b=h1E2bOJJIizRhLbyIrLS1KB5Xbt5N46t/QIHDcWnj1t/sIq4l5IDMytKVEULuGjGHk
         tNNyeE7NAUvVI65HjehnnwOlQfeXA8VT7zFcPqOAncMtoLROsvtEe+kSBv7ifu1AYO1Z
         e8pBZAHAouiHrEXMkTzbYeELm3oCgpoSFiaYwTarC867gWaEFRw0vCZpC3kh8HmhwGFB
         kKBDKRGgVnX/a9RbkAjWJT5Z1zePB+ePGldcrz9t/7/srkT/Sqhq8ZJQ3pu3QAvO0OPf
         LtX6KUQk7WNNEbqWANM3FHFP16ke8HM4vye5UhMeH89BmIn5MFdrWxdseEXRnbjPWJVR
         YdQw==
X-Gm-Message-State: AGi0PuY6Y1LiIuOi4r5ot/N039j66ouYKBFPV6TryeSD/QrxolqageY3
        roysyj0/N/5/Jo6JhTT+5wI69tC6RL+E
X-Google-Smtp-Source: APiQypLhULsJZRIuttUUR+U23Z9tJRZCIwTGp15jbtp9H43pfMqumb7vvBOFCZSrLauffh+3rGSCtIFWkQWv
X-Received: by 2002:a17:90a:2170:: with SMTP id a103mr2489493pje.181.1587429813723;
 Mon, 20 Apr 2020 17:43:33 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:43:29 -0700
Message-Id: <20200421004329.43109-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] perf script: avoid null dereference on symbol
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

al->sym may be null given current if conditions and may cause a segv.

Fixes: cd2bedb7863e9 (perf script: Allow --symbol to accept hexadecimal addresses)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index dc0e11214ae1..f581550a3015 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al->sym->name);
 		}
-		if (!(ret && al->sym)) {
+		if (!ret && al->sym) {
 			snprintf(al_addr_str, sz, "0x%"PRIx64,
 				al->map->unmap_ip(al->map, al->sym->start));
 			ret = strlist__has_entry(symbol_conf.sym_list,
-- 
2.26.1.301.g55bc3eb7cb9-goog


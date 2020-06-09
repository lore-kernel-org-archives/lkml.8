Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBB420774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc6+Ns3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFIFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgFIFgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:36:19 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE7C03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:36:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c22so16204663qtp.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gjR3FjC3a4XxlniyWA5ukXKzsQXPMyC8X+int1qtENM=;
        b=Mc6+Ns3zwM3+SJoBU3dH12LuJ9By2MQjCdWaDKJNBN9xvZD8ISKjzBehFYHgCY3Ehp
         2mUeG1tcGr++VIrz8n9HPxyRQlpvLankbUs/HCBu078JUPJJOYWw3HEoUXKHgEShxJ/W
         q/PYbnchrpOS94730yU+RMd8a3e5dcNCB8hU+UyT6wXqEN2u/MB47q8db77TVUqRvhd2
         A4CsDhhaxQsptQHkVVZ9wxUU3hqwhEFvvITBr6eFdiSA91nxPISr46lBmuY/agF86k4p
         96MJYcr4XHCnYsWpA6Tz4WgeK3ezWazi5ffmIJZhzkx6oEb6ugiZMYaL/5uFmhbOOlXC
         7EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gjR3FjC3a4XxlniyWA5ukXKzsQXPMyC8X+int1qtENM=;
        b=gtWKo+RnFSQ8iINUyDBjqU7qjU4AuMSvfE6s3Md/6pg1kDG1JWqRZURwOuwjwke2Hx
         OhRz78UrBBFbJK5EIGUnuVeTHJF0QHJuwsmS4ljh0SvfxBnDqhvRcGEpy8d8uhzhWwcT
         ZRPg8zs2trLBJjCJi3axOXjc0ReCajswe/VFmn6tzfVfINhaSft8qlfZWlZGNaDmvKDD
         U8JTox+pKK1zVb79s194AOXlyfCdffYExlWS16uaH95n08PgHfLP88Lgh3ct3q1ueZIq
         SvUe1TpP/nkVDxG1t+OcWwxKaWijn2RuaGCaQ6TcqVsnlVvghYpa7UzGFarxFDnGRJ2X
         ee5g==
X-Gm-Message-State: AOAM533cPudidBE1XO6nbHyXh7OTJ+2Al+hB9EoDRKhhfcSc4732A7dZ
        hijcC5s0oqUyhKsezhAo5BOIFuADxyw1
X-Google-Smtp-Source: ABdhPJzb8AEFZmmOiaOqwJe+bO2OSQeU8CZLXWGJgJotqBNenV/dPwYLbS/Hes8o2Xa0+DnhWMridpGATVt5
X-Received: by 2002:a05:6214:6b2:: with SMTP id s18mr2004410qvz.135.1591680978554;
 Mon, 08 Jun 2020 22:36:18 -0700 (PDT)
Date:   Mon,  8 Jun 2020 22:36:10 -0700
In-Reply-To: <20200609053610.206588-1-irogers@google.com>
Message-Id: <20200609053610.206588-2-irogers@google.com>
Mime-Version: 1.0
References: <20200609053610.206588-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 2/2] perf parse-events: fix an old style declaration
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: a26e47162d76 (perf tools: Move ALLOC_LIST into a function)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d4e076c9c2ab..acef87d9af58 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -26,7 +26,7 @@ do { \
 		YYABORT; \
 } while (0)
 
-static struct list_head* alloc_list()
+static struct list_head* alloc_list(void)
 {
 	struct list_head *list;
 
-- 
2.27.0.278.ge193c7cf3a9-goog


Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4FC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129AC20735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVRLolBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgEJPG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:06:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:06:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u10so2812346pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uC5ywdwhC6QhJdb040LifTd+jWrOXKwSoJG87krF0M=;
        b=WVRLolBea36VTFfp7GQ/0SjwqfNb0SXj2jlD4in55TDGbD0zqkMDVpsAL5mWHnB3V7
         ttnKV+1gLd8VyxwOu+B1OQYK1zpIyJGvIJd7Ykjy6jM7GKVvnGmFEGgDtpA4hT+kxyE5
         Gj3QTZ0d6rD5c74JrSmRxPP+hFZjQmyQAqQ0XzZIGWlAxzgbO0i3lIyvfFHAphGvoiRS
         QK3J5nxQWDrTKwF5QlTmw9mOsnjdin45NG1x00MGaTqyWfJPJQburTdqptU1dhPLxh4v
         LWHdg/hfo15aKk85DEKT0Y1E1OVMKAuoAlGexyaAtEpjbs+5b/Oc6v2juGBWqMef9Akw
         qsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uC5ywdwhC6QhJdb040LifTd+jWrOXKwSoJG87krF0M=;
        b=E0YMgItAbREK/wA9M4ATpEhFLrtZHDb4GELbex+wjAW/uHbPCT37+XO8ZctsgFb2pr
         e7PvDabI/PzttED2dOgvNRsd0MJW8zjXX379cv09x7Ws/WZd4jQU8mtA0c4G5dbqd2lp
         +Zbrqt35Hi2LQHIlkRr+7qzGlHaQLoLdVrBzd36m8lDd/kkPLO9fmIhaC7mulJyv7Ui+
         XYW1+2U4JuRE9uySARHAn4WawfNPidmnCT9pNW4PwNKxfoxiOxV6A2YyGRih+ki2Yq4F
         LIEmzGMyCxvapbuUfa4w4B9wEr670+gEcWV++sFIV9nG2klHqnRzXCoLKSercdRToVJ7
         E1Gw==
X-Gm-Message-State: AGi0PuYTjBJBzO9tMianusEXxBiMqCL9aJjLFesKwxYkKTtCGhurkUdy
        KM/qgtLqcikDhOVlKG4bMGs=
X-Google-Smtp-Source: APiQypItCDRZDS6gRBMn+dqAXmI4copb0C4hw0Bffocehtjj008ubjQ/CFx0jrB2Qsshkc5V3mserw==
X-Received: by 2002:a17:90a:23e2:: with SMTP id g89mr17243006pje.105.1589123218126;
        Sun, 10 May 2020 08:06:58 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:06:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 01/19] perf ftrace: trace system wide if no target is given
Date:   Sun, 10 May 2020 23:06:10 +0800
Message-Id: <20200510150628.16610-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This align ftrace to other perf sub-commands that if no target specified
then we trace all functions.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d5adc417a4ca..11fc02037899 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -493,7 +493,7 @@ int cmd_ftrace(int argc, const char **argv)
 	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc && target__none(&ftrace.target))
-		usage_with_options(ftrace_usage, ftrace_options);
+		ftrace.target.system_wide = true;
 
 	ret = target__validate(&ftrace.target);
 	if (ret) {
-- 
2.25.1


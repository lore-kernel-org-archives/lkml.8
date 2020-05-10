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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B66C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52FB20735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUuQsm5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgEJPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgEJPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C122C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id y6so6520044pjc.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0glvZ9Uc9djdHjs6Vrqf3MeDwiLKp7EUlpX6bcp3Fs=;
        b=PUuQsm5qKJU9SVQK4BiOIgtnFCk34EQeL7yxv6CETJD28R9vDa+i1y5zDRqmIH9f+/
         nsdhAHCUXyJQSvzsSy/i+cbsHnL+w88swfLx5CADQSH7OVTk5384AvZEhFWQiPD41Oe9
         66GzzOieyu8UfBNl8rE7K3HwlnDDKXnmIOAFSFwsERn1gDjYJltOEXSl9FkfjnBbKZX3
         IwWWDzzi9HoPHqL/NtzzQIt21s/5FY9wPGgt6no0F1L4vv1dSdqHbat/89nnPRku72fI
         O9vwI4cvTozQsMBkSycGDBpg6x7tZyfQLUXP1oTFJR7i2xcbrcP5SNnn69DrMuXgErg4
         +HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0glvZ9Uc9djdHjs6Vrqf3MeDwiLKp7EUlpX6bcp3Fs=;
        b=EmX6alEoD+rRn6BzLmttrvGc2FETgiZ72kvRN2jmOGrCSI30SDvkL9aVB/d49akeLU
         qsnlju5eYCoUEyHRBCfBk6ORyShJyRv487Q3S5s4jhwDEA4FsMdygOsnrqq/hlD8Bjz9
         6sNtNIJzYH7hpc6fwWGtYomZO3gjVzTMB40WTD2p8p/8m34GD13vYo06jnLsPtikTQbX
         h7tS5brHZmeoxOPS8SOYmazjYohk0nRVFhX3RXwNwVlkZYLKqPqWgi8XXTHycRcSQ5QQ
         mQ+/Eto5mttMvysVzoJiKyiR+V5OU3tbsJs+wCr3eQvx/n6ddGOKxlQF70aPIeW8y5L0
         v/6g==
X-Gm-Message-State: AGi0PuaHQB77alVstBOEdcFvLbaYGK/c/TQRGXEv26afHctkRKYfMg2M
        SIMXeTxdwGuVRK69as8s1uE=
X-Google-Smtp-Source: APiQypLm8bzOWDeC9wJvQjS2mXX5Qc8Nh+WrfVQeGR7sNrJO8Ml/WxLKyrKhV6gYKT5KmB9eBuY5jg==
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr11560464pll.147.1589123412987;
        Sun, 10 May 2020 08:10:12 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:10:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 16/19] perf ftrace: add option -t/--tid to filter by thread id
Date:   Sun, 10 May 2020 23:06:25 +0800
Message-Id: <20200510150628.16610-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to trace single thread instead of the whole process.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 0b39b6a88026..8d04e5afe2d3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -707,6 +707,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "List available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
+	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
+		   "trace on existing thread id (exclusive to --pid)"),
 	OPT_INCR('v', "verbose", &verbose,
 		 "be more verbose"),
 	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
-- 
2.25.1


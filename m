Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A714C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F2D215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599631139;
	bh=GXONSfNbejAcRklnkM9C2P2MuG85Q3CDRsps+x++fto=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tc9I0WF5tqVnWecgIiNXinbfVdrkrELyGDPc0COiB5ER12JSj0q79f4n4k9vGZS8k
	 ySXzlt5SyhmYA/v2vMy/0cA0t6oNYi74ehFboQAo/rWwc9HBpe9Wyjh9OKUL3SAmK7
	 fgqFfafqHeV7NeIM6Or1tJpeSciHd2FmxGx4jVIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIIF65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIF64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:58:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB456C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:58:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1177585pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVip2zLy0Mby3PgeipiASyPDQ3AmrKiByHtBrriLr98=;
        b=YJVYItRFoSjVCc+YqlTV2X/GiU7foewyHipNs+VhYSnpgG4fi/MMHDXsrDMi5a+d9e
         EfH+dyTzoZ7oTrGAegfRSlCIrweiyU0xTj0/h271ulX98OQLACkrpjrYx92ZfnShPVRX
         1cxaD9tlfJHuCgIycB2CGUBzqI8wdUrFO4KFsi6gTLCoidYSmfqkYHm+0gWN9S7uDuD4
         ymW1CiNz4ZBWbMwY3kdMa0WRp9xk5hzwUZRib20afZQCLljZif1kn95h7r5po8VPs6Wb
         Bue6I3koRHbvpjGUmChNnweQyP6i233nFcqK30nKJzK/ZBPxzgqf4SyEekl9vKtj/soJ
         mQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dVip2zLy0Mby3PgeipiASyPDQ3AmrKiByHtBrriLr98=;
        b=Dy2aDmzWZO03dHB6MO1Qj/jDqnsZM4/Qh19fQEBVktPO8hEjDXSElJm9ggBE8oyPUZ
         CxI++6CgrN4FoAWjeC6ufASlGM+np3bPM0KNZ/CeCOQEuHcA1L5qf4/ArEtsfP9SZ3DK
         RIGO1gIaYwcLoKknnfG4ML+DELlUbZNa+rOaHdr5m/noh8OAKqkbJoXRCmzLQodk6Zp2
         /rSwb0bXeq2H49uAFq2o2cMMVY2Yp7vIdGgm/74wuzVwtIDZ+3bOkxOQSn2UNu1atgV8
         FctWIhx5FIPLq4Ps2MW7KT4mxGYg3iQGr4ImUDdyG5Qi3dYw0BPOB9ZFGmm9IAQEYDn8
         J/oQ==
X-Gm-Message-State: AOAM533nGWpczLWANYVWICfiyBrdLddvUzv1Kfx9C9pBYKGbXYnE04SP
        0Mc2FviQSZvEoi8lfKv5yXQ=
X-Google-Smtp-Source: ABdhPJzTUTmhLS/rA2mZvveZSnoAbasfAz8lf33hzVAchftr9Ykhy/FjNEOmh25DKsjphnw08aP1Ug==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11mr2292547pls.84.1599631135498;
        Tue, 08 Sep 2020 22:58:55 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q3sm1267158pfb.201.2020.09.08.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:58:54 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/3] perf list: Remove dead code in argument check
Date:   Wed,  9 Sep 2020 14:58:47 +0900
Message-Id: <20200909055849.469612-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sep is already checked being not NULL.  The code seems to be a
leftover from some refactoring.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 0a7fe4cb5555..10ab5e40a34f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -92,13 +92,6 @@ int cmd_list(int argc, const char **argv)
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
-			if (sep == NULL) {
-				print_events(argv[i], raw_dump, !desc_flag,
-							long_desc_flag,
-							details_flag,
-							deprecated);
-				continue;
-			}
 			sep_idx = sep - argv[i];
 			s = strdup(argv[i]);
 			if (s == NULL)
-- 
2.28.0.526.ge36021eeef-goog


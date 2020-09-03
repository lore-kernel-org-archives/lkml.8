Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC2C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8481D2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599146731;
	bh=gF93qnwEhhiJIOd0IjG8TTpjegaV4Kt/MgXFavRUm3I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XCIpZ2q4QmKqXCY/y9TjDLJXuqlGtHclnxJ1lDJiwmEX654EICTboqMyIUROsT4Mf
	 fRQKk4CHFKRJKRZ25f8OYa///6tboV8+iJ1iDVzAcPEkD7KG2y74v5p2fR8hqBqM98
	 5h99rEAizWcR3aQmJosN7oovWrdVloLpfLOUy3F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgICPZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:25:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A7C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:25:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so2611767pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUCYQPXeBx7nXiy5cnEN4/pxJiYlomWh8nAFa/O38Bw=;
        b=I+oO2zwJyOHijuA6Kv70MOruUxWtpt9QKg7XlpsMB9thieaCqrP5BbdezNHxn39ccS
         G8beBxMYCUzXs9MUJOY1Kf2EwX9l8B0lk+rBBjFN+FlTLA/R4iJJ5Oo3RQqzGVcC1uly
         tHTFK0O9ZFXBddh5wyfFMk8VI+HadBi2RiikxUMuDuq8pEY7ik81iMyfAxT5la8X4s+X
         977YuhCvDwKi9ft1dzkLOMc4sZ/cP8LAeU0xwGGZmbrGpExK8hg2OkiizA785Rs8CH4X
         4kQC7sixcZmej3fbMkFvnljcXqYdGo06/BGEnL8lCh7pMV/1zARP+caVtTibzVVDtPSj
         Juog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FUCYQPXeBx7nXiy5cnEN4/pxJiYlomWh8nAFa/O38Bw=;
        b=HdeRNPtG1tzqx49URGSInzQVfLTnINCcnZ7LJ9J92ZPCkXNgSvvw9XWsyoIlSpCTjf
         vmmdL3Px+aggGv1eabRkjOBYaFAcFkbORTv8Bbeci04XpCBYRoEGIKRge1SjOSVwGk74
         AzF8EYJhafzdoSi37O5d5gwxPTFsgAcst+nnAF1RiZMeRYDzAWDEeGkwbvdhlHwYS/d+
         VPenbSA+XWlphVOtqE6MZOYNRXQgla84iuaK4UCf06XBzh5Hq/PoDe84hhsqpkjPDuCU
         J4FHxxLJxDF9biZi/WQmkMcdHGyaVQfd4I+cWpyJu9jvIseKdIUBVXne42LPcbv/eT/Z
         Vgmg==
X-Gm-Message-State: AOAM532loRIgkI5I+bcHpi1ao7VsrY7dYQSPkni9p/R+q0di6bGwqyYm
        sBfWOWJc2OS4LNoZEvlykLk=
X-Google-Smtp-Source: ABdhPJzQ/KlPLuscqJJ+38Deh0Plrj9UzHydfe2HH963njA8STZWIeqqvtaoEDnIWHg/53Z4Oou7Fw==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr3293910pgo.183.1599146718184;
        Thu, 03 Sep 2020 08:25:18 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm3514013pfu.16.2020.09.03.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 08:25:17 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf jevents: Fix suspicious code in fixregex()
Date:   Fri,  4 Sep 2020 00:25:10 +0900
Message-Id: <20200903152510.489233-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new string should have enough space for the original string and
the back slashes IMHO.

Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/pmu-events/jevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..fc9c158bfa13 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -137,7 +137,7 @@ static char *fixregex(char *s)
 		return s;
 
 	/* allocate space for a new string */
-	fixed = (char *) malloc(len + 1);
+	fixed = (char *) malloc(len + esc_count + 1);
 	if (!fixed)
 		return NULL;
 
-- 
2.28.0.402.g5ffc5be6b7-goog


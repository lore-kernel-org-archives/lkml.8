Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7E02068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngd+sBI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEDL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:56:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 04:56:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so5372476pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E/O/xlSGOBaRIcRWlWmBws8CpSsXMJGISjIPWe4h7js=;
        b=ngd+sBI4q9GztVXWyhv9u/d2H1/CxJIw+a63h0woPZPHqRYtaEMRyoTABmtAEpBk7w
         gGpg1reWhWTDlAxQ/uFzDU16JAz7HqudOL/ysc8AA3xH8ZeGfiGk9F1nbnRVEFz94TMP
         o3sjN5FlskSywRbv9BHUMPuGQve3A4t3wYWbLZJapZi+PU5KopwfUKP8PUe7fLQMcxDQ
         MH8uuLxG8rwxyg44NBAL6Y58q5Y8YOoYE4Up7rc/dDtDCpr1FYRng3GNcAXLsrjJKxqn
         D9WMQUwlH/2lM4IITPHx380hoWMq+PHzAxg1uZaXC7nUPnl4VIA16jHBJvEBMvBURw3N
         V/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E/O/xlSGOBaRIcRWlWmBws8CpSsXMJGISjIPWe4h7js=;
        b=S5YU0bEntTNTFpFhzeCkVfNc1OMgWJtV3QoUz16FYGZylwXeDGx4pbdgZ5dNktfU/y
         HQdFGXd02AopkxukQH0FZ7W/aHvqebvA3fC4reYysd8vp9KYJNeZs1FaTwNjuuWCxOa7
         iWKgWTdl1bX0iCvWrtXKGMsSj71a0n4vm/HlrVmmjXo9d0gmdOhfWwWaA2axTb06AkcN
         dRF/0r60NoVct48F35xYJA4Chf8BsQrtVRb5l680C34DIerKVNjphcFjTAWZAlBkhp1+
         x/+PEkeBcm/yocnLvrmqN2rDniPV9TzorWYNPWqksrTdkDQkYVAwbjdGHvRoEOaMHkcI
         IdWg==
X-Gm-Message-State: AGi0PuaPo9GxjUpSlJyWTgUDW0BTu69E2dBXutiej1ynABBKI7hM1GDD
        Je180zHDJGeQFbdoFXS1vAMdFg==
X-Google-Smtp-Source: APiQypIBTkeD1NgnxriwtF7GJh8g6aRYPENbMctnD2pRVoMa4Dnc/oOm1I4oIFUtEG/jJvssWE19jQ==
X-Received: by 2002:a63:df54:: with SMTP id h20mr16304752pgj.169.1588593398370;
        Mon, 04 May 2020 04:56:38 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id o63sm7014010pjb.40.2020.05.04.04.56.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 04:56:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Date:   Mon,  4 May 2020 19:56:22 +0800
Message-Id: <20200504115625.12589-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to support synthetic events with enabling Arm SPE
decoder.  Since before Xiaojun Tan (Hisilicon) and James Clark (Arm)
have contributed much for this task, so this patch set is based on their
privous work and polish for the version 7.

The main work in this version is to polished the core patch "perf
arm-spe: Support synthetic events", e.g. rewrite the code to calculate
ip, packet generation for multiple types (L1 data cache, Last level
cache, TLB, remote access, etc).  It also heavily refactors code for
data structure and program flow, which removed unused fields in
structure and polished the program flow to achieve neat code as
possible.

This patch set has been checked with checkpatch.pl, though it leaves
several warnings, but these warnings are delibarately kept after
reviewing.  Some warnings ask to add maintainer (so far it's not
necessary), and some warnings complaint for patch 02 "perf auxtrace:
Add four itrace options" for the text format, since need to keep the
consistency with the same code format in the source code, this is why
this patch doesn't get rid of checkpatch warnings.


Tan Xiaojun (3):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf auxtrace: Add four itrace options
  perf arm-spe: Support synthetic events

 tools/perf/Documentation/itrace.txt           |   6 +-
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 219 +++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  82 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |  16 +
 tools/perf/util/arm-spe.c                     | 823 +++++++++++++++++-
 tools/perf/util/auxtrace.c                    |  17 +
 tools/perf/util/auxtrace.h                    |  15 +-
 10 files changed, 1135 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (64%)

-- 
2.17.1


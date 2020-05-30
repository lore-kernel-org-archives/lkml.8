Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6500CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C12F2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYq78r4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgE3MYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgE3MYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:24:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07DDC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:24:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a4so1179017pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qPBl8zyeRWMQE8qgQ1Ncwy5FHON+t2q5+yA52769q5M=;
        b=NYq78r4/cZDsKa/m5Ms0v4s70rWr2TgoJxRrvCqdHZsbTEfeAG9M5Tt9pyjuZm7Yku
         mW3TH4hQgoQ4ftTla/eE5uWhH4XMU3HRwWrrIX3HoYpDDeObNCVltrkB2gITbSMnpkYD
         39q0ehiY9eLUEFRXGjBYpY7Vj+CD2qx/ExFqVX5n6dRoSpYRnrOyYuVLx8CCc60UELOL
         Fm7aXLdZSIPhrYDNQFzMM3HP9mKEXPa8KdiiTu8MkINE1HeRIrp6VD1DbyMsaXCvZDqZ
         FF6/11liIlq/uulTv2unDewYQZ5rZUa3TGgGTmc0+LnWuO4kS20F9rqisLpmi/Xc8Uj1
         ifIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qPBl8zyeRWMQE8qgQ1Ncwy5FHON+t2q5+yA52769q5M=;
        b=idD9M1oWruq1ky0saij+34XY0hdsyRD3KdqpKAmYR+ilnLdiXf6Xdoat12al3/trK5
         iwk8ueyDpk1EBmfga8bwRg3YGih/k9GcE8ZOnwnrzQP2OFF8rBZEIZSc8zTfnssnXZq4
         0JuSI8/mncHhcH3+v0ETScgIYt4h8mdGEONFI79bmptVvFm+cZVLDoW6mksXZUM4voQP
         WLD2JCmZZ5b3x3X0fNRiTo4KXJybta6oLWsVsDRhaeb/9t0ysuJMC45dIbGcbjPAG72u
         c7UZLUZApFNqp6DBSOLxV+r9/1W/9tr6zhPDFWRW9SRTxYCu5n+6SHGp8apvZ86Inak+
         GM4w==
X-Gm-Message-State: AOAM532nKLisXWvk75nS0PcljML5qs/Qi6reCs+PXgQax1eex09DHmYZ
        1k8a/c3iy3STPfNP/1zoRtTqLQ==
X-Google-Smtp-Source: ABdhPJwA+cZT20tCgDf0rfl5Ccg26j7UUiBcsUgAeKjv7j1PZ+lQFKzjf2nQOiOdZTl7EN6xByt+Rg==
X-Received: by 2002:aa7:9252:: with SMTP id 18mr13106400pfp.17.1590841488879;
        Sat, 30 May 2020 05:24:48 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id 140sm6787881pfy.95.2020.05.30.05.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 May 2020 05:24:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 0/3] perf arm-spe: Add support for synthetic events
Date:   Sat, 30 May 2020 20:24:39 +0800
Message-Id: <20200530122442.490-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to support synthetic events with enabling Arm SPE
decoder.  This patch set is based Xiaojun Tan (Hisilicon) and
James Clark (Arm)'s previous patches who have contributed much for
the related task.

This patch set has been checked with checkpatch.pl, though it leaves
several warnings, but these warnings are deliberately kept after
reviewing.  Some warnings ask to add maintainer (so far it's not
necessary), and some warnings complaint for patch 02 "perf auxtrace:
Add four itrace options" for the text format, since need to keep the
consistency with the same code format in the source code, this is why
this patch doesn't get rid of checkpatch warnings.

This patch set has been rebased on Perf tmp.perf/core branch with
latest commit 9300acc6fed8 ("perf build: Add a LIBPFM4=1 build test
entry").  The patches has been tested on Arm N1 machine (by James)
and on Hisilicon D06 platform (by Leo).

Changes from v7:
* Added James's tested-by tags;
* Rebased on Perf tmp.perf/core branch.


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


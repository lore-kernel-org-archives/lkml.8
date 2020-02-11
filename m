Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1742C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A472F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgBKOFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:05:00 -0500
Received: from foss.arm.com ([217.140.110.172]:46698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgBKOE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:04:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087E030E;
        Tue, 11 Feb 2020 06:04:57 -0800 (PST)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.36.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC6073F68F;
        Tue, 11 Feb 2020 06:04:55 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>
Subject: [PATCH v4 0/4] perf tools: Add support for some spe events and precise ip
Date:   Tue, 11 Feb 2020 14:04:41 +0000
Message-Id: <20200211140445.21986-1-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210122509.GA2005279@krava>
References: <20200210122509.GA2005279@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

Oops. I've removed all the changes to evlist.c and evsel.h


James

Tan Xiaojun (4):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: Add SPE options to --itrace argument
  perf tools: Support "branch-misses:pp" on arm64

 tools/perf/Documentation/itrace.txt           |   5 +-
 tools/perf/arch/arm/util/auxtrace.c           |  38 +
 tools/perf/builtin-record.c                   |   5 +
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |   2 +
 tools/perf/util/arm-spe.c                     | 756 +++++++++++++++++-
 tools/perf/util/arm-spe.h                     |   3 +
 tools/perf/util/auxtrace.c                    |  13 +
 tools/perf/util/auxtrace.h                    |  14 +-
 13 files changed, 1089 insertions(+), 41 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)

-- 
2.17.1


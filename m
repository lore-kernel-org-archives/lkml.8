Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4987620729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O72V5sfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgHQOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgHQOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0425C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g75so14130208wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gizyHEuaIQ1r+v83Hy0lDwfDoJAQnzb8+1UA5OWfyfM=;
        b=O72V5sfk9nnsU7WMzjBDxDJP0yDKq0sVeI8AO90X7vqJ8YXSCusqf6bPKjTFOD6a6z
         5yngEkFI+Nt1L4JV6MI4QKMK4GYR9QsCJ9BCfqZoBDcFVXOGF4Z36ULGuZq+ydXPS6fD
         eQSdvSFuwKLxgSKfT4rmvfwEi46F+8Qc50VeEGejcc89B7hts5+/Af5orrhJURwqI31a
         gA/ceZ95Z/nYafJ3n+dooDdqFaQ8o2qBcWB8ytqtsHmcC/iucxbmjZQ/V9omuWfSY2F8
         WDXN4eKPcC81R9TRclbehgnLBpGpcD04VdHvRbBvPVhjQcWcyuptpNS3ZnHwfHHAbfJb
         QN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gizyHEuaIQ1r+v83Hy0lDwfDoJAQnzb8+1UA5OWfyfM=;
        b=acraiTrD+IdoEvKp0H5NEjNxLQ58fGlymhynmSY/AWGhw/gVaSMSedSPQ9fzCkozHx
         W37fbsG2LD1kXF8w8hhXl178YN0yTViEiqGn3fOPXLvNFhce43Tq6IjYBF+ny8I6Fyel
         mt0TEOzpM2WoN42ofazLwcKczQYWsWmbN7EkjXIxAzGOUy7LYPbcOaBipbgoNy/pgB7a
         T9jNIcQnzQHwrGavwmtdPp1QFF5pY59VrqLNfc5HFBuG2zbTEKWtUaJW7qIBaGIP0w7h
         R9qcT3+Sot1QoF8runFFIy73MKnsHYhFGYgOBGgaYDiUbxBH4qDt7dcB7y8Wg+7MNZrL
         mWdg==
X-Gm-Message-State: AOAM531abb6bdJBVUmC4Nl2PNRY1ciYZtjR+5iGeqKb5cqQZASh30MvH
        7BfWtj7Kv2xuqRRfyV3oGOUpdA==
X-Google-Smtp-Source: ABdhPJyeJVOtUFHCXoUCYQyMmqUxvEtUEVyO+dmavz3mMHvB2tZ8b8QA6GkYhuU/Xv6jLlaowcX7Cw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr14746983wme.158.1597676053045;
        Mon, 17 Aug 2020 07:54:13 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:12 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 00/13] perf arm-spe: Refactor decoding & dumping flow
Date:   Mon, 17 Aug 2020 15:53:35 +0100
Message-Id: <20200817145348.14461-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prominent issue for the SPE trace decoding and dumping is the packet
header and payload values are hard coded with numbers and it's not
readable and difficult to maintain; and has other minor issues, e.g. the
packet length (header + payload) calculation is not correct for some
packet types, and the dumping flow misses to support specific sub
classes for operation packet, etc.

So this patch set is to refactor the Arm SPE decoding SPE with:
- Patches 01, 02 are minor cleans up;
- Patches 03, 04 are used to fix and polish the packet and payload
  length calculation;
- Patches 05 ~ 12 are used to refactor decoding for different types
  packet one by one (address packet, context packet, counter packet,
  event packet, operation packet);
- Patch 13 is coming from Wei Li to add decoding for ARMv8.3
  extension, in this version it has been improved to use defined
  macros, also is improved for failure handling and commit log.

Prerequisite: This patch set is applied on the top of perf/core branch
with commit 492e4edba6e2 ("perf ftrace: Make option description initials
all capital letters"), and also it relies on Wei Li's bug fixing patch
"perf: arm-spe: Fix check error when synthesizing events" [1].

This patch set has been verified on Hisilicon D06 platform.

[1] https://lkml.org/lkml/2020/7/24/132

Sigh, the patch set failed to send out caused by my networking
connection, resend it.  Sorry for spamming and inconvinence.


Leo Yan (12):
  perf arm-spe: Include bitops.h for BIT() macro
  perf arm-spe: Fix a typo in comment
  perf arm-spe: Refactor payload length calculation
  perf arm-spe: Fix packet length handling
  perf arm-spe: Refactor packet header parsing
  perf arm-spe: Refactor address packet handling
  perf arm-spe: Refactor context packet handling
  perf arm-spe: Refactor counter packet handling
  perf arm-spe: Refactor event type handling
  perf arm-spe: Detect failure for snprintf()
  perf arm-spe: Refactor operation packet handling
  perf arm-spe: Add more sub classes for operation packet

Wei Li (1):
  perf arm-spe: Add support for ARMv8.3-SPE

 .../util/arm-spe-decoder/arm-spe-decoder.c    |  54 ++-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  17 -
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 433 ++++++++++++------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 117 ++++-
 4 files changed, 418 insertions(+), 203 deletions(-)

-- 
2.17.1


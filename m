Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20108C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD422067C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nvtjv9wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBCBw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:52:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCBw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:52:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so2829656pgi.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZiZzXgFFYfVLqsOFrcF9kT69hQ1R19EZVXuDA6GrIHs=;
        b=Nvtjv9wfYlFsYgkgZwOXN/3fh58yXTRzeeGI/vrHA2OtF3MgRKOus3uWZDfSIHD4/j
         saz44zAXa5kXX+9rto2vkpklXNpMSQ5s0kYQ7xmyWfStSPPXn2gUNpG4Rlp+uYJdPdsr
         L4flCZI4VVV8Lx2i8QHaxYPPC/SaQeatGTSlySyH1y7RRlNY642e36rzLoyPpStPZQDO
         cdccR2nY7E9MWuyba7YN4VctTQsZGVf9WuHTcM/g+fP1LpqBZmtojfepX0FyoiVKTCSE
         yizo6R7A8N6VRuNNRpsg2Q0yrVgy5IKY4TYutrUh7ukld2ISABEJobbKZO9VLuks1T3h
         ZCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZiZzXgFFYfVLqsOFrcF9kT69hQ1R19EZVXuDA6GrIHs=;
        b=AQwMUvVArrIttjoSIyAcGAUnKuznx9r9m4OYvYf2KN386INiRynC2vi24iXBnlSqrU
         lqGZH82U30sx1rWLlLKakOBaiddCFVhuBqZL80caLkWBB0F9tnb/z004dpUGHF3QG+uY
         c1DRANVGQQKTEgta+FRDAIScQn/RAhKfMhlADexR+J+Szas8CCrLk5k99Xoy4/hWn4FE
         ZQROEqFNganIzpsTYye9CGw3+2MG1YdXc9BuHkzY1YB38+UlnRDPbvTW5kYyPr4tIPNZ
         7HshrJ4pALnyyhwwKwdZJqwbIv3lMQoSHyie5qA2Y2ngHpXXtlt+Parc1o/8rRmaO7Kj
         UnLw==
X-Gm-Message-State: APjAAAUvCYQdq7wQG5gLRR0LPrnMF9nnHg7T3hQNvNIu6WXtMcJEfgjV
        DHO3eCXpIje5667QokyBaJNv7cMKR2l77w==
X-Google-Smtp-Source: APXvYqxWZZDHjTaMPRW6uSIFzGF3LauAyqo7quszdHdzQvYb9TKezHOAcjyfmqGck6uaIum0XO4x0g==
X-Received: by 2002:aa7:848c:: with SMTP id u12mr21352468pfn.12.1580694747534;
        Sun, 02 Feb 2020 17:52:27 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:52:26 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/5] perf cs-etm: Fix synthesizing instruction samples
Date:   Mon,  3 Feb 2020 09:51:58 +0800
Message-Id: <20200203015203.27882-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's restart this work [1], this patch set is the dependency for
support callchain for Arm CoreSight, which will be sent out in another
patch set.

This patch series is to address issues for synthesizing instruction
samples, especially when the instruction sample period is small enough,
the current logic cannot synthesize multiple instruction samples within
one instruction range packet.

Patch 0001 is to swap packets for instruction samples, so this allow
option '--itrace=iNNN' can work well.

Patch 0002 avoids to reset the last branches for every instruction
sample; if reset the last branches for every time generating sample, the
later samples in the same range packet cannot use the last branches
anymore.

Patch 0003 is the fixing for handling different instruction periods,
especially for small sample period.

Patch 0004 is an optimization for copying last branches; it only copies
last branches once if the instruction samples share the same last
branches.

Patch 0005 is a minor fix for unsigned variable comparison to zero.

This patch set has been rebased on the latest perf/core branch; and
verified on Juno board with below commands:

  # perf script --itrace=i2
  # perf script --itrace=i2il16
  # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
  # perf inject --itrace=i100il16 -i perf.data -o perf.data.new

Changes from v2:
* Added patch 0001 which is to fix swapping packets for instruction
  samples;
* Refined minor commit logs and comments;
* Rebased on the latest perf/core branch.

Changes from v1:
* Rebased patch set on perf/core branch with latest commit 9fec3cd5fa4a
  ("perf map: Check if the map still has some refcounts on exit").

[1] https://patchwork.kernel.org/cover/11222259/


Leo Yan (5):
  perf cs-etm: Swap packets for instruction samples
  perf cs-etm: Continuously record last branch
  perf cs-etm: Correct synthesizing instruction samples
  perf cs-etm: Optimize copying last branches
  perf cs-etm: Fix unsigned variable comparison to zero

 tools/perf/util/cs-etm.c | 142 ++++++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 24 deletions(-)

-- 
2.17.1


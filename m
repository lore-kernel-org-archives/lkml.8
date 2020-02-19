Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACAC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AD7207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Me8zxQw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBSCSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46642 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id y30so291016pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0+108IOesbRWKkXIcgZRG7vo28p7He8IXnYqkLZv3L4=;
        b=Me8zxQw/D7mHDat7NIMdMH0mLvTOK5tGJdycsXDRm9E0Kj297naPKoDg3jISIwUvaB
         8yVnzY0Lyhh2bVOb1q3XOFXqKUrjN1sp2Lw7t+a6Bch4u2UtZb+obgiMciFRRf6Sl2VV
         KC6o3N0WP/pnwJuA/CCGRiYYNcf54kvmPs4WzIaQ0MTBi+LiyjV5Md5ZF7JjzY7FdZbE
         I1hHPU/qLdIw1+zy1qzJVjZ5ucWIUdTeiy0gQr9Uw9PiEPRqehJIaoKiRJ8iOjm5sNu5
         tp62+sda/DVnDTmK3W+/1QG3r5ITe1InXu4HRZNLuuNi+2l54J0wzPdRuDJbtOl5WJrc
         4cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0+108IOesbRWKkXIcgZRG7vo28p7He8IXnYqkLZv3L4=;
        b=Uhj3w7tz5l3yJaU7pcBZB2uQdg441NUYaPh0JrfnqIQWe31DWEBTPAzwcPJ+cGWMSb
         /rE3ptzmroNqQrbytbUl6xn6qowOprQPH3N/lHBHho/D4RIrI199c0MFhT8SvbtX4TjE
         lalWv18fRtchCk2/crMMOImw5X6m7bo1sYRB5yeHQx0audLlPnvgrMB8BDVIZ5d+rUvq
         HWF5pNJUa0pXC2GXmBZFHFAOaD2aAWUc8R2H81cIWkvWS6Kdask7fdtnXwqfcZ9G8HA3
         wy/JBgYxQ0s94TYHlWG4V5Q0myEFXyzh4Qqj7HkgO7Oek8T11iXW64au3iPZWOyUIM1+
         tCAg==
X-Gm-Message-State: APjAAAUS1ecQI3JhQHZi7QVqq1i+M/M0kYGk5wzq34Zll73fMJLhbMmt
        d8OlJiUKX1uKDP+VWZoivs8TvA==
X-Google-Smtp-Source: APXvYqzysKpDAyIJCYxPC5lPf4a+XpuyoPJB9/89YlJ+djoiMXgkoRJZIUPvokn0XxNjLlAQP4QsGA==
X-Received: by 2002:a63:691:: with SMTP id 139mr27078821pgg.325.1582078714985;
        Tue, 18 Feb 2020 18:18:34 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:18:34 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/5] perf cs-etm: Fix synthesizing instruction samples
Date:   Wed, 19 Feb 2020 10:18:06 +0800
Message-Id: <20200219021811.20067-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes from v4:
* Added Mike's review tag for patch 03;
* Added Mathieu's review tags for all patches.

Changes from v3:
* Refactored patch 0001 with new function cs_etm__packet_swap() (Mike);
* Refined instruction sample generation flow with single while loop,
  which completely uses Mike's suggestions (Mike);
* Added Mike's review tags for patch 01/02/04/05.

Changes from v2:
* Added patch 0001 which is to fix swapping packets for instruction
  samples;
* Refined minor commit logs and comments;
* Rebased on the latest perf/core branch.

Changes from v1:
* Rebased patch set on perf/core branch with latest commit 9fec3cd5fa4a
  ("perf map: Check if the map still has some refcounts on exit").


Leo Yan (5):
  perf cs-etm: Swap packets for instruction samples
  perf cs-etm: Continuously record last branch
  perf cs-etm: Correct synthesizing instruction samples
  perf cs-etm: Optimize copying last branches
  perf cs-etm: Fix unsigned variable comparison to zero

 tools/perf/util/cs-etm.c | 157 +++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 46 deletions(-)

-- 
2.17.1


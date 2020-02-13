Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io6WQ6Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgBMJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:42:33 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37942 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:42:33 -0500
Received: by mail-pl1-f174.google.com with SMTP id t6so2128421plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S/ghNKXRSZz4hGEEcpXpDQwI1tYwPeM0vOIIlfcElJU=;
        b=io6WQ6MaLhj+zbFMXA5CKhrY8GPFI6/umJNB3wHne1XogN9Dw5s8d1k004duQzmevq
         E0M9SBYOVadyleg54df3OJETqlZw4OP3CT+0ISD7Aiw1e8/9SI6FB+LXBglp5pQg/xWn
         3EroAValxQo2FhmbVUZWp56EROx8kfhAkyIClCmJqis6XGtCgUrBcsekk/FnrFM8NvWS
         8fTdtLlzLs51IkF6vfTI9NyIsg2DxwFiNASRllI56X2OgKQiJRMHGcW1shSxW1EMjk2J
         0jj1i6Uk1qdnrsUSpsU+MKmySIr+CriWYzes3IA7oAoLyYgkYTidvs/Nb0M40IdzxfpR
         IrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S/ghNKXRSZz4hGEEcpXpDQwI1tYwPeM0vOIIlfcElJU=;
        b=YRuFbml7buTyYW1NCIq+DOTL6WTBQovKuKbLBJGdXNvq5NbxwoDjrA5BoNkr80yE+p
         bZl1X0VJWSxDnohEdk0BtBps0ley5Vf84zB9PlIKnv4pZNky82bclvPYYJ6BxyXK3zzE
         AOBv+tzA8aMJE1OG7csssQqzb8RrrRtkYEbKoB4+ZrLkNqVw8ZExFjw4fU6E5/R3FASY
         pBCk/W+aeeDVEv/1SefSUT9dZ0MZMB3yLKetX2z20IP2Y7ARkr2yv03rpMlU8+3Pnk8N
         PfzbQanP7bBIPuyNRfZxlKO7hp2uddtlHcKEzCWxamfsPNKUcH5Qs6GSbQTaO7Wz5eXX
         NRww==
X-Gm-Message-State: APjAAAUXM/+cMuju4KaiQViQotBmi1RbgxoFTDl0KDMvuAQ18UkHlMeZ
        fQBqX9gCneLMxRzcIpfy4epR7A==
X-Google-Smtp-Source: APXvYqyNzUZdPGouJRFQFTcXwQmxRIUQ8rDBZOAPaV3uOSYYi0QOE0bCORvmwHW1WdHSFC5vLa3Ynw==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr12499791plt.306.1581586951239;
        Thu, 13 Feb 2020 01:42:31 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id 3sm2310277pfi.13.2020.02.13.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:42:30 -0800 (PST)
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
Subject: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Date:   Thu, 13 Feb 2020 17:41:59 +0800
Message-Id: <20200213094204.2568-1-leo.yan@linaro.org>
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


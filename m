Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1863820720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155218;
	bh=l1pLP8kEW01xxuhJns0gp39CmGFpRI/DiYvyZ8cGaeY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2OLm7SGnVit5XiPFFbpSv0vVmupMsPtQgx4BsTAf0Ig9OzcV6lCd2JYMAHRhLRilt
	 ZAMXsELZIM/fBdvv0mpxF+5YoizsvQjzA8IeGhzJwwp7eygycUSGxd+vKAd5cBLgE+
	 yEMcxT+ldXLbsKYbOCGakC9D6PI3y/ovWpWrhdeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgGGUxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42469 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgGGUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:36 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so44691555ioi.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GR2CJXgCSOKYliNYqaIcMWhFJvB++9qQc4TM7LVt2FM=;
        b=E6r3urod3lwWaq2xyPm4aU3T0iqxCESawNwEVYltnidJXGmpvaq94VIzFIfA7aTrwn
         CvTInyQKMPAAmWG8zeBHf0THCfg/kQAPGDj9TOK6Vg0FUQl33KJmrLI7HhS9SYfSCN/X
         AVrLjEhXZ9EdH0h/0jyHuBG4fdSdfe2jSYsICs4GzK1ToH2svHae6/UFJe5iju04kmTu
         65g8ZSw404emmJxeVV1XBfrbobwJY5mUdodTptNLm3u5Dgo5Bbx/z0guGTMIrBDqo7KW
         Pa1UgmwBE7gLLbEnDg98GUJRMGg8Sd0xJ/qcKkRfDC2VSjoGcCHvt9o1PRFzTHF5GYtE
         MHzw==
X-Gm-Message-State: AOAM532rw+P0TgEXDyWU7MUcAb6FlKuozaGiqJYpMJ9DmhB5jvl4FUqX
        /Mf0K3+7uZfRYdgz4mQbYFKAgZwwUQ==
X-Google-Smtp-Source: ABdhPJwUDeg2dTDViH5hfWp06a1VEwoBndInpis1J7J5VmQSzixZlVwYzOscMX8K18ghGWf3cODtMQ==
X-Received: by 2002:a02:212b:: with SMTP id e43mr63679291jaa.80.1594155215399;
        Tue, 07 Jul 2020 13:53:35 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/5] arm64: Enable access to pmu registers by user-space
Date:   Tue,  7 Jul 2020 14:53:28 -0600
Message-Id: <20200707205333.624938-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is resurrecting Raphael's series[1] to enable userspace counter
access. The following changes have been made from the last version:

The major change is support for heterogeneous systems with some
restrictions. Specifically, userspace must pin itself to like CPUs, open
a specific PMU by type, and use h/w specific events. The tests have been
reworked to demonstrate this.

Chained events are not supported. The problem with supporting chained
events was there's no way to distinguish between a chained event and a
native 64-bit counter. We could add some flag, but do self monitoring
processes really need that? Native 64-bit counters are supported if the
PMU h/w has support. As there's already an explicit ABI to request 64-bit
counters, userspace can request 64-bit counters and if user
access is not enabled, then it must retry with 32-bit counters.

There was a bug in that pmc_width was not set in the user page. The tests
now check for this.

The documentation has been converted to rST. I've added sections on
chained events and heterogeneous.

The tests have been expanded to test the cycle counter access.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20190822144220.27860-1-raphael.gault@arm.com/


Raphael Gault (5):
  perf: arm64: Add tests to check userspace access to hardware counters
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: pmu: Add function implementation to update event index in
    userpage
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

 Documentation/arm64/index.rst                 |   1 +
 .../arm64/perf_counter_user_access.rst        |  52 ++
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 +
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/perf_event.c                |  80 +++
 drivers/perf/arm_pmu.c                        |  38 ++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/perf/arch/arm64/include/arch-tests.h    |  11 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |  12 +
 tools/perf/arch/arm64/tests/user-events.c     | 454 ++++++++++++++++++
 13 files changed, 675 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

--
2.25.1

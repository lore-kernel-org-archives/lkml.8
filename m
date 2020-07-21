Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229DCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0170720792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxePU75M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGUER6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUER6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:17:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:17:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so11320191pgv.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGaATuKDW25tfXnjy17rADeTuRjp0tV/vbWKKeWM86k=;
        b=FxePU75MyL2vEbevw6TtpxAoZ7al858qTZLgnulsvLtPDHAZfRUGdWc8xDb2P2/S9/
         bBc/PZv5oRmBtHu48J57hkDZoUPQczKHwLfygAQtWJAsbxUuyNPgQOhqoO7hnGwY2S1l
         BjCPVh9MaV1iO0wYglWEBL4YpgbhAKblNLO+R5ajQ6JgPxXfHsi5f7SvrdmclWZhjMtz
         Y+YCcQoTX72YN/GxWylHQAn1hpHmYUVKeFMHkT/mb0j446hxYU+dM2N7Iccf+4Enn9/u
         /BVQr+laVTtELgg68bMcctbJvSPmcvK0ISINvHZSf6qmhX8LdfPhs54QE7ulpgedx3ty
         BEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGaATuKDW25tfXnjy17rADeTuRjp0tV/vbWKKeWM86k=;
        b=asnypfmAePEPL43ZuR3dW1XpZ9sRVQZGLBZNWyRiewxe2uYvkJSKMpuRct5xka1dOB
         4MO4Cw0dSiI3bK8GqcGUMhCEfIq2RJdDJ4D0Zner1X3OkmloffmizcvhqIi6NXooi+kf
         Mlfqtzkf4o4okT7yzZth6wtGtuVkQQBGxDTEv3MwRYn7SSEDd7qpOsGKmHsyR+ug7sJw
         ixsLM+TsFVeIgIultRZILCU+fDigbnvVIIv3gblMEnmgF+jKRPsoiehuT5oLyE3yy7+Z
         YmSnikf1REdaXLEFqIXYi0v06IjmEZlVa31d8s887URPmEs17X0nO2/kF0Z8vMjpaDpx
         W0zQ==
X-Gm-Message-State: AOAM532ZEzJXy6HQyRxAjRfYfXFYS9owTvRsZpPwI3a9e0ggcW39fzGD
        Fl+PBiXZTdhJ6yefe2wDOHw=
X-Google-Smtp-Source: ABdhPJzYY7DsDQI2R2Hw96u5qdwyUqBzumqyzaOhAyEtXxWQuqRgXwtqQViAPRcRnUwjnAvM4sTsoQ==
X-Received: by 2002:a63:6884:: with SMTP id d126mr20548484pgc.341.1595305077188;
        Mon, 20 Jul 2020 21:17:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e28sm18467270pfm.177.2020.07.20.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:17:56 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     suleiman@google.com, joelaf@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
Date:   Tue, 21 Jul 2020 13:17:38 +0900
Message-Id: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	RFC

	We noticed that in a number of cases when we wake_up_process()
on arm64 guest we end up enqueuing that task on a preempted VCPU. The culprit
appears to be the fact that arm64 guests are not aware of VCPU preemption
as such, so when sched picks up an idle VCPU it always assumes that VCPU
is available:

      wake_up_process()
       try_to_wake_up()
        select_task_rq_fair()
         available_idle_cpu()
          vcpu_is_preempted()    // return false;

Which is, obviously, not the case.

This RFC patch set adds a simple vcpu_is_preempted() implementation so
that scheduler can make better decisions when it search for the idle
(v)CPU.

I ran a number of sched benchmarks please refer to [0] for more
details.

[0] https://github.com/sergey-senozhatsky/arm64-vcpu_is_preempted

Sergey Senozhatsky (4):
  arm64:kvm: define pv_state SMCCC HV calls
  arm64: add guest pvstate support
  arm64: add host pvstate support
  arm64: do not use dummy vcpu_is_preempted() anymore

 arch/arm64/include/asm/kvm_host.h  |  23 ++++++
 arch/arm64/include/asm/paravirt.h  |  15 ++++
 arch/arm64/include/asm/spinlock.h  |  17 +++--
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/paravirt-state.c | 117 +++++++++++++++++++++++++++++
 arch/arm64/kernel/paravirt.c       |   4 +-
 arch/arm64/kernel/time.c           |   1 +
 arch/arm64/kvm/Makefile            |   2 +-
 arch/arm64/kvm/arm.c               |   4 +
 arch/arm64/kvm/hypercalls.c        |  11 +++
 arch/arm64/kvm/pvstate.c           |  58 ++++++++++++++
 include/linux/arm-smccc.h          |  18 +++++
 12 files changed, 262 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/kernel/paravirt-state.c
 create mode 100644 arch/arm64/kvm/pvstate.c

-- 
2.27.0


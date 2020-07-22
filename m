Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65856C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4609B20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgGVRU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:20:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgGVRU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:20:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C4D31B;
        Wed, 22 Jul 2020 10:20:55 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2F8E3F66F;
        Wed, 22 Jul 2020 10:20:54 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 00/14] coresight: Support for ETMv4.4 system instructions
Date:   Wed, 22 Jul 2020 18:20:26 +0100
Message-Id: <20200722172040.1299289-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETMv4.4 introduced system instructions for accessing
the ETM. This also implies that they may not be on the amba bus.
Right now all the CoreSight components are accessed via memory
map. Also, we have some common routines in coresight generic
code driver (e.g, CS_LOCK, claim/disclaim), which assume the
mmio. In order to preserve the generic algorithms at a single
place and to allow dynamic switch for ETMs, this series introduces
an abstraction layer for accessing a coresight device. It is
designed such that the mmio access are fast tracked (i.e, without
an indirect function call).

This will also help us to get rid of the driver+attribute specific
sysfs show/store routines and replace them with a single routine
to access a given register offset (which can be embedded in the
dev_ext_attribute). This is not currently implemented in the series,
but can be achieved.

Further we switch the generic routines to work with the abstraction.
With this in place, we refactor the etm4x code a bit to allow for
supporting the system instructions with very little new code. The
changes also switch to using the system instructions by default
even when we may have an MMIO.

The series has been mildly tested on a model. I would really 
appreciate any testing on real hardware.

Applies on coresight/next tree. The tree is also available here :

 git://linux-arm.org/linux-skp.git etm-4.4/rfc

Suzuki K Poulose (14):
  coresight: etm4x: Skip save/restore before device registration
  coresight: Introduce device access abstraction
  coresight: tpiu: Use coresight device access abstraction
  coresight: etm4x: Free up argument of etm4_init_arch_data
  coresight: Convert coresight_timeout to use access abstraction
  coresight: Convert claim and lock operations to use access wrappers
  coresight: etm4x: Always read the registers on the host CPU
  coresight: etm4x: Convert all register accesses
  coresight: etm4x: Add sysreg access helpers
  coresight: etm4x: Define DEVARCH register fields
  coresight: etm4x: Detect system register access support
  coresight: etm4x: Refactor probing routine
  coresight: etm4x: Add support for sysreg only devices
  dts: bindings: coresight: ETMv4.4 system register access only units

 .../devicetree/bindings/arm/coresight.txt     |   6 +-
 drivers/hwtracing/coresight/coresight-catu.c  |  17 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |  26 +-
 .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
 drivers/hwtracing/coresight/coresight-cti.c   |  31 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
 .../coresight/coresight-etm3x-sysfs.c         |   8 +-
 drivers/hwtracing/coresight/coresight-etm3x.c |  45 +-
 .../coresight/coresight-etm4x-sysfs.c         |  32 +-
 drivers/hwtracing/coresight/coresight-etm4x.c | 580 +++++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x.h | 403 +++++++++++-
 .../hwtracing/coresight/coresight-funnel.c    |  19 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
 .../coresight/coresight-replicator.c          |  28 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  36 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  19 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |  10 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  32 +-
 drivers/hwtracing/coresight/coresight.c       | 130 +++-
 include/linux/coresight.h                     | 189 +++++-
 21 files changed, 1273 insertions(+), 426 deletions(-)

-- 
2.24.1


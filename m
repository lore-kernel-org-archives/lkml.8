Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364FD20814
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEVHmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:42:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:45536 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:42:05 -0400
IronPort-SDR: aAHi9UYgOMk2BjYLeWIW5OP9Ji+2R+LFV4S3hWXuJ+8s4nxb9wyeBbLGG0sl3zQdYB/RtNKajN
 UrI3WXId/fOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 00:42:04 -0700
IronPort-SDR: i1macvYvtZkl5m1avnXmq2geqjGod5ZgR6FyZ5tEavhShC9o59CqQwHEcihvOubtYGFOofNwXO
 l9INAVJYB1hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="374694136"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2020 00:42:01 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 0/2] pwm: intel:  Add PWM driver for new SoC
Date:   Fri, 22 May 2020 15:41:57 +0800
Message-Id: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 adds dt binding document in YAML format.
Patch 2 add PWM driver for LGM SoC.


Rahul Tanwar (2):
  Add YAML schema for a new PWM driver
  Add PWM driver for LGM

 .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     |  43 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 356 +++++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0


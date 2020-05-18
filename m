Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4756D207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgERJM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:12:28 -0400
Received: from foss.arm.com ([217.140.110.172]:36338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERJM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:12:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA456106F;
        Mon, 18 May 2020 02:12:27 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 699F43F68F;
        Mon, 18 May 2020 02:12:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 + ARCH_SOC_ID support
Date:   Mon, 18 May 2020 10:12:15 +0100
Message-Id: <20200518091222.27467-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
This doesn't add other changes added in SMCCC v1.2 yet. They will
follow these soon along with its first user SPCI/PSA-FF.

This is tested using upstream TF-A + the patch[3] fixing the original
implementation there.

v1[0]->v2[1]:
	- Incorporated comments from Steven Price in patch 5/5
	- Fixed build for CONFIG_PSCI_FW=n on some arm32 platforms
	- Added Steven Price's review tags

v2[1]->v3[2]:
	- Incorporated additional comments from Steven Price in patch 5/5
	  and added his review tags
	- Refactored SMCCC code from PSCI and moved it under
	  drivers/firmware/smccc/smccc.c
	- Also moved soc_id.c under drivers/firmware/smccc

v3[2]->v4:
	- Incorporated all the review comments from Mark R

Regards,
Sudeep

[0] https://lore.kernel.org/r/20200430114814.14116-1-sudeep.holla@arm.com/
[1] https://lore.kernel.org/r/20200504092905.10580-1-sudeep.holla@arm.com/
[2] https://lore.kernel.org/r/20200506164411.3284-1-sudeep.holla@arm.com/
[3] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/4002

Sudeep Holla (7):
  firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
  firmware: smccc: Update link to latest SMCCC specification
  firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
  firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
  firmware: smccc: Refactor SMCCC specific bits into separate file
  firmware: smccc: Add function to fetch SMCCC version
  firmware: smccc: Add ARCH_SOC_ID support

 MAINTAINERS                     |   9 ++
 arch/arm64/kernel/paravirt.c    |   2 +-
 drivers/firmware/Kconfig        |   6 +-
 drivers/firmware/Makefile       |   3 +-
 drivers/firmware/psci/psci.c    |  22 ++---
 drivers/firmware/smccc/Kconfig  |  25 ++++++
 drivers/firmware/smccc/Makefile |   4 +
 drivers/firmware/smccc/smccc.c  |  31 +++++++
 drivers/firmware/smccc/soc_id.c | 151 ++++++++++++++++++++++++++++++++
 include/linux/arm-smccc.h       |  27 +++++-
 include/linux/psci.h            |   7 --
 11 files changed, 256 insertions(+), 31 deletions(-)
 create mode 100644 drivers/firmware/smccc/Kconfig
 create mode 100644 drivers/firmware/smccc/Makefile
 create mode 100644 drivers/firmware/smccc/smccc.c
 create mode 100644 drivers/firmware/smccc/soc_id.c

--
2.17.1


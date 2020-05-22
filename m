Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED895C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE66B206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEVMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:34882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgEVMuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92A555D;
        Fri, 22 May 2020 05:50:00 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99A583F68F;
        Fri, 22 May 2020 05:49:59 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] base: soc: Add JEP106 manufacturer's identification code
Date:   Fri, 22 May 2020 13:49:49 +0100
Message-Id: <20200522124951.35776-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While attempting to add custom sysfs attributes for SMCCC ARCH_SOC_ID
Arnd suggested to make it generic. Here is my first attempt.

The original thread/discussion can be found here[1]

Regards,
Sudeep

[1] https://lore.kernel.org/r/CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com/

Sudeep Holla (2):
  base: soc: Add JEDEC JEP106 manufacturer's identification code attribute
  firmware: smccc: Add ARCH_SOC_ID support

 Documentation/ABI/testing/sysfs-devices-soc |  31 ++++++
 drivers/base/soc.c                          |  12 +++
 drivers/firmware/smccc/Kconfig              |   9 ++
 drivers/firmware/smccc/Makefile             |   1 +
 drivers/firmware/smccc/soc_id.c             | 113 ++++++++++++++++++++
 include/linux/arm-smccc.h                   |   5 +
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 172 insertions(+)
 create mode 100644 drivers/firmware/smccc/soc_id.c

-- 
2.17.1


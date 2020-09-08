Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F7CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB081215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIHIbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:31:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:63017 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgIHIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:31:48 -0400
IronPort-SDR: scu6mIea1k1qH3FQFwLo1SmyfsEIWpJlDKUoiK6Kp03aIQ7w5k9ijjbx9GG5Co8KIru3GO7PNm
 y94ljeQRwp7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="222303803"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="222303803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 01:31:44 -0700
IronPort-SDR: FweSmouYNk++v8QtEDs+cCrQB3qHOl51qKbd1PoAMr7SqCMfKSDkfCwcps9QO1kYDfUXJEZ5kb
 3plRa9JxnjhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="504298538"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 08 Sep 2020 01:31:42 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     krzk@kernel.org, mdf@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH] add the FPGA Device Feature List (DFL) EMIF support
Date:   Tue,  8 Sep 2020 16:27:24 +0800
Message-Id: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depend on the patchsets: "Modularization of DFL private
feature drivers" & "add dfl bus support to MODULE_DEVICE_TABLE()"

https://lore.kernel.org/linux-fpga/1599488581-16386-1-git-send-email-yilun.xu@intel.com/

The driver supports the EMIF controller on Intel Programmable
Acceleration Card (PAC). The controller manages the on-board memory of
the PCIe card.

Xu Yilun (1):
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   2 +
 drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 drivers/memory/dfl-emif.c

-- 
2.7.4


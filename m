Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB0520789
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHQNdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:33:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:35962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgHQNdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:33:31 -0400
IronPort-SDR: Zqd+1GQ132B98LPpABbjGyUe359esc4Plb3EsYBuZzc6KOjAmGvXurNpYitgj6haNerrgcSswG
 /HzMjD5vcLLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134759639"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134759639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 06:33:31 -0700
IronPort-SDR: E8WEF2UhFAYaIvOt4bObPNnuNOrUKIp59q5nUuKU6+1HdLopvbzewb86ff9KmBzhtV+NOrHO+v
 EIe8iW/nshXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="334075644"
Received: from marshy.an.intel.com ([10.122.105.159])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2020 06:33:30 -0700
From:   richard.gong@linux.intel.com
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@intel.com
Subject: [PATCHv2 0/2] add Intel SoCFPGA crypto service driver 
Date:   Mon, 17 Aug 2020 08:47:28 -0500
Message-Id: <1597672050-25829-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is the 2nd submission of Intel SoCFPGA crypto service driver.

I followed the process to register or request a valid IOCTL number/letter,
but I got the delivery failure status notification.

Cypto service driver and service layer driver patches have been reviewed
internally by colleagues at Intel.

Intel SoCFPGA is composed of a 64 bit quad-core ARM Cortex A53 hard
processor system (HPS) and Secure Device Manager (SDM). SDM is the
hardware which does the FPGA configuration, QSPI, remote system update,
crypto and warm reset.

To meet the whole system security needs and support virtual machine
requesting communication with SDM, only the secure world of software (EL3,
Exception Level 3) can interface with SDM. All software entities running
on other exception levels must channel through the EL3 software whenever
it needs service from SDM.

Intel Stratix10 service layer driver is added to provide the service for
FPGA configuration, Remote System Update and FPGA crypto service (FCS).
Running at privileged exception level (EL1, Exception Level 1), Intel
Stratix10 service layer driver interfaces with the service clients at EL1
and manages secure monitor call (SMC) to communicate with secure monitor
software at secure monitor exception level (EL3).

The crypto services include security certificate, image boot validation,
security key cancellation, get provision data, random number generation,
advance encryption standard (AES) encryption and decryption services.

To perform supporting crypto features on Intel SoCFPGA platforms, Linux
user-space application interacts with FPGA crypto service (FCS) driver via
structures defined in include/uapi/linux/intel_fcs-ioctl.h.

The application allocates spaces for IOCTL structure to hold the contents
or points to the data that FCS driver needs, uses IOCTL calls to passes
data to kernel FCS driver for processing at low level firmware and get
processed data or status back form the low level firmware via FCS driver.

The user-space application named as fcs_client is at
https://github.com/altera-opensource/fcs_apps/tree/fcs_client.

Richard Gong (2):
  firmware: stratix10-svc: extend svc to support new crypto features
  misc: add Intel SoCFPGA crypto service driver

 drivers/firmware/stratix10-svc.c                   | 178 +++++-
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-fcs.c                           | 709 +++++++++++++++++++++
 include/linux/firmware/intel/stratix10-smc.h       | 147 ++++-
 .../linux/firmware/intel/stratix10-svc-client.h    |  42 ++
 include/uapi/linux/intel-fcs_ioctl.h               | 222 +++++++
 7 files changed, 1292 insertions(+), 19 deletions(-)
 create mode 100644 drivers/misc/intel-fcs.c
 create mode 100644 include/uapi/linux/intel-fcs_ioctl.h

-- 
2.7.4


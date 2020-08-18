Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7950C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAFC204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRMJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:09:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:58725 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgHRMJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:09:57 -0400
IronPort-SDR: qlC9t0RqywJ59IymggbLtjlaylBzqCE2Nyi8qbhtYn1WzDDcqssETyi0mwxUUIuVLLiQTrj8G7
 +H90PGgSygdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200358"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:09:56 -0700
IronPort-SDR: Cpj3mVf/b75ctf071bSHheOjWInCzy+9GhIXcx4QgaR+vhgcWg6YaZN40ewUVOPqIxhmLFL8ta
 M5YZNEVycsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712920"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:09:55 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 00/13] mei: add support for virtual tags
Date:   Tue, 18 Aug 2020 14:51:34 +0300
Message-Id: <20200818115147.2567012-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mei virtualization for ACRN but might be used for other purposes such as sandboxing.
ACRN is an open-source hypervisor maintained by The Linux Foundation.
The support for ACRN was added in kernel in v5.3.
The patches were part of the ACRN service OS kernel for a while.
https://github.com/projectacrn/acrn-kernel

Only selected platforms, notable for IoT usage, such as APL-I, have
firmware that supports vtags.


Alexander Usyskin (10):
  mei: hbm: add capabilities message
  mei: restrict vtag support to hbm version 2.2
  mei: add vtag support bit in client properties
  mei: bump hbm version to 2.2
  mei: add a spin lock to protect rd_completed queue
  mei: add a vtag map for each client
  mei: handle tx queue flushing for vtag connections
  mei: bus: use zero vtag for bus clients.
  mei: bus: unconditionally enable clients with vtag support
  mei: add connect with vtag ioctl

Tomas Winkler (3):
  mei: add support for mei extended header.
  mei: docs: add vtag ioctl documentation
  mei: virtio: virtualization frontend driver

 Documentation/ABI/testing/sysfs-bus-mei |   7 +
 Documentation/driver-api/mei/mei.rst    |  37 +
 drivers/misc/mei/Kconfig                |  10 +
 drivers/misc/mei/Makefile               |   3 +
 drivers/misc/mei/bus-fixup.c            |  12 +
 drivers/misc/mei/bus.c                  |  89 ++-
 drivers/misc/mei/client.c               | 423 ++++++++++--
 drivers/misc/mei/client.h               |  22 +-
 drivers/misc/mei/debugfs.c              |   9 +-
 drivers/misc/mei/hbm.c                  | 101 ++-
 drivers/misc/mei/hbm.h                  |   2 +
 drivers/misc/mei/hw-virtio.c            | 874 ++++++++++++++++++++++++
 drivers/misc/mei/hw.h                   | 150 +++-
 drivers/misc/mei/interrupt.c            | 113 ++-
 drivers/misc/mei/main.c                 | 284 +++++++-
 drivers/misc/mei/mei_dev.h              |  34 +-
 include/uapi/linux/mei.h                |  49 ++
 17 files changed, 2084 insertions(+), 135 deletions(-)
 create mode 100644 drivers/misc/mei/hw-virtio.c

-- 
2.25.4


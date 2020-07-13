Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFE2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgGMGOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:14:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:34487 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgGMGOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:14:19 -0400
IronPort-SDR: YcWqGEyeUPfXmVw8iKi3blx2VKJI+FFhk1ZqRAVkw8e5BoY6Ewz8qhgqfcwbWsUurvBH6kCgWr
 BNN2Z0NZr+ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="147680037"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="147680037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 23:14:18 -0700
IronPort-SDR: cNdZNa3QY6bxf8cN8wRcPGvmPxxHMUOhnFBeH4ssm4mM9VdV6WEcai0hGrnjW4H32IQh/0wEoA
 v0lyHwNL/PGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="459177266"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2020 23:14:16 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, trix@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/2] Bug fixes for FPGA DFL
Date:   Mon, 13 Jul 2020 14:10:01 +0800
Message-Id: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 fix patches for FPGA DFL.

v2 adds Reviewed-by of Tom. No code change.

Matthew Gerlach (1):
  fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
  fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4


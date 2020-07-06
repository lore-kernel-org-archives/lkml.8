Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D967BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD02E20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgGFQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:13:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:10083 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgGFQNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:13:50 -0400
IronPort-SDR: zy1JVJuzHdmqhRtbUadtIlKGrI92wfA1x8hQgl5YgFFK6CDLymotp78tK8WhM/ZDaeExeiqphj
 KU075qSEhcFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="146520647"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="146520647"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 09:13:49 -0700
IronPort-SDR: Vx6qrEfDAUSMgudUqoV0+WyTITy3y/6ZvbopR/0L24fGpY4PFTQ8M7xiGuYme7oZ2grFgI33sU
 pS+yTHED1eQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="283084186"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 09:13:47 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/4] intel_th: Fixes for v5.8
Date:   Mon,  6 Jul 2020 19:13:35 +0300
Message-Id: <20200706161339.55468-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the fixes I have for v5.8 cycle so far. There is, in fact, just
one bugfix and 3 new PCI IDs. Nothing dramatic. Andy's r-bs are included.
Please consider applying. Thanks!

Alexander Shishkin (4):
  intel_th: pci: Add Jasper Lake CPU support
  intel_th: pci: Add Tiger Lake PCH-H support
  intel_th: pci: Add Emmitsburg PCH support
  intel_th: Fix a NULL dereference when hub driver is not loaded

 drivers/hwtracing/intel_th/core.c | 21 ++++++++++++++++++---
 drivers/hwtracing/intel_th/pci.c  | 15 +++++++++++++++
 drivers/hwtracing/intel_th/sth.c  |  4 +---
 3 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.27.0


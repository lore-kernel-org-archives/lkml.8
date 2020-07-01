Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD93C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8F620760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgGAPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:30:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:63074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbgGAPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:30:09 -0400
IronPort-SDR: 9ubm55pGbFyUs6cfLcbCDI4a7kRTmEg+Khd+VlXnr2klh12OFSwt92wNl1AaryJFgd7/HPA5RZ
 Wi6OZr6VJDOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134886180"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="134886180"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:29:51 -0700
IronPort-SDR: qii2doTNGxxQ9EAUM+l5Od+zB+Fh1ps2PvsDbF1g75+lgSHfxDfTzMGjfoLJ92LYZMmPa9Lgph
 24hh9lQMI5QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="321789364"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2020 08:29:51 -0700
Subject: [PATCH 0/3] [v2] Repair and clean up vm.zone_reclaim_mode sysctl ABI
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Jul 2020 08:26:21 -0700
Message-Id: <20200701152621.D520E62B@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous cleanup accidentally changed the vm.zone_reclaim_mode ABI.

This series restores the ABI and then reorganizes the code to make
the ABI more obvious.  Since the single-patch v1[1], I've:

 * Restored the RECLAIM_ZONE naming, comment and Documentation now
   that the implicit checks for it are known.
 * Move RECLAIM_* definitions to a uapi header
 * Add a node_reclaim_enabled() helper

 Documentation/admin-guide/sysctl/vm.rst |   10 +++++-----
 include/linux/swap.h                    |    7 +++++++
 include/uapi/linux/mempolicy.h          |    7 +++++++
 mm/khugepaged.c                         |    2 +-
 mm/page_alloc.c                         |    2 +-
 mm/vmscan.c                             |    3 ---
 6 files changed, 21 insertions(+), 10 deletions(-)

1. https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Daniel Wagner <dwagner@suse.de>

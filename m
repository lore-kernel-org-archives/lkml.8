Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F2C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9614221556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAMSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:00:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:10778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMSAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:00:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 10:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="304903947"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 10:00:17 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     yu.chen.surf@gmail.com, andy@infradead.org, dvhart@infradead.org,
        andy@kernel.org, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/2] Intel Uncore frequency control
Date:   Mon, 13 Jan 2020 10:00:13 -0800
Message-Id: <20200113180015.503314-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
	Chen Yu pointed issue with rdmsrl, to change to rdmsrl_on_cpu

v2:
	Split the documentation patch to another patch to merge via different
	tree
	Add MAINTAINER entry

Srinivas Pandruvada (2):
  platform/x86: Add support for Uncore frequency control
  MAINTAINERS: Update for the intel uncore frequency control

 MAINTAINERS                                   |   6 +
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel-uncore-frequency.c | 437 ++++++++++++++++++
 4 files changed, 455 insertions(+)
 create mode 100644 drivers/platform/x86/intel-uncore-frequency.c

-- 
2.24.1


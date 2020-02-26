Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5EC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1520656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBZTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:11:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:20002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgBZTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="285072246"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2020 11:11:40 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com
Subject: [PATCH 0/2] x86/delay: Introduce TPAUSE instruction 
Date:   Wed, 26 Feb 2020 11:10:56 -0800
Message-Id: <1582744258-42744-1-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors that support the WAITPKG feature implement
the TPAUSE instruction that suspends execution in a lower power
state until the TSC (Time Stamp Counter) exceeds a certain value.

Update the udelay() function to use TPAUSE on systems where it
is available. Note that we hard code the deeper (C0.2) sleep
state because exit latency is small compared to the "microseconds"
that usleep() will delay.

Kyung Min Park (2):
  x86/asm: Define a few helpers in delay_waitx()
  x86/asm/delay: Introduce TPAUSE delay

 arch/x86/include/asm/mwait.h | 17 +++++++++
 arch/x86/lib/delay.c         | 82 ++++++++++++++++++++++++++++++++------------
 2 files changed, 78 insertions(+), 21 deletions(-)

-- 
2.7.4


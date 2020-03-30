Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58589C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269A420714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgC3SjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:39:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:11897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgC3SjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:39:14 -0400
IronPort-SDR: Ql+5PGh1N20d97T10HVjJihB2pKaSvjnO28enQSVhLDFbxpw0Yf58t2kc57bkbMGR2JVdd9KCr
 AT7U/YGp30rQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 11:39:14 -0700
IronPort-SDR: GTTrCUV9Efmpy4y5ocnST56b6jKYkisg35tLqyYfzOKEgfjyB4tN/OzLxQfdIEnf997wqndPkH
 WTx3SNjvVu4Q==
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="395219392"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 11:39:13 -0700
Date:   Mon, 30 Mar 2020 11:39:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ia64 for v5.7
Message-ID: <20200330183912.GA27085@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git please-pull-ia64_for_5.7

for you to fetch changes up to 172e7890406d6183b9b39271ffb434ff0a97ce72:

  tty/serial: cleanup after ioc*_serial driver removal (2020-03-13 16:12:17 -0700)

----------------------------------------------------------------
Couple of cleanup patches

----------------------------------------------------------------
Lukas Bulwahn (1):
      tty/serial: cleanup after ioc*_serial driver removal

afzal mohammed (1):
      ia64: replace setup_irq() by request_irq()

 MAINTAINERS                    |  9 +---
 arch/ia64/include/asm/hw_irq.h |  2 -
 arch/ia64/kernel/irq.h         |  3 ++
 arch/ia64/kernel/irq_ia64.c    | 43 +++++++------------
 arch/ia64/kernel/mca.c         | 50 +++++++----------------
 arch/ia64/kernel/perfmon.c     | 10 ++---
 arch/ia64/kernel/time.c        | 11 ++---
 include/linux/ioc3.h           | 93 ------------------------------------------
 8 files changed, 40 insertions(+), 181 deletions(-)
 create mode 100644 arch/ia64/kernel/irq.h
 delete mode 100644 include/linux/ioc3.h

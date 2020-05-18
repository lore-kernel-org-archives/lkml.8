Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A61207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgERFDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:03:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:22856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgERFDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:03:00 -0400
IronPort-SDR: yAcv2VPO/QeyCwL16YL2qPVPKEXcCM7f9gBIyv9hdKlmmBc3apdnTqoou3tOJN9Db4dbeI7flt
 hEdoWROkT1zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 22:03:00 -0700
IronPort-SDR: QslUiUcqLdBNlYU9VpaP6qJsIOxWbbMWBz/jCxrvOjLTwl3v/Q7YVbFfvxW9b76EmxBa915xnE
 Qh+PQG5N0mDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="299659598"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2020 22:02:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaXvW-000D9C-KZ; Mon, 18 May 2020 13:02:58 +0800
Date:   Mon, 18 May 2020 13:02:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linus] RISC-V: gp_in_global can be static
Message-ID: <20200518050227.GA13086@f1dbffaf4744>
References: <202005181328.2fITyRLh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181328.2fITyRLh%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 52e7c52d2ded ("RISC-V: Stop relying on GCC's register allocator's hueristics")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 610c11e916068..3b2933839d492 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -22,7 +22,7 @@
 #include <asm/switch_to.h>
 #include <asm/thread_info.h>
 
-unsigned long gp_in_global __asm__("gp");
+static unsigned long gp_in_global __asm__("gp");
 
 extern asmlinkage void ret_from_fork(void);
 extern asmlinkage void ret_from_kernel_thread(void);

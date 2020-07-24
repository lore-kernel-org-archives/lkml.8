Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D267C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD24206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGXFF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:05:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:1886 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:05:58 -0400
IronPort-SDR: 5O5THgPvS3uERbwRkiLXXLn28Hug3q8kQsYCKcmDqnzVZZ/rlXypPb2llv1v8ZCQBy2zTrLrzr
 +t5pnkfd2GwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="149850586"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="149850586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:05:57 -0700
IronPort-SDR: ZBWC5rV1mTr/ZUnRTae3bWgA+q6XNfXQSs2SASPa/4e9DqadwPwI9ePGMQI9LbKbG9RxjNI2IV
 NIWFG1lBH0rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="302553377"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 22:05:55 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 0/6] arch/x86: kprobes: Remove MODULES dependency
Date:   Fri, 24 Jul 2020 08:05:47 +0300
Message-Id: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MODULES dependency by migrating from module_alloc() to the new
text_alloc() API. Essentially these changes provide preliminaries for
allowing to compile a static kernel with a proper tracing support.

The same API can be used later on in other sites that allocate space for
trampolines, and trivially scaled to other arch's. An arch can inform
with CONFIG_ARCH_HAS_TEXT_ALLOC that it's providing implementation for
text_alloc().

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>

v4:
* Squash lock_modules() patches into one.
* Remove fallback versions of text_alloc() and text_free(). Instead, use
  ARCH_HAS_TEXT_ALLOC at site when required.
* Use lockdep_assert_irqs_enabled() in text_free() instead of
  WARN_ON(in_interrupt()).

v3:
* Make text_alloc() API disjoint.
* Remove all the possible extra clutter not absolutely required and
  split into more logical pieces.

Jarkko Sakkinen (6):
  kprobes: Remove dependency to the module_mutex
  vmalloc: Add text_alloc() and text_free()
  arch/x86: Implement text_alloc() and text_free()
  arch/x86: kprobes: Use text_alloc() and text_free()
  kprobes: Use text_alloc() and text_free()
  kprobes: Remove CONFIG_MODULES dependency

 arch/Kconfig                   |  2 +-
 arch/x86/Kconfig               |  3 ++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/kprobes/core.c |  4 +--
 arch/x86/kernel/text_alloc.c   | 41 +++++++++++++++++++++++
 include/linux/module.h         | 32 ++++++++++++++----
 include/linux/vmalloc.h        | 17 ++++++++++
 kernel/kprobes.c               | 61 +++++++++++++++++++++++-----------
 kernel/trace/trace_kprobe.c    | 20 ++++++++---
 9 files changed, 147 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/kernel/text_alloc.c

-- 
2.25.1


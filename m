Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81472076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgFHMyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:54:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:47795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbgFHMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:54:35 -0400
IronPort-SDR: 4zCeo/Gu/l11k6LvMtnkJ9eYHSdx6u2gYck4Bxrv75QiLPh8rR4yY4bqyuFrNefAzASTu3q46U
 V2j0Pok1NPUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 05:54:34 -0700
IronPort-SDR: x66KGXaPNNEaV3zpLIrWlHsD7kGIHT9bFjM06CXGMcX4rRaMM90o9OXGsj7bxVwD0UlZcnZ4As
 SSQlJhb+ro7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="379410653"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2020 05:54:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9E9251BC; Mon,  8 Jun 2020 15:54:30 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/2] x86: Fix boot with some memory above MAXMEM
Date:   Mon,  8 Jun 2020 15:54:22 +0300
Message-Id: <20200608125424.70198-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 5-level paging capable machine can have memory above 46-bit in the
physical address space. This memory is only addressable in the 5-level
paging mode: we don't have enough virtual address space to create direct
mapping for such memory in the 4-level paging mode.

Tested with a hacked QEMU: https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d

v2:
 - Fix boot with KASLR enabled on such machines;
 - Better error message;

Kirill A. Shutemov (2):
  x86/mm: Fix boot with some memory above MAXMEM
  x86/boot/KASLR: Fix boot with some memory above MAXMEM

 arch/x86/boot/compressed/kaslr.c | 11 +++++++++++
 arch/x86/kernel/e820.c           | 24 ++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.26.2


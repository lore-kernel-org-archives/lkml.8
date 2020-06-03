Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A083C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055E620679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFCOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:42:01 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49430 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgFCOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:42:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U-U6fCz_1591195316;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0U-U6fCz_1591195316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Jun 2020 22:41:57 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     jpoimboe@redhat.com
Cc:     bp@alien8.de, changhuaixin@linux.alibaba.com, hpa@zytor.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, michal.lkml@markovi.net, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v3 0/3] Build ORC fast lookup table in scripts/sorttable tool
Date:   Wed,  3 Jun 2020 22:39:42 +0800
Message-Id: <20200603143945.64248-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20200601173840.3f36m6l4fsu5bill@treble>
References: <20200601173840.3f36m6l4fsu5bill@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move building of fast lookup table from boot to sorttable tool. This saves us
6380us boot time on Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz with cores. It
adds a little more than 7ms to boot time when testing on the same CPU.

Changelog v3:
1. Modify annotation of unwind_init().

Changelog v2:
1. Type of section orc_lookup needs to be SHT_PROGBITS.
2. unwind_init() cannot be removed totally as setting lookup_num_blocks is needed.

Huaixin Chang (3):
  scripts/sorttable: Change section type of orc_lookup to SHT_PROGBITS
  scripts/sorttable: Build orc fast lookup table via sorttable tool
  x86/unwind/orc: Simplify unwind_init() for x86 boot

 arch/x86/kernel/unwind_orc.c      | 41 +---------------
 include/asm-generic/vmlinux.lds.h |  2 +
 scripts/sorttable.h               | 99 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 96 insertions(+), 46 deletions(-)

-- 
2.14.4.44.g2045bb6


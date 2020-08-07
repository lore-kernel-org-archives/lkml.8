Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17865C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC7F22D07
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGESb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:18:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39173 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgHGESa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:18:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0U4zix1D_1596773906;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0U4zix1D_1596773906)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 12:18:26 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, michal.lkml@markovi.net, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v2 0/3] Build ORC fast lookup table in scripts/sorttable tool
Date:   Fri,  7 Aug 2020 12:17:59 +0800
Message-Id: <20200807041802.18639-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20200723034643.33537-1-changhuaixin@linux.alibaba.com>
References: <20200723034643.33537-1-changhuaixin@linux.alibaba.com>
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

Changelog v2:
1. Write .orc_lookup section header via objtool
2. Move two ORC lookup table macro from orc_lookup.h into orc_types.h
3. Spell 'ORC' in capitalized fashion

Huaixin Chang (3):
  objtool: Write .orc_lookup section header
  scripts/sorttable: Build ORC fast lookup table via sorttable tool
  x86/unwind/orc: Simplify unwind_init() for x86 boot

 arch/x86/include/asm/orc_lookup.h      | 16 ------
 arch/x86/include/asm/orc_types.h       | 16 ++++++
 arch/x86/kernel/unwind_orc.c           | 41 +--------------
 arch/x86/kernel/vmlinux.lds.S          |  2 +-
 scripts/sorttable.h                    | 96 +++++++++++++++++++++++++++++++---
 tools/arch/x86/include/asm/orc_types.h | 16 ++++++
 tools/objtool/orc_gen.c                |  4 ++
 7 files changed, 128 insertions(+), 63 deletions(-)

-- 
2.14.4.44.g2045bb6


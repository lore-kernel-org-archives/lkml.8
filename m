Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD3C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B296521734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="bj5rSvCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgAVK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:59:34 -0500
Received: from mail.dlink.ru ([178.170.168.18]:54914 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgAVK7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:59:34 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id D56191B2025C; Wed, 22 Jan 2020 13:59:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru D56191B2025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1579690772; bh=q9dD2Cr59uR3VZnrDzVBjRZfBPQ42Iq20hp5A0NIbfM=;
        h=From:To:Cc:Subject:Date;
        b=bj5rSvCSaAQYN8nKQtedqE3otEt+XcbfBX4n4ivOTeJKRB/dfY2pguBTs9l6Tsk8w
         Lrzfv9/3bLsdP9N4fNxM8tgH9lZ6sq4qvibz8cm/1tsCTNvCMyFG0n/2HB7TWPbFFX
         KEDYtvnjYsowDwtIX9DG8GWodrWT/hH9sycM5AmU=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 319741B204A3;
        Wed, 22 Jan 2020 13:59:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 319741B204A3
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id CF9EC1B217C5;
        Wed, 22 Jan 2020 13:59:18 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Wed, 22 Jan 2020 13:59:18 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH mips-next 0/5] MIPS: a set of misc Kconfig/Kbuild improvements
Date:   Wed, 22 Jan 2020 13:58:47 +0300
Message-Id: <20200122105852.8788-1-alobakin@dlink.ru>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims mainly at MIPS and Generic MIPS Kconfig optimizations
except for the last patch that removes redundant BASE_BAUD override for
Generic MIPS. If it should go out of this series, please let me know.
All changes were fully tested on Generic MIPS32R2 board, but I admit
there potentionally might be any non-critical issues on other systems
(unlikely though).

Alexander Lobakin (5):
  MIPS: don't explicitly select LIBFDT in Kconfig
  MIPS: generic: don't unconditionally select PINCTRL
  MIPS: make CPU_HAS_LOAD_STORE_LR opt-out
  MIPS: sort MIPS and MIPS_GENERIC Kconfig selects alphabetically
    (again)
  Revert "MIPS: Add custom serial.h with BASE_BAUD override for generic
    kernel"

 arch/mips/Kconfig                             | 60 ++++++-------------
 arch/mips/configs/generic/board-ocelot.config |  1 +
 arch/mips/include/asm/Kbuild                  |  1 +
 arch/mips/include/asm/serial.h                | 18 ------
 arch/mips/kernel/unaligned.c                  | 36 +++++------
 arch/mips/lib/memcpy.S                        | 14 ++---
 arch/mips/lib/memset.S                        | 16 ++---
 7 files changed, 52 insertions(+), 94 deletions(-)
 delete mode 100644 arch/mips/include/asm/serial.h

-- 
2.25.0


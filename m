Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ADEC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8FE2086A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 23:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCHXYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:24:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57283 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgCHXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:24:02 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Gn-00037I-NJ; Mon, 09 Mar 2020 00:23:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 21041100292;
        Mon,  9 Mar 2020 00:23:35 +0100 (CET)
Message-Id: <20200308231410.905396057@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 09 Mar 2020 00:14:10 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-III V2 00/23] x86/entry: Consolidation - Part III (simple exceptions)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the second version of the entry consolidation work part III
covering simple exceptions. V1 can be found here:

  https://lore.kernel.org/r/20200225221606.511535280@linutronix.de

It applies on top of part II which is available here

  https://lore.kernel.org/r/20200308222359.370649591@linutronix.de

and is also available from git (including part II):

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel entry-v2-part3

The changes vs. V1:

  - Remove #BP (int3) conversion as this needs extra care vs. kprobes (Peter)

  - Fixup the FOOF bug do_invalid_op() call in fault.c 

  - Address the few review comments (mostly changelog and comment improvements)

  - Picked up Reviewed-by and Acked-by tags

Thanks,

	tglx
---
 arch/x86/entry/entry_32.S         |  160 +++++---------
 arch/x86/entry/entry_64.S         |  410 ++++++++++++++++++++------------------
 arch/x86/include/asm/traps.h      |   76 -------
 arch/x86/kernel/idt.c             |   28 +-
 arch/x86/kernel/traps.c           |  131 +++++++-----
 arch/x86/mm/fault.c               |    2 
 arch/x86/xen/enlighten_pv.c       |   33 +--
 arch/x86/xen/xen-asm_32.S         |    2 
 arch/x86/xen/xen-asm_64.S         |   28 +-
 b/arch/x86/include/asm/idtentry.h |  167 +++++++++++++++
 b/arch/x86/include/asm/trapnr.h   |   31 ++
 11 files changed, 611 insertions(+), 457 deletions(-)



Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E976C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB2A207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323090;
	bh=L7HAS4sYz0Q0M+EaHokWTKwpor0s3bgHozek18pK5LY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EOIDX1ccp0mGAfCtFq0TpOdOUbGTfQ380CHi8U8d86vlqjgapbftwnixheU5t4K1k
	 7Bf/Dmvx2DK1PpYINvJgAndEsBrOmotiZ2i1KrGf/XfqdvreqzLgtVGa1i1y7ivSjc
	 MAv69DhyFu5nEfB110UqgwX97f9QNEWhXwZDsAfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFPP6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733119AbgFPP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:58:04 -0400
Received: from localhost.localdomain (unknown [42.120.72.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9ADA21548;
        Tue, 16 Jun 2020 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323084;
        bh=L7HAS4sYz0Q0M+EaHokWTKwpor0s3bgHozek18pK5LY=;
        h=From:To:Cc:Subject:Date:From;
        b=AuOpr7G3+Fh9kTygW02K/pdHhG0lP5NrT3swgnodY5YTjhLi6ow3Y1S3k66sWESZ/
         RP1goGarTA+IuSP+K765jpDunyR1Ns6xKyskcRjY5NEQqnRznAxXKesdm0b01twqRG
         EseNQ8zymopKcK248UAlBjPE8fpWH14y3pKaQ334=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, zong.li@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, tycho@tycho.ws, nickhu@andestech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/3] riscv: Enable LOCKDEP
Date:   Tue, 16 Jun 2020 15:56:58 +0000
Message-Id: <1592323021-98541-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Lockdep is needed by proving the spinlocks and rwlocks. To suupport
it, we need fixup TRACE_IRQFLAGS_SUPPORT in kernel/entry.S. This
patch follow Documentation/irqflags-tracing.txt.

And there are 2 bugs block the lockdep implementation.

Guo Ren (2):
  riscv: Fixup static_obj() fail
  riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT

Zong Li (1):
  riscv: Fixup lockdep_assert_held with wrong param cpu_running

 arch/riscv/Kconfig              |  3 +++
 arch/riscv/kernel/entry.S       | 41 ++++++++++++++++++++++++++++++++++++++++-
 arch/riscv/kernel/smpboot.c     |  1 -
 arch/riscv/kernel/vmlinux.lds.S |  2 +-
 4 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.7.4


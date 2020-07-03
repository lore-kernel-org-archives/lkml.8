Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D01C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ADA2100A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795783;
	bh=Kl4Bwj85//LM40HE3a7a0PfezbN7/BWnzIk7Y5H2afo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BgnMYqMwa3Uu2aABw4dhH8NGQ4k36V/IrzRftJaINXZrdm1p0rzFL6e1ZdlZqKNvI
	 aFYI5CDCW4WujAUmlrIrR5nBFRCwLFXwCCTkmQESm2D6br3/NMM7dCFBpQKopR6hNd
	 Bv7A4YRUrYH7Ym4ojtUvmDjzEwxJ3fDN2M0wVGIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGCRDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGCRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:01 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EFE20870;
        Fri,  3 Jul 2020 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795781;
        bh=Kl4Bwj85//LM40HE3a7a0PfezbN7/BWnzIk7Y5H2afo=;
        h=From:To:Cc:Subject:Date:From;
        b=sJSigZZdcVxsSzZLDKMJ+dS3AWpix07MgvySG4oLGsZwlQmX5ThKwDR4fVZO+t2Z2
         tgl2bjn2ZLBC08/6Kt2b9qp8RoqacKL2jGs7K88YtRKNrKHJ1qyP+UCkDn+RE5xPn0
         FhVSrTWcbi0TbcDyAx1QlxvI2ByqT5n+gAGUg8Wc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH entry v2 0/6] x86/entry: Fixes and cleanups
Date:   Fri,  3 Jul 2020 10:02:52 -0700
Message-Id: <cover.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are in priority order.  Patch 1 could be folded into the patch
it fixes.  The selftests improve my confidence in the correctness of
the whole pile.  The next two patches fix IDTENTRY miswiring.  The
last two are optional and could easily wait until the next merge
window.

Andy Lutomirski (6):
  x86/entry/compat: Clear RAX high bits on Xen PV SYSENTER
  x86/entry, selftests: Further improve user entry sanity checks
  x86/entry/xen: Route #DB correctly on Xen PV
  x86/entry/32: Fix #MC and #DB wiring on x86_32
  x86/ldt: Disable 16-bit segments on Xen PV
  x86/entry: Rename idtentry_enter/exit_cond_rcu() to
    idtentry_enter/exit()

 arch/x86/entry/common.c                  | 69 +++++++++++++++-------
 arch/x86/entry/entry_64_compat.S         | 19 +++---
 arch/x86/include/asm/idtentry.h          | 75 +++++++++++-------------
 arch/x86/kernel/cpu/mce/core.c           |  4 +-
 arch/x86/kernel/kvm.c                    |  6 +-
 arch/x86/kernel/ldt.c                    | 35 ++++++++++-
 arch/x86/kernel/traps.c                  | 20 +++++--
 arch/x86/mm/fault.c                      |  6 +-
 arch/x86/xen/enlighten_pv.c              | 28 +++++++--
 arch/x86/xen/xen-asm_64.S                |  5 +-
 kernel/time/tick-sched.c                 |  1 +
 tools/testing/selftests/x86/syscall_nt.c | 11 ++++
 12 files changed, 189 insertions(+), 90 deletions(-)

-- 
2.25.4


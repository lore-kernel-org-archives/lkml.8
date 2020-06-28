Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE12F20720
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgF1OnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgF1OnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E305ACBD;
        Sun, 28 Jun 2020 14:43:19 +0000 (UTC)
Date:   Sun, 28 Jun 2020 16:43:19 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.8-rc3
Message-ID: <20200628144319.GD18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/urgent pile which has nothing but clear fixes.

Thx.

---
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_5.8_rc3

for you to fetch changes up to bb5570ad3b54e7930997aec76ab68256d5236d94:

  x86/asm/64: Align start of __clear_user() loop to 16-bytes (2020-06-19 18:32:11 +0200)

----------------------------------------------------------------
* AMD Memory bandwidth counter width fix, by Babu Moger.

* Use the proper length type in the 32-bit truncate() syscall variant,
by Jiri Slaby.

* Reinit IA32_FEAT_CTL during wakeup to fix the case where after
resume, VMXON would #GP due to VMX not being properly enabled, by Sean
Christopherson.

* Fix a static checker warning in the resctrl code, by Dan Carpenter.

* Add a CR4 pinning mask for bits which cannot change after boot, by
Kees Cook.

* Align the start of the loop of __clear_user() to 16 bytes, to improve
performance on AMD zen1 and zen2 microarchitectures, by Matt Fleming.

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Fix memory bandwidth counter width for AMD

Dan Carpenter (1):
      x86/resctrl: Fix a NULL vs IS_ERR() static checker warning in rdt_cdp_peer_get()

Jiri Slaby (1):
      syscalls: Fix offset type of ksys_ftruncate()

Kees Cook (1):
      x86/cpu: Use pinning mask for CR4 bits needing to be 0

Matt Fleming (1):
      x86/asm/64: Align start of __clear_user() loop to 16-bytes

Sean Christopherson (1):
      x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during wakeup

 arch/x86/include/asm/cpu.h             |  5 +++++
 arch/x86/kernel/cpu/centaur.c          |  1 +
 arch/x86/kernel/cpu/common.c           | 24 ++++++++++++------------
 arch/x86/kernel/cpu/cpu.h              |  4 ----
 arch/x86/kernel/cpu/resctrl/core.c     |  8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  1 +
 arch/x86/kernel/cpu/zhaoxin.c          |  1 +
 arch/x86/lib/usercopy_64.c             |  1 +
 arch/x86/power/cpu.c                   |  6 ++++++
 include/linux/syscalls.h               |  2 +-
 11 files changed, 33 insertions(+), 21 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

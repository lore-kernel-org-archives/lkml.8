Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974DA20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFJUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFJUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:25:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D6C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:25:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj7HZ-006d0R-Nn; Wed, 10 Jun 2020 20:25:09 +0000
Date:   Wed, 10 Jun 2020 21:25:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] uaccess misc
Message-ID: <20200610202509.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted uaccess patches for this cycle - the stuff that
didn't fit into thematic series.

The following changes since commit b44f687386875b714dae2afa768e73401e45c21c:

  drm/i915/gem: Replace user_access_begin by user_write_access_begin (2020-05-01 12:35:22 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.misc

for you to fetch changes up to b7e4b65f3fe92abbf4a1f57987a54c820969aebd:

  bpf: make bpf_check_uarg_tail_zero() use check_zeroed_user() (2020-06-03 16:59:45 -0400)

----------------------------------------------------------------
Al Viro (9):
      pselect6() and friends: take handling the combined 6th/7th args into helper
      binfmt_elf: don't bother with __{put,copy_to}_user()
      binfmt_elf_fdpic: don't use __... uaccess primitives
      binfmt_flat: don't use __put_user()
      x86: switch cp_stat64() to unsafe_put_user()
      TEST_ACCESS_OK _never_ had been checked anywhere
      user_regset_copyout_zero(): use clear_user()
      x86: kvm_hv_set_msr(): use __put_user() instead of 32bit __clear_user()
      bpf: make bpf_check_uarg_tail_zero() use check_zeroed_user()

 arch/x86/include/asm/pgtable_32.h |   7 ---
 arch/x86/kernel/sys_ia32.c        |  40 ++++++++------
 arch/x86/kvm/hyperv.c             |   2 +-
 fs/binfmt_elf.c                   |  16 +++---
 fs/binfmt_elf_fdpic.c             |  31 +++++++----
 fs/binfmt_flat.c                  |  22 +++++---
 fs/select.c                       | 112 ++++++++++++++++++++++----------------
 include/linux/regset.h            |   2 +-
 kernel/bpf/syscall.c              |  25 ++-------
 9 files changed, 135 insertions(+), 122 deletions(-)

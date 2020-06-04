Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00584206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgFDUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:13:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60070 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgFDUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:13:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwEm-00039a-Kq; Thu, 04 Jun 2020 14:13:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwEl-0008Pb-PQ; Thu, 04 Jun 2020 14:13:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Jun 2020 15:09:16 -0500
Message-ID: <87k10mioer.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgwEl-0008Pb-PQ;;;mid=<87k10mioer.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ZkL+F89jjfIpI3mg8ccyT4X1fIe58w40=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] exec cleanups for v5.8-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the proc-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

   HEAD: 3977e285ee89a94699255dbbf6eeea13889a1083 exec: Remove the recomputation of bprm->cred

Last cycle for the Nth time I ran into bugs and quality of
implementation issues related to exec that could not be easily be fixed
because of the way exec is implemented.  So I have been digging into
exec and cleanup up what I can.

I don't think I have exec sorted out enough to fix the issues I started
with but I have made some headway this cycle with 4 sets of changes.

      exec: Promised cleanups after introducing exec_update_mutex
      exec: Trivial cleanups for exec
      exec: Control flow simplifications
      exec: Remove the recomputation of bprm->cred

The net result is code that is a bit easier to understand and work with
and a decrease in the number of lines of code (if you don't count the
added tests).

There is a trivial conflict with the transformation of
copy_strings_kernel into copy_string_kernel by Christoph Hellwig.  These
changes touch adjacent lines.

Arnd Bergmann (1):
      binfmt_elf_fdpic: fix execfd build regression

Eric W. Biederman (30):
      binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
      exec: Make unlocking exec_update_mutex explict
      exec: Rename the flag called_exec_mmap point_of_no_return
      exec: Merge install_exec_creds into setup_new_exec
      exec: In setup_new_exec cache current in the local variable me
      exec: Move most of setup_new_exec into flush_old_exec
      exec: Rename flush_old_exec begin_new_exec
      exec: Promised cleanups after introducing exec_update_mutex
      exec: Move the comment from above de_thread to above unshare_sighand
      exec: Fix spelling of search_binary_handler in a comment
      exec: Run sync_mm_rss before taking exec_update_mutex
      exec: Move handling of the point of no return to the top level
      exec: Set the point of no return sooner
      exec: Trivial cleanups for exec
      exec: Move would_dump into flush_old_exec
      Merge f87d1c955916 ("exec: Move would_dump into flush_old_exec")
      exec: Teach prepare_exec_creds how exec treats uids & gids
      exec: Factor security_bprm_creds_for_exec out of security_bprm_set_creds
      exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
      exec: Allow load_misc_binary to call prepare_binprm unconditionally
      exec: Move the call of prepare_binprm into search_binary_handler
      exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
      exec: Generic execfd support
      exec: Remove recursion from search_binary_handler
      exec: Control flow simplifications
      exec: Always set cap_ambient in cap_bprm_set_creds
      Merge commit a4ae32c71fe9 ("exec: Always set cap_ambient in cap_bprm_set_creds")
      exec: Add a per bprm->file version of per_clear
      exec: Compute file based creds only once
      exec: Remove the recomputation of bprm->cred

Kees Cook (1):
      selftests/exec: Add binfmt_script regression test

 Documentation/trace/ftrace.rst             |   2 +-
 arch/alpha/kernel/binfmt_loader.c          |  11 +-
 arch/x86/ia32/ia32_aout.c                  |   4 +-
 fs/binfmt_aout.c                           |   3 +-
 fs/binfmt_elf.c                            |   7 +-
 fs/binfmt_elf_fdpic.c                      |   9 +-
 fs/binfmt_em86.c                           |  13 +-
 fs/binfmt_flat.c                           |   4 +-
 fs/binfmt_misc.c                           |  69 +------
 fs/binfmt_script.c                         |  82 ++++----
 fs/exec.c                                  | 320 ++++++++++++++++-------------
 include/linux/binfmts.h                    |  45 ++--
 include/linux/lsm_hook_defs.h              |   3 +-
 include/linux/lsm_hooks.h                  |  56 ++---
 include/linux/security.h                   |  15 +-
 kernel/cred.c                              |   3 +
 kernel/events/core.c                       |   2 +-
 security/apparmor/domain.c                 |   7 +-
 security/apparmor/include/domain.h         |   2 +-
 security/apparmor/lsm.c                    |   2 +-
 security/commoncap.c                       |  22 +-
 security/security.c                        |   9 +-
 security/selinux/hooks.c                   |   8 +-
 security/smack/smack_lsm.c                 |   9 +-
 security/tomoyo/tomoyo.c                   |  12 +-
 tools/testing/selftests/exec/Makefile      |   1 +
 tools/testing/selftests/exec/binfmt_script | 171 +++++++++++++++
 27 files changed, 503 insertions(+), 388 deletions(-)


Eric

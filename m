Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA488C38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF7021D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h47hddgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgDQOFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:05:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730832AbgDQOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587132293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jzl14S/tVGzQ32rarxG1WpSRn0vKq6/LsU3dsOiZ0hs=;
        b=h47hddgyBD/d5yAgo5SyuO2Jtye/+3Rt1V0kxfLeNE2QEgEdt4REo/82cOBRwcIMzVAo4W
        n3A3dEopkhU+wTumWPUDQRLUr8iLugLC4gYbObbapzc7GF1+IaF4zSsOw7EM6Wy1t2PGmF
        BD+eRinrr2WUos4BZVHOQvo/y31NxSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-D2ilogYQPbCltZ7fQKFYdw-1; Fri, 17 Apr 2020 10:04:46 -0400
X-MC-Unique: D2ilogYQPbCltZ7fQKFYdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF952801A00;
        Fri, 17 Apr 2020 14:04:44 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 417B65C1C5;
        Fri, 17 Apr 2020 14:04:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2 0/9] livepatch,module: Remove .klp.arch and module_disable_ro()
Date:   Fri, 17 Apr 2020 09:04:25 -0500
Message-Id: <cover.1587131959.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- add vmlinux.ko check [peterz]
- remove 'klp_object' forward declaration [mbenes]
- use text_mutex [jeyu]
- fix documentation TOC [jeyu]
- fix s390 issues [mbenes]
- upstream kpatch-build now supports this
  (though it's only enabled for Linux >=3D 5.8)

These patches add simplifications and improvements for some issues Peter
found six months ago, as part of his non-writable text code (W^X)
cleanups.

Highlights:

- Remove the livepatch arch-specific .klp.arch sections, which were used
  to do paravirt patching and alternatives patching for livepatch
  replacement code.

- Add support for jump labels in patched code.

- Remove the last module_disable_ro() usage.

For more background, see this thread:

  https://lkml.kernel.org/r/20191021135312.jbbxsuipxldocdjk@treble

I've tested this with a modified kpatch-build:

  https://github.com/jpoimboe/kpatch/tree/no-klp-arch

(I'm planning to submit a github PR for kpatch-build, once I get
 the updated unit/integration tests sorted out.



Josh Poimboeuf (6):
  livepatch: Disallow vmlinux.ko
  livepatch: Apply vmlinux-specific KLP relocations early
  livepatch: Prevent module-specific KLP rela sections from referencing
    vmlinux symbols
  s390: Change s390_kernel_write() return type to match memcpy()
  livepatch: Remove module_disable_ro() usage
  module: Remove module_disable_ro()

Peter Zijlstra (3):
  livepatch: Remove .klp.arch
  s390/module: Use s390_kernel_write() for late relocations
  x86/module: Use text_poke() for late relocations

 Documentation/livepatch/module-elf-format.rst |  15 +-
 arch/s390/include/asm/uaccess.h               |   2 +-
 arch/s390/kernel/module.c                     | 125 ++++++++++------
 arch/s390/mm/maccess.c                        |   9 +-
 arch/um/kernel/um_arch.c                      |  16 +++
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/livepatch.c                   |  53 -------
 arch/x86/kernel/module.c                      |  43 +++++-
 include/linux/livepatch.h                     |  17 ++-
 include/linux/module.h                        |   2 -
 kernel/livepatch/core.c                       | 133 +++++++++++-------
 kernel/module.c                               |  22 +--
 12 files changed, 243 insertions(+), 195 deletions(-)
 delete mode 100644 arch/x86/kernel/livepatch.c

--=20
2.21.1


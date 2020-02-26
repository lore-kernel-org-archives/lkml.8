Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB299C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C87524656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PN+tIYgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBZLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:53:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgBZLxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:53:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDj96Prnz9txV7;
        Wed, 26 Feb 2020 12:53:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PN+tIYgh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Dn2Kw7Dwbv3M; Wed, 26 Feb 2020 12:53:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDj95LDxz9txV6;
        Wed, 26 Feb 2020 12:53:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718029; bh=2s3YW0KML+/xUiP0hXm8pjV+lTatUYv8hk+kjqlee7c=;
        h=From:Subject:To:Cc:Date:From;
        b=PN+tIYgh2EfrPUsyBeEK92x6rU91LrsbrJSJDduw11YlAFrrwnk3mZFWwHtAsj8PL
         +vs1iYPR47BnnfuZHXmKzGOf0Sj/OpvlW+/HuEMaTJclqpOFG+LJeeQmGmlP/+cESQ
         CfJstVi+jTqWBmAQuVh5OU/n2aUoosMBXtEGxdZk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0F398B846;
        Wed, 26 Feb 2020 12:53:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SMJGUkULozTv; Wed, 26 Feb 2020 12:53:50 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1E778B776;
        Wed, 26 Feb 2020 12:53:50 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 708A265400; Wed, 26 Feb 2020 11:53:50 +0000 (UTC)
Message-Id: <cover.1582717645.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 00/13] Reduce ifdef mess in ptrace
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 26 Feb 2020 11:53:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to reduce the amount of #ifdefs
in ptrace.c

Link: https://github.com/linuxppc/issues/issues/128

Tentatively build checked on kisskb allthough kisskb seems overloaded and failing to complete the tests.
See http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/ff12a199b21e80584096a72665023d212499accd/

v3:
- Droped part of #ifdef removals iaw mpe's comments
- Removed unneccesary includes

v2:
- Fixed several build failures. Now builts cleanly on kisskb, see http://kisskb.ellerman.id.au/kisskb/head/840e53cf913d6096dd60181a085f102c85d6e526/
- Droped last patch which is not related to ptrace and can be applies independently.

Christophe Leroy (13):
  powerpc: move ptrace into a subdirectory.
  powerpc/ptrace: remove unused header includes
  powerpc/ptrace: drop unnecessary #ifdefs CONFIG_PPC64
  powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
  powerpc/ptrace: split out VSX related functions.
  powerpc/ptrace: split out ALTIVEC related functions.
  powerpc/ptrace: split out SPE related functions.
  powerpc/ptrace: split out TRANSACTIONAL_MEM related functions.
  powerpc/ptrace: move register viewing functions out of ptrace.c
  powerpc/ptrace: split out ADV_DEBUG_REGS related functions.
  powerpc/ptrace: create ptrace_get_debugreg()
  powerpc/ptrace: create ppc_gethwdinfo()
  powerpc/ptrace: move ptrace_triggered() into hw_breakpoint.c

 arch/powerpc/include/asm/ptrace.h           |    2 +
 arch/powerpc/kernel/Makefile                |    7 +-
 arch/powerpc/kernel/hw_breakpoint.c         |   16 +
 arch/powerpc/kernel/ptrace.c                | 3468 -------------------
 arch/powerpc/kernel/ptrace/Makefile         |   20 +
 arch/powerpc/kernel/ptrace/ptrace-adv.c     |  492 +++
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  126 +
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  184 +
 arch/powerpc/kernel/ptrace/ptrace-noadv.c   |  269 ++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   57 +
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |   66 +
 arch/powerpc/kernel/ptrace/ptrace-tm.c      |  851 +++++
 arch/powerpc/kernel/ptrace/ptrace-view.c    |  904 +++++
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  151 +
 arch/powerpc/kernel/ptrace/ptrace.c         |  480 +++
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c |   11 -
 16 files changed, 3621 insertions(+), 3483 deletions(-)
 delete mode 100644 arch/powerpc/kernel/ptrace.c
 create mode 100644 arch/powerpc/kernel/ptrace/Makefile
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-adv.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-altivec.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-decl.h
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-noadv.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-novsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-spe.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-tm.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-view.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-vsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace.c
 rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (96%)

-- 
2.25.0


Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74CCC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741E6206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2C6OCux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCLRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:30:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726194AbgCLRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3R2Gqj26CcpZZ/eyppvbqet2wzOeK+LC4RTK9uEl04I=;
        b=F2C6OCuxD8tX8FdtRyfqDPEYZqJfpU2VzV312ux160TGfM1Ei38QVbqRBWaQ9xeeDX63Cp
        c8ksBHV4RLQJjL/tEm3micviIN7AzrcbaS6Jtjttu3LRmB72kHA/TyBfasdR95R5q8yIYo
        FiibXbnVowWSMHPOZjNvuUv37G3VArY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-fi-tcavTNiqQ7jN_0gUoaw-1; Thu, 12 Mar 2020 13:30:52 -0400
X-MC-Unique: fi-tcavTNiqQ7jN_0gUoaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F56710BEC26;
        Thu, 12 Mar 2020 17:30:50 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0CD60BEC;
        Thu, 12 Mar 2020 17:30:48 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/14] x86/unwind/orc: ORC fixes
Date:   Thu, 12 Mar 2020 12:30:19 -0500
Message-Id: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several ORC unwinder cleanups, fixes, and debug improvements.

Jann Horn (1):
  x86/entry/64: Fix unwind hints in rewind_stack_do_exit()

Josh Poimboeuf (12):
  x86/dumpstack: Add SHOW_REGS_IRET mode
  objtool: Fix stack offset tracking for indirect CFAs
  x86/entry/64: Fix unwind hints in register clearing code
  x86/entry/64: Fix unwind hints in kernel exit path
  x86/entry/64: Fix unwind hints in __switch_to_asm()
  x86/unwind/orc: Convert global variables to static
  x86/unwind: Prevent false warnings for non-current tasks
  x86/unwind/orc: Prevent unwinding before ORC initialization
  x86/unwind/orc: Fix error path for bad ORC entry type
  x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
  x86/unwind/orc: Add more unwinder warnings
  x86/unwind/orc: Add 'unwind_debug' cmdline option

Miroslav Benes (1):
  x86/unwind/orc: Don't skip the first frame for inactive tasks

 .../admin-guide/kernel-parameters.txt         |   6 +
 arch/x86/entry/calling.h                      |  40 ++--
 arch/x86/entry/entry_64.S                     |  14 +-
 arch/x86/include/asm/kdebug.h                 |   1 +
 arch/x86/include/asm/unwind.h                 |   2 +-
 arch/x86/kernel/dumpstack.c                   |  27 +--
 arch/x86/kernel/dumpstack_64.c                |   3 +-
 arch/x86/kernel/process_64.c                  |   7 +-
 arch/x86/kernel/unwind_frame.c                |   3 +
 arch/x86/kernel/unwind_orc.c                  | 185 ++++++++++++++----
 tools/objtool/check.c                         |   2 +-
 11 files changed, 201 insertions(+), 89 deletions(-)

--=20
2.21.1


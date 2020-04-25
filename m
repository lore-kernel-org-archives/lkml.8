Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E4C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B34520714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH68DJtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDYKD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726035AbgDYKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qOCa5O/JBWzIhQkLQAB3sV0bF/koEEFyGjb42S2sN2M=;
        b=ZH68DJtStI9fYuK37X/Q97eSe65J36sxPwVq6B0F7FC9GIYppKuuzGMyxfxH9F9X4UrKPq
        Au8meXFrribg8W2wFBOHUneYfTRaDjVFEdvqyzg0C86halUGEzFrFVptfT8G16qtBmDwD4
        Of4il9Y2mxRio8a8TNQhYQw5pZFyOdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-L5kzyss9MKqSTGXxEOp1_w-1; Sat, 25 Apr 2020 06:03:20 -0400
X-MC-Unique: L5kzyss9MKqSTGXxEOp1_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E61D107ACCD;
        Sat, 25 Apr 2020 10:03:19 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDC376061E;
        Sat, 25 Apr 2020 10:03:17 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/11] ORC fixes
Date:   Sat, 25 Apr 2020 05:02:59 -0500
Message-Id: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Dropped three patches which technically weren't fixes.  Will post them
  later as part of another patch set with more improvements.
- Removed show_iret_regs() declaration [mbenes]
- Added Miroslav Reviewed-by, Linus Reported-by

v1 was here:
https://lkml.kernel.org/r/cover.1584033751.git.jpoimboe@redhat.com

Jann Horn (1):
  x86/entry/64: Fix unwind hints in rewind_stack_do_exit()

Josh Poimboeuf (9):
  objtool: Fix stack offset tracking for indirect CFAs
  x86/entry/64: Fix unwind hints in register clearing code
  x86/entry/64: Fix unwind hints in kernel exit path
  x86/entry/64: Fix unwind hints in __switch_to_asm()
  x86/unwind/orc: Convert global variables to static
  x86/unwind: Prevent false warnings for non-current tasks
  x86/unwind/orc: Prevent unwinding before ORC initialization
  x86/unwind/orc: Fix error path for bad ORC entry type
  x86/unwind/orc: Fix premature unwind stoppage due to IRET frames

Miroslav Benes (1):
  x86/unwind/orc: Don't skip the first frame for inactive tasks

 arch/x86/entry/calling.h       |  40 ++++++------
 arch/x86/entry/entry_64.S      |  14 ++---
 arch/x86/include/asm/unwind.h  |   2 +-
 arch/x86/kernel/dumpstack_64.c |   3 +-
 arch/x86/kernel/unwind_frame.c |   3 +
 arch/x86/kernel/unwind_orc.c   | 111 ++++++++++++++++++++++-----------
 tools/objtool/check.c          |   2 +-
 7 files changed, 108 insertions(+), 67 deletions(-)

--=20
2.21.1


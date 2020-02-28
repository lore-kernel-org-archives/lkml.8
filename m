Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_XPILL,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EC8246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898430;
	bh=kdqYWUgWFBMMFrElriRCiZY+9upnYZqSJXt10ZrQ58k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hM4CaW4dgkWh38wU1+201Zaq8+/qTp9TeiBrW34Rr5RNfXc8kFAk2n0a9mrGfD9nO
	 iV7Hyqwq+n78rt6ep+WsqdoRIIYbItvaTZRIbSURBsoHuzwkK4CUiBgzA5NnJpq5R8
	 0LL/3HeePWDUS8nQ59PuPD0tnYzcoiPYlfQu6XqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgB1OA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgB1OA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E49246B2;
        Fri, 28 Feb 2020 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898428;
        bh=kdqYWUgWFBMMFrElriRCiZY+9upnYZqSJXt10ZrQ58k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WpGN1V4V3rVhDsrVUZ3BttYodc6njysuyGLLFh8o2XRMsoBLu/+tzjOWl4bQmtVc
         0dXsAJ9QI5z1tGHurHKNWF0UfgtXlfVYYP9kquscLUR+/NxuuXEODFuQKT38BvcC9H
         6zFkzpz/tUSiq4ozLGPI2SfcVF9a7QGhCTfOLy0E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 02/15] tools headers UAPI: Update tools's copy of kvm.h headers
Date:   Fri, 28 Feb 2020 11:00:01 -0300
Message-Id: <20200228140014.1236-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

No change in tooling ensues, just the x86 kvm tooling gets rebuilt as
those headers are included in its build:

  $ cp arch/x86/include/uapi/asm/kvm.h tools/arch/x86/include/uapi/asm/kvm.h
  $ make -C tools/perf
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j12' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  <SNIP>
  ...        disassembler-four-args: [ on  ]

    DESCEND  plugins
    CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  <SNIP>
    LD       /tmp/build/perf/arch/x86/util/perf-in.o
    LD       /tmp/build/perf/arch/x86/perf-in.o
    LD       /tmp/build/perf/arch/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf
  <SNIP>
  $

As it doesn't seem to be used there:

  $ grep STATE tools/perf/arch/x86/util/kvm-stat.c
  $

And the 'perf trace' beautifier table generator isn't interested in
these things:

  $ grep regex= tools/perf/trace/beauty/kvm_ioctl.sh
  regex='^#[[:space:]]*define[[:space:]]+KVM_(\w+)[[:space:]]+_IO[RW]*\([[:space:]]*KVMIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 503d3f42da16..3f3f780c8c65 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -390,6 +390,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
+#define KVM_STATE_NESTED_MTF_PENDING	0x00000008
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
-- 
2.21.1


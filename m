Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B48C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5AA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry6ixK9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCQNIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:08:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53042 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgCQNIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584450534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4vUj2Br24aWbt0Dfmp9kIalpxRUydFyy+kQ8WN3rD0M=;
        b=Ry6ixK9+deWGeGuxdBiG8kMXz078liOs5mVMrTAsgZuJvA9JD44aL3jBeJx458rE1ZSb+J
        GeaR18wATAkKcKfmbA6/m+RKUP6Xay/HygboLnpMoPwo8Bn7hltv8HFSzyjWuBHevSa+2y
        oMRPsN1yarq5r/2JR3UCvUJZzIK98fU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-7LRlzu93P4S34VA6bZzFug-1; Tue, 17 Mar 2020 09:08:48 -0400
X-MC-Unique: 7LRlzu93P4S34VA6bZzFug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E3B100550D;
        Tue, 17 Mar 2020 13:08:47 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-115-120.ams2.redhat.com [10.36.115.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB505DE54;
        Tue, 17 Mar 2020 13:08:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 1/2] x86/purgatory: Disable various profiling and sanitizing options
Date:   Tue, 17 Mar 2020 14:08:40 +0100
Message-Id: <20200317130841.290418-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the purgatory is a special stand-alone binary, various profiling
and sanitizing options must be disabled. Having these options enabled
typically will cause dependencies on various special symbols exported by
special libs / stubs used by these frameworks. Since the purgatory is
special, it is not linked against these stubs causing missing symbols in
the purgatory if these options are not disabled.

Sync the set of disabled profiling and sanitizing options with that from
drivers/firmware/efi/libstub/Makefile, adding
-DDISABLE_BRANCH_PROFILING to the CFLAGS and setting:

GCOV_PROFILE                    :=3D n
UBSAN_SANITIZE                  :=3D n

This fixes broken references to ftrace_likely_update when
CONFIG_TRACE_BRANCH_PROFILING is enabled and to __gcov_init and
__gcov_exit when CONFIG_GCOV_KERNEL is enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- Improve commit message wording
- Rebase on top of tip/master

Changes in v5:
- Not only add -DDISABLE_BRANCH_PROFILING to the CFLAGS but also set:
  GCOV_PROFILE                    :=3D n
  UBSAN_SANITIZE                  :=3D n

Changes in v4:
- This is a new patch in v4 of this series
---
 arch/x86/purgatory/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 69379bce9574..5313dd7314fe 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,9 +17,11 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
 LDFLAGS_purgatory.ro :=3D -e purgatory_start -r --no-undefined -nostdlib=
 -z nodefaultlib
 targets +=3D purgatory.ro
=20
-# Sanitizer runtimes are unavailable and cannot be linked here.
+# Sanitizer, etc. runtimes are unavailable and cannot be linked here.
+GCOV_PROFILE	:=3D n
 KASAN_SANITIZE	:=3D n
 KCSAN_SANITIZE	:=3D n
+UBSAN_SANITIZE	:=3D n
 KCOV_INSTRUMENT :=3D n
=20
 # These are adjustments to the compiler flags used for objects that
@@ -27,7 +29,7 @@ KCOV_INSTRUMENT :=3D n
=20
 PURGATORY_CFLAGS_REMOVE :=3D -mcmodel=3Dkernel
 PURGATORY_CFLAGS :=3D -mcmodel=3Dlarge -ffreestanding -fno-zero-initiali=
zed-in-bss
-PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN)
+PURGATORY_CFLAGS +=3D $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFI=
LING
=20
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. =
That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and=
 not
--=20
2.24.1


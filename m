Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2AFC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF032071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbY2UcoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCLLt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgCLLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584013797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBKUW7xvv5dSLBpQf4v1o9UnoSywyHIpkeGrSd1TMC8=;
        b=QbY2UcoFWRaJfWV6ooWVdNBFu37GkQKac0ZfuTB36fMeM+ff8UavusLZIa8Izd11aAqV2D
        aFZb/YNxFah36w7jpWFFqWlI2BLamUM6zIyyKLCVLNcDKpTi20FLLBoZ/7fC597QHhAp1U
        bn4An0KlgUQjgv5c3zNXHzpljUIWVFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-SElKE9czNXKcwZ7OPg-ZBw-1; Thu, 12 Mar 2020 07:49:55 -0400
X-MC-Unique: SElKE9czNXKcwZ7OPg-ZBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E858017CC;
        Thu, 12 Mar 2020 11:49:54 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5ABF9182F;
        Thu, 12 Mar 2020 11:49:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] x86/purgatory: Disable various profiling and sanitizing options
Date:   Thu, 12 Mar 2020 12:49:50 +0100
Message-Id: <20200312114951.56009-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the purgatory is a special stand-alone binary, we need to disable
various profiling and sanitizing options. Having these options enabled
typically will cause dependency on various special symbols exported by
special libs / stubs used by these frameworks. Since the purgatory is
special we do not link against these stubs causing missing symbols in
the purgatory if we do not disable these options.

This commit syncs the set of disabled profiling and sanitizing options
with that from drivers/firmware/efi/libstub/Makefile, adding
-DDISABLE_BRANCH_PROFILING to the CFLAGS and setting:

GCOV_PROFILE                    :=3D n
UBSAN_SANITIZE                  :=3D n

This fixes broken references to ftrace_likely_update when
CONFIG_TRACE_BRANCH_PROFILING is enabled and to __gcov_init and
__gcov_exit when CONFIG_GCOV_KERNEL is enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
-Not only add -DDISABLE_BRANCH_PROFILING to the CFLAGS but also set:
 GCOV_PROFILE                    :=3D n
 UBSAN_SANITIZE                  :=3D n

Changes in v4:
-This is a new patch in v4 of this series
---
 arch/x86/purgatory/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..4a35b9b94cb5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,7 +17,9 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
 LDFLAGS_purgatory.ro :=3D -e purgatory_start -r --no-undefined -nostdlib=
 -z nodefaultlib
 targets +=3D purgatory.ro
=20
+GCOV_PROFILE	:=3D n
 KASAN_SANITIZE	:=3D n
+UBSAN_SANITIZE	:=3D n
 KCOV_INSTRUMENT :=3D n
=20
 # These are adjustments to the compiler flags used for objects that
@@ -25,7 +27,7 @@ KCOV_INSTRUMENT :=3D n
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
2.25.1


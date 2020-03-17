Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC5C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944E420752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU8pJI0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCQNI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:08:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33135 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgCQNIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584450534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZ6+c2hf9/AurpPzGt9JVIn3k3cOytjVHvVkgGFswbI=;
        b=EU8pJI0ylz2sEYHaw5G05nX1LVObWeTRiUBdccCwqYFn2SyWo+k/ZhwUPZDlBUY8KPbX3i
        Af6JWKJs3thU1P9VPfTnAKchF0FQ4Hs0c15tj1K3yzdJTTSmv0dZpqJD2YQoxE+tRAcOpE
        mvHqg/lP8zmtEK1KYBkulADqxqRMqxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-Embl4HBDNCyVnGD_4lM3AA-1; Tue, 17 Mar 2020 09:08:50 -0400
X-MC-Unique: Embl4HBDNCyVnGD_4lM3AA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE2F189D6C0;
        Tue, 17 Mar 2020 13:08:49 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-115-120.ams2.redhat.com [10.36.115.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D395DE54;
        Tue, 17 Mar 2020 13:08:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 2/2] x86/purgatory: Make sure we fail the build if purgatory.ro has missing symbols
Date:   Tue, 17 Mar 2020 14:08:41 +0100
Message-Id: <20200317130841.290418-2-hdegoede@redhat.com>
In-Reply-To: <20200317130841.290418-1-hdegoede@redhat.com>
References: <20200317130841.290418-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking purgatory.ro with -r enables "incremental linking" this means
no checks for unresolved symbols are done while linking purgatory.ro.

A change to the sha256 code has caused the purgatory in 5.4-rc1 to have
a missing symbol on memzero_explicit, yet things still happily build.

Add an extra check for unresolved symbols by calling ld without -r before
running bin2c to generate kexec-purgatory.c.

This causes a build of 5.4-rc1 with this patch added to fail as it should=
:

  CHK     arch/x86/purgatory/purgatory.ro
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
make[2]: *** [arch/x86/purgatory/Makefile:72:
    arch/x86/purgatory/kexec-purgatory.c] Error 1
make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
make: *** [Makefile:1650: arch/x86] Error 2

Also remove --no-undefined from LDFLAGS_purgatory.ro as that has
no effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- Improve commit message wording
- Rebase on top of tip/master
---
 arch/x86/purgatory/.gitignore |  1 +
 arch/x86/purgatory/Makefile   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/purgatory/.gitignore

diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignor=
e
new file mode 100644
index 000000000000..d2be1500671d
--- /dev/null
+++ b/arch/x86/purgatory/.gitignore
@@ -0,0 +1 @@
+purgatory.chk
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 5313dd7314fe..679d7dd3024a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,8 +14,12 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
=20
 CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
=20
-LDFLAGS_purgatory.ro :=3D -e purgatory_start -r --no-undefined -nostdlib=
 -z nodefaultlib
-targets +=3D purgatory.ro
+# When linking purgatory.ro with -r unresolved symbols are not checked,
+# also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
+PURGATORY_LDFLAGS :=3D -e purgatory_start -nostdlib -z nodefaultlib
+LDFLAGS_purgatory.ro :=3D -r $(PURGATORY_LDFLAGS)
+LDFLAGS_purgatory.chk :=3D $(PURGATORY_LDFLAGS)
+targets +=3D purgatory.ro purgatory.chk
=20
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
 GCOV_PROFILE	:=3D n
@@ -62,12 +66,15 @@ CFLAGS_string.o			+=3D $(PURGATORY_CFLAGS)
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
=20
+$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
+		$(call if_changed,ld)
+
 targets +=3D kexec-purgatory.c
=20
 quiet_cmd_bin2c =3D BIN2C   $@
       cmd_bin2c =3D $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
=20
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
=20
 obj-$(CONFIG_KEXEC_FILE)	+=3D kexec-purgatory.o
--=20
2.24.1


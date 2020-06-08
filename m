Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8375C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947062076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRpx0Tma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgFHP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730228AbgFHP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XmB9dtJu++KVpOBk6iZgjeuWMZ0//aiEGYwXB9eRqM=;
        b=DRpx0Tma3OuSunO8JInFI79X1r7aGhIkeWujA4oadjLShaxV5qfeaC3F+P04T5MhYyPWlX
        yQlH4kT8Prd0yfTYhT4Hqucyb1SLpzv9Su03YJ5uvoa3l3V1lfkBcnZG3i6dfDREq2aI5g
        ZTlEXv+GU5NJ9tEAfSCHi2xhSyvEMqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-zvAoXYcENVKXKqogWTDuBQ-1; Mon, 08 Jun 2020 11:28:00 -0400
X-MC-Unique: zvAoXYcENVKXKqogWTDuBQ-1
Received: by mail-wr1-f70.google.com with SMTP id t5so7286181wro.20
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XmB9dtJu++KVpOBk6iZgjeuWMZ0//aiEGYwXB9eRqM=;
        b=jSV1ha/KcGhTowarffNn9kF0QfgyTHraXqykbJUW183x8wRrKJYT6XKJHpTWopgVDZ
         oEneLvcBUHmeVyexK61hy2XcBRe9XaGM5AtUA2E2V+k8hkGVVnfJQz2VyqxvenoIrOJI
         4Dxu7kdjfHDKddqIbSDMSpoIiupxFz6Wc56nZZJf2GflRpclflsoU7mRV58ysypr/pJY
         zjo7l5Ayamh/WlMVpLJTdvYncvaDnPPwVoFEXrbIARFwaPQ0+en6OHZ7BuDvYBvFkcF8
         lObbplP3bAogHBofmAkYW+LK2ICyKwY/UzbjwY7OnTbXVATBJ84viqxdiUVMynaEnwx0
         HdeA==
X-Gm-Message-State: AOAM532pyo3oHeG7O4jCJDUNeWpogAHtRErrABsTXI8W3pxWcEsXuYCr
        9c5WUcKQNHIaUPmWl1y8PxqV9tuIoiKXu50wlGcCUwU1TMqYaGdFc2cS46rOs6P+lu04oevlzN2
        vWX90Ee/9kNICm6AVU/QpjYSA
X-Received: by 2002:a1c:998c:: with SMTP id b134mr17814682wme.78.1591630079537;
        Mon, 08 Jun 2020 08:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHXNzORKTd0v3kaj8su5+gmOSW20lAFHTxkmsHP3RKhTFVsUnh1rD56J/NEFRcPZA6kSdrbA==
X-Received: by 2002:a1c:998c:: with SMTP id b134mr17814670wme.78.1591630079357;
        Mon, 08 Jun 2020 08:27:59 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:27:58 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 2/7] objtool: Make sync-check consider the target architecture
Date:   Mon,  8 Jun 2020 16:27:49 +0100
Message-Id: <20200608152754.2483-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not take into account outdated headers unrelated to the build of the
current architecture.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile      | 2 +-
 tools/objtool/sync-check.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..614b87278260 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -60,7 +60,7 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
-	@$(CONFIG_SHELL) ./sync-check.sh
+	@$(CONFIG_SHELL) ./sync-check.sh $(SRCARCH)
 	@$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 13e4fca28015..f01b5a4d12ac 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+TARGET_ARCH=$1
+
+if [ "$TARGET_ARCH" == "x86" ]; then
 FILES="
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
@@ -12,6 +15,7 @@ arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
 arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
 arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+fi
 
 check_2 () {
   file1=$1
-- 
2.21.1


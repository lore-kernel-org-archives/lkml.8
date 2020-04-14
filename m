Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F029DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58C20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 01:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="stA0CpFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390740AbgDNBVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 21:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDNBVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 21:21:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961FC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 18:21:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so8868209qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucg4luoxBe5p5/9cUQj1RfBcJ3voR9LqlqIX5ioc/8o=;
        b=stA0CpFPzED8+cDmFDlFOPUc9NOX+a+UVO1kgT140a7AuOQYxHz7mttPD82mqFuEwq
         W6S8EKZqQIcIz7gfWoLTX5HQL7saCVNRntogBQD+C/1AVTlxYLmT0ZBLzeinkr5a6qCV
         sUhjkUmFi/hCVurWWSuId2T8rZesUg9lce+xk21coIwuFzF7FiH6svj7C45L2kmkfSQM
         dw8Eo1+or04uZukAobNvXInrGC8xprR+ScPVIwaI6PkvhHo1j62yxQLJ6rt6nVmBqeFM
         R8o0PM0fdOiOw6dgRa9brPEw0U5ZK9zu1C4otfg/4MSSerAj1zvvRc6XvPjVhV6l/V1C
         HFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucg4luoxBe5p5/9cUQj1RfBcJ3voR9LqlqIX5ioc/8o=;
        b=UzLMSKpJkEnT+K5urUnmPXoB5IJlbq2bGH0jPkuTBmj3BBQpBvbVBQqcx4/iPlsSGW
         uUoBbiw9US555zHAk9MS0+9A5u0E5Yju52pMOe7cmXLnxCQJJyOMZrM17yHHUNh7Dtps
         49H+a3i92Pz6HboTzRvdQmXm2WAzw1TetrreyVlg9OeVmLI3bQvU148KQB/jZ8/B5i57
         /0oP4yKeXFQzCNIkhIba61Lo+s7cU1pAAA3WVLW0t55r1j8vSOp5YQOP2FUPKpIpIvjt
         6fOxH5Blx1DukIYdCQiRd08TUrDhNFs5bIqkWbSvMNQuV1dRQ/4Ll5CA5Xg6fu0JaJjX
         xp6g==
X-Gm-Message-State: AGi0PuY0ZUqs6bMkch3ZpHyUW/R5ex2uJibO79EjHntRL5bS81SotAVt
        JNuZDSyyFuQpA29G1jEJOdObWA==
X-Google-Smtp-Source: APiQypKUMU9nNqLUSqQ6nEaJqBlYNc1SVRRFUNeid6/LPY7Ts/1eHVhK+OYeZuZdmAr1ZMHR5h92vw==
X-Received: by 2002:ac8:370c:: with SMTP id o12mr13960452qtb.380.1586827298833;
        Mon, 13 Apr 2020 18:21:38 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id b13sm6380638qka.20.2020.04.13.18.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 18:21:38 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Subject: [PATCH v2] kbuild: ensure mrproper removes arch/$(SUBARCH)/include/generated/
Date:   Mon, 13 Apr 2020 22:21:32 -0300
Message-Id: <20200414012132.32721-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following use case, when compiling the kernel for the UML
architecture, for example:

 * `make ARCH=um defconfig && make ARCH=um -j8`,

SUBARCH files are generated, however when we run the command:

 * `mrproper ARCH=um`

the files `arch/$(SUBARCH)/include/generated/ aren't cleaned up.

This generates compilation errors by running the following command:

 * `make ARCH=um defconfig O=./build_um && make ARCH=um -j8 O=./build_um`

This PATCH fix that problem.

This makes it possible to compile on different architectures that use the
SUBARCH variable, in different build directories and root directory of the
linux directory. This is important because we can compile without the object
files being overwritten. This reduces the re-compilation time in this use case.

Besides that, in the workflow of developing unit tests, using kunit, and
compiling in different architectures to develop or test a PATCH, this use case
applies.

 * This bug was introduced in this commit a788b2ed81abe

 * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
v2:
 * Explains what this PATCH does and the importance as suggested
   by Brendan Higgins.
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 70def4907036..e1a79796032e 100644
--- a/Makefile
+++ b/Makefile
@@ -532,7 +532,8 @@ outputmakefile:
 ifdef building_out_of_srctree
 	$(Q)if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
-		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
+		 -d $(srctree)/arch/$(SRCARCH)/include/generated -o \
+		 -d $(srctree)/arch/$(SUBARCH)/include/generated ]; then \
 		echo >&2 "***"; \
 		echo >&2 "*** The source tree is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
 		echo >&2 "*** in $(abs_srctree)";\
@@ -1388,6 +1389,7 @@ CLEAN_FILES += modules.builtin modules.builtin.modinfo modules.nsdeps
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
+		  arch/$(SUBARCH)/include/generated \
 		  debian/ snap/ tar-install/
 MRPROPER_FILES += .config .config.old .version \
 		  Module.symvers \
-- 
2.25.1


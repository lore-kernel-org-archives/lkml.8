Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC1B2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uignxrhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHJP7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgHJP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:59:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77222C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:59:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a65so7648493otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5putFXdjtBiiOZjaW1jRRPwgbKFumMUrDaAe/TfxPY=;
        b=uignxrhsl7YqL25IJPzaeQXCoDgqMrVG9f+CPe4/oYGjkrjCNccX9cxo55Q0FIZqWi
         r8H6U36L0yuC4+zpiRiy3XA5NfVlOFKrYHhF4j4kmUwG+sgpKCzCainG9M60wqFgqvY3
         KGAVS9udnWAAByIIrLA00VkzjQqhgPzcPjx5g5gK9ZrPn5KinNo09hTEoqMjj9qiuNML
         YQysgdbWXfuSxDGdalQBVaYHSGYv397P3GBgXS51nuycnaAdxk/GDhsaducV9ZGj8NDM
         ITxDUHMWnQFCKU+C0jbGmdkrvgmseHh+dsXYa86kyIMcmMaDzX3R4vKb6lb3LOOf/jn+
         e9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5putFXdjtBiiOZjaW1jRRPwgbKFumMUrDaAe/TfxPY=;
        b=NFAuc9EnbQvSJ+LQwXvNaPX2DJDrRdMMlSJk9KYmcSAtdoSZh1hGW2xfmswsyr3xgu
         QUndo+kMr/i9Rbr490dFgB1Ksx5D2L5Jhj2wAkG4Qv0juji10F7Kj/CB/u+JCRgIyaTY
         TbECjIzCJnjo1+HOOxIqEbkc3F/aagu3lXIhsC91Us8WS1aj9jzVQWQbA+hTyUT2IsKx
         f2qE0ApAC5lKSOxyUeyYKNCqtIvCez8coFwiBIvQYTXOq8deQ10gBP0RMvRhYUx8fau7
         3iL26MWsE9eAzB0A9IQ2mAli1LLAsNehisRPm94Vk62jNtG9HiPN6YedJ5M0vf3QuOs1
         xP/A==
X-Gm-Message-State: AOAM532bAW0UtMQ3BunG3sz7/1lnNPenUUKjkDnbDw15JyFWNH6vGfAj
        dNC8Kt6gFV9OfhIdNOGXh0j3Q3LkMuQ=
X-Google-Smtp-Source: ABdhPJxizqA1nqhjSNonj9MQPdozgl4Rzd9yzf+lOgCNtJSKtIDmVk23Zmm4rcGC2V5I3R9mdJmrlg==
X-Received: by 2002:a9d:12ce:: with SMTP id g72mr1317273otg.306.1597075193722;
        Mon, 10 Aug 2020 08:59:53 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-219-73-83.Hosts.InterCable.net. [189.219.73.83])
        by smtp.googlemail.com with ESMTPSA id h23sm970148otn.54.2020.08.10.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:59:53 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/defconfigs/32: Unset 64BIT
Date:   Mon, 10 Aug 2020 10:59:42 -0500
Message-Id: <20200810155943.2583275-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent refresh of the defconfigs got rid of the following
(unset) config:

  # CONFIG_64BIT is not set

Innocuous as it seems, when the config file is saved again the
behavior is changed so that CONFIG_64BIT=y.

Currently,

  $ make i386_defconfig
  $ grep CONFIG_64BIT .config
  CONFIG_64BIT=y

whereas previously (and with this patch now):

  $ make i386_defconfig
  $ grep CONFIG_64BIT .config
  # CONFIG_64BIT is not set

This was found with weird compiler errors on OpenEmbedded
builds, as the compiler was unable to cope with 64-bits data
types:

  NOTE: make -j1 bzImage CC=i686-linaro-linux-gcc  -fuse-ld=bfd -fdebug-prefix-map=/oe/build/tmp/work/intel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0=/usr/src/debug/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0 -fdebug-prefix-map=/oe/build/tmp/work/intel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0/recipe-sysroot= -fdebug-prefix-map=/oe/build/tmp/work/intel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0/recipe-sysroot-native=  -fdebug-prefix-map=/oe/build/tmp/work-shared/intel-core2-32/kernel-source=/usr/src/kernel -ffile-prefix-map=/oe/build/tmp/work/intel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0/git=/kernel-source/  LD=i686-linaro-linux-ld.bfd
    GEN     Makefile
    CC      scripts/mod/empty.o
  cc1: error: code model 'kernel' not supported in the 32 bit mode
  cc1: sorry, unimplemented: 64-bit mode not compiled in
  /oe/build/tmp/work-shared/intel-core2-32/kernel-source/scripts/Makefile.build:280: recipe for target 'scripts/mod/empty.o' failed
  make[2]: *** [scripts/mod/empty.o] Error 1
  /oe/build/tmp/work-shared/intel-core2-32/kernel-source/Makefile:1174: recipe for target 'prepare0' failed
  make[1]: *** [prepare0] Error 2
  /oe/build/tmp/work-shared/intel-core2-32/kernel-source/Makefile:185: recipe for target '__sub-make' failed
  make: *** [__sub-make] Error 2

Fixes: 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 arch/x86/configs/i386_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index d7577fece9eb..4cfdf5755ab5 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -19,6 +19,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+# CONFIG_64BIT is not set
 CONFIG_SMP=y
 CONFIG_X86_GENERIC=y
 CONFIG_HPET_TIMER=y
-- 
2.25.1


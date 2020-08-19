Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E54206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vou7XzxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHSRcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgHSRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:32:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:32:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x24so19706506otp.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qjauqKV3XM87srHEaNbTG1q73II8EoPOgmO5VtaQq8M=;
        b=Vou7XzxKHYK3tUipZdhe2Jtr8SaovEUcI2Jwgt9VWYMrAz/x4CP3grIELZXtAAe/J3
         7YzB8Yo89cKhFcn6I7PUW9ytF4nNRdp4LdZeHVnJ/ff/CH6Oys6H+Aq/SOFdS7S+TCIb
         h2joY2AmhtNj8oF7oMHP8rviCRP2PweBCVezW/dyr0RKWAMd5SzD4d1OMr6bX8fMasnf
         QOtNCNmMt3h8ZnTimgwSK8hGj5v7PLDGPR7fT+JG3wlzCVqkCjYpOJcbTrdKmw2+S5+a
         bMQpzlfpYEc50XbKRCYrnyRYbK83yhUct7aPNq2TzWcf1yJfLWy6uvXnZT0ien/U+BJ5
         DERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjauqKV3XM87srHEaNbTG1q73II8EoPOgmO5VtaQq8M=;
        b=GbaodmeWVdlpsvdU6xskNlLJnXZ4YB6kBacvhnimgsJDsnbGuXvmN3NcSFNPFzK0EN
         QXLrqQikdFdNv24BT+IYM+jCgDn64dgL6i89Wolzla0gkfXi0TGdsii6+ExC+c65kv7K
         dXGKvCRokPNydimWBokTL9v5+8c+XkhZTv6mBTzO/AoOuOseatf0VniGVvTXCCp8Jw3Q
         +Wx9PY26YjuAOF5dsEBZKDd7edaMYDGpiJ4t5VOUNe4KVaMbn0To65VF4DG6FVuB1vv+
         EKAIyvuxVkgnC3/TSHOEJwA1OajaV51zH9uWfeftnTk7iX2ZH5paLkiAT9dPO0OmlZYr
         Yj5Q==
X-Gm-Message-State: AOAM533PJq7lqzpnFMwW8N6EShL4L9+3W7qTlNnKi9h/Bntagf6yt5fF
        2KuS9gyqroTL+A9638VsBE0YwQ==
X-Google-Smtp-Source: ABdhPJymPZkNouyQs/pvkm9XMAX5loryQTi22kiAaNmODpZHXmaRiWwy/q6sJfXACAqkJBHpr1YCFw==
X-Received: by 2002:a9d:7656:: with SMTP id o22mr18116903otl.109.1597858366862;
        Wed, 19 Aug 2020 10:32:46 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-189-219-73-83.Hosts.InterCable.net. [189.219.73.83])
        by smtp.googlemail.com with ESMTPSA id n25sm4643929otf.64.2020.08.19.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:32:46 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2] x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig
Date:   Wed, 19 Aug 2020 12:32:24 -0500
Message-Id: <20200819173225.3821449-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810155943.2583275-1-daniel.diaz@linaro.org>
References: <20200810155943.2583275-1-daniel.diaz@linaro.org>
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

whereas previously (and with this patch):

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
v1 -> v2: Clarify subject

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


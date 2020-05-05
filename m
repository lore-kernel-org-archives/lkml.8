Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C70820675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgEEOM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:12:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEEOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:12:28 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPooP-1jjMYw3zMZ-00MqB8; Tue, 05 May 2020 16:12:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: use ARM unwinder for gcov
Date:   Tue,  5 May 2020 16:11:56 +0200
Message-Id: <20200505141218.684079-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xYF4bWF6ZBT8Pyevxjl7TuHwrRpMUeaWC2ade9WpKlAo8vN+BLm
 5NYEooCfRPujRggbxVIeOPf1it9oT34YwaSKvZLx4zh1Mfhw3zzT6Y67uyTAI7izRBYyIbH
 HDnX7Aqnx6wJdexU7I9d9IkEDRelLi3/xo1y/LZ7OWdkJM5ICcrjCfBLbnJlGHsK7Brk22w
 VPiIPtIVo3hVudvHHOilw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hcOUmx89Pao=:ORC3xGKBYI8iWGf6iU56dM
 IWOLCS5ZkjFI9dCrUtHFQ0k2f+Dmmy669ljCEwKvg6LHATZNCa0VuIDVwJL68A+PZJOyPq6A5
 iL3xXsjnCHos+K0gdqh3nKqTk8kEJFKIaFppmhvFP0X8nAc7bfF+lHSY0lMpt0ZuWSyQPBHNt
 2Mb5akhUSpSlSTnKRxq1xV1MojGzEwfqkgrGy/+NRkQlXQ5wIVQZCVgZy8R05Qov7Dwq4w8sx
 Uzc7zCt88Z4IT65oVp6DFa+4qiV9pUdX/ujF9/MejBiBfLEQJhlV2JBhFM/rtsGlXp1mYl40P
 emt1EMa1fDqmZK7RsNO4jvA3Gg9peIxDNCh0dhadFCvONg1nuiJtuhJewfODqrttyfz9/zv9H
 coH7/be7/rZv6D3CHB28sK11ZuuCBissstLRibs0umsQCszOJ6F68fOeRjMNkO0QlRWOIEBu4
 /FubQg6OALzjsjYfUPLBqk+Yn0oGfflvrK3oYVfPoEAk2IIIQ23av5eombjwyxHgWUSvXnYsm
 zi555iu0Qh4P/7/Und7k8uhh/X4by2ULb0WBfH+RD/qBmTy6eT9dSorUuPQXs+LsknoK5OB4C
 guO+1D6OugrO6LlrUzC43cYAekk5PG6bTsx/CeL5NL8KybRPlLGVRIiXaAlG8gSBio1n8RGtJ
 a427JdifUZ+xlWNLC7sBWH9/VPrwP6dw4EHRBL5ac8BdivGlhpydUZgXyrgOcna1FxugNUt1P
 ccde1FtN8fjo3qNX6E2zMbajPVDtHvdq1rAuduFNNgqGGQFAuGJR1V0B2z26w7pvmPg0oLhR9
 jcBnb2ONOBsE9XYMONjrPNuuB0c778z8iUZh8Og52BolAv0nig=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using gcov on ARM fails when the frame pointer unwinder is used:

arm-linux-gnueabi-ld: kernel/softirq.o:(.ARM.exidx+0x120): undefined reference to `__aeabi_unwind_cpp_pr0'
arm-linux-gnueabi-ld: init/main.o:(.ARM.exidx+0x98): undefined reference to `__aeabi_unwind_cpp_pr0'
arm-linux-gnueabi-ld: init/version.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
arm-linux-gnueabi-ld: init/do_mounts.o:(.ARM.exidx+0x28): undefined reference to `__aeabi_unwind_cpp_pr0'
arm-linux-gnueabi-ld: init/do_mounts_initrd.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
arm-linux-gnueabi-ld: init/initramfs.o:(.ARM.exidx+0x8): more undefined references to `__aeabi_unwind_cpp_pr0' follow

This is likely a bug in clang that should be fixed in the compiler.
Forcing the use of the ARM unwinder in this configuration however
works around the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a1dfb04231fd..41ef58acabf7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -56,7 +56,7 @@ choice
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
-	depends on !THUMB2_KERNEL
+	depends on !THUMB2_KERNEL && !(CC_IS_CLANG && GCOV_KERNEL)
 	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
-- 
2.26.0


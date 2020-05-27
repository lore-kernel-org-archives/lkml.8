Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC62078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbgE0NyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:54:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0NyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:54:12 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJm8H-1jKMLM2LCT-00K8Nw; Wed, 27 May 2020 15:53:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86: work around clang IAS bug referencing __force_order
Date:   Wed, 27 May 2020 15:53:19 +0200
Message-Id: <20200527135329.1172644-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lPqKd3ceKcOiWSf6k7n0RT4DN5BdzpvV9e/sXSasbhanLS+Oa8b
 zCfaDCYQCGPRsqQGnAq8IlMVatLfXkTtRhm+oZ9caPDHrTJjA28xSHP6uw7B7cbHoP+DUp2
 OtVtwLD2cSC0Lh2zT2hmfjFQZ7KcflKRXk++pbClkDFjbyAGo09nwQMeJLEUflpWaeQhwzs
 kFb0rHfkf/bj8PjONn4ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fwuCPC7PnkQ=:DL0TsWJH75aNmoZSVF1D5Q
 dq+b71QtO2Ax/M1aqBhd8xXm/oHYJdSt+YMBPcX83mfCr3VKdX5B7t9SdQzzpVF6bzcFm1vvv
 qUmO1MTs/90Szakgatu6YNZi8D6fOeo8QrbRNeVLjT2GJwa+rR7wi/8bkJaV7lF/uZ604GfIt
 o43mOSlA2z4VHItLnYb4nvlIAPc6DiwgMM91rue4RK6IUpnGDY7PToLoIF+X+Zc5eCxI0NT2I
 cmzeKREiMZEVWhXvxP5XamgDv6/3EaMiUBrEiy+hq+Q2a0PwTAeTq4KE+ld/181RunLOj8j4R
 /aOFL8r8p5TCEA6TwIaye45ypXXoEdR+YKXWTnj1D6c4+yW0zSbxbQiFfBoKtXeBm6Z8FTJEc
 d2lrSiJGzLuaD2rF/IZkkxj6bcsDTNz0IsAo3JctqfHRE/xhd+x6cCMAd+RxVBI2p+WdkDSSI
 A45dSQJ+inGZEZR++eOdnQyfAR1FRJQh1ex89aTswZXLnO21jOCrTncn9fRMRMewwGXsBU1Nv
 9urovaD3b5NuSMJ0jUBkmRF7oXzkdPDYjKdexKMFgaxVecf4HEg0jvbnZhF/3atzYv5XI+2jo
 OcLGlSReK1DTRpoVYn1X2kLCBptbJpXqZ4UMoTjw5y5rkZXaGo+qZCEHnUMouIXvjPReWtY/W
 oLNFN1ic2RsCD4tTxmlbG0e2z6Nv8bvtWlvJ5PEwxLHzmQr6cjNyxHx7eMZvAvBPHq/88y5eU
 pu/PPoXunnSctZWlfOvL6pDkVcJUPl6lTK24QuvoItc1tYZ9HOO92obr2kVBIIHTfefxQWp0M
 ri9ItI+AQjsep3e55X17LZfWUAp0pDioitA40fBjN3LHpZo0Uw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the clang integrated assembler, we get a reference
to __force_order that should normally get ignored in a few
rare cases:

ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!

Add a 'static' definition so any file in which this happens can
have a local copy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 ++
 arch/x86/include/asm/special_insns.h  | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c8862696a47b..8595194cea41 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -12,7 +12,9 @@
  * It is not referenced from the code, but GCC < 5 with -fPIE would fail
  * due to an undefined symbol. Define it to make these ancient GCCs work.
  */
+#ifndef CONFIG_CC_IS_CLANG
 unsigned long __force_order;
+#endif
 
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 82436cb04ccf..7081e587c1ea 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -16,8 +16,15 @@
  * A memory clobber would solve the problem, but would prevent reordering of
  * all loads stores around it, which can hurt performance. Solution is to
  * use a variable and mimic reads and writes to it to enforce serialization
+ *
+ * Clang sometimes fails to kill the reference to the dummy variable, so
+ * provide an actual copy.
  */
+#ifdef CONFIG_CC_IS_CLANG
+static unsigned long __force_order;
+#else
 extern unsigned long __force_order;
+#endif
 
 void native_write_cr0(unsigned long val);
 
-- 
2.26.2


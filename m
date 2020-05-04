Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38D92073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgEDQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgEDQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:52:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584BC061A0F;
        Mon,  4 May 2020 09:52:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jVeK4-0001aX-Nv; Mon, 04 May 2020 18:52:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 47E8D1C047D;
        Mon,  4 May 2020 18:52:04 +0200 (CEST)
Date:   Mon, 04 May 2020 16:52:04 -0000
From:   "tip-bot2 for Vamshi K Sthambamkadi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Add kstrtoul() from lib/
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587645588-7130-2-git-send-email-vamshi.k.sthambamkadi@gmail.com>
References: <1587645588-7130-2-git-send-email-vamshi.k.sthambamkadi@gmail.com>
MIME-Version: 1.0
Message-ID: <158861112423.8414.159944326230563590.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5fafbebc86a0043ca5bbd8d3ce4f63dc5a02ad8e
Gitweb:        https://git.kernel.org/tip/5fafbebc86a0043ca5bbd8d3ce4f63dc5a02ad8e
Author:        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
AuthorDate:    Thu, 23 Apr 2020 18:09:47 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 May 2020 15:19:07 +02:00

x86/boot: Add kstrtoul() from lib/

Add kstrtoul() to ../boot/ to be used by facilities there too.

 [
   bp: Massage, make _kstrtoul() static. Prepend function names with
   "boot_". This is a temporary workaround for build errors like:

   ld: arch/x86/boot/compressed/acpi.o: in function `count_immovable_mem_regions':
   acpi.c:(.text+0x463): undefined reference to `_kstrtoul'
   make[2]: *** [arch/x86/boot/compressed/Makefile:117: arch/x86/boot/compressed/vmlinux] Error 1

   due to the namespace clash between x86/boot/ and kernel proper.
   Future reorg will get rid of the linux/linux/ namespace as much as
   possible so that x86/boot/ can be independent from kernel proper. ]

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1587645588-7130-2-git-send-email-vamshi.k.sthambamkadi@gmail.com
---
 arch/x86/boot/string.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/boot/string.h |  1 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 8272a44..8a3fff9 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -117,7 +117,6 @@ static unsigned int simple_guess_base(const char *cp)
  * @endp: A pointer to the end of the parsed string will be placed here
  * @base: The number base to use
  */
-
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
 	unsigned long long result = 0;
@@ -335,3 +334,45 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 		s++;
 	return _kstrtoull(s, base, res);
 }
+
+static int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	unsigned long long tmp;
+	int rv;
+
+	rv = kstrtoull(s, base, &tmp);
+	if (rv < 0)
+		return rv;
+	if (tmp != (unsigned long)tmp)
+		return -ERANGE;
+	*res = tmp;
+	return 0;
+}
+
+/**
+ * kstrtoul - convert a string to an unsigned long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Used as a replacement for the simple_strtoull.
+ */
+int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
index 38d8f2f..995f7b7 100644
--- a/arch/x86/boot/string.h
+++ b/arch/x86/boot/string.h
@@ -30,4 +30,5 @@ extern unsigned long long simple_strtoull(const char *cp, char **endp,
 					  unsigned int base);
 
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res);
 #endif /* BOOT_STRING_H */

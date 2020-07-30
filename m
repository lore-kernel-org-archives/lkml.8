Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53201C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DF320838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgG3WjE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:39:04 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37867 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgG3WjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:39:03 -0400
Received: from sogo13.sd4.0x35.net (sogo13.sd4.0x35.net [10.200.201.63])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id EB848100003;
        Thu, 30 Jul 2020 22:38:58 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 31 Jul 2020 00:38:58 +0200
Cc:     "Eldad Zack" <eldad@fogrefinery.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Mans Rullgard" <mans@mansr.com>, "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <1ee1-5f234c00-f3-165a6440@234394593>
Subject: =?utf-8?q?=5BPATCH?==?utf-8?q?_1=2F2=5D?==?utf-8?q?_kstrto*=3A?= correct 
 documentation references to =?utf-8?q?simple=5Fstrto*=28=29?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of the kstrto*() functions reference the simple_strtoull
function by "used as a replacement for [the obsolete] simple_strtoull".
All these functions describes themselves as replacements for the function
simple_strtoull, even though a function like kstrtol() would be more aptly
described as a replacement of simple_strtol().

Fix these references by making the documentation of kstrto*() reference
the closest simple_strto*() equivalent available. The functions
kstrto[u]int() do not have direct simple_strto[u]int() equivalences, so
these are made to refer to simple_strto[u]l() instead.

Furthermore, add parentheses after function names, as is standard in
kernel documentation.

Fixes: 4c925d6031f71 ("kstrto*: add documentation")
Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>

---
 include/linux/kernel.h | 4 ++--
 lib/kstrtox.c          | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 82d91547d122..2d6050f12c64 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -346,7 +346,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtoull. Return code must be checked.
+ * Used as a replacement for the simple_strtoul(). Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -374,7 +374,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtoull. Return code must be checked.
+ * Used as a replacement for the simple_strtol(). Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 1006bf70bf74..252ac414ba9a 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -115,7 +115,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
+ * Used as a replacement for the obsolete simple_strtoull(). Return code must
  * be checked.
  */
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(kstrtoull);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
+ * Used as a replacement for the obsolete simple_strtoll(). Return code must
  * be checked.
  */
 int kstrtoll(const char *s, unsigned int base, long long *res)
@@ -211,7 +211,7 @@ EXPORT_SYMBOL(_kstrtol);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
+ * Used as a replacement for the obsolete simple_strtoul(). Return code must
  * be checked.
  */
 int kstrtouint(const char *s, unsigned int base, unsigned int *res)
@@ -242,7 +242,7 @@ EXPORT_SYMBOL(kstrtouint);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
+ * Used as a replacement for the obsolete simple_strtol(). Return code must
  * be checked.
  */
 int kstrtoint(const char *s, unsigned int base, int *res)
-- 
2.28.0


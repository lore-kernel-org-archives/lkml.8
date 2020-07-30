Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDF6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3E120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgG3Wkh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:40:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34627 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgG3Wkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:40:36 -0400
Received: from sogo13.sd4.0x35.net (sogo13.sd4.0x35.net [10.200.201.63])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPA id 47FBBE0004;
        Thu, 30 Jul 2020 22:40:29 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <1ee1-5f234c00-f3-165a6440@234394593>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 31 Jul 2020 00:40:29 +0200
Cc:     "Eldad Zack" <eldad@fogrefinery.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Mans Rullgard" <mans@mansr.com>, "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <29b9-5f234c80-13-4e3aa200@244003027>
Subject: =?utf-8?q?=5BPATCH?==?utf-8?q?_2=2F2=5D?==?utf-8?q?_kstrto*=3A?= do not 
 describe =?utf-8?q?simple=5Fstrto*=28=29?= as 
 =?utf-8?q?obsolete=2Freplaced?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of the kstrto*() functions describes kstrto*() as
"replacements" of the "obsolete" simple_strto*() functions. Both of
these terms are inaccurate: they're not replacements because they have
different behaviour, and the simple_strto*() are not obsolete because
there are cases where they have benefits over kstrto*().

Remove usage of the terms "replacement" and "obsolete" in reference
to simple_strto*(), and instead use the term "preferred over".

Fixes: 4c925d6031f71 ("kstrto*: add documentation")
Fixes: 885e68e8b7b13 ("kernel.h: update comment about simple_strto<foo>() functions")
Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>

---
 include/linux/kernel.h |  4 ++--
 lib/kstrtox.c          | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2d6050f12c64..35fd7e0e3f04 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -346,7 +346,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtoul(). Return code must be checked.
+ * Preferred over simple_strtoul(). Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -374,7 +374,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtol(). Return code must be checked.
+ * Preferred over simple_strtol(). Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 252ac414ba9a..a14ccf905055 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -115,8 +115,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull(). Return code must
- * be checked.
+ * Preferred over simple_strtoull(). Return code must be checked.
  */
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
@@ -139,8 +138,7 @@ EXPORT_SYMBOL(kstrtoull);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoll(). Return code must
- * be checked.
+ * Preferred over simple_strtoll(). Return code must be checked.
  */
 int kstrtoll(const char *s, unsigned int base, long long *res)
 {
@@ -211,8 +209,7 @@ EXPORT_SYMBOL(_kstrtol);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoul(). Return code must
- * be checked.
+ * Preferred over simple_strtoul(). Return code must be checked.
  */
 int kstrtouint(const char *s, unsigned int base, unsigned int *res)
 {
@@ -242,8 +239,7 @@ EXPORT_SYMBOL(kstrtouint);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtol(). Return code must
- * be checked.
+ * Preferred over simple_strtol(). Return code must be checked.
  */
 int kstrtoint(const char *s, unsigned int base, int *res)
 {
-- 
2.28.0


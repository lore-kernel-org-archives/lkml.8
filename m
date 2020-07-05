Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AB8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E5E20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgGES1O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:27:14 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45559 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGES1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:27:13 -0400
Received: from sogo3.sd4.0x35.net (sogo3.sd4.0x35.net [10.200.201.53])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPA id 09FD360002;
        Sun,  5 Jul 2020 18:27:09 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <CAHp75Ve7JO0xJzwODoNS6f_UcvNtWTTu9mJxWAE0xEyBpHqQSg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Sun, 05 Jul 2020 20:27:09 +0200
Cc:     "David Laight" <David.Laight@aculab.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
MIME-Version: 1.0
Message-ID: <1da5-5f021b80-5d-39f90500@71664587>
Subject: =?utf-8?q?Re=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 04, 2020 22:54 CEST, Andy Shevchenko wrote: 
> This and similar are not correct. 1/ They are not replacement per se
> (because of different behaviour). 2/ They simple_strto*() are not
> obsoleted.
> 
> Can you correct all places you found and make it consistent?

Something like the following patch? It changes all occurrences of
"replacement" or "obsolete" (that I'm aware of) with "preferred over".

This patch does not change the phrase "please use kstrtoul instead",
as you called that correct. I could change it to something like "prefer
using kstrtoul instead" for consistent terminology; should I?

---
 include/linux/kernel.h |  4 ++--
 lib/kstrtox.c          | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 82d91547d122..b3b10d7cc693 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -346,7 +346,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtoull. Return code must be checked.
+ * Preferred over simple_strtoul. Return code must be checked.
 */
 static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
 {
@@ -374,7 +374,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the simple_strtoull. Return code must be checked.
+ * Preferred over simple_strtol. Return code must be checked.
  */
 static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
 {
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 1006bf70bf74..9be1341aaa89 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -115,8 +115,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Preferred over simple_strtoull. Return code must be checked.
  */
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
@@ -139,8 +138,7 @@ EXPORT_SYMBOL(kstrtoull);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Preferred over simple_strtoll. Return code must be checked.
  */
 int kstrtoll(const char *s, unsigned int base, long long *res)
 {
@@ -211,8 +209,7 @@ EXPORT_SYMBOL(_kstrtol);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Preferred over simple_strtoul. Return code must be checked.
  */
 int kstrtouint(const char *s, unsigned int base, unsigned int *res)
 {
@@ -242,8 +239,7 @@ EXPORT_SYMBOL(kstrtouint);
  * @res: Where to write the result of the conversion on success.
  *
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Used as a replacement for the obsolete simple_strtoull. Return code must
- * be checked.
+ * Preferred over simple_strtol. Return code must be checked.
  */
 int kstrtoint(const char *s, unsigned int base, int *res)
 {
--
2.27.0


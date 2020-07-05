Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2126EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC00E2073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGEUsn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:48:43 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48737 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgGEUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:48:43 -0400
Received: from sogo3.sd4.0x35.net (sogo3.sd4.0x35.net [10.200.201.53])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPA id 057661BF207;
        Sun,  5 Jul 2020 20:48:38 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <CAHp75Ve3m=UK9r2o8bDotQWQBLz-fV8CO_VcTmWjdLW1p5wE-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Sun, 05 Jul 2020 22:48:38 +0200
Cc:     "David Laight" <David.Laight@aculab.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
MIME-Version: 1.0
Message-ID: <6e16-5f023c80-2df-35a18880@71958197>
Subject: =?utf-8?q?Re=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 05, 2020 21:11 CEST, Andy Shevchenko <andy.shevchenko@gmail.com> wrote: 
> On Sunday, July 5, 2020, Kars Mulder <kerneldev@karsmulder.nl> wrote:
> > On Saturday, July 04, 2020 22:54 CEST, Andy Shevchenko wrote:
> > > This and similar are not correct. 1/ They are not replacement per se
> > > (because of different behaviour). 2/ They simple_strto*() are not
> > > obsoleted.
> > >
> > > Can you correct all places you found and make it consistent?
> >
> > Something like the following patch? It changes all occurrences of
> > "replacement" or "obsolete" (that I'm aware of) with "preferred over".
> 
> While at it, makes sense to refer to the functions like func() as per
> kernel doc format.

So I'm working on two patches with tentative names:

[PATCH 1/2] kstrto*: Fix references to simple_strto* analogues in comments
[PATCH 2/2] kstrto*: Do not describe simple_strto* as obsolete/replaced

(I decided to switch the order since the last mail because the first
change should be less controversial than the second.)

The first one makes all simple_strto* references match their respective
functions and adds parentheses after the function name (I hope this can
happen in a single patch?), the second one removes mention of "obsolete"
or "replacement" and instead uses "preferred over".

I should probably put you in Suggested-by: for the second patch (and
maybe the first one as well?), but I need your explicit permission to
do so. So, do you want to be added as Suggested-by: on one/both of
these patches?

(Maybe I should add you as Acked-by: as well? I'm not actually sure if
it's even possible to ask you to ack the patch until its form including
changelog is finalized. Anyway, the current patches have been attached
below for good measure.)

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
2.27.0

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
2.27.0


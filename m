Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C8C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C8C24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBTM5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:57:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:56352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:57:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C29DAC54;
        Thu, 20 Feb 2020 12:57:09 +0000 (UTC)
Date:   Thu, 20 Feb 2020 13:57:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
Message-ID: <20200220125707.hbcox3xgevpezq4l@pathway.suse.cz>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
 <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-19 16:40:08, Rasmus Villemoes wrote:
> On 19/02/2020 15.45, Petr Mladek wrote:
> > On Wed 2020-02-19 14:56:32, Rasmus Villemoes wrote:
> >> On 19/02/2020 14.48, Petr Mladek wrote:
> >>> On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
> >>>> --- a/lib/vsprintf.c
> >>>> +++ b/lib/vsprintf.c
> >>> The test should go into null_pointer() instead of errptr().
> >>
> >> Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
> >> way. But I should add a #else section that tests how %pe behaves without
> >> CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.
> > 
> > OK, we should agree on some structure first.
> > 
> > We already have two top level functions that test how a particular
> > pointer is printed using different pointer modifiers:
> > 
> > 	null_pointer();     -> NULL with %p, %pX, %pE
> > 	invalid_pointer();  -> random pointer with %p, %pX, %pE
> > 
> > Following this logic, errptr() should test how a pointer from IS_ERR() range
> > is printed using different pointer formats.
> 
> Oh please. I wrote test_printf.c originally and structured it with one
> helper for each %p<whatever>. How are your additions null_pointer and
> invalid_pointer good examples for what the existing style is?

I see, I was the one who broke the style. Please, find below a patch
that tries to fix it. If you agree with the approach then I could
split it into smaller steps.

Also it would make sense to add checks for NULL and ERR pointer
into each existing %p modifier check. It will make sure that
check_pointer() is called in all handlers.


> So yeah, I'm going to continue testing the behaviour of %pe in errptr, TYVM.

OK.

> >>>> BTW., your original patch for %p lacks corresponding update of
> >>>> test_vsprintf.c. Please add appropriate test cases.
> >>>
> >>> diff --git a/lib/test_printf.c b/lib/test_printf.c
> >>> index 2d9f520d2f27..1726a678bccd 100644
> >>> --- a/lib/test_printf.c
> >>> +++ b/lib/test_printf.c
> >>> @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
> >>>  static void __init
> >>>  null_pointer(void)
> >>>  {
> >>> -	test_hashed("%p", NULL);
> >>> +	test(ZEROS "00000000", "%p", NULL);
> >>
> >> No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
> >> (where one of course has to use explicit integers and not E* constants).
> > 
> > Yes, it would be great to add checks for %p, %px for IS_ERR() range.
> > But it is different story. The above change is for the original patch
> > and it was about NULL pointer handling.
> 
> Wrong. The original patch (i.e. Ilya's) had subject "vsprintf: don't
> obfuscate NULL and error pointers" and did
> 
> +	if (IS_ERR_OR_NULL(ptr))
> 
> so the tests that should be part of that patch very much need to cover
> both NULL and ERR_PTRs passed to plain %p.

Grr, I see. I was too fast yesterday. OK, I suggest to fix the
structure of the tests first. All these patches are for 5.7
anyway.


Here is the proposed clean up:

From 855909f2a1945d3a5bf490ddf4f2cca775ef967b Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 20 Feb 2020 12:53:43 +0100
Subject: [PATCH] lib/test_printf: Clean up basic pointer testing

The pointer testing has been originally split by the %p modifiers,
for example, the function dentry() tested %pd and %pD handling.

There were recently added tests that do not really fit into
the existing structure, namely:

  + hashed pointers tested by a maze of functions
  + null and invalid pointer handling with various modifiers

The hash pointer test is really special because the hash depends
on a random key that is generated during boot. Though, it is
still possible to check some aspects:

  + output string length
  + hash differs from the original pointer value
  + top half bites are zeroed on 64-bit systems

Let's put all these checks into test_hashed() function that has
the same behavior as the test() functions for well-defined output.
It increments the number of tests and eventual failures. It prints
warnings/errors when some aspects of the output are not as expected.

Most of these checks were there even before. The only addition is
the check whether hash differs from the original pointer value.
There is a small chance of a false error. It might be reduced
by checking more pointers but let's keep it simple for now.

The existing null_pointer() and invalid_pointer() checks are
newly split per-format modifier. And there is also fixed
difference between invalid pointer in the IS_ERR() range
and invalid pointer that looks like a valid one.

The invalid pointer Oxdeaddead00000000 should work on most
architectures. But I am not able to check it everywhere.
So there is a small chance of a false error. It might get
fixed when anyone reports a problem.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/test_printf.c | 162 ++++++++++++++++++++----------------------------------
 1 file changed, 59 insertions(+), 103 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 2d9f520d2f27..4e89b508def6 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -206,146 +206,101 @@ test_string(void)
 }
 
 #define PLAIN_BUF_SIZE 64	/* leave some space so we don't oops */
+#define PTR_ERROR ERR_PTR(-EFAULT)
+#define PTR_VAL_ERROR "fffffff2"
 
 #if BITS_PER_LONG == 64
 
 #define PTR_WIDTH 16
 #define PTR ((void *)0xffff0123456789abUL)
 #define PTR_STR "ffff0123456789ab"
+#define PTR_INVALID ((void *)0xdeaddead000000ab)
+#define PTR_VAL_INVALID "deaddead000000ab"
 #define PTR_VAL_NO_CRNG "(____ptrval____)"
+#define ONES "ffffffff"		/* hex 32 one bits */
 #define ZEROS "00000000"	/* hex 32 zero bits */
 
-static int __init
-plain_format(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int nchars;
-
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
-
-	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
-			PTR_VAL_NO_CRNG);
-		return 0;
-	}
-
-	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
-		return -1;
-
-	return 0;
-}
-
 #else
 
 #define PTR_WIDTH 8
 #define PTR ((void *)0x456789ab)
 #define PTR_STR "456789ab"
+#define PTR_INVALID ((void *)0x000000ab)
+#define PTR_VAL_INVALID "000000ab"
 #define PTR_VAL_NO_CRNG "(ptrval)"
+#define ONES ""
 #define ZEROS ""
 
-static int __init
-plain_format(void)
-{
-	/* Format is implicitly tested for 32 bit machines by plain_hash() */
-	return 0;
-}
-
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
-plain_hash_to_buffer(const void *p, char *buf, size_t len)
+static void __init
+test_hashed(const char *fmt, const void *p)
 {
+	char pointer[PLAIN_BUF_SIZE];
+	char hash[PLAIN_BUF_SIZE];
 	int nchars;
 
-	nchars = snprintf(buf, len, "%p", p);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
+	total_tests++;
 
-	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
-			PTR_VAL_NO_CRNG);
-		return 0;
+	nchars = snprintf(pointer, sizeof(pointer), "%px", p);
+	if (nchars != PTR_WIDTH) {
+		pr_err("error in test suite: vsprintf(\"%%px\", p) returned number of characters %d, expected %d\n",
+		       nchars, PTR_WIDTH);
+		goto err;
 	}
 
-	return 0;
-}
-
-static int __init
-plain_hash(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return ret;
-
-	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
-		return -1;
-
-	return 0;
-}
-
-/*
- * We can't use test() to test %p because we don't know what output to expect
- * after an address is hashed.
- */
-static void __init
-plain(void)
-{
-	int err;
-
-	err = plain_hash();
-	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
-		return;
+	nchars = snprintf(hash, sizeof(hash), fmt, p);
+	if (nchars != PTR_WIDTH) {
+		pr_warn("vsprintf(\"%s\", p) returned number of characters %d, expected %d\n",
+			fmt, nchars, PTR_WIDTH);
+		goto err;
 	}
 
-	err = plain_format();
-	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
+	if (strncmp(hash, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
+		pr_warn_once("crng possibly not yet initialized. vsprinf(\"%s\", p) printed \"%s\"",
+			     fmt, hash);
+		total_tests--;
+		return;
 	}
-}
-
-static void __init
-test_hashed(const char *fmt, const void *p)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
 
 	/*
-	 * No need to increase failed test counter since this is assumed
-	 * to be called after plain().
+	 * There is a small chance of a false negative on 32-bit systems
+	 * when the hash is the same as the pointer value.
 	 */
-	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return;
+	if (strncmp(hash, pointer, PTR_WIDTH) == 0) {
+		pr_warn("vsprintf(\"%s\", p) returned %s, expected hashed pointer\n",
+			fmt, hash);
+		goto err;
+	}
+
+#if BITS_PER_LONG == 64
+	if (strncmp(hash, ZEROS, PTR_WIDTH / 2) != 0) {
+		pr_warn("vsprintf(\"%s\", p) returned %s, expected %s in the top half bits\n",
+			fmt, hash, ZEROS);
+		goto err;
+	}
+#endif
+	return;
 
-	test(buf, fmt, p);
+err:
+	failed_tests++;
 }
 
 static void __init
-null_pointer(void)
+plain_pointer(void)
 {
 	test_hashed("%p", NULL);
-	test(ZEROS "00000000", "%px", NULL);
-	test("(null)", "%pE", NULL);
+	test_hashed("%p", PTR_ERROR);
+	test_hashed("%p", PTR_INVALID);
 }
 
-#define PTR_INVALID ((void *)0x000000ab)
 
 static void __init
-invalid_pointer(void)
+real_pointer(void)
 {
-	test_hashed("%p", PTR_INVALID);
-	test(ZEROS "000000ab", "%px", PTR_INVALID);
-	test("(efault)", "%pE", PTR_INVALID);
+	test(ZEROS "00000000", "%px", NULL);
+	test(ONES PTR_VAL_ERROR, "%px", PTR_ERROR);
+	test(PTR_VAL_INVALID, "%px", PTR_INVALID);
 }
 
 static void __init
@@ -372,6 +327,8 @@ addr(void)
 static void __init
 escaped_str(void)
 {
+	test("(null)", "%pE", NULL);
+	test("(efault)", "%pE", PTR_ERROR);
 }
 
 static void __init
@@ -458,9 +415,9 @@ dentry(void)
 	test("foo", "%pd2", &test_dentry[0]);
 
 	test("(null)", "%pd", NULL);
-	test("(efault)", "%pd", PTR_INVALID);
+	test("(efault)", "%pd", PTR_ERROR);
 	test("(null)", "%pD", NULL);
-	test("(efault)", "%pD", PTR_INVALID);
+	test("(efault)", "%pD", PTR_ERROR);
 
 	test("romeo", "%pd", &test_dentry[3]);
 	test("alfa/romeo", "%pd2", &test_dentry[3]);
@@ -647,9 +604,8 @@ errptr(void)
 static void __init
 test_pointer(void)
 {
-	plain();
-	null_pointer();
-	invalid_pointer();
+	plain_pointer();
+	real_pointer();
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
-- 
2.16.4


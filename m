Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E32121973
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594691862;
	bh=wLIvmYd4KBmDzs2Q/hlnCi1CEtHw65SAqVZY1eF2e0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hMbfMXn/NMbk0aHIXH2Ia1kvWCIiY0Pg/ouxAlwM6PTYTaQLyRwYsj9gi8EndyoIu
	 ItHnwqd0VfHeUBJi4GEtb7LocqrlsbUGG7uiuI/c9J2En8b5iHxlxfUtRrDeMEzgxh
	 VUXJeP8Kg3Mesg+Wl7xFQOKvTq5PpVVD6pH/fpCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgGNB5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:57:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B5362186A;
        Tue, 14 Jul 2020 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594691860;
        bh=wLIvmYd4KBmDzs2Q/hlnCi1CEtHw65SAqVZY1eF2e0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0YUp4fbrSBr8S1wX5O+tz0YpWcd3J+tjZJo9fAc4NHWvY3JD+elPoKVEZGLbhlK9
         Kg+HX2Gtmm0jGgYAoo++UM85xQqtIOulYqFiFOsS0l2bbE4FCoUnptQ5G3QbxFBCs8
         cdfKlfsrRzmub2MrVG4/eD1VY7Kwcu0sLY9rKW9M=
Date:   Mon, 13 Jul 2020 18:57:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Changming <charley.ashbringer@gmail.com>
Cc:     willy@infradead.org, rdunlap@infradead.org, keescook@chromium.org,
        mcgrof@kernel.org, yzaikin@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: prevent panic_timeout * 1000 from overflow
Message-Id: <20200713185739.03d576cca0dc9f618ea76d67@linux-foundation.org>
In-Reply-To: <20200711051728.1499-1-charley.ashbringer@gmail.com>
References: <0d4601d65709a0e2d80e2a8880gmail.com>
        <20200711051728.1499-1-charley.ashbringer@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 01:17:28 -0400 Changming <charley.ashbringer@gmail.com> wrote:

> From: Changming Liu <charley.ashbringer@gmail.com>
> 
> Since panic_timeout is an integer passed-in through sysctl,
> the loop boundary panic_timeout * 1000 could overflow and
> result in a zero-delay panic when panic_timeout is greater
> than INT_MAX/1000.
> 
> Fix this by moving 1000 to the left, also in case i/1000
> might never be greater than panic_timeout, change i to
> long long so that it strictly has more bits.
> 
> ...
>
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -178,7 +178,8 @@ void panic(const char *fmt, ...)
>  {
>  	static char buf[1024];
>  	va_list args;
> -	long i, i_next = 0, len;
> +	long long i;
> +	long i_next = 0, len;
>  	int state = 0;
>  	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> @@ -315,7 +316,7 @@ void panic(const char *fmt, ...)
>  		 */
>  		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
>  
> -		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
> +		for (i = 0; i / 1000 < panic_timeout; i += PANIC_TIMER_STEP) {

Problem is, 32-bit machines generally cannot perform 64-bit divides. 
So a call is emitted to the library function __divsi64() (I forget the exact
name) which Linux doesn't implement (because it's so slow, and we don't
want to be calling it by accident).

So a fix would be to call do_div() or something from
include/linux/div64.h but it's all a great mess.

However we can do native 64-bit multiplication on 32-bit!  So how about
something like

--- a/kernel/panic.c~a
+++ a/kernel/panic.c
@@ -313,13 +313,16 @@ void panic(const char *fmt, ...)
 		 * Delay timeout seconds before rebooting the machine.
 		 * We can't use the "normal" timers since we just panicked.
 		 */
+		u64 timeout = panic_timeout * 1000;	/* avoid overflow */
+		u64 timer;
+
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
 
-		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
+		for (timer = 0; timer < timeout; timer += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
-			if (i >= i_next) {
-				i += panic_blink(state ^= 1);
-				i_next = i + 3600 / PANIC_BLINK_SPD;
+			if (timer >= i_next) {
+				timer += panic_blink(state ^= 1);
+				i_next = timer + 3600 / PANIC_BLINK_SPD;
 			}
 			mdelay(PANIC_TIMER_STEP);
 		}

(untested)

There's still the 3600/PANIC_BLINK_SPD in there, but a) that will be
done at compile-time and b) the 64-bit promotion should be done after
the division.

And... oh crap, i_next needs to be 64-bit as well.



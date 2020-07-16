Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79BF2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLjn3Zui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgGPEsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPEsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:48:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA336C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:48:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a32so3963079qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Z+UbXyBi8oxtMS31bKgfGmZ5hKHJm4ka7q7+ka7SGf4=;
        b=DLjn3ZuiCiB2NouAl0nYCNELdZ6ky0HvJEGOxTyho1vZOT6WnpxCi3xo1KIodB9bJh
         d+OYKbqLLdza93/9S0HmEzsL4sgYN+2UbPCSmo+UMRW70hE/tXeamvSy035NumbkALp+
         Cj0cYJ1UiDJGAusGd7wH5QyIELteY2tGvajUfHdgKXYPsqPxT7O9q1HnlfxbTvdpXmHx
         XxNg0VWzmj841u47oHNoQ1LsYJT/OhRcF0S32oeoMkXhlXD7EssCOm47BXUyfTv0rSkE
         EhDfjej9nUAiD5EzuqgnqkezEsE62Ke4gPfe+TeGKuuQiQ7+rjFPdthx9zIphSWZ35A7
         k50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Z+UbXyBi8oxtMS31bKgfGmZ5hKHJm4ka7q7+ka7SGf4=;
        b=SalmE4GZy1PhQeXNJHszZp3Lwzrg/+eDB7YvnWeaQ7VFsuk2inx3BE9a+tQrinjUaP
         iK+O40fJW2zZEekQXJc4dLNv+lPJTNBKdko7PIv7I+NnXFbygyVHzCDE9OsvBE0KFxDm
         cYTrM0C5GIe2WWUjq0Y5tYvvodi7JAf6RoIuKXnqH1xqAVYMdE37Dg2bDOIo9qtGcFcp
         /AtnYNDK7CI8rYNb2uWoNtP7LtqxjpAf4G5xDaAEUNykNyzvnQgBxHGKb1RvU1ifDIGn
         gHyP0bQA9wnlKgHOB7KLg0JxDApXEtGgZ6TSEGUnfs3SNGWF/JZC8pxnc4/3HXmyyr+x
         TcxA==
X-Gm-Message-State: AOAM531T2R+9uFsXq3uAQuEgzMDY+f5J0vvkcpZJiwE/df9jA2RlZTCV
        kl8IYGjw41kBCr4Qcq805jPjvyXwnWY=
X-Google-Smtp-Source: ABdhPJxUMM9RObqxnbEzgrnyqpmgv+KE2xdRBucJPdpQyyZeEvPdCh0VGKd3Epz/rAi1zYCfaJFrnw==
X-Received: by 2002:ac8:4e03:: with SMTP id c3mr3388804qtw.82.1594874895788;
        Wed, 15 Jul 2020 21:48:15 -0700 (PDT)
Received: from DESKTOP2I1VNC3 ([209.94.140.104])
        by smtp.gmail.com with ESMTPSA id y40sm6414556qtc.29.2020.07.15.21.48.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 21:48:15 -0700 (PDT)
From:   <charley.ashbringer@gmail.com>
To:     "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     <willy@infradead.org>, <rdunlap@infradead.org>,
        <keescook@chromium.org>, <mcgrof@kernel.org>, <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>
References: <0d4601d65709a0e2d80e2a8880gmail.com>       <20200711051728.1499-1-charley.ashbringer@gmail.com> <20200713185739.03d576cca0dc9f618ea76d67@linux-foundation.org>
In-Reply-To: <20200713185739.03d576cca0dc9f618ea76d67@linux-foundation.org>
Subject: RE: [PATCH v2] panic: prevent panic_timeout * 1000 from overflow
Date:   Thu, 16 Jul 2020 00:48:14 -0400
Message-ID: <000901d65b2c$515211f0$f3f635d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGmsmd3p9TK+JTkCQ2rB/CG8P/fbgG/W7agAmus1EWpR5rc4A==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since panic_timeout is an integer passed-in through sysctl,
> > the loop boundary panic_timeout * 1000 could overflow and
> > result in a zero-delay panic when panic_timeout is greater
> > than INT_MAX/1000.
> >
> > Fix this by moving 1000 to the left, also in case i/1000
> > might never be greater than panic_timeout, change i to
> > long long so that it strictly has more bits.
> >
> > ...
> >
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -178,7 +178,8 @@ void panic(const char *fmt, ...)
> >  {
> >  	static char buf[1024];
> >  	va_list args;
> > -	long i, i_next = 0, len;
> > +	long long i;
> > +	long i_next = 0, len;
> >  	int state = 0;
> >  	int old_cpu, this_cpu;
> >  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> > @@ -315,7 +316,7 @@ void panic(const char *fmt, ...)
> >  		 */
> >  		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
> >
> > -		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP)
{
> > +		for (i = 0; i / 1000 < panic_timeout; i += PANIC_TIMER_STEP)
{
> 
> Problem is, 32-bit machines generally cannot perform 64-bit divides.
> So a call is emitted to the library function __divsi64() (I forget the
exact
> name) which Linux doesn't implement (because it's so slow, and we don't
> want to be calling it by accident).
> 

It's good to know, thanks for letting me know why 64-bit division 
is slow, and 64-multiplication is fast, surely doing so many
64-bit division will drag a lot, and should be prevented.

> So a fix would be to call do_div() or something from
> include/linux/div64.h but it's all a great mess.
> 
> However we can do native 64-bit multiplication on 32-bit!  So how about
> something like
> 
> --- a/kernel/panic.c~a
> +++ a/kernel/panic.c
> @@ -313,13 +313,16 @@ void panic(const char *fmt, ...)
>  		 * Delay timeout seconds before rebooting the machine.
>  		 * We can't use the "normal" timers since we just panicked.
>  		 */
> +		u64 timeout = panic_timeout * 1000;	/* avoid overflow */
> +		u64 timer;
>		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
> -		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP)
{
> +		for (timer = 0; timer < timeout; timer += PANIC_TIMER_STEP)
{

If using u64 as the loop boundary, would it be a problem if
panic_timeout is negative? Since in the current code, if
panic_timeout is negative, the loop will not be executed;
as in the patched code, the loop boundary will be a huge 
unsigned value. I guess s64 should do？

If it's not a problem, I'll submit another patch enforcing
the change, including the changes suggested by Matthew here:

> > +		u64 timeout = panic_timeout * 1000;	/* avoid overflow */
> 1000ULL to not truncate before the assignment.

> > +		u64 timer;
> ... as you implied lateru64 timer, timer_next;


Thank you guys so much for your valuable feedback, I learned a lot!

Best,
Changming


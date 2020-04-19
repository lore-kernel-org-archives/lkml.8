Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C323C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 03:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A75C20722
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 03:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnEgVOnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDSDWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 23:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDSDWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 23:22:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 20:22:11 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 184so3799534vsu.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 20:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Qx8nDbaFMkUzFVZR7ocRhoUCDYt1J+4uYo1UgQQZqo=;
        b=PnEgVOnDNJXXYPdCDGx/XAl7N+Z2fAAAoJMoPad4k+esD9S79bdLo5Xz9G9naZjIFY
         tQWZn1CTmWRy5zS8fiMQShcEyF8N5py/9QRqyuaEPlpY3u3wERWgSe3Ol3zOkwjbz8eN
         3lWVYpDYxUV1cSEdyyhj7ODek1CMak84ag6uxP2DljyUEYKqSmDdXwqWEunXp8Jcvs30
         Nm+jbRDu0iybyZiK5J6DYfmpzjY+A08+AyWmC9Yj4C+SQDROffKPUcowxruhANXUOX65
         RHeykxUSUG+5OZzcGrYGliWwiNPK15xjKGCmXb/IdolAwAJfzHIbHkcyIxk/mZMhC3TT
         DWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Qx8nDbaFMkUzFVZR7ocRhoUCDYt1J+4uYo1UgQQZqo=;
        b=rFsBxvhK+/w+1bB1LED2YAlNyGFgQ2iHldjVrRSmkTG1VOY7A4m7gw0d0aPtIS0Us+
         yNuflgJvT8rI0qd4CCaNbdo5sEvlwTgC85UtB4TvCeMlgbyUl9RS0LHOtxn6IiqtKO/0
         NChuy8rp35UzdLfjDvHUIVT6yNQCIyRnrsZmo/Y8P2GePYPoJvd0uBXJSmGcak/BJUNO
         JPMRTrS9sybQSBNnLoCTFzNWocQLHiWJosB9D1hzn4Foda07dAGdK/TASoywE55xGYK7
         nMNMBxs4DeMSiQcDPqXOH5+6Ybwuwe5NlWezdj5lPj9FTbZ8QWUFgPywzOVXq4U5Zh6G
         Iaig==
X-Gm-Message-State: AGi0PuYrXGqOydkR80NOUDJdW879/FIq5xI0ajHMN4fhlTywiFyYcbu+
        5EbZU40Ghyu6zybNrOxxlrogmtfRcxZjPH0Zscmd3p+/
X-Google-Smtp-Source: APiQypKJmhvAR9duc+u9Cs7ivXeidR5tg4GtlRZ7qqku3GW7dGO8cdTgtqLjirmkt5pncHezv/4RQFbAMqq4VEc6J8Y=
X-Received: by 2002:a67:d90f:: with SMTP id t15mr7737339vsj.214.1587266530482;
 Sat, 18 Apr 2020 20:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200417162451.91969-1-pilgrimtao@gmail.com> <20200417170506.ldz2eee4mm4szqij@linutronix.de>
In-Reply-To: <20200417170506.ldz2eee4mm4szqij@linutronix.de>
From:   Tao pilgrim <pilgrimtao@gmail.com>
Date:   Sun, 19 Apr 2020 11:21:59 +0800
Message-ID: <CAAWJmAZ3p9jdSUi5H0+kmCN7h-rzBA0=9tR-y5J4kJgYDUDBdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] kernel/smp: Use smp_call_func_t in on_each_cpu()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, peterz@infradead.org, namit@vmware.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 1:05 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-04-18 00:24:51 [+0800], Kaitao Cheng wrote:
> > There is already a typedef smp_call_func_t, so we can just use it,
> > maybe better.
> >
> > Fixes: 3a5f65df5a0fc ("Typedef SMP call function pointer")
> > Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
>
> I would not go as far as the Fixes: tag but otherwise:
>
>   Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your review. Do you mean I should delete the Fixes tag?

>
> > ---
> >  kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 786092aabdcd..84303197caf9 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -620,7 +620,7 @@ void __init smp_init(void)
> >   * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
> >   * of local_irq_disable/enable().
> >   */
> > -void on_each_cpu(void (*func) (void *info), void *info, int wait)
> > +void on_each_cpu(smp_call_func_t func, void *info, int wait)
> >  {
> >       unsigned long flags;
> >
>
> Sebastian

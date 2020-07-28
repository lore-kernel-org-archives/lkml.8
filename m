Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9893C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881A620786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPIMIt06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgG1Sfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgG1Sfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:35:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:35:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a26so6824022otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Z63JKAOHq4FmpWz4KBmz4cVqOLwzIvbRITRXwRUNMg=;
        b=GPIMIt06GdktXH/MGPQAgShkUf3xRghQYf+l+eRGqs2hhNLnYxeu0YJcUSVm4aWq6+
         JnLC4qT6HYzxvFFz3ZJcvfVQgPuAgo8WKeUb8jkHnnRV+HukPiceUAjuOiCRPfqcn4Rf
         8s5ENREcr1d5c48Aj7xQ3o6qcvLkQ4XGumU/Zj3YyTt1XPJeuhuPZsrpvUcQvFfEk68N
         IXV7CWoENQ1ufiO8hAuitfNaTEL3xyb8IGjI/q3MSvio2EQU3OQnGhSZFBe3nJbHzIlA
         7uiqk9pMyc0ymqN60xtYwQTbpaRjrKhbYIibaO6d3GQvqyN5TLiZax4obJ1JpOGM1fED
         sF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Z63JKAOHq4FmpWz4KBmz4cVqOLwzIvbRITRXwRUNMg=;
        b=ncqnYQFjW8rlquzdhhMkQj0EvJDF9dN1q4euflIsIH8x3BkEDKqPFEySwNTidLLY3e
         FnTaOwCbF19hJFi2bmmUATBZm5jeHPCU97y4hURxUAe0MiYQMDa4vtPLNTR39CkdybZo
         wRBaYUzJ4GefEw+BQ9VeRWX1x9UVzoqDMZywfW+Kev7nLbZfHzWaXJPfDm9LFSOnEzKM
         RC19SAAhmIzNEUv+FxDpYrakhh71koyo0YzdzOb4jed2+O5P/Dv6BxbvwhdimWAj6rSX
         8IKIg2L2WVsf9Np2/A+8PwJgbTMl4rQnuqEsydr2dplrL71+z9gFoQaTA8DebTr2025y
         2Q9A==
X-Gm-Message-State: AOAM530ptc0h2Ph+DXe5y+z3qa48WTQmHkXwlNjl3V2HJyTEVhdHLbVt
        1A1eE3HBr6lHLOjm3KAHav881XJQmVwguCucP98=
X-Google-Smtp-Source: ABdhPJyzWjrRD0PrwzvQqD83SQdnWksQWGtydVmK8bWLCVtscOqjbdlaXNKFDL1fEPN2+nshHblWyt37hJyOEDw7PQQ=
X-Received: by 2002:a05:6830:4c8:: with SMTP id s8mr24921273otd.368.1595961352281;
 Tue, 28 Jul 2020 11:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com> <20200728182519.GA328787@kroah.com>
In-Reply-To: <20200728182519.GA328787@kroah.com>
From:   Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Date:   Wed, 29 Jul 2020 00:05:39 +0530
Message-ID: <CAPRy4h3RWzY0nStJzvLUJuEyxN4Pc03LiqJxie-_GWhzuZEmgA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: used const keyword
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I have understood now that I should not trust on
checkpatch.pl script fully but partially it is indeed helpful. Please
don't criticize this script, it was my fault instead.

Before submitting code changes I would test them all, sorry for
wasting your time please ignore this patch changes now.

I will not commit such foolish mistakes now.


Thank you
Dhiraj Sharma

On Tue, Jul 28, 2020 at 11:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 28, 2020 at 11:29:35PM +0530, Dhiraj Sharma wrote:
> > I ran checkpatch.pl script which reported a warning to use const keyword
> > on line 370.Therefore I made this change.
> >
> > Signed-off-by: Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
> > ---
> >  drivers/staging/android/ashmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> > index c05a214191da..f9cfa15b785f 100644
> > --- a/drivers/staging/android/ashmem.c
> > +++ b/drivers/staging/android/ashmem.c
> > @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> >
> >  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -     static struct file_operations vmfile_fops;
> > +     static const struct file_operations vmfile_fops;
>
> You have now submitted two patches that you obviously never even built,
> which is the first step in kernel development :(
>
> Please be more careful next time.
>
> greg k-h

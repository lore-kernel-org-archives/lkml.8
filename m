Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A05BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C5620760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnPpG0sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFHTeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgFHTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:34:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD04C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:34:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so22014567ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsN50RK5r6jDucbLG6NxXwSMIZheMgVO+8udfaUFEhA=;
        b=dnPpG0sRgWJSwbphbBzlq6YmOObuGHcgN3CFvKiU+huwVjg+2CRTE23BcRjG7iDJUq
         sLmFZCJFRIjxW7Qa+IYWpCjcAfV6dKqhIQf4+ymNh9wdF9ye5UnkiJnXekhYt8+Sx04Y
         SkK3HbcXNBE+uspuN45JcFfAp8ixin0Maw7yVe+rlSYQd2UB3JVG2xIGtqOkk3tHtaGW
         S3mYm65yYjhDClDTl9/+uoaijEXqK5JaOtu/F+rL2OFUsKLEGOHmJWFaR+lDc+hYPPiS
         rGJtDWGh/bl4fvEW/+xLXw4DA862+2NFTPO95MsB8YPlxAo7garOjhhs8p1ufwbIPAme
         Q70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsN50RK5r6jDucbLG6NxXwSMIZheMgVO+8udfaUFEhA=;
        b=NryrhO9UjucRC+OVvemiAnBnj+TZQlyiKrJTk5brosNHe9OC2fegbYeh4ToV2j3Mx/
         2D1RilrogH4jjyV45Ig7YOBs3VP6tao9dLB+FeBZt6y/rn7y6erhChUDr9gAsgYKxLdc
         wkXRzAmWXty4ebOZjRTX+RQQ53BM6OEepgZB0ZqEUf47Eo7/62/QuQqaDNcayWwnxjYQ
         XWhKXETnlYIAEYKFq4yw0dEqi/s3UJLwRyytTDsLVwHmbT+S0vZZ/tPR/9zTRHZk86Kz
         6ZJaMfgW6Ts3ktB1Ugw9PJRrT+xx6adOG4mtQIvbWIQwWt4p0YYKsJqgJKBeDwE1LVar
         zf3g==
X-Gm-Message-State: AOAM532g6rALmDvxk2y7TA3p+BxN4wIyT9yDPwwfLHt8zdJWpNz/ypqF
        YbaMkzeeT+sZEGvEoaHtoOIAwPENvmQlIplHkMs=
X-Google-Smtp-Source: ABdhPJzmUAhskEMJMcCtJ8j3JnStIVXdACrsqSv1JVkoISUUXzUrO/vK2clj0h978rDhlNppkpd4b1q4FHaP5RHRX98=
X-Received: by 2002:a2e:83c7:: with SMTP id s7mr12235681ljh.68.1591644843450;
 Mon, 08 Jun 2020 12:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com> <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
 <20200608191459.GZ30374@kadam>
In-Reply-To: <20200608191459.GZ30374@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 9 Jun 2020 01:03:51 +0530
Message-ID: <CAFqt6zYqnRWYSKoZ2yAdcAK7WWa311Mmmc3Y3dm8CO9r79ZtYg@mail.gmail.com>
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() --> pin_user_pages()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        harshjain32@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        jane.pnx9@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 12:47 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Jun 09, 2020 at 12:31:42AM +0530, Souptick Joarder wrote:
> > > > @@ -189,10 +192,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> > > >       sg_free_table(&acd->sgt);
> > > >    err_dma_map_sg:
> > > >    err_alloc_sg_table:
> > >
> > > So now we end up with two unnecessary labels. Probably best to delete two of these
> > > three and name the remaining one appropriately:
> >
> > Hmm, I thought about it. But later decided to wait for review comments
> > on the same in v1.
> > I will remove it now.
>
> These are all unrelated to pin_user_pages().  Please don't do it in the
> same patch. Staging code is there because it's ugly...  If you don't
> want to do unrelated changes to label names then you don't have to.

What I am planning is to put this changes in a series. One patch will take care
of pin_user_pages() related changes, 2nd patch will take care of minor bug
fix in error path + level correction and 3rd patch
will take care of set_page_dirty() -> set_page_dirty_lock().

Does it make sense ?

>
> Also on a personal note.  The label name should say what the goto does
> just like a function name says what the function does.  "goto put_pages;"
> Or "goto free_foo;".
>
> Don't do this:
>
>         p = kmalloc();
>         if (!p)
>                 goto kmalloc_failed;
>
> This is a come-from label name and does not provide any information that
> is not there on the line above...
>
> If you send a patch which uses your own personal style of label names,
> I won't say anything about unless there is a bug.  But just know in your
> heart that you are wrong and I have silently reviewed your patch to
> drivers/staging.
>
> regards,
> dan carpenter

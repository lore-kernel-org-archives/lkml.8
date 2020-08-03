Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4277C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E72067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2X2zOxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHCQXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:23:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 09:23:05 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so20972545plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DuAzZZbtTCD/FunpRik00QhyAGnIAetc0b9NRlFShwk=;
        b=X2X2zOxVAHLGT14KTEzVrxN+YVOkB2JZ0AWCYwVkpNrjN6xpv7uJnHGDexGy1sYLXG
         u/2rrBX3dMh04chIdQxxkJZchGHaLBKxcZhngBPpI1VFasSgC4v1CV7ao/cPQ61yQjy5
         ei0pqTZOsbFHSlEAAvLyJh1RUzkIfIjxAaqWt3bX0QCKKb22uShKmM1/tC5A0sQV9bLo
         QHCzx1vKs8h0kr/EDTHq8Cf9LqsmD8iZjyzKETpTtAK5K04DbnFqrnx1to7mISTevhDg
         GejktA8vH2oS1es01S5SLWtAQx5+3/6aT9BW6iASea+uli0QssQRtAcK331OucnyZJcl
         +Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuAzZZbtTCD/FunpRik00QhyAGnIAetc0b9NRlFShwk=;
        b=gaJo18NWiWCn8jQ7gvq8squCutF+cjamhBv80JJ9iLYZXlnvsnSKkCLSo7bRA/HBEf
         oH8hB/6OqI5IDxv91wbJUEmLStKFgwzsUKLYVOi4ff7RqcUBsQWWqNF4cGEJsG5wHRkn
         ZERiMDhFrgu4Y3PAsD9XeZTqNY+wBrKFB0KYSUpAByOyTKfDZrjoR//SiqYTfJwgaKMD
         S4QVkwjO6MxuAFaFkkCMBVFh+Oecbd0dfdKgyWuI3Wy6Ogg3G3R/NS1ljrkj/Y2sm7Du
         gNPYml5vqjhEJU1Ak42bD3uWgJAl6Vt0yzcyd3nBZ6+QPI1waJ24a4TPJO5do8TcgVpJ
         OTqw==
X-Gm-Message-State: AOAM5337RwX5tElXF1FulEfIMlu8raFfaRfsRvebCd5wPWV/IoSrOubp
        Y/dAnvC/+aAsuMv8SmXA6jjn3+vguZsgyaNySt21FIkGlmo=
X-Google-Smtp-Source: ABdhPJw4q/ZXP9VLpgKpRjolRWqGRWM7lRrYpiraKWz+WS2rqxzSA2J4h04p9yxEq05Q+UN+KZ6A3bHJZXLviXDzUZw=
X-Received: by 2002:a67:6441:: with SMTP id y62mr12434936vsb.82.1596471784607;
 Mon, 03 Aug 2020 09:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-3-kaleshsingh@google.com> <20200803154125.GA23808@casper.infradead.org>
 <CAJuCfpFLikjaoopvt+vGN3W=m9auoK+DLQNgUf-xUbYfC=83Mw@mail.gmail.com> <20200803161230.GB23808@casper.infradead.org>
In-Reply-To: <20200803161230.GB23808@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 3 Aug 2020 09:22:53 -0700
Message-ID: <CAJuCfpGot1Lr+eS_AU30gqrrjc0aFWikxySe0667_GTJNsGTMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmabuf/tracing: Add dma-buf trace events
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 9:12 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 03, 2020 at 09:00:00AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 3, 2020 at 8:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Aug 03, 2020 at 02:47:19PM +0000, Kalesh Singh wrote:
> > > > +static void dma_buf_fd_install(int fd, struct file *filp)
> > > > +{
> > > > +     trace_dma_buf_fd_ref_inc(current, filp);
> > > > +}
> > >
> > > You're adding a new file_operation in order to just add a new tracepoint?
> > > NACK.
> >
> > Hi Matthew,
> > The plan is to attach a BPF to this tracepoint in order to track
> > dma-buf users. If you feel this is an overkill, what would you suggest
> > as an alternative?
>
> I'm sure BPF can attach to fd_install and filter on file->f_ops belonging
> to dma_buf, for example.

Sounds like a workable solution. Will explore that direction. Thanks Matthew!

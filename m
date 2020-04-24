Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FEC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F572071C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBYxr6F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDXBmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgDXBmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:42:07 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B1AC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:42:07 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n188so4212031ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l23qZuUbbo3ViqI2ySplyyQqRUP3mFV2loomTBalDSY=;
        b=aBYxr6F+mvuF4RXiZhZ7/TOOGek5Jbyxwkt0+kilTkf25Svp4JNtAznaaYMgJ0zZ2V
         boCsgBrE6gAWZuSAb+yXGK13hoTcOdG0BzrLNe8eI1wJwAuHhwnJXMY4WWYxUzOiWWg2
         59XkDBcRCM5sXCuWkJT7KifzI9p3kRz53WDtTRUB33pY2ELqKulePRiTtSHHwguyjgLU
         quQSa7k/sAIrC/AHdoJ+sOFh/zYRJOkRDVb36tJ4A+Ayd/84eSZY00bREHMni3TLB2U0
         YyRRhn0dqt3We39e8uXhyWsHjFamurc+3GipKEQ9KDKfAMs4GusXDoCM8IGvDwJfl1li
         2buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l23qZuUbbo3ViqI2ySplyyQqRUP3mFV2loomTBalDSY=;
        b=Swh1abWX+FWk4LfY0BaJBJxloGJxWLFKsNWCflREn6fLPPq9UNHm1Bh0S+3eD7IkU0
         phMwncElS0xiG8PTIi8S+wkxOlV73U8oN2kT52hBKjwytZZ2wA0PiiNUVPXOJEdDvYFe
         aqXalTh0FulGvp33BEpCXaqQjaUAzuAj9xh4+mzsVTLtERu4xtJR2/SLfAbDqrcSCHAD
         sOwMq5wOJ0nnOll5Q0SyDW/doocl+8oXWO6JsnZt2FrdQgVCuCK4YNIYg5joafvw4XSK
         gsTGJJJyxtP8nnAdm4k6z+oFDIdbMMTIRhRhQDlh+h2DVbf6NUqouJt28JaxdQzSKahE
         Fk0g==
X-Gm-Message-State: AGi0Pubx26sgFr9F/F2fOYSvGiE0zTrnlllTf+FqOyWXXdj6oJcoA9tQ
        RVCltBoU3G9qiCR57hVA/UXMB+CiidQRSvircjIghg==
X-Google-Smtp-Source: APiQypLCqGM186vZ/gOE5YTUOSqHd/vjc482HoZb0OM4rEIGLXuSpbnF7IuR9Vjy6xOqXF4+FyAS+kD9KRjNVATW/Ho=
X-Received: by 2002:a25:df03:: with SMTP id w3mr11870988ybg.224.1587692526417;
 Thu, 23 Apr 2020 18:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200423210523.52833-1-sqazi@google.com> <83078447-831c-2921-db5e-9cab4c4c12df@kernel.dk>
In-Reply-To: <83078447-831c-2921-db5e-9cab4c4c12df@kernel.dk>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 23 Apr 2020 18:41:54 -0700
Message-ID: <CAKUOC8Vb4AZnU_Sm=rxGk7QDK9=NvQT+G3Kp1cV8uVcebxsVWQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: Limit number of items taken from the I/O
 scheduler in one go
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I remailed it with the changes since v1 added.  But just to answer directly:

Changes since v1:

* Removed max_sched_batch.
* Extended the fix to the software queue.
* Use a return value from blk_mq_do_dispatch_sched to indicate if
  the dispatch should be rerun.
* Some comments added.

On Thu, Apr 23, 2020 at 2:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/23/20 3:05 PM, Salman Qazi wrote:
> > Flushes bypass the I/O scheduler and get added to hctx->dispatch
> > in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
> > hctx->run_work work item and is past the point in
> > blk_mq_sched_dispatch_requests where hctx->dispatch is checked.
> >
> > The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
> > because the I/O scheduler can feed an arbitrary number of commands.
> >
> > Since we have only one hctx->run_work, the commands waiting in
> > hctx->dispatch will wait an arbitrary length of time for run_work to be
> > rerun.
> >
> > A similar phenomenon exists with dispatches from the software queue.
> >
> > The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
> > blk_mq_do_dispatch_ctx and return from the run_work handler and let it
> > rerun.
>
> Any changes since v1? It's customary to put that in here too, below
> the --- lines.
>
> --
> Jens Axboe
>

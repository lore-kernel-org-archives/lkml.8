Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92770C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D1B20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3tSPTDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDEQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:23:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46735 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgDEQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:23:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so13594812qkj.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6xRDGarxRrQ+McG4oPgKgxZsvgT+lL55o+pn4FdRW0=;
        b=P3tSPTDy1xRCb4k4SD8xFq/6fzytUsmxxMdM64YWsMUx3U5tS7FSoWOyXGdQXL/yx2
         aPc7DVKSQ/3ZhfEsfW2SSW5Et/Zl/uzf4kwog2W8BEUyD0Rv7WDaRQc7KpiT+IvUT5XV
         p/eA9XCxpHNeW8oBcj+LcVOmpJfnXskYJ0SaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6xRDGarxRrQ+McG4oPgKgxZsvgT+lL55o+pn4FdRW0=;
        b=L0WNVbv30vLGGyOyAWmWGOBMo3X3UMHERpeLTlKtT08P1Yz1BqxpQNZVG0ODAlZzVT
         e0LDVd1+NxNDqQ57Xf1eW/PWxSfyhXD1RZuzq2fa04kTl3ce+QmWyFqYNUtdDVWj1PS2
         N/BunNrhsCiE6DnAEsjdZLWjVNV7RMCLzLHhYGmrvHEq5e0fkfsu1qZYO81y+UjdfnoY
         Xz/qWmC7qOuSjinZ5oHudwzy7RGh5S4zSPB80Nbi8/zbj3ixZTtts1GbK7YEJHkBtnXh
         Sssvyqj9U4TfcjUcDI+v73Sb6IrMhSDkM3JeOsmkq7prINVYc82PuHLExnI8EK7UbL9H
         ngbA==
X-Gm-Message-State: AGi0PubYAhxLF2S1c7oO9T0N7BoquDP3LHOIvIML4jXs0MSK61gOfozU
        zBfX9l96nhTxzJmrPZIoJIdCKqk1h/k=
X-Google-Smtp-Source: APiQypKw1a29RGxF622c2ghOgHrfgH8NtFbz6LLY4VOx2vltqeTt3uh4voyQSlih8H4xPlc3LqGsSQ==
X-Received: by 2002:a37:8bc5:: with SMTP id n188mr18388946qkd.415.1586103812862;
        Sun, 05 Apr 2020 09:23:32 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id s11sm12697762qke.97.2020.04.05.09.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 09:23:32 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id a5so7376207ybo.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:23:32 -0700 (PDT)
X-Received: by 2002:ab0:2389:: with SMTP id b9mr10876340uan.120.1586103403434;
 Sun, 05 Apr 2020 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200402155130.8264-1-dianders@chromium.org> <20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200403013356.GA6987@ming.t460p> <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
 <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com>
 <20200405091446.GA3421@localhost.localdomain> <CAD=FV=X_S_YHvKkp96f3HVM3uX0VFTCKBxNK3fEu9Yt=NB8wEQ@mail.gmail.com>
 <E316A36E-1B2B-47E8-A78C-7DD3F354425A@linaro.org>
In-Reply-To: <E316A36E-1B2B-47E8-A78C-7DD3F354425A@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 5 Apr 2020 09:16:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK=4OW2Q5i2FhrJw_+A-q+R=K8E5ui-PCQXvYhDY3ZHw@mail.gmail.com>
Message-ID: <CAD=FV=UK=4OW2Q5i2FhrJw_+A-q+R=K8E5ui-PCQXvYhDY3ZHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blk-mq: Rerun dispatching in the case of budget contention
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Salman Qazi <sqazi@google.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Ajay Joshi <ajay.joshi@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 5, 2020 at 7:55 AM Paolo Valente <paolo.valente@linaro.org> wrote:
>
> > Il giorno 5 apr 2020, alle ore 16:00, Doug Anderson <dianders@chromium.org> ha scritto:
> >
> > Hi,
> >
> > On Sun, Apr 5, 2020 at 2:15 AM Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> OK, looks it isn't specific on BFQ any more.
> >>
> >> Follows another candidate approach for this issue, given it is so hard
> >> to trigger, we can make it more reliable by rerun queue when has_work()
> >> returns true after ops->dispath_request() returns NULL.
> >>
> >> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> >> index 74cedea56034..4408e5d4fcd8 100644
> >> --- a/block/blk-mq-sched.c
> >> +++ b/block/blk-mq-sched.c
> >> @@ -80,6 +80,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >>        blk_mq_run_hw_queue(hctx, true);
> >> }
> >>
> >> +#define BLK_MQ_BUDGET_DELAY    3               /* ms units */
> >> /*
> >>  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
> >>  * its queue by itself in its completion handler, so we don't need to
> >> @@ -103,6 +104,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >>                rq = e->type->ops.dispatch_request(hctx);
> >>                if (!rq) {
> >>                        blk_mq_put_dispatch_budget(hctx);
> >> +
> >> +                       if (e->type->ops.has_work && e->type->ops.has_work(hctx))
> >> +                               blk_mq_delay_run_hw_queue(hctx, BLK_MQ_BUDGET_DELAY);
> >
> > I agree that your patch should solve the race.  With the current BFQ's
> > has_work() it's a bit of a disaster though. It will essentially put
> > blk-mq into a busy-wait loop (with a 3 ms delay between each poll)
> > while BFQ's has_work() says "true" but BFQ doesn't dispatch anything.
> >
> > ...so I guess the question that still needs to be answered: does
> > has_work() need to be exact?  If so then we need the patch you propose
> > plus one to BFQ.  If not, we should continue along the lines of my
> > patch.
> >
>
> Some more comments.  BFQ's I/O plugging lasts 9 ms by default.  So,
> with this last Ming's patch, BFQ may happen to be polled every 3ms,
> for at most three times.

Ah!  I did not know this.  OK, then Ming's patch seems like it should
work.  If nothing else it should fix the problem.  If this ends up
making BFQ chew up too much CPU time then presumably someone will
notice and BFQ's has_work() can be improved.

Ming: how do you want to proceed?  Do you want to formally post the
patch?  Do you want me to post a v3 of my series where I place patch
#2 with your patch?  Do you want authorship (which implies adding your
Signed-off-by)?


> On the opposite end, making bfq_has_work plugging aware costs more
> complexity, and possibly one more lock.  While avoiding the above
> occasional polling, this may imply a lot of overhead or CPU stalls on
> every dispatch.

I still think it would be interesting to run performance tests with my
proof-of-concept solution for has_work().  Even if it's not ideal,
knowing whether performance increased, decreased, or stayed the same
would give information about how much more effort should be put into
this.

-Doug

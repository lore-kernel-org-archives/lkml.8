Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B297C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B9E20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rgz2/Mn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDEOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:08:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35377 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDEOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:08:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id c12so4849279plz.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1Alutm8Kz0gIUiQDyHVyu0RXaT8qrBV0QAHZoy8LI8=;
        b=Rgz2/Mn+rn4dCEVcoawWzXBK5JL6tV65J4lw4QvmUiox3TESU526+qFxhBlUrPXdr6
         UOxz+3do+0YW5XmA1tmpOLMpXRfXXybaoSfMxUi28ozSZ2JMEQNzUDTr4VvmdjWwPLd4
         X4AStBSbH3MujuRQV3kB2CekDrMCOZAXxzkCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1Alutm8Kz0gIUiQDyHVyu0RXaT8qrBV0QAHZoy8LI8=;
        b=g0KIsbOb1oHkRyM7M4XRJnXGwYmjtk8lZ4ciI8BUSIdekTUWBLXxxQ9+StESxkalKb
         QVnZx9BpicIRg099PX59xPrp3ALsMAjjiGXDpZ+0YDxYJmKBu5aiMUDRHrRFuso4yMH+
         V7TlCfWgwoCO4z+/3PweYCnPmlTm47CONkfUaGgKPKjVFS01nEuLWW5WSHcG8UFA5tCq
         tM7O1ZNs/su1UApa2TCrBz7TNz8FAtqU9FrMobCT7xpC6YjFw6Jg9WkmKj2wTvlz2Rop
         r4y7BKRBvHLZKj2GyIMaLnPNLw7BOd7J7O7C1BejtLvbNHf1IKYDVycX/ztsdJoVAflV
         s5fg==
X-Gm-Message-State: AGi0PuYZfjs0c5lYQwQuz+DJmpvIdDPzpZ0v9VYudtm2WAQrCU0JwVHk
        5GRumMTz/t+S788WFS3Kj6p0bL0NGDQ=
X-Google-Smtp-Source: APiQypJ2B6ZErsCGIRPfqaln0uBatZTZFZY6lN9N0AFLLzSpk8H551rcsV7OA7W0wFTKR6HXmqC0+A==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr11596704pjy.54.1586095687586;
        Sun, 05 Apr 2020 07:08:07 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com. [209.85.216.44])
        by smtp.gmail.com with ESMTPSA id a19sm9641731pfk.110.2020.04.05.07.08.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 07:08:07 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id fh8so5317459pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:08:07 -0700 (PDT)
X-Received: by 2002:a1f:a055:: with SMTP id j82mr11678218vke.75.1586095258097;
 Sun, 05 Apr 2020 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200402155130.8264-1-dianders@chromium.org> <20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200403013356.GA6987@ming.t460p> <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
 <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com> <20200405091446.GA3421@localhost.localdomain>
In-Reply-To: <20200405091446.GA3421@localhost.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 5 Apr 2020 07:00:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_S_YHvKkp96f3HVM3uX0VFTCKBxNK3fEu9Yt=NB8wEQ@mail.gmail.com>
Message-ID: <CAD=FV=X_S_YHvKkp96f3HVM3uX0VFTCKBxNK3fEu9Yt=NB8wEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blk-mq: Rerun dispatching in the case of budget contention
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Paolo Valente <paolo.valente@linaro.org>,
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

On Sun, Apr 5, 2020 at 2:15 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> OK, looks it isn't specific on BFQ any more.
>
> Follows another candidate approach for this issue, given it is so hard
> to trigger, we can make it more reliable by rerun queue when has_work()
> returns true after ops->dispath_request() returns NULL.
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 74cedea56034..4408e5d4fcd8 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -80,6 +80,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>         blk_mq_run_hw_queue(hctx, true);
>  }
>
> +#define BLK_MQ_BUDGET_DELAY    3               /* ms units */
>  /*
>   * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
>   * its queue by itself in its completion handler, so we don't need to
> @@ -103,6 +104,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>                 rq = e->type->ops.dispatch_request(hctx);
>                 if (!rq) {
>                         blk_mq_put_dispatch_budget(hctx);
> +
> +                       if (e->type->ops.has_work && e->type->ops.has_work(hctx))
> +                               blk_mq_delay_run_hw_queue(hctx, BLK_MQ_BUDGET_DELAY);

I agree that your patch should solve the race.  With the current BFQ's
has_work() it's a bit of a disaster though. It will essentially put
blk-mq into a busy-wait loop (with a 3 ms delay between each poll)
while BFQ's has_work() says "true" but BFQ doesn't dispatch anything.

...so I guess the question that still needs to be answered: does
has_work() need to be exact?  If so then we need the patch you propose
plus one to BFQ.  If not, we should continue along the lines of my
patch.

-Doug

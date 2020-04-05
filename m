Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB29C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33650206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XGTA92Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgDEQ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 12:26:54 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46522 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgDEQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:26:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id z125so8137582vsb.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6T7ksURYXKLZGeHSyOCL3A1tNfq7XKqIZYcBs2Q8Mk=;
        b=XGTA92UoUx+18PteLh/M5XPPWiyGCoyO0TpycRQaJ3yy9na9WoTpAYQue98Z8XHztd
         ET7qSbFaFeY/zA4KtjO5TB6cx2P/T9AyqQJqpHPESPxTj4MlpRKi3vjyvLj9v26XSoFY
         uGj4taDxve29elSJ4bx++oVHe6bWOUdOYWaWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6T7ksURYXKLZGeHSyOCL3A1tNfq7XKqIZYcBs2Q8Mk=;
        b=ocaTz87VvDguCGwqssZ1ReqzA4CU0FRRiguRGYGGsfB8FqztE3yXZNMx6Uq1bqsj2h
         VwDZIsoT89WJeLe+tBmd8wqOWMQEYevLwl06uGfy2LGn878s9edrh6l5YFx9VW3LO3+3
         5G6GqEztFXISpota0Jmo0EZFL3CrniTy9Lb+Nca7kTC1TZMfG+vP5sf7zcRoLGVdEngO
         dS3jmZTYYicWMjL2spz8xylRQc86GHsbaIUiCrzu0Uod+KCsEWxn0SOkOHzbM0WHiQec
         lKm83ZQ6e3ml+5xuyVne5yCfdjaKTdTOxC9jAMKxWgA5N0+giWkWHj6zqdopAqxfqU8C
         hOKw==
X-Gm-Message-State: AGi0PuagKOQMTiyrw0gzOvsrOR6c0e+OB0xDael2EsMm4Q26Hk8lBuMR
        xzppKbSaH7xtAu0sI6hOSn35nOuMPbU=
X-Google-Smtp-Source: APiQypKzveFXLfFvirdEZzOA/jsoihW2iowyLeJ/GnTWX/7Xs6TeSfsA/tZJq+gJYjyCthbdqhXWUA==
X-Received: by 2002:a67:907:: with SMTP id 7mr12349834vsj.42.1586104013013;
        Sun, 05 Apr 2020 09:26:53 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id u84sm3748409vsc.15.2020.04.05.09.26.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 09:26:52 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id u11so8214431vsg.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 09:26:51 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr13151546vsr.169.1586104010954;
 Sun, 05 Apr 2020 09:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200402155130.8264-1-dianders@chromium.org> <20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200403013356.GA6987@ming.t460p> <CAD=FV=Ub6zhVvTj79SWPUv19RDvD0gt5EjJV-FZSbYxUy_T1OA@mail.gmail.com>
 <CAD=FV=Vsk0SjkA+DbUwJxvO6NFcr0CO9=H1FD7okJ2PxMt5pYA@mail.gmail.com> <20200405091446.GA3421@localhost.localdomain>
In-Reply-To: <20200405091446.GA3421@localhost.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sun, 5 Apr 2020 09:26:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQZA7PGEbv_fKikGOEijP+qEEZgYXWifgjDzV6BVOUMQ@mail.gmail.com>
Message-ID: <CAD=FV=WQZA7PGEbv_fKikGOEijP+qEEZgYXWifgjDzV6BVOUMQ@mail.gmail.com>
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
> @@ -103,6 +104,9 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>                 rq = e->type->ops.dispatch_request(hctx);
>                 if (!rq) {
>                         blk_mq_put_dispatch_budget(hctx);
> +
> +                       if (e->type->ops.has_work && e->type->ops.has_work(hctx))
> +                               blk_mq_delay_run_hw_queue(hctx, BLK_MQ_BUDGET_DELAY);

To really close the race, don't we need to run all the queues
associated with the hctx?  I haven't traced it through, but I've been
assuming that the multiple "hctx"s associated with the same queue will
have the same budget associated with them and thus they can block each
other out.

-Doug

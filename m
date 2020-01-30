Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D74C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3A2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgA3PhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:37:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgA3PhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:37:07 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MV2Sk-1j6RYV3xIs-00S3p5 for <linux-kernel@vger.kernel.org>; Thu, 30 Jan
 2020 16:37:06 +0100
Received: by mail-qt1-f176.google.com with SMTP id l19so2771198qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:37:05 -0800 (PST)
X-Gm-Message-State: APjAAAVSzvXBAfQPueP3bzXFwFeye4a1vV/7aTjX6Yq12YTnXdq/1ZQX
        b3+nKewe/5T1/kqGBVMFaHs7pIIzX24zkRbiZ/k=
X-Google-Smtp-Source: APXvYqxCkWZBhg4bg1vNcfrCI3V9o1JnukFHyxuV/csq9TxhQ8iZPBGMHyGyEWygs8mH72cQSiA48iKSHJWBp2VH4C4=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr5422862qtr.7.1580398624859;
 Thu, 30 Jan 2020 07:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20200107214215.935781-1-arnd@arndb.de> <20200130150451.GA25427@infradead.org>
In-Reply-To: <20200130150451.GA25427@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jan 2020 16:36:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
Message-ID: <CAK8P3a0EgfQkrSr77jE12Wm_NKemEZ1rFZLMcVhkAuu1cwOOWQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix uninitialized-variable warning
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/uaXO/mLcLBgPYk+pMt8WX7ILSUG9/56npsWyXJrqmKqfzh0J2d
 tou+kpYZkBFs9v/dkC9P6dA97mnKtaCyFgDab81IWCP0y0j7xGrCxCgvdZkGmByjwFHk2K7
 J7DB/8hAjKXlq+TYrK9K2FFfTbIeEp0WIybI8/p31UT65ex1Zl3HBcwjv6nhphisRNqYNwL
 Z9QGrkYh1szhBrqgwqjqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h2ItaTtIMLk=:mg96FVOZXd2/7v7GB4ie/L
 KVC2jWteU+9d6D6mpkejpKxZob4ObWPRoEa9kEEBHu2RurF9+cPWEE0nJ2ROuw4oHlfxdhk/B
 1N/ozXhTwl2+pqV5v9GmcHB1KW4tHYtXOtqidCuAoR+KvKCt/nvv3IZ89ZwZnxQUkJcfX4C31
 3k0YnBT4+z2zLwP09VDoZcOA7xEX7eSDqfZEMQD0d9SmYWk6uOGBU9dAnJRUHIPqA5QRe7J37
 kbnxWV6nCbcKSmzEWRwFP6+5croGfIkRBxg//Yw5U5l6oke+euC+au1rIQG28CNW2baf3bLJA
 VWAAun1FPbxakMelDrvE+pQKuNe7ILm4aixILUprzKwVwGJnZ6tKFclmYO+djFqF5RJ+UI1P5
 gnxHp5LQgHkS7VwGq7qKDaPNkaVKl+Q3icSNp/dcLCLFy/CDsGAuHoVuJmNTlIcPjhogiyJ4b
 PfB9KE4kXbm0rkwu1lycthI34lM0iHMRFrHK1hp4EsYKrrXGcctgLnK4SsUV6W4WsajExCTTz
 7lCnvUL92acj+gU2GF5HGoCbOawuJEIhEqCW0cGzvZXp9fTeT0MSmUL8tvCB4lzOosh3h3lH8
 VJmc0lpf4C9CkylVW3oJW/GotncndjYGVeLyhl7SQnze4pz8PuDf0irpZebqkCBQtIIRBbZPy
 QI6upcWvwhovxRNIhc/bLAOKJTxPGDNpI6GyTbaO9kaq2UBVZk6HMizepXCpXzfUhKmJ6Q+X/
 FkHIHtZputPPyfPC95R1SZarslAVnbdXO1ySqKQ/LbdP6+Sp1Dl4b1NbtSkiEtJj3dernayUM
 mh+LQ9RF2+6lQHpf+Dr3rZNxNqK7oqDwiJkFfg+cyxUaWu6ZPc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 07, 2020 at 10:42:08PM +0100, Arnd Bergmann wrote:
> > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/nvme/host/core.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 667f18f465be..6f0991e8c5cc 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -825,14 +825,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> >       int ret;
> >
> >       req = nvme_alloc_request(q, cmd, flags, qid);
> > -     if (IS_ERR(req))
> > -             return PTR_ERR(req);
> > +     ret = PTR_ERR_OR_ZERO(req);
> > +     if (ret < 0)
> > +             return ret;
>
> This one is just gross.  I think we'll need to find some other fix
> that doesn't obsfucate the code as much.

Initializing the nvme_result in nvme_features() would do it, as would
setting it in the error path in __nvme_submit_sync_cmd() -- either
way the compiler cannot be confused about whether it is initialized
later on.

       Arnd

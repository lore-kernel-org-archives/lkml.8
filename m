Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A417D2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgdqYyCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgIIRLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:11:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729785AbgIIPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599665564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDCg8To8PVZc/Jy4VpaJ8RUW2JiYebaTzDo+8HJa1Rs=;
        b=UgdqYyCYujoMgztJHPGb/s++My6LYZpCEkL0UpFxdigr1x0qMLOFvy7PVuKrjWJFjGL7ve
        QnoOqv5eIOkoQUanWqQsI4vMNjA+u2M3TtUMvjBJQUsKs2X3gpkOqS8t2nl2iwcyfUTDo0
        gYJlYg43qYwTnh2oZia71kmqJg6Ql/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-JfeRSkT7MpensYoeBZC00Q-1; Wed, 09 Sep 2020 11:32:41 -0400
X-MC-Unique: JfeRSkT7MpensYoeBZC00Q-1
Received: by mail-wm1-f72.google.com with SMTP id 189so965473wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDCg8To8PVZc/Jy4VpaJ8RUW2JiYebaTzDo+8HJa1Rs=;
        b=AxBZabz21EHLJMAQo8LK/R8Jn6+Nf4rrtIV0yYlr55MnxYfgcHSOxze6AuaQnohYJU
         OW71mByO5GGnwhfDkpRW9klwCprpwM+Jm5ObVBnm7hUL5QiN/lLZZbxFiLPHLLAMQMPg
         3KkP+1otoB767rky67ozo509daUrfiG8BwIuCQ6YtDPMnYe4adPVUTV3hj4wLMJIX/3i
         GRFQAizTcF3uVRu0IhJ+gdP67S/q4ZSyNiutWsoMyFrdEcSj0wny0SF8L2E+KRpo+FjO
         ev0j1qoZbFIjzColVZxdfYdUIhzNRs7wWlnJ3aV2maL3NgOrC8ayObPd6vUCfLBhV+ps
         6tQg==
X-Gm-Message-State: AOAM530RkNnbcdIicpwfJAXaSP8zXmKYoGl/nBe8lLSCR6MzMlZRjzc7
        dGK+8TpQe8PvtRpE0HpufKuRYLOZchLpNeQzQR0m9DXC7PB5yjgH8+CK78hJ7AOkpD0Mo8P3y/4
        9dOn1/j/0wJZ6IlOQkLQ2+f0P
X-Received: by 2002:a1c:c910:: with SMTP id f16mr4070521wmb.82.1599665559654;
        Wed, 09 Sep 2020 08:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrl9uLP4HdYT7AmY2PVq8Ybf24Jg2oS57iN373p/WZoSRqKSAYvg4TV3HV/QODmFgBvBaGVA==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr4070489wmb.82.1599665559309;
        Wed, 09 Sep 2020 08:32:39 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id 70sm4689288wme.15.2020.09.09.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:32:38 -0700 (PDT)
Date:   Wed, 9 Sep 2020 17:32:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in io_sq_thread_stop
Message-ID: <20200909153235.joqj6hjyxug3wtwv@steredhat>
References: <00000000000030a45905aedd879d@google.com>
 <20200909134317.19732-1-hdanton@sina.com>
 <4d55d988-d45e-ba36-fed7-342e0a6ab16e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d55d988-d45e-ba36-fed7-342e0a6ab16e@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:05:33AM -0600, Jens Axboe wrote:
> On 9/9/20 7:43 AM, Hillf Danton wrote:
> > 
> > On Wed, 9 Sep 2020 12:03:55 +0200 Stefano Garzarella wrote:
> >> On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
> >>> git tree:       linux-next
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
> >>> compiler:       gcc (GCC) 10.1.0-syz 20200507
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
> >>>
> >>> Bisection is inconclusive: the first bad commit could be any of:
> >>>
> >>> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
> >>> 7ec3d1dd io_uring: allow disabling rings during the creation
> >>
> >> I'm not sure it is related, but while rebasing I forgot to update the
> >> right label in the error path.
> >>
> >> Since the check of ring state is after the increase of ctx refcount, we
> >> need to decrease it jumping to 'out' label instead of 'out_fput':
> > 
> > I think we need to fix 6a7bb9ff5744 ("io_uring: remove need for
> > sqd->ctx_lock in io_sq_thread()") because the syzbot report
> > indicates the io_sq_thread has to wake up the kworker before
> > scheduling, and in turn the kworker has the chance to unpark it.
> > 
> > Below is the minimum walkaround I can have because it can't
> > ensure the parker will be waken in every case.
> > 
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -6834,6 +6834,10 @@ static int io_sq_thread(void *data)
> >  			io_sq_thread_drop_mm();
> >  		}
> >  
> > +		if (kthread_should_park()) {
> > +			/* wake up parker before scheduling */
> > +			continue;
> > +		}
> >  		if (ret & SQT_SPIN) {
> >  			io_run_task_work();
> >  			cond_resched();
> > 
> 
> I think this should go in the slow path:
> 
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 652cc53432d4..1c4fa2a0fd82 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -6839,6 +6839,8 @@ static int io_sq_thread(void *data)
>  		} else if (ret == SQT_IDLE) {
>  			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
>  				io_ring_set_wakeup_flag(ctx);
> +			if (kthread_should_park())
> +				continue;
>  			schedule();
>  			start_jiffies = jiffies;
>  		}
> 

Yes, I agree since only in this case the kthread is not rescheduled.

Thanks both for the fix :-)
Feel free to add my R-b:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA0C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8C20719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ68BbHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404026AbgDCO4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:56:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39502 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403981AbgDCO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=loH0Iyc8DztXgdE0IC0vivynYULzbS4RKiT0U2Rn5EM=;
        b=iQ68BbHRGrN6+kWci0oS025bVyPg8goKVvWa4hKaz+w1ejrGE7xg8o/nE4ochp5X2dHIZ9
        ppqE3Ms6vF5nDDfO0sgBQi2tS3zivEcPYUczPVBmt5+Zy7jct+JbWD1zOvN8AxaTgcliLM
        Dw1o+zkK8zIlU6L6CleM9TitW8QFzKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-gnBygK-YMCqtPQMcIlAoYA-1; Fri, 03 Apr 2020 10:56:46 -0400
X-MC-Unique: gnBygK-YMCqtPQMcIlAoYA-1
Received: by mail-wr1-f69.google.com with SMTP id a10so668499wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=loH0Iyc8DztXgdE0IC0vivynYULzbS4RKiT0U2Rn5EM=;
        b=Ruz35JRopiI7RFc/eQv0Z+MgYbZxgwaTg3EsRN5qzcV0p6nwzGEMnt7u5ambQ0U7wp
         IiFov0RJX0p4BCN2wH3R4bVFwbjmrNcaYvfUPQlgEDnBdUO18iNPF2hauD56uG5woBFD
         ME8zHv7e110mQyY+tpQpveR957Cj2rFENyWAxKOicHUEZv9cMEKJ389fGhilYqB3ckxp
         D+Cqq9w82PyKDKhs8vISWFs8Od6rZ2wJ0Umx3HOpFvxoTdnVtUQ3sdx0hh5Xw0r5gv9v
         WiBHSRvvUzHGW+IVldff+pO2Zxrxp3NjhrRrrV7fz2yDp+7sL8Rm39fRhfhxGHp6kWMC
         DgQQ==
X-Gm-Message-State: AGi0PubSAyAHg8/yoJUGZuoo9qwzOhhQQxTidCr1c4UTncKRhpTsy5jT
        90zyTjwMc4xNTozFBLGQbKRKM1SLrNzdltE8ycWUQB81MopurMstdK0hJyYcMl8mCOmwsW3kuZX
        lGeDhjHT/6X4P/MHCHQZvGh4M
X-Received: by 2002:a5d:484b:: with SMTP id n11mr285274wrs.110.1585925805553;
        Fri, 03 Apr 2020 07:56:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLl4t8+RAIQho3Ho0qyn5QfOhB6yEWA3y5ASECeRQQOMztrN2sciZlYtWlkW2IjLS9OOwFfIQ==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr285255wrs.110.1585925805311;
        Fri, 03 Apr 2020 07:56:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o129sm3783691wma.20.2020.04.03.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:56:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels
In-Reply-To: <20200403133826.GA25401@andrea>
References: <20200325225505.23998-1-parri.andrea@gmail.com> <20200325225505.23998-4-parri.andrea@gmail.com> <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea> <87pncz3tcn.fsf@vitty.brq.redhat.com> <20200328182148.GA11210@andrea> <87imim2epp.fsf@vitty.brq.redhat.com> <20200403133826.GA25401@andrea>
Date:   Fri, 03 Apr 2020 16:56:43 +0200
Message-ID: <87wo6wy5w4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Mon, Mar 30, 2020 at 02:45:54PM +0200, Vitaly Kuznetsov wrote:
>> Andrea Parri <parri.andrea@gmail.com> writes:
>> 
>> >> Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
>> >> per-cpu list of channels on the same CPU so we don't need a spinlock to
>> >> guarantee that during an interrupt we'll be able to see the update if it
>> >> happened before the interrupt (in chronological order). With a global
>> >> list of relids, who guarantees that an interrupt handler on another CPU
>> >> will actually see the modified list? 
>> >
>> > Thanks for pointing this out!
>> >
>> > The offer/resume path presents implicit full memory barriers, program
>> > -order after the array store which should guarantee the visibility of
>> > the store to *all* CPUs before the offer/resume can complete (c.f.,
>> >
>> >   tools/memory-model/Documentation/explanation.txt, Sect. #13
>> >
>> > and assuming that the offer/resume for a channel must complete before
>> > the corresponding handler, which seems to be the case considered that
>> > some essential channel fields are initialized only later...)
>> >
>> > IIUC, the spin lock approach you suggested will work and be "simpler";
>> > an obvious side effect would be, well, a global synchronization point
>> > in vmbus_chan_sched()...
>> >
>> > Thoughts?
>> 
>> This is, of course, very theoretical as if we're seeing an interrupt for
>> a channel at the same time we're writing its relid we're already in
>> trouble. I can, however, try to suggest one tiny improvement:
>
> Indeed.  I think the idea (still quite informal) is that:
>
>   1) the mapping of the channel relid is propagated to (visible from)
>      all CPUs before add_channel_work is queued (full barrier in
>      queue_work()),
>
>   2) add_channel_work is queued before the channel is opened (aka,
>      before the channel ring buffer is allocate/initalized and the
>      OPENCHANNEL msg is sent and acked from Hyper-V, cf. OPEN_STATE),
>
>   3) the channel is opened before Hyper-V can start sending interrupts
>      for the channel, and hence before vmbus_chan_sched() can find the
>      channel relid in recv_int_page set,
>
>   4) vmbus_chan_sched() finds the channel's relid in recv_int_page
>      set before it search/load from the channel array (full barrier
>      in sync_test_and_clear_bit()).
>
> This is for the "normal"/not resuming from hibernation case; for the
> latter, notice that:
>
>   a) vmbus_isr() (and vmbus_chan_sched()) can not run until when
>      vmbus_bus_resume() has finished (@resume_noirq callback),
>
>   b) vmbus_bus_resume() can not complete before nr_chan_fixup_on_resume
>      equals 0 in check_ready_for_resume_event().
>      
> (and check_ready_for_resume_event() does also provides a full barrier).
>
> If makes sense to you, I'll try to add some of the above in comments.
>

It does, thank you!

-- 
Vitaly


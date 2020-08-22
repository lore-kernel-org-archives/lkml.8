Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A36C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC25920735
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Kwe2X1e+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHVCcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 22:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHVCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 22:32:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70984C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:32:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so1710488plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEKRnglK6Uw5vxRZV01eNKU9EnkH3odhoU8NXOrchRo=;
        b=Kwe2X1e+pe5e2Smxnnt4OKAS4Ceex4ZLHfHs161gOt2iJpQrGPtapwFL9QRpTGWi/u
         wTSZPUnkUgUq1HZ9rm2O1yI/E8CBMi6hciV6525pCD/S5bH5Ng4pjhFU/dASjTi3uvlK
         8QUn9mgyngwxCkQNITQEagjuM3dHiBRdkY8PNeBY792p1MBby/c1wyFuBNjNXjATeMbB
         KNSSBHvJrKuS+DYoo7AamOZyZN+Te3D8R3kP/VvhvCxZUXONAlMXNbJrF3gGFq4nDcQ0
         pzA7GcR7FxnjWbDq0vg2UeJ3SHgpntkKVOhZcm9+JHnXigpblqfpxlckgv9FW1L4twVd
         WuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEKRnglK6Uw5vxRZV01eNKU9EnkH3odhoU8NXOrchRo=;
        b=lcSVKNgiXaoeJDwfd+zfpozrc/174RDyrwmOrNVntcHx5yQvICdrXvNstOq4OrZt5u
         4deqpg44Bt94xGKpkPUI6QIEawGDbYBu2TzM6EdKdNSBriAxchpbFnNnvcDQb0C/1XU/
         hULfSmC1peQRV3hl100iYXRW2d6rXYCJffMGls8I4ZpbvjUw6MxhafzrKboUfQbxvylj
         2ObpChrEs3kJ4N6LQ0yfwdC61rtiegKTgjHtWhed5vlIkUJo+eHrpnORdBmAdcduDh4w
         jsy/u5Z4h2mfmkTOT+0IkREDTW1k068SYjuPFG38XtqBvHn0jB8pKXQLo+cVQ1vFzMEx
         ZbDA==
X-Gm-Message-State: AOAM533Burzh5olaMzPzc9OMttP6i+eor1y5g2SsguaVRE+OFwpSAkxF
        XGaHB37EtdRrfdWq7W8Kinp7lSUz+q7d6XVvRHy2Og==
X-Google-Smtp-Source: ABdhPJxplZCmjgZ1oMazNqpuXGIO2mVoG1RLOeQlDFVEMREPxsFs97gSocjw/blLkKw4Yj840979EPyREh4NE0jffQo=
X-Received: by 2002:a17:90b:611:: with SMTP id gb17mr4794443pjb.229.1598063534893;
 Fri, 21 Aug 2020 19:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200820031933.46025-1-songmuchun@bytedance.com>
 <20200821212843.180dc6f2f417e60cff2b886c@kernel.org> <20200821222847.7d0730e4b193c3ea8da6bae2@kernel.org>
In-Reply-To: <20200821222847.7d0730e4b193c3ea8da6bae2@kernel.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 22 Aug 2020 10:31:36 +0800
Message-ID: <CAMZfGtVjenzLTLWPx7maoh2wbtiBjzqOD8Ckbzwf=LAx1GiCPA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] kprobes: Fix kill kprobe which has been
 marked as gone
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, songliubraving@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 9:28 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Fri, 21 Aug 2020 21:28:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Hi Muchun,
> >
> > On Thu, 20 Aug 2020 11:19:33 +0800
> > Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > > If a kprobe is marked as gone, we should not kill it again. Otherwise,
> > > we can disarm the kprobe more than once. In that case, the statistics
> > > of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
> > > do not work.
> > >
> >
> > Good catch! Hmm, I think we also need an assertion in
> > kill_kprobe() so that p is already gone. Anyway, this looks good to me.
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Thanks!
> >
> > > Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
>
> BTW, this fixes older bug than this commit.
>
> Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")

Yeah, it's right. Thanks.

>
> Thank you,
>
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > ---
> > >  kernel/kprobes.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index d36e2b017588..7bac3ea44ff4 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -2422,7 +2422,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
> > >     mutex_lock(&kprobe_mutex);
> > >     for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> > >             head = &kprobe_table[i];
> > > -           hlist_for_each_entry(p, head, hlist)
> > > +           hlist_for_each_entry(p, head, hlist) {
> > > +                   if (kprobe_gone(p))
> > > +                           continue;
> > > +
> > >                     if (within_module_init((unsigned long)p->addr, mod) ||
> > >                         (checkcore &&
> > >                          within_module_core((unsigned long)p->addr, mod))) {
> > > @@ -2439,6 +2442,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> > >                              */
> > >                             kill_kprobe(p);
> > >                     }
> > > +           }
> > >     }
> > >     if (val == MODULE_STATE_GOING)
> > >             remove_module_kprobe_blacklist(mod);
> > > --
> > > 2.11.0
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>



-- 
Yours,
Muchun

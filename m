Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD44C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYw0raqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAMPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:12:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43357 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:12:36 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so10119200ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SUlfi3/GqfXao1oO/G6psqHGfJrcihbQOVmO4DOC/g=;
        b=gYw0raqMhmBOlRGv/rmFVRsYYW2DhYVb3tV8Cv8TSaZMSueSL8UFYYeYqXUEhaGLax
         oaZ5FwnvAGaUvR9MHuqU7/TSwaIG/Vi5D/3I/N9YlRFGphV5xaB0VUQIUXf+JiY+QaIy
         54BlHNEwBSuInbPeSeS142k1Q9r7CA2JSWRQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SUlfi3/GqfXao1oO/G6psqHGfJrcihbQOVmO4DOC/g=;
        b=ixD/mHKWerfNIq5Hjprmd37ZRHCf88RkWl/KUsXLUyH2CJUOUzm0/UaBJLh+PefAih
         8Fpo40uKV3h/TWSZc9f6lX7IfbF6K0eC6eohWa3lR6pVUWwTNWaaOq+JHwcA6EXCq8Ed
         ohseeu9isHVghpcYYOk2iwc8zyDOL6EOwDuyHTgww9NeQJqa8Xo5erJxSFC8u2XOch1o
         14ZPluhveIZnmOyEGQCOzvbcvt+Myr8PjNn0FF2ww0ynYSNfnlI58Xo2PA7LKKz31bbM
         ys/HAcIku56eYgVTATENG2EfjxqhQDWwZHn6g7M9CnxnBGXW5qN47VtMELYXJLT+GEWN
         WMIg==
X-Gm-Message-State: APjAAAUV+p+Z6Gds2WHkvTFNwMiiRLSO26jMSWiL2klD82DHntIbWTvP
        ZlY4pV3jgyqv/VvRxhciuckEmctiWOvLAmfKYsC6Og==
X-Google-Smtp-Source: APXvYqzFJOiKRHYMf0ckRaIKnY2QZ2S3371VLktefyf0rROyHqbhr3XyFFGDSdtF4JKWrEQX7WoPWn2K7HNlPFTYZb4=
X-Received: by 2002:a6b:3845:: with SMTP id f66mr13666899ioa.102.1578928355244;
 Mon, 13 Jan 2020 07:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20200113120157.85798-1-hsinyi@chromium.org> <20200113120157.85798-2-hsinyi@chromium.org>
 <87r203plr7.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r203plr7.fsf@vitty.brq.redhat.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 13 Jan 2020 23:12:09 +0800
Message-ID: <CAJMQK-gXbs+B8HCdKHvgDf3NpP_YfkheMXzzWHMcoTzZuP-9hw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/3] reboot: support hotplug CPUs before reboot
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 8:46 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

Thanks for your comments.

> > +config REBOOT_HOTPLUG_CPU
> > +     bool "Support for hotplug CPUs before reboot"
> > +     depends on HOTPLUG_CPU
> > +     help
> > +       Say Y to do a full hotplug on secondary CPUs before reboot.
>
> I'm not sure this should be a configurable option, e.g. in case this is
> a good approach in general, why not just use CONFIG_HOTPLUG_CPU in the
> code?
>
In v2 it uses CONFIG_HOTPLUG_CPU, but I think adding another config is
more flexible. Maybe there are some architecture that supports
HOTPLUG_CPU but doesn't want to do full cpu hotplug before reboot.
(Eg. doing cpu hotplug would make reboot process slower.)
> > +
> >  config HAVE_OPROFILE
> >       bool
> >
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index 1ca2baf817ed..3bf5ab289954 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -118,6 +118,9 @@ extern void cpu_hotplug_disable(void);
> >  extern void cpu_hotplug_enable(void);
> >  void clear_tasks_mm_cpumask(int cpu);
> >  int cpu_down(unsigned int cpu);
> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> > +extern void offline_secondary_cpus(int primary);
> > +#endif
> >
> >  #else /* CONFIG_HOTPLUG_CPU */
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 9c706af713fb..52afc47dd56a 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1057,6 +1057,25 @@ int cpu_down(unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL(cpu_down);
> >
> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> > +void offline_secondary_cpus(int primary)
> > +{
> > +     int i, err;
> > +
> > +     cpu_maps_update_begin();
> > +
> > +     for_each_online_cpu(i) {
> > +             if (i == primary)
> > +                     continue;
> > +             err = _cpu_down(i, 0, CPUHP_OFFLINE);
> > +             if (err)
> > +                     pr_warn("Failed to offline cpu %d\n", i);
> > +     }
> > +     cpu_hotplug_disabled++;
> > +
> > +     cpu_maps_update_done();
> > +}
> > +#endif
>
> This looks like a simplified version of freeze_secondary_cpus(), can
> they be merged?
>
Comparing to freeze_secondary_cpus(),  I think it's not necessary to
check pm_wakeup_pending() before _cpu_down() here. Thus it doesn't
need to depend on CONFIG_PM_SLEEP_SMP.
Also I think it could continue to offline other CPUs even one fails,
while freeze_secondary_cpus() would stop once it fails on offlining
one CPU.
Based on these differences, I didn't use freeze_secondary_cpus() here.
As for merging the common part, it might need additional flags to
handle the difference, which might lower the readability.
>

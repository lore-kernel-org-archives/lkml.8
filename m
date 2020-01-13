Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C222A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ai7Aeeg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgAMRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:01:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37377 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:01:15 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so8784240iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GX/5iCiZVyWHAxwX+ifn8XhMI3EhrDTJyX/hxFYQsc=;
        b=Ai7Aeeg+fyzRqiKZUI7Q5madDAVj9MDhbC+sh2pkTtg5w/h5v/QosfWC9Kk0ko91SN
         +WCzIucgq6NRcNxdFuq7ggMqnlLl1woI+Sw0egWHUsHmSCw5SqDEhnDdWFhpR/lM5S2p
         IqsIwAUTYlsUNoy259ffBzfdMumUYAcdnLUR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GX/5iCiZVyWHAxwX+ifn8XhMI3EhrDTJyX/hxFYQsc=;
        b=JbhRYFkjJjigGlHmZroqwfEut4Fe758MWYh2Oe3Hsx6SrkJsGciaLxTZcYkLk/PqlM
         I/2l5f2RleAKU7cMHbJl+bGJZI30u6/phGJ/neQAhcf08OHqkTValLobcz1Y6oj2iGYB
         KM0+pPo3G35YHuEky11b5TZ8qAaJ+u3t1GNJmGDZ/VZ5+z4Gup8eAIfCg2nJDseaPekn
         YIpTpZ85D99WOIQKBa18TpmnpCDJeRVIEVBCsL7vUBDwvUaNQAO4zI7PHN1RyjXvr7ns
         DVktaTvpn2ineJYCEhwgJZUhLuFfVUy1Dfk/ZIdEMv1HAL3Rz3UDa8XhUYqc8JN0OEop
         aKog==
X-Gm-Message-State: APjAAAVSOuRnDK6e7yqVN2kSKMw2r1FfSZ6WSMIro+dRUGoZPtII0Jew
        lyrt74TQxZRF/WnI+FhyykVvwlTKlsqi+0Mdw+ryZg==
X-Google-Smtp-Source: APXvYqx1TQJMDp0u+7RMhBdaQnofktELRVj8l+7G8d1pfFxA4kt+F+CvQKJOnkdmrOx0Phd9aPF6j5V20Sm69o7TrgU=
X-Received: by 2002:a92:af8e:: with SMTP id v14mr15089408ill.150.1578934874420;
 Mon, 13 Jan 2020 09:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20200113120157.85798-1-hsinyi@chromium.org> <20200113120157.85798-2-hsinyi@chromium.org>
 <87r203plr7.fsf@vitty.brq.redhat.com> <CAJMQK-gXbs+B8HCdKHvgDf3NpP_YfkheMXzzWHMcoTzZuP-9hw@mail.gmail.com>
 <87muarpcwm.fsf@vitty.brq.redhat.com>
In-Reply-To: <87muarpcwm.fsf@vitty.brq.redhat.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 14 Jan 2020 01:00:48 +0800
Message-ID: <CAJMQK-hPy9XaWbMUB-5zMR6eJHvqU3nBVjoLPR2dstMmtrZ-VQ@mail.gmail.com>
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

On Mon, Jan 13, 2020 at 11:57 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > On Mon, Jan 13, 2020 at 8:46 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > Thanks for your comments.
> >
> >> > +config REBOOT_HOTPLUG_CPU
> >> > +     bool "Support for hotplug CPUs before reboot"
> >> > +     depends on HOTPLUG_CPU
> >> > +     help
> >> > +       Say Y to do a full hotplug on secondary CPUs before reboot.
> >>
> >> I'm not sure this should be a configurable option, e.g. in case this is
> >> a good approach in general, why not just use CONFIG_HOTPLUG_CPU in the
> >> code?
> >>
> > In v2 it uses CONFIG_HOTPLUG_CPU, but I think adding another config is
> > more flexible. Maybe there are some architecture that supports
> > HOTPLUG_CPU but doesn't want to do full cpu hotplug before reboot.
> > (Eg. doing cpu hotplug would make reboot process slower.)
>
> In that case this should be an architectural decision, not a selectable
> option. If you want to enable it for certain arches only (and not the
> other way around), that would look like
>
> config ARCH_HAS_HOTUNPLUG_CPUS_ON_REBOOT
>         bool
>
> ...
>
> config X86
>         def_bool y
>         ...
>         select ARCH_HAS_HOTUNPLUG_CPUS_ON_REBOOT
>
> because as a user, I really have no idea if I want to 'unplug secondary
> CPUs on reboot' or not.
>
Thanks for the example. I would use this way in next version.
> >> > +
> >> >  config HAVE_OPROFILE
> >> >       bool
> >> >
> >> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> >> > index 1ca2baf817ed..3bf5ab289954 100644
> >> > --- a/include/linux/cpu.h
> >> > +++ b/include/linux/cpu.h
> >> > @@ -118,6 +118,9 @@ extern void cpu_hotplug_disable(void);
> >> >  extern void cpu_hotplug_enable(void);
> >> >  void clear_tasks_mm_cpumask(int cpu);
> >> >  int cpu_down(unsigned int cpu);
> >> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> >> > +extern void offline_secondary_cpus(int primary);
> >> > +#endif
> >> >
> >> >  #else /* CONFIG_HOTPLUG_CPU */
> >> >
> >> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> >> > index 9c706af713fb..52afc47dd56a 100644
> >> > --- a/kernel/cpu.c
> >> > +++ b/kernel/cpu.c
> >> > @@ -1057,6 +1057,25 @@ int cpu_down(unsigned int cpu)
> >> >  }
> >> >  EXPORT_SYMBOL(cpu_down);
> >> >
> >> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> >> > +void offline_secondary_cpus(int primary)
> >> > +{
> >> > +     int i, err;
> >> > +
> >> > +     cpu_maps_update_begin();
> >> > +
> >> > +     for_each_online_cpu(i) {
> >> > +             if (i == primary)
> >> > +                     continue;
> >> > +             err = _cpu_down(i, 0, CPUHP_OFFLINE);
> >> > +             if (err)
> >> > +                     pr_warn("Failed to offline cpu %d\n", i);
> >> > +     }
> >> > +     cpu_hotplug_disabled++;
> >> > +
> >> > +     cpu_maps_update_done();
> >> > +}
> >> > +#endif
> >>
> >> This looks like a simplified version of freeze_secondary_cpus(), can
> >> they be merged?
> >>
> > Comparing to freeze_secondary_cpus(),  I think it's not necessary to
> > check pm_wakeup_pending() before _cpu_down() here. Thus it doesn't
> > need to depend on CONFIG_PM_SLEEP_SMP.
> > Also I think it could continue to offline other CPUs even one fails,
> > while freeze_secondary_cpus() would stop once it fails on offlining
> > one CPU.
> > Based on these differences, I didn't use freeze_secondary_cpus() here.
> > As for merging the common part, it might need additional flags to
> > handle the difference, which might lower the readability.
>
> I have to admit I'm not convinced (but maintainers may disagree of
> course): #ifdefs are there to avoid compiling code which we don't need,
> in case a second user emerges we can drop them or #ifdef just some parts
> of it, it's not set in stone. Also, in case the only difference is that
> you don't want to stop if some CPU fails to offline, a single bool flag
> (e.g. 'force') would solve the problem, I don't see a significant
> readability change.
>
Okay, I will merge them with an additional flag for whether it should
check pm_wakeup_pending() and break on error.
> --
> Vitaly
>

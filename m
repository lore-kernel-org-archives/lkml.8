Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37472C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306820678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnycnXX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:57:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20569 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728650AbgAMP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578931054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvyprAPcFK8o12jmnCTy6nT/O3F1l+Lxn2TnJQUdcbk=;
        b=GnycnXX5IdPc3joM5sbs+CCXd+YJVS56rT0Vsu88SQ0LNTUd/WAqN1ox1+cp2rxeeaXiOj
        alAvmAczqwbwn5eBbl8uA/lAvO+BNJoPnUEiph9bgoXtOqR4dsH5P+SRUA/l1SHWWZUSzJ
        2Jgt9ePOTvTiZjdrEsVfOmV9GVO4Ujo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-zyp6m_z5M5eDUUjQCAtl6g-1; Mon, 13 Jan 2020 10:57:33 -0500
X-MC-Unique: zyp6m_z5M5eDUUjQCAtl6g-1
Received: by mail-wm1-f70.google.com with SMTP id t17so1349425wmi.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mvyprAPcFK8o12jmnCTy6nT/O3F1l+Lxn2TnJQUdcbk=;
        b=MpJ98gOELVDMdA5xsc6+upkn0Q97YIaP9DOxhLjHoTiZeFV9D8WjybfXCW5nl5PCBz
         SsezRvsHfxc7xXyLR2mSFyAFeFU+QcLL/v1/MwkOD+WNomsLlSxUeDAukwXKky1gWTGz
         Q0X5Wv+2sR92ABTW25PQokZNrWh10cQAAhtWvilB0Nno5+SnsnlVCBA0YwqfQdPdDeSI
         1z22LuYwKKFQO/EL9glAX9l4zRysXD2mG8F9/wwcYKdQ9P9KSE5/sr32at8yT5NDPbOl
         SRNyU9toRyP6wEZeqdr6GYVIZVOA4Bsqwp4TY78nTLO9339iR3QjDtkjGfOVmUSPaM6l
         RZkw==
X-Gm-Message-State: APjAAAU3BgZJL/gVos+RMl0tFggd0Cow6bWi7KtsOb0lj0Memwtuxbiw
        nfT0BYwfENFp8CvgwePzRy0j5M656R3cs5FnpQPQwC6MoqnMen3x4QcFpUpW5fU7Ko9m9xj8Fhq
        KLHsYnsvZxZHG1ccSrK9kmYzr
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr20214689wrx.304.1578931052015;
        Mon, 13 Jan 2020 07:57:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwD+bZ80cPZbwUBRL05n2kLSuCQIbt/FwOXBAEElxf9CDR5Kf1aP66EoDIEzE6rkizRraQExQ==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr20214619wrx.304.1578931051326;
        Mon, 13 Jan 2020 07:57:31 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o129sm14837926wmb.1.2020.01.13.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:57:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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
Subject: Re: [PATCH RFC v3 1/3] reboot: support hotplug CPUs before reboot
In-Reply-To: <CAJMQK-gXbs+B8HCdKHvgDf3NpP_YfkheMXzzWHMcoTzZuP-9hw@mail.gmail.com>
References: <20200113120157.85798-1-hsinyi@chromium.org> <20200113120157.85798-2-hsinyi@chromium.org> <87r203plr7.fsf@vitty.brq.redhat.com> <CAJMQK-gXbs+B8HCdKHvgDf3NpP_YfkheMXzzWHMcoTzZuP-9hw@mail.gmail.com>
Date:   Mon, 13 Jan 2020 16:57:29 +0100
Message-ID: <87muarpcwm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> On Mon, Jan 13, 2020 at 8:46 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Thanks for your comments.
>
>> > +config REBOOT_HOTPLUG_CPU
>> > +     bool "Support for hotplug CPUs before reboot"
>> > +     depends on HOTPLUG_CPU
>> > +     help
>> > +       Say Y to do a full hotplug on secondary CPUs before reboot.
>>
>> I'm not sure this should be a configurable option, e.g. in case this is
>> a good approach in general, why not just use CONFIG_HOTPLUG_CPU in the
>> code?
>>
> In v2 it uses CONFIG_HOTPLUG_CPU, but I think adding another config is
> more flexible. Maybe there are some architecture that supports
> HOTPLUG_CPU but doesn't want to do full cpu hotplug before reboot.
> (Eg. doing cpu hotplug would make reboot process slower.)

In that case this should be an architectural decision, not a selectable
option. If you want to enable it for certain arches only (and not the
other way around), that would look like

config ARCH_HAS_HOTUNPLUG_CPUS_ON_REBOOT
	bool

...

config X86
        def_bool y
        ...
        select ARCH_HAS_HOTUNPLUG_CPUS_ON_REBOOT

because as a user, I really have no idea if I want to 'unplug secondary
CPUs on reboot' or not.

>> > +
>> >  config HAVE_OPROFILE
>> >       bool
>> >
>> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
>> > index 1ca2baf817ed..3bf5ab289954 100644
>> > --- a/include/linux/cpu.h
>> > +++ b/include/linux/cpu.h
>> > @@ -118,6 +118,9 @@ extern void cpu_hotplug_disable(void);
>> >  extern void cpu_hotplug_enable(void);
>> >  void clear_tasks_mm_cpumask(int cpu);
>> >  int cpu_down(unsigned int cpu);
>> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
>> > +extern void offline_secondary_cpus(int primary);
>> > +#endif
>> >
>> >  #else /* CONFIG_HOTPLUG_CPU */
>> >
>> > diff --git a/kernel/cpu.c b/kernel/cpu.c
>> > index 9c706af713fb..52afc47dd56a 100644
>> > --- a/kernel/cpu.c
>> > +++ b/kernel/cpu.c
>> > @@ -1057,6 +1057,25 @@ int cpu_down(unsigned int cpu)
>> >  }
>> >  EXPORT_SYMBOL(cpu_down);
>> >
>> > +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
>> > +void offline_secondary_cpus(int primary)
>> > +{
>> > +     int i, err;
>> > +
>> > +     cpu_maps_update_begin();
>> > +
>> > +     for_each_online_cpu(i) {
>> > +             if (i == primary)
>> > +                     continue;
>> > +             err = _cpu_down(i, 0, CPUHP_OFFLINE);
>> > +             if (err)
>> > +                     pr_warn("Failed to offline cpu %d\n", i);
>> > +     }
>> > +     cpu_hotplug_disabled++;
>> > +
>> > +     cpu_maps_update_done();
>> > +}
>> > +#endif
>>
>> This looks like a simplified version of freeze_secondary_cpus(), can
>> they be merged?
>>
> Comparing to freeze_secondary_cpus(),  I think it's not necessary to
> check pm_wakeup_pending() before _cpu_down() here. Thus it doesn't
> need to depend on CONFIG_PM_SLEEP_SMP.
> Also I think it could continue to offline other CPUs even one fails,
> while freeze_secondary_cpus() would stop once it fails on offlining
> one CPU.
> Based on these differences, I didn't use freeze_secondary_cpus() here.
> As for merging the common part, it might need additional flags to
> handle the difference, which might lower the readability.

I have to admit I'm not convinced (but maintainers may disagree of
course): #ifdefs are there to avoid compiling code which we don't need,
in case a second user emerges we can drop them or #ifdef just some parts
of it, it's not set in stone. Also, in case the only difference is that
you don't want to stop if some CPU fails to offline, a single bool flag
(e.g. 'force') would solve the problem, I don't see a significant
readability change.

-- 
Vitaly


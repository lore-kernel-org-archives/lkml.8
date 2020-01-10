Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79531C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2D62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5IFnsFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgAJK66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:58:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32948 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgAJK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:58:57 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so1649191ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlbcVSb51HWE+FwIuewJKkQb6b2R8//lfQVmKPB42ok=;
        b=Y5IFnsFNoBtiaTR6MocCoq2qDLtJB0jJ27O8o/ULMJAcB5A0utQj7sXN6hZBT8UR5O
         WUoIQonPcKqqrnu+cnl5ZeDKii+KFH+JdiwnUdgOdQMZRtHTsH7X2pBVdFJQ4NrQXCqK
         cdIAJESzBHXDFtq0/5nsNVI/4u5BTeKdv/9Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlbcVSb51HWE+FwIuewJKkQb6b2R8//lfQVmKPB42ok=;
        b=hgD9QOuPdTDSbiIfmFIskWrIhUbBay/4lNgJL8ispuJ45mZkzILMM3zOhjqMUriALx
         ddmkh26N1QWptpRtJiJMs62JeCaLivI5t6bUXtFjBn3SUFn1aQJEyafBo1yIDVId41gy
         zdEBypVqf3NqI+SF5JxXF0iZovRVTUslgdxSRdXHHUIh169A6AI1YT90o/TWDj5moN9a
         kbKOwWqJ5IEAQ06YiFiLamWkzrkiC1Gvdnez8dUvxFFwOdBm7/je+15eoAfCUXzSEGLz
         IsD1NB1EupQ/q/TgvZ9CYwTAU5j/HmDuciGDut+gB0qUl3x/mLyOiEMR2naQFpRQpH59
         shww==
X-Gm-Message-State: APjAAAW4pLTTD4++52sQ3IKcHtu6lTD+/zbj3nQ3w1JlMmdSf8scAmf6
        iGEqLXG1ZTAtMsgJlqP9eJ/ce6X7mFKqICKnvgjc8Q==
X-Google-Smtp-Source: APXvYqx6QHga1qqeC4hzfZbeyr6cH5rPqsgP2hU5N29tuj3lh3dg4B1XImkZKeptOiz8qLJCHjX60MQgkSIUNHNOsCM=
X-Received: by 2002:a5d:9c10:: with SMTP id 16mr1864331ioe.150.1578653937032;
 Fri, 10 Jan 2020 02:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20191009232655.48583-1-hsinyi@chromium.org> <87blrcbd3n.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blrcbd3n.fsf@nanos.tec.linutronix.de>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 10 Jan 2020 18:58:30 +0800
Message-ID: <CAJMQK-ijrdcG-WKcNmgWu4ng5_TxrdYPr0TV0uAqS8UcFuL1ug@mail.gmail.com>
Subject: Re: [PATCH RFC v2] reboot: hotplug cpus in migrate_to_reboot_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > @@ -220,8 +221,6 @@ void migrate_to_reboot_cpu(void)
> >       /* The boot cpu is always logical cpu 0 */
> >       int cpu = reboot_cpu;
> >
> > -     cpu_hotplug_disable();
> > -
> >       /* Make certain the cpu I'm about to reboot on is online */
> >       if (!cpu_online(cpu))
> >               cpu = cpumask_first(cpu_online_mask);
> > @@ -231,6 +230,11 @@ void migrate_to_reboot_cpu(void)
> >
> >       /* Make certain I only run on the appropriate processor */
> >       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> > +
> > +     /* Hotplug other cpus if possible */
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +     offline_secondary_cpus(cpu);
> > +#endif
>
> In general I like the idea, but shouldn't this remove the architecture
> code as a follow up?
>
> Also this needs to be explicitely enabled per architecture (opt-in) and
> not as an unconditional operation for all architectures which support
> CPU hotplug.
>
> Thanks,
>
>         tglx

Thanks for your comment.

I'll make this another config and depends on HOTPLUG_CPU.

I did some check on how architectures implement smp_send_stop. Most
architecture would loop through all other cpus in cpu_online_mask and
call ipi stop to each. If they enable this config, the loop would be
empty loop. In case they don't enable this config, they still need
original smp_send_stop (or as a fallback if some cpus fails to
offline).
Currently there are 2 architectures (csky, alpha) that call ipi on
possible cpus (instead of online cpus). Besides this, I'm not sure if
there's other architecture code that should be cleaned up.

Thanks,

Hsin-Yi

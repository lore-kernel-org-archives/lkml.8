Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77963C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441D721D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9fBDua5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSKAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:00:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42459 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBSKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:00:18 -0500
Received: by mail-io1-f68.google.com with SMTP id z1so25142116iom.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8De8fz7bsiPi+rxf171LdpvWNZJLQq3TPj0+x4vwjc=;
        b=e9fBDua5k7kesXY9nVLuwsqJex+AojArkjJ57bX5JkA/7k2Cw1cIGUsn7UOtGw5H3Y
         sQN9uuERhSBMnT9yuhlFy0WtXQMZG6LBsUlOcXsyb9RJcbPtqh2UKb5wIK1KVNI0l+Is
         Yo8zb09bT/6xtvfglQu3twEIl9FZf/2UMZLx6l/PdNb18XGsBcY2ZB+TihdJhszVSZhl
         g0SWU5QN/kwoz8ijkrs+8iwtfYbV6LoSRaJsABTAWki0pAOJ61xTI8iAuRDnWPcYdMS8
         Dq6kHgl3JfsMQfI0yKITAxQ9QFv5ZcNlaFf7iXrZ9qEPzp27QC9B7XKJjtxxGkojvpov
         35oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8De8fz7bsiPi+rxf171LdpvWNZJLQq3TPj0+x4vwjc=;
        b=c26vGBs50a/eeGTLpWUK6J6vnORJzCE2SeXcl1HP1bg4QrEbAoJm/ZI1SIhyquZ5a6
         BhkZvl8dLAmiGcSVSJib+1oSaZsKRxIkdArGeby0OEHzxksZOJeF8nUZ0GnEKg64pv1P
         4fxsgf2bszZcdVmAGZ2w9DrzQs8XxjmbtacsqPyLoNT5dI3yIReZqIE3nmLe/jpC505o
         lEq8yiv8okXTVIBAEg9X4HFQLES2yQB49ZRIpqzkAuTQCGji5IWD5XWGAtwclgk/vLBa
         yzcK7E1QQ2CheSlrbjijwdt/5RYkm6+LvaPfWKlvy0Xsa8EfwZMD72M81yQnEfRAuXZQ
         VcfA==
X-Gm-Message-State: APjAAAUbYHWcZ4MatmQUyBbVbnGvtS7MOEY5TuFHM7w0B7J2gak75ifq
        e+nJqwiDIQaKyH5UHDh4wBaZZyhjQb7/umwbVgw=
X-Google-Smtp-Source: APXvYqwUzDfTQvaPcYEkpiyt6L44VomWqUiHJYpXBpK11rzki6vl6FCoQvE6mfF1NPOvhGR2MM/GMAAQR+9OFr4LlKM=
X-Received: by 2002:a6b:6604:: with SMTP id a4mr19874115ioc.300.1582106416969;
 Wed, 19 Feb 2020 02:00:16 -0800 (PST)
MIME-Version: 1.0
References: <CADjb_WQ0wFgZWBo0Xo1Q+NWS6vF0BSs5H0ho+5FM82Mu-JVYoQ@mail.gmail.com>
 <787302f0-670f-fadf-14e6-ea0a73603d77@arm.com>
In-Reply-To: <787302f0-670f-fadf-14e6-ea0a73603d77@arm.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 19 Feb 2020 18:00:05 +0800
Message-ID: <CADjb_WR+611uXfPjME4dTeLRPsKTYoR52X4KSuxhZts1SSnrWA@mail.gmail.com>
Subject: Re: [RFC] Display the cpu of sched domain in procfs
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Tony Luck <tony.luck@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,
Thanks very much for looking at my question,
On Wed, Feb 19, 2020 at 4:13 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi,
>
> On 19/02/2020 07:15, Chen Yu wrote:
> > Problem:
> > sched domain topology is not always consistent with the CPU topology exposed at
> > /sys/devices/system/cpu/cpuX/topology,  which makes it
> > hard for monitor tools to distinguish the CPUs among different sched domains.
> >
> > For example, on x86 if there are NUMA nodes within a package, say,
> > SNC(Sub-Numa-Cluster),
> > then there would be no die sched domain but only NUMA sched domains
> > created. As a result,
> > you don't know what the sched domain hierarchical is by only looking
> > at /sys/devices/system/cpu/cpuX/topology.
> >
> > Although by appending sched_debug in command line would show the sched
> > domain CPU topology,
> > it is only printed once during boot up, which makes it hard to track
> > at run-time.
> >
>
> It should (and in my experience, is) be printed any time there is a sched
> domain update - hotplug, cpusets, IOW not just at bootup.
>
Right, whenever domain has changed it will be printed.
> e.g. if I hotplug out a CPU:
>
> root@valsch-juno:~# echo 0 > /sys/devices/system/cpu/cpu3/online
> [40150.882586] CPU3: shutdown
> [40150.885383] psci: CPU3 killed (polled 0 ms)
> [40150.891362] CPU0 attaching NULL sched-domain.
> [40150.895954] CPU1 attaching NULL sched-domain.
> [40150.900433] CPU2 attaching NULL sched-domain.
> [40150.906583] CPU3 attaching NULL sched-domain.
> [40150.910998] CPU4 attaching NULL sched-domain.
> [40150.915444] CPU5 attaching NULL sched-domain.
> [40150.920108] CPU0 attaching sched-domain(s):
> [40150.924396]  domain-0: span=0,4-5 level=MC
> [40150.928592]   groups: 0:{ span=0 cap=444 }, 4:{ span=4 cap=445 }, 5:{ span=5 cap=446 }
> [40150.936684]   domain-1: span=0-2,4-5 level=DIE
> [40150.941207]    groups: 0:{ span=0,4-5 cap=1335 }, 1:{ span=1-2 cap=2041 }
> [40150.948107] CPU1 attaching sched-domain(s):
> [40150.952342]  domain-0: span=1-2 level=MC
> [40150.956311]   groups: 1:{ span=1 cap=1020 }, 2:{ span=2 cap=1021 }
> [40150.962592]   domain-1: span=0-2,4-5 level=DIE
> [40150.967082]    groups: 1:{ span=1-2 cap=2041 }, 0:{ span=0,4-5 cap=1335 }
> [40150.973984] CPU2 attaching sched-domain(s):
> [40150.978208]  domain-0: span=1-2 level=MC
> [40150.982176]   groups: 2:{ span=2 cap=1021 }, 1:{ span=1 cap=1021 }
> [40150.988431]   domain-1: span=0-2,4-5 level=DIE
> [40150.992922]    groups: 1:{ span=1-2 cap=2042 }, 0:{ span=0,4-5 cap=1335 }
> [40150.999819] CPU4 attaching sched-domain(s):
> [40151.004045]  domain-0: span=0,4-5 level=MC
> [40151.008186]   groups: 4:{ span=4 cap=445 }, 5:{ span=5 cap=446 }, 0:{ span=0 cap=444 }
> [40151.016220]   domain-1: span=0-2,4-5 level=DIE
> [40151.020722]    groups: 0:{ span=0,4-5 cap=1335 }, 1:{ span=1-2 cap=2044 }
> [40151.027619] CPU5 attaching sched-domain(s):
> [40151.031843]  domain-0: span=0,4-5 level=MC
> [40151.035985]   groups: 5:{ span=5 cap=446 }, 0:{ span=0 cap=444 }, 4:{ span=4 cap=445 }
> [40151.044021]   domain-1: span=0-2,4-5 level=DIE
> [40151.048512]    groups: 0:{ span=0,4-5 cap=1335 }, 1:{ span=1-2 cap=2043 }
> [40151.055440] root domain span: 0-2,4-5 (max cpu_capacity = 1024)
>
>
> Same for setting up cpusets:
>
> root@valsch-juno:~# cgset -r cpuset.mems=0 asym
> root@valsch-juno:~# cgset -r cpuset.cpu_exclusive=1 asym
> root@valsch-juno:~#
> root@valsch-juno:~# cgcreate -g cpuset:smp
> root@valsch-juno:~# cgset -r cpuset.cpus=4-5 smp
> root@valsch-juno:~# cgset -r cpuset.mems=0 smp
> root@valsch-juno:~# cgset -r cpuset.cpu_exclusive=1 smp
> root@valsch-juno:~#
> root@valsch-juno:~# cgset -r cpuset.sched_load_balance=0 .
> [40224.135466] CPU0 attaching NULL sched-domain.
> [40224.140038] CPU1 attaching NULL sched-domain.
> [40224.144531] CPU2 attaching NULL sched-domain.
> [40224.148951] CPU3 attaching NULL sched-domain.
> [40224.153366] CPU4 attaching NULL sched-domain.
> [40224.157811] CPU5 attaching NULL sched-domain.
> [40224.162394] CPU0 attaching sched-domain(s):
> [40224.166623]  domain-0: span=0,3 level=MC
> [40224.170624]   groups: 0:{ span=0 cap=445 }, 3:{ span=3 cap=446 }
> [40224.176709]   domain-1: span=0-3 level=DIE
> [40224.180884]    groups: 0:{ span=0,3 cap=891 }, 1:{ span=1-2 cap=2044 }
> [40224.187497] CPU1 attaching sched-domain(s):
> [40224.191753]  domain-0: span=1-2 level=MC
> [40224.195724]   groups: 1:{ span=1 cap=1021 }, 2:{ span=2 cap=1023 }
> [40224.202010]   domain-1: span=0-3 level=DIE
> [40224.206154]    groups: 1:{ span=1-2 cap=2044 }, 0:{ span=0,3 cap=890 }
> [40224.212792] CPU2 attaching sched-domain(s):
> [40224.217020]  domain-0: span=1-2 level=MC
> [40224.220989]   groups: 2:{ span=2 cap=1023 }, 1:{ span=1 cap=1020 }
> [40224.227244]   domain-1: span=0-3 level=DIE
> [40224.231386]    groups: 1:{ span=1-2 cap=2042 }, 0:{ span=0,3 cap=889 }
> [40224.238025] CPU3 attaching sched-domain(s):
> [40224.242252]  domain-0: span=0,3 level=MC
> [40224.246221]   groups: 3:{ span=3 cap=446 }, 0:{ span=0 cap=443 }
> [40224.252329]   domain-1: span=0-3 level=DIE
> [40224.256474]    groups: 0:{ span=0,3 cap=889 }, 1:{ span=1-2 cap=2042 }
> [40224.263142] root domain span: 0-3 (max cpu_capacity = 1024)
> [40224.268945] CPU4 attaching sched-domain(s):
> [40224.273200]  domain-0: span=4-5 level=MC
> [40224.277173]   groups: 4:{ span=4 cap=446 }, 5:{ span=5 cap=444 }
> [40224.283291] CPU5 attaching sched-domain(s):
> [40224.287517]  domain-0: span=4-5 level=MC
> [40224.291487]   groups: 5:{ span=5 cap=444 }, 4:{ span=4 cap=446 }
> [40224.297584] root domain span: 4-5 (max cpu_capacity = 446)
> [40224.303185] rd 4-5: CPUs do not have asymmetric capacities
>
> So in short, if you have sched_debug enabled, whatever is reported as the
> last sched domain hierarchy in dmesg will be the one in use.
>
> Now, if you have a userspace that tries to be clever and wants to use this
> information then yes, this isn't ideal, but then that's a different matter.
The dmesg might be lost if someone has once used dmesg -c to clear the log,
and the /var/log/dmesg might not always there. And it is not common to trigger
sched domain update once boot up in some environment.
But anyway, this information printed by sched_debug is very fertile for knowing
the topology.
> I think exposing the NUMA boundaries is fair game - and they already are
> via /sys/devices/system/node/node*/.
It seems that the numa sysfs could not reflect the SNC topology, it just has the
*leaf* numa node information. Say, node0 and node1 might form one sched_domain.
> I'm not sure we'd want to expose more
> (e.g. MC span), ideally that is something you shouldn't really have to care
> about - that's the scheduler's job.
I agree, it just aims to facilitate the user space, or just for
debugging purpose.
But as Dietmar replied, the /proc/schedstat has already exposed it.


thanks again,
Chenyu

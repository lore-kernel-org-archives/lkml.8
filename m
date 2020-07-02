Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB0120885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecEKjjW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGBPzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGBPzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:55:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2B7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:55:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so16990402ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lz/Rwriw7MOyTtl/2EK07lY3ZziSZL1DtV3ILOXn4zI=;
        b=ecEKjjW8b32K9MKv8GmAxLaCpNia/1ZHY4+nfXlcVEDL+NDekak1dzeCsX0jqB/PT9
         Wvszuw3fEvt7aNQdoc3TMtj36Mc0uPTIyWB+7Xa+kRSpYpCh+Tulyz+8BfY/xwgE/43I
         0yc/95tpyAzwj2bqxi4tZDwPGiFiS4JspITlRqFaE+7qzVdM5jbZP8PZwhn0otnVuWGm
         Puz4yfZnodxuXKGhEsxDEGfoa/Xx3IQ96hUC3iEMUGXypjnUVwdpHgXIxToixYKBq3NH
         kVDAlGlLM0xRkywZp7vDplpI7yioYbTBDqbEU0Nn42WkJWRbgBbmS25D/LCzVDgQJpQD
         QEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lz/Rwriw7MOyTtl/2EK07lY3ZziSZL1DtV3ILOXn4zI=;
        b=LdvZz/8ge6cnka+6C2dHDMj7pjMtulwMNlYg+fr9KyC0hJqbz8EiXmuoXyigA2Phpm
         fcO4q5gQNgeocEleLzYq6ALk2fPxzsPTfAwYB6pR2D5/B+D9VraHa3CEMFzcI7jHjp7f
         HGUqECV5Inv4/KY07eEJPZ1PvUhd8aHahBT6byTDistatbL8H1mmh9tVdCfr5EZO18jc
         60TQBBT4/p9IrsR03X+5ajlR9KnZaLHeSrw8sclYRSn7JeF2T3t7Ccne2764nCYXreJU
         4t3Ky/WJQJSjcwF8rzr5+aZxf9f2biuHBvy/Nut6PCc+rfTzxGJbWZr2TAELCtPGHyrM
         SlxQ==
X-Gm-Message-State: AOAM531FrrRHGfcUKxUezdoHelYm6KsXkPshlfRQbKIYqqJ16EEYPEIl
        wkBICUnSiNoWidTtqMuszNrpckDiwnaV/Tp8G+xs8w==
X-Google-Smtp-Source: ABdhPJx17fz1SYiGKBI24R2KRxUc8hwNWiWuZ56YizZZ/iopmmUldQYvolPmZviKiF1bbYP1NcA4DTksPLw1G/XZ0QA=
X-Received: by 2002:a2e:9ed0:: with SMTP id h16mr17845323ljk.366.1593705319549;
 Thu, 02 Jul 2020 08:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz> <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <CA+G9fYvC_+Gmab=b5pJW+5m1cR=JnLKLuMfxh3p-j8XKBzseSA@mail.gmail.com> <20200702154920.GA90961@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200702154920.GA90961@carbon.dhcp.thefacebook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jul 2020 21:25:08 +0530
Message-ID: <CA+G9fYs7y+FHhcExWp96W5j-NVqv_8nR4Pz7cex5ttb-L7QQqA@mail.gmail.com>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 at 21:19, Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 02, 2020 at 12:22:03PM +0530, Naresh Kamboju wrote:
> > On Thu, 2 Jul 2020 at 00:16, Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Jul 01, 2020 at 10:29:04AM +0200, Michal Hocko wrote:
> > > > Smells like a different observable problem with the same/similar cu=
lprit
> > > > as http://lkml.kernel.org/r/CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNsp=
c=3DOzzFhL=3DxRQ@mail.gmail.com
> > > >
> > > > On Wed 01-07-20 13:48:57, Naresh Kamboju wrote:
> > > > > While running LTP mm test suite on x86_64 device the BUG: Bad pag=
e
> > > > > state in process
> > > > > noticed on linux-next 20200630 tag.
> > > > >
> > > > > Steps to reproduce:
> > > > > - boot linux-next 20200630 kernel on x86_64 device
> > > > > - cd /opt/ltp
> > > > > - ./runltp -f mm
> > > > >
> > > > > metadata:
> > > > >   git branch: master
> > > > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/=
linux-next.git
> > > > >   git commit: f2b92b14533e646e434523abdbafddb727c23898
> > > > >   git describe: next-20200630
> > > > >   kernel-config:
> > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__builds.tux=
build.com_j60yrp7CUpq3LCmqMB8Wdg_kernel.config&d=3DDwIBAg&c=3D5VD0RTtNlTh3y=
cd41b3MUw&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3Dh_KJ0e7abuh0BK2eDlDmWnAxqHPccpqchP=
gBS-oJcVE&s=3Dqofg2XRToTeHvi8vSdOvDPtKpJsUqf3IWfqwieZqITg&e=3D
> > > > >
> > > > > Test crash dump:
> > > > > [  803.905169] Node 0 Normal: 2608*4kB (UMEH) 1380*8kB (UMEH) 64*=
16kB
> > > > > (MEH) 28*32kB (MEH) 13*64kB (UMEH) 164*128kB (UMEH) 39*256kB (UE)
> > > > > 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 1*4096kB (M) =3D 62880kB
> > > > > [  803.922375] Node 0 hugepages_total=3D0 hugepages_free=3D0
> > > > > hugepages_surp=3D0 hugepages_size=3D2048kB
> > > > > [  803.930806] 2418 total pagecache pages
> > > > > [  803.934559] 0 pages in swap cache
> > > > > [  803.937878] Swap cache stats: add 0, delete 0, find 0/0
> > > > > [  803.943108] Free swap  =3D 0kB
> > > > > [  803.945997] Total swap =3D 0kB
> > > > > [  803.948885] 4181245 pages RAM
> > > > > [  803.951857] 0 pages HighMem/MovableOnly
> > > > > [  803.955695] 626062 pages reserved
> > > > > [  803.959016] Tasks state (memory values in pages):
> > > > > [  803.963722] [  pid  ]   uid  tgid total_vm      rss pgtables_b=
ytes
> > > > > swapents oom_score_adj name
> > > > > [  803.972336] [    332]     0   332     8529      507   106496
> > > > > 0             0 systemd-journal
> > > > > [  803.981387] [    349]     0   349    10730      508   118784
> > > > > 0         -1000 systemd-udevd
> > > > > [  803.990262] [    371]   993   371     8666      108   118784
> > > > > 0             0 systemd-network
> > > > > [  803.999306] [    379]   992   379     9529       99   110592
> > > > > 0             0 systemd-resolve
> > > > > [  804.008347] [    388]     0   388     2112       19    61440
> > > > > 0             0 syslogd
> > > > > [  804.016709] [    389]   995   389     9308      108   122880
> > > > > 0             0 avahi-daemon
> > > > > [  804.025517] [    391]     0   391     1075       21    57344
> > > > > 0             0 acpid
> > > > > [  804.033695] [    394]   995   394     9277       68   114688
> > > > > 0             0 avahi-daemon
> > > > > [  804.042476] [    396]   996   396     7241      154   102400
> > > > > 0          -900 dbus-daemon
> > > > > [  804.051170] [    397]     0   397     2313       72    65536
> > > > > 0             0 crond
> > > > > [  804.059349] [    399]     0   399    34025      161   167936
> > > > > 0             0 thermald
> > > > > [  804.067783] [    400]     0   400     8615      115   110592
> > > > > 0             0 systemd-logind
> > > > > [  804.076734] [    401]     0   401     2112       32    57344
> > > > > 0             0 klogd
> > > > > [  804.084907] [    449] 65534   449     3245       39    69632
> > > > > 0             0 dnsmasq
> > > > > [  804.093254] [    450]     0   450     3187       33    73728
> > > > > 0             0 agetty
> > > > > [  804.101541] [    452]     0   452     3187       33    73728
> > > > > 0             0 agetty
> > > > > [  804.109826] [    453]     0   453    14707      107   159744
> > > > > 0             0 login
> > > > > [  804.118007] [    463]     0   463     9532      163   122880
> > > > > 0             0 systemd
> > > > > [  804.126362] [    464]     0   464    16132      424   172032
> > > > > 0             0 (sd-pam)
> > > > > [  804.134803] [    468]     0   468     4538      105    81920
> > > > > 0             0 sh
> > > > > [  804.142741] [    472]     0   472    11102       83   131072
> > > > > 0             0 su
> > > > > [  804.150680] [    473]     0   473     4538       99    81920
> > > > > 0             0 sh
> > > > > [  804.158637] [    519]     0   519     2396       57    61440
> > > > > 0             0 lava-test-runne
> > > > > [  804.167700] [   1220]     0  1220     2396       52    61440
> > > > > 0             0 lava-test-shell
> > > > > [  804.176738] [   1221]     0  1221     2396       55    61440
> > > > > 0             0 sh
> > > > > [  804.184680] [   1223]     0  1223     2462      135    61440
> > > > > 0             0 ltp.sh
> > > > > [  804.192946] [   1242]     0  1242     2462      134    61440
> > > > > 0             0 ltp.sh
> > > > > [  804.201207] [   1243]     0  1243     2462      134    61440
> > > > > 0             0 ltp.sh
> > > > > [  804.209475] [   1244]     0  1244     2462      134    61440
> > > > > 0             0 ltp.sh
> > > > > [  804.217742] [   1245]     0  1245     2561      229    65536
> > > > > 0             0 runltp
> > > > > [  804.226010] [   1246]     0  1246     1072       15    53248
> > > > > 0             0 tee
> > > > > [  804.234012] [   1313]     0  1313     1070       29    53248
> > > > > 0             0 ltp-pan
> > > > > [  804.242374] [   3216]     0  3216     1613       20    53248
> > > > > 0             0 oom01
> > > > > [  804.250554] [   3217]     0  3217     1646       31    57344
> > > > > 0             0 oom01
> > > > > [  804.258728] [   3245]     0  3245    81271      469   266240
> > > > > 0             0 NetworkManager
> > > > > [  804.267688] [   3249]     0  3249     6422       54    98304
> > > > > 0             0 systemd-hostnam
> > > > > [  804.276734] [   3250]     0  3250    52976      178   172032
> > > > > 0             0 nm-dispatcher
> > > > > [  804.285603] [   3254]   998  3254   131113      828   245760
> > > > > 0             0 polkitd
> > > > > [  804.293956] [   3261]     0  3261  4726385  3349389 26939392
> > > > > 0             0 oom01
> > > > > [  804.302129] [   3265]     0  3265     3187       33    73728
> > > > > 0             0 agetty
> > > > > [  804.310397] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(=
null),cpuset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/,task=3Doom01,pi=
d=3D3261,uid=3D0
> > > > > [  804.322751] Out of memory: Killed process 3261 (oom01)
> > > > > total-vm:18905540kB, anon-rss:13397556kB, file-rss:0kB, shmem-rss=
:0kB,
> > > > > UID:0 pgtables:26308kB oom_score_adj:0
> > > > > [  806.652952] oom_reaper: reaped process 3261 (oom01), now
> > > > > anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> > > > > [  807.579373] BUG: Bad page state in process kworker/u8:12  pfn:=
374308
> > > > > [  807.579521] BUG: Bad page state in process kworker/u8:13  pfn:=
4182a4
> > > > > [  807.585734] page:ffffea000dd0c200 refcount:0 mapcount:0
> > > > > mapping:0000000000000000 index:0xffff88837430e000
> > > > > head:ffffea000dd0c200 order:3 compound_mapcount:0 compound_pincou=
nt:0
> > > > > [  807.585736] flags: 0x200000000010000(head)
> > > > > [  807.585740] raw: 0200000000010000 ffffea000dce6e00 00000002000=
00002
> > > > > 0000000000000000
> > > > > [  807.592099] page:ffffea001060a900 refcount:0 mapcount:0
> > > > > mapping:0000000000000000 index:0xffff8884182a5e00
> > > > > head:ffffea001060a900 order:1 compound_mapcount:0
> > > > > [  807.607719] raw: ffff88837430e000 0000000000040000 00000000fff=
fffff
> > > > > ffff8883bda6cac1
> > > > > [  807.607720] page dumped because: page still charged to cgroup
> > > > > [  807.607720] page->mem_cgroup:ffff8883bda6cac1
> > > > > [  807.607721] Modules linked in: x86_pkg_temp_thermal
> > > > > [  807.607725] CPU: 0 PID: 3242 Comm: kworker/u8:12 Not tainted
> > > > > 5.8.0-rc3-next-20200630 #1
> > > > > [  807.607727] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, B=
IOS
> > > > > 2.0b 07/27/2017
> > > > > [  807.607731] Workqueue: rpciod rpc_async_schedule
> > > > > [  807.611836] flags: 0x200000000010000(head)
> > > > > [  807.619563] Call Trace:
> > > > > [  807.619567]  dump_stack+0x84/0xba
> > > > > [  807.619569]  bad_page.cold+0x7b/0xac
> > > > > [  807.619573]  __free_pages_ok+0x95b/0xab0
> > > > > [  807.633461] raw: 0200000000010000 dead000000000100 dead0000000=
00122
> > > > > 0000000000000000
> > > > > [  807.641189]  __free_pages+0x42/0x50
> > > > > [  807.641191]  __free_slab+0xcd/0x1f0
> > >
> > > Hm, interesting, it means that page->obj_cgroups is still set.
> > > But before __free_pages() __free_slab() always calls uncharge_slab_pa=
ge(),
> > > which sets page->obj_cgroups to NULL except when !memcg_kmem_enabled(=
).
> > >
> > > So it makes me think that somehow memcg_kmem_enabled() became false
> > > after being true, which can cause refcounting problems as well.
> > >
> > > Naresh, can you, please, check if the following patch solves problems=
?
> > > And thank you for reporting the problem!
> > >
> >
> > Thanks for providing a quick fix patch.
> >
> > >
> > > From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 200=
1
> > > From: Roman Gushchin <guro@fb.com>
> > > Date: Wed, 1 Jul 2020 11:05:32 -0700
> > > Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> > >
> > > Historically the kernel memory accounting was an opt-in feature, whic=
h
> > > could be enabled for individual cgroups. But now it's not true, and
> > > it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> > > user has at least one non-root memory cgroup, the kernel memory
> > > accounting is on. So in most setups it's either always on (if memory
> > > cgroups are in use and kmem accounting is not disabled), either alway=
s
> > > off (otherwise).
> > >
> > > memcg_kmem_enabled() is used in many places to guard the kernel memor=
y
> > > accounting code. If memcg_kmem_enabled() can reverse from returning
> > > true to returning false (as now), we can't rely on it on release path=
s
> > > and have to check if it was on before.
> > >
> > > If we'll make memcg_kmem_enabled() irreversible (always returning tru=
e
> > > after returning it for the first time), it'll make the general logic
> > > more simple and robust. It also will allow to guard some checks which
> > > otherwise would stay unguarded.
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > The below patch applied on top of linux-next 20200701and tested and
> > the reported bug got fixed on arm64, arm, x86_64 and i386.
>
> Hello, Naresh!
>
> Thank you very much for testing the patch!
>
> Btw, did it also fix the problem reported here:
> https://lore.kernel.org/linux-mm/20200701081951.GL2369@dhcp22.suse.cz/T/#=
t ?

Yes it got fixed the reported problem on the above e-mail thread.

- Naresh

>
> Thanks!
>
> Roman

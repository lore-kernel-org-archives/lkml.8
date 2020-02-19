Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF32C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81D21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBpsLhyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:02:10 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35444 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBSKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:02:10 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so20065530ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZw/x7OOmWsRPs2KXXA49rjbloN6GS0ZFchRGCp2bD4=;
        b=WBpsLhyM4d5bJ47VBArWknaQDsfmBfB06bUtLNlUIVsHn0Y+Qsq2QthZSzLhha2Av9
         DiMAK9vHsY1+WRyf0aCdkRapBzvX9/3066/UFiSI+M52ES7nyJpfUf9fUO1vBHuNWbhp
         X7UhN0QsDZOMi1gW3Kxo7IOQq1DhPwLPmWiSjU9MrqS+Plkm30b8NY63FuGTIbbtj4yI
         C6X5oezrQPz7QiU6DZkPGk3v0JCg4AsTYIdUt0chJDxGl8E0sfdmJPqmSDslNwCRWXs3
         fvLnfbqDmEV1/JJghpjF2pH/y0DGgRwqNw2u0m+kjjLRBGtkXktW49aUm/OYzL4Sy/T4
         NVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZw/x7OOmWsRPs2KXXA49rjbloN6GS0ZFchRGCp2bD4=;
        b=K0SHwgL4ndpCX6g+4v9WDOsHCrlPRxrx0pYnpW2lm0yQhx8Gmh4/Yed4zpfZFOJBpI
         IydfqTwX1+knmDW3XtKAlYfuWb083mdvsotamd/fnNtnUeqAMLFmJ9Rzljt56U1gZ7wa
         qTn4dGv1GVjUTL/HCQQ8AiaaZiNNvLub5u1ivKBblEdyqsyZYQleFo9ogqHgKK/r6rCS
         Rur45HUMXwE1jmGRa42hMWN7X1arvHvl7SPatnGmZWhDx7ekW8N2iUpKXx8ix246tl54
         FdLonQCR0zojOTXoOBYuWajMF0SXGHu5GkH+zxP2Z2XhHt54p1dRUXNdPftlnCfnPFIT
         0SLg==
X-Gm-Message-State: APjAAAXb6FljL9i12DUdZEhqTGLppuX0DPHSlFtiZVWS7/qcsbX7XAMb
        ZR8BtX//p32z9AdTsRkrg6uJ+QOT9a7QkVMm43M=
X-Google-Smtp-Source: APXvYqw/oHjZVKNPCmgzq1xoxcw3r2PVM3NptIGwADTC6kugpd44yztDicEsxdDf1BAu3tJCKu40RRZAcnsLlDwoe74=
X-Received: by 2002:a92:d7cd:: with SMTP id g13mr24384408ilq.300.1582106529867;
 Wed, 19 Feb 2020 02:02:09 -0800 (PST)
MIME-Version: 1.0
References: <CADjb_WQ0wFgZWBo0Xo1Q+NWS6vF0BSs5H0ho+5FM82Mu-JVYoQ@mail.gmail.com>
 <787302f0-670f-fadf-14e6-ea0a73603d77@arm.com> <60febadb-df21-a44b-d282-e43c104d2497@arm.com>
In-Reply-To: <60febadb-df21-a44b-d282-e43c104d2497@arm.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 19 Feb 2020 18:01:58 +0800
Message-ID: <CADjb_WRg-kbWCoPcds82SGFUfSpkvCQytfjvZV674NxOuTRE3Q@mail.gmail.com>
Subject: Re: [RFC] Display the cpu of sched domain in procfs
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Dietmar,

On Wed, Feb 19, 2020 at 4:53 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 19/02/2020 09:13, Valentin Schneider wrote:
> > Hi,
> >
> > On 19/02/2020 07:15, Chen Yu wrote:
> >> Problem:
> >> sched domain topology is not always consistent with the CPU topology exposed at
> >> /sys/devices/system/cpu/cpuX/topology,  which makes it
> >> hard for monitor tools to distinguish the CPUs among different sched domains.
> >>
> >> For example, on x86 if there are NUMA nodes within a package, say,
> >> SNC(Sub-Numa-Cluster),
> >> then there would be no die sched domain but only NUMA sched domains
> >> created. As a result,
> >> you don't know what the sched domain hierarchical is by only looking
> >> at /sys/devices/system/cpu/cpuX/topology.
> >>
> >> Although by appending sched_debug in command line would show the sched
> >> domain CPU topology,
> >> it is only printed once during boot up, which makes it hard to track
> >> at run-time.
>
> What about /proc/schedstat?
>
That's it!  I did not notice it before, this should work although the
user space might
need to parse the format.


-- 
Thanks,
Chenyu
> E.g. on Intel Xeon CPU E5-2690 v2
>
> $ cat /proc/schedstat | head
> version 15
> timestamp 4486170100
> cpu0 0 0 0 0 0 0 59501267037720 16902762382193 1319621004
> domain0 00,00100001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain1 00,3ff003ff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>
>         ^^^^^^^^^^^
>
> cpu1 0 0 0 0 0 0 56045879920164 16758983055410 1318489275
> domain0 00,00200002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain1 00,3ff003ff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> ...
>

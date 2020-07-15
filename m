Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54035C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3159820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nC5u3pxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgGOIWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:22:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47804 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgGOIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:22:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200715082234euoutp012dc85c0cafd69d67832c801eab0f05b5~h32HdvScC2982229822euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:22:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200715082234euoutp012dc85c0cafd69d67832c801eab0f05b5~h32HdvScC2982229822euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594801354;
        bh=OoigdLKrfoK3H3M17PMh/buAdwlhfNUYAko5PagZWJM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nC5u3pxJg5622QnEQrAZ0CH4J/uPKX4rEbtfeimCaHTFrbqkPjD1pqrmvu0cwowkv
         vma+nVCJX3ZKU45JJClCO4QlatemWbCAeDaQWRV2cL2WKGgVO4V7Wf6pg9QW2qej/Q
         Wu3Fj7cwkPJ5G3XkEjdpnRFaPNxRsmmmuu9FmeIo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200715082234eucas1p27bbcfe0e91758a0b61dec4aea9246036~h32HFZxF52122921229eucas1p2O;
        Wed, 15 Jul 2020 08:22:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.7B.05997.9CCBE0F5; Wed, 15
        Jul 2020 09:22:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200715082233eucas1p261d4c5133226b800c3656c9010aa5940~h32GtFYud2332723327eucas1p2F;
        Wed, 15 Jul 2020 08:22:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200715082233eusmtrp246981ff6767b26e5ea37cbeb53ecf3d3~h32GiYRzZ0358603586eusmtrp2m;
        Wed, 15 Jul 2020 08:22:33 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-cd-5f0ebcc96e50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.A3.06017.9CCBE0F5; Wed, 15
        Jul 2020 09:22:33 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200715082232eusmtip1b3dc9731aa94fcaf514b980bce444063~h32F4unjI2461424614eusmtip1r;
        Wed, 15 Jul 2020 08:22:32 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f564bac4-1120-cee4-4ea5-aad5fcc7bd91@samsung.com>
Date:   Wed, 15 Jul 2020 10:22:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710132305.GA1920995@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7qn9vDFG0w4xWixccZ6VovmxevZ
        LM781rXYsV3E4vKuOWwWM87vY7KY+2Uqs0XXob9sDhwe23ZvY/VYsKnUY9OqTjaPO9f2sHns
        n7uG3aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyJi7Zx1xwMLjiTMN11gbGNV5djJwcEgIm
        EksnnWXuYuTiEBJYwShx5dkERpCEkMAXRom2DQEQic+MEqcW72eE6Vj3aA4bRGI5o0TvxB4m
        COc9o0T3lY3MIFXCAj4SUxc8YAKxRQRiJU7c7WIHKWIWmMMkceXUHrBRbAKGEl1vu9hAbF4B
        O4mXkz6BNbAIqEq8n/gFrEZUIE5i/cvtTBA1ghInZz5hAbE5gXoXTnkBVsMsIC/RvHU2M4Qt
        LnHryXywiyQE9rFL3Fj1hAnibheJOYfXsEPYwhKvjm+BsmUk/u+EaWhmlHh4bi07hNPDKHG5
        aQbU19YSd879AjqVA2iFpsT6XfoQYUeJnzs/s4KEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGI
        ajWJWcfXwa09eOES8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8
        dL3k/NxNjMD0dPrf8S87GHf9STrEKMDBqMTDO2Emb7wQa2JZcWXuIUYJDmYlEV6ns6fjhHhT
        EiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamA0z98ZwaXw23dS
        tPpcsQ2uVbxrtc1ulK1z2xkduPeC/aeP/jN3ahqWcjg/eXRg2nrZrJqvbddfTb34xmzWGpuL
        gU/i0k0tp6+foubWWB5a8OE/+63ktMdrZ9/UvGoa/rAs+nnX5QParjMtvz2fukhlhrD4n8dV
        V35cd9lyP7SO98q1wBkvF8yJV2Ipzkg01GIuKk4EAPGkFV5LAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7on9/DFG8z/Jm6xccZ6VovmxevZ
        LM781rXYsV3E4vKuOWwWM87vY7KY+2Uqs0XXob9sDhwe23ZvY/VYsKnUY9OqTjaPO9f2sHns
        n7uG3aNvyypGj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
        UlJzMstSi/TtEvQyJi7Zx1xwMLjiTMN11gbGNV5djJwcEgImEusezWEDsYUEljJKrLqXBhGX
        kTg5rYEVwhaW+HOtC6iGC6jmLaPEvs+/GEESwgI+ElMXPGACsUUEYiUeLrzFDGIzC8xhkli7
        VwCi4S6TxI+NK1hAEmwChhJdb7vAtvEK2Em8nPQJrJlFQFXi/cQvYENFBeIklm+Zzw5RIyhx
        cuYTsF5OoN6FU14wQiwwk5i3+SHUMnmJ5q2zoWxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDI
        sopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwGrcd+7llB2PXu+BDjAIcjEo8vBNm8sYLsSaW
        FVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgYkiryTe0NTQ3MLS
        0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo3RJ4olgjTIVEbkVCRz3HBaX1Xic
        PiSr+f7JC4Wio0yrdT67tn6ftktd6e7n6LnGErHWGqlhFzonTBZxv2gsFH/qyLObe67e2n9H
        yGUH+zZl6WbR5Vu/R+7f7P8+QTfs8PTvB08snSgsue9ES51ngb7nYz7lPiu3x95fQgyD53Wp
        q1fLq4ecUWIpzkg01GIuKk4EAHNk9tHcAgAA
X-CMS-MailID: 20200715082233eucas1p261d4c5133226b800c3656c9010aa5940
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200715082233eucas1p261d4c5133226b800c3656c9010aa5940
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200715082233eucas1p261d4c5133226b800c3656c9010aa5940
References: <20200521191800.136035-1-saravanak@google.com>
        <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
        <20200529123025.GA1710508@kroah.com>
        <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
        <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com>
        <20200710132305.GA1920995@kroah.com>
        <CGME20200715082233eucas1p261d4c5133226b800c3656c9010aa5940@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Saravana,

On 10.07.2020 15:23, Greg Kroah-Hartman wrote:
> On Mon, Jul 06, 2020 at 03:45:02PM -0700, Saravana Kannan wrote:
>> On Tue, Jun 16, 2020 at 8:45 PM Saravana Kannan <saravanak@google.com> wrote:
>>> On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>> Looks semi-sane, but it's too close to the merge window at the moment
>>>> for me to take this.  If there's no objections by the time 5.8-rc1 is
>>>> out, I'll queue it up in my tree for 5.9-rc1.
>>> Another friendly reminder :)
>> *nudge* *nudge*
> Looks sane, given no objections, let's see what linux-next thinks about
> it...

linux-next is not very happy from this patchset... Starting from 
next-20200713 I see a few new issues on various Samsung Exynos based 
boards. Here are examples from Exynos4412-based Odroid U3 board (ARM 
32bit, kernel compiled from exynos_defconfig):

BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
2 locks held by kworker/0:1/12:
  #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: 
process_one_work+0x174/0x7dc
  #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: 
process_one_work+0x174/0x7dc
Preemption disabled at:
[<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G        W 
5.8.0-rc3-00022-g287905e68dd2 #8753
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f04>] (dump_stack+0xbc/0xe8)
[<c0517f04>] (dump_stack) from [<c0159188>] (___might_sleep+0x288/0x2d8)
[<c0159188>] (___might_sleep) from [<c0abbd1c>] (__mutex_lock+0x48/0xb18)
[<c0abbd1c>] (__mutex_lock) from [<c0abc808>] (mutex_lock_nested+0x1c/0x24)
[<c0abc808>] (mutex_lock_nested) from [<c064590c>] (device_del+0x30/0x39c)
[<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
[<c0645c9c>] (device_unregister) from [<c01b10fc>] 
(srcu_invoke_callbacks+0xcc/0x154)
[<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] 
(process_one_work+0x234/0x7dc)
[<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
[<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
[<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee921fb0 to 0xee921ff8)


BUG: scheduling while atomic: kworker/0:0/5/0x00000201
3 locks held by kworker/0:0/5:
  #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: 
process_one_work+0x174/0x7dc
  #1: ee907f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: 
process_one_work+0x174/0x7dc
  #2: c11367e4 (kernfs_mutex){+.+.}-{3:3}, at: 
kernfs_remove_by_name_ns+0x24/0x94
Modules linked in:
Preemption disabled at:
[<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W 
5.8.0-rc3-00022-g287905e68dd2 #8753
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f04>] (dump_stack+0xbc/0xe8)
[<c0517f04>] (dump_stack) from [<c0158da0>] (__schedule_bug+0x88/0xe0)
[<c0158da0>] (__schedule_bug) from [<c0ab7f88>] (__schedule+0x5d0/0x83c)
[<c0ab7f88>] (__schedule) from [<c0ab8258>] (schedule+0x64/0x124)
[<c0ab8258>] (schedule) from [<c0ab8768>] 
(schedule_preempt_disabled+0x14/0x20)
[<c0ab8768>] (schedule_preempt_disabled) from [<c0abc1ec>] 
(__mutex_lock+0x518/0xb18)
[<c0abc1ec>] (__mutex_lock) from [<c0abc808>] (mutex_lock_nested+0x1c/0x24)
[<c0abc808>] (mutex_lock_nested) from [<c0362fc0>] 
(kernfs_remove_by_name_ns+0x24/0x94)
[<c0362fc0>] (kernfs_remove_by_name_ns) from [<c0644eac>] 
(device_remove_class_symlinks+0x70/0x94)
[<c0644eac>] (device_remove_class_symlinks) from [<c0645994>] 
(device_del+0xb8/0x39c)
[<c0645994>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
[<c0645c9c>] (device_unregister) from [<c01b10fc>] 
(srcu_invoke_callbacks+0xcc/0x154)
[<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] 
(process_one_work+0x234/0x7dc)
[<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
[<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
[<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee907fb0 to 0xee907ff8)
sysfs: cannot create duplicate filename 
'/devices/virtual/devlink/regulator.28:cpu0'

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5 at kernel/sched/core.c:3897 
preempt_count_sub+0x104/0x108
DEBUG_LOCKS_WARN_ON(val > preempt_count())
Modules linked in:
CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W 
5.8.0-rc3-00022-g287905e68dd2 #8753
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f04>] (dump_stack+0xbc/0xe8)
[<c0517f04>] (dump_stack) from [<c01270a8>] (__warn+0xf0/0x108)
[<c01270a8>] (__warn) from [<c0127134>] (warn_slowpath_fmt+0x74/0xb8)
[<c0127134>] (warn_slowpath_fmt) from [<c0158efc>] 
(preempt_count_sub+0x104/0x108)
[<c0158efc>] (preempt_count_sub) from [<c012fee4>] 
(__local_bh_enable_ip+0x74/0x16c)
[<c012fee4>] (__local_bh_enable_ip) from [<c01b1108>] 
(srcu_invoke_callbacks+0xd8/0x154)
[<c01b1108>] (srcu_invoke_callbacks) from [<c01493c4>] 
(process_one_work+0x234/0x7dc)
[<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
[<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
[<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee907fb0 to 0xee907ff8)
7fa0:                                     00000000 00000000 00000000 
00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 2274
hardirqs last  enabled at (2273): [<c02b3274>] __slab_free+0x2b0/0x480
hardirqs last disabled at (2274): [<c012fecc>] 
__local_bh_enable_ip+0x5c/0x16c
softirqs last  enabled at (2184): [<c010174c>] __do_softirq+0x50c/0x608
softirqs last disabled at (2056): [<c01b10e4>] 
srcu_invoke_callbacks+0xb4/0x154
---[ end trace eaa99e7b5e453175 ]---

PU: 0 PID: 1 Comm: swapper/0 Tainted: G        W 
5.8.0-rc3-00022-g287905e68dd2 #8753
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f04>] (dump_stack+0xbc/0xe8)
[<c0517f04>] (dump_stack) from [<c0365474>] (sysfs_warn_dup+0x58/0x64)
[<c0365474>] (sysfs_warn_dup) from [<c03655a8>] 
(sysfs_create_dir_ns+0xe0/0xf4)
[<c03655a8>] (sysfs_create_dir_ns) from [<c051f218>] 
(kobject_add_internal+0xb8/0x370)
[<c051f218>] (kobject_add_internal) from [<c051f69c>] 
(kobject_add+0x5c/0xbc)
[<c051f69c>] (kobject_add) from [<c0647338>] (device_add+0x100/0x744)
[<c0647338>] (device_add) from [<c0647b88>] (device_link_add+0x1f4/0x5d0)
[<c0647b88>] (device_link_add) from [<c0582f60>] (_regulator_get+0xf4/0x280)
[<c0582f60>] (_regulator_get) from [<c0803da4>] 
(dev_pm_opp_set_regulators+0xf8/0x210)
[<c0803da4>] (dev_pm_opp_set_regulators) from [<c080df80>] 
(cpufreq_init+0xb8/0x304)
[<c080df80>] (cpufreq_init) from [<c080aae0>] (cpufreq_online+0x2c8/0x9f8)
[<c080aae0>] (cpufreq_online) from [<c080b2ac>] (cpufreq_add_dev+0x8c/0xc0)
[<c080b2ac>] (cpufreq_add_dev) from [<c0649854>] 
(subsys_interface_register+0xa8/0xf4)
[<c0649854>] (subsys_interface_register) from [<c0808184>] 
(cpufreq_register_driver+0x178/0x294)
[<c0808184>] (cpufreq_register_driver) from [<c080ddac>] 
(dt_cpufreq_probe+0xd8/0x1f4)
[<c080ddac>] (dt_cpufreq_probe) from [<c064e048>] 
(platform_drv_probe+0x6c/0xa4)
[<c064e048>] (platform_drv_probe) from [<c064b664>] 
(really_probe+0x200/0x48c)
[<c064b664>] (really_probe) from [<c064ba58>] 
(driver_probe_device+0x78/0x1fc)
[<c064ba58>] (driver_probe_device) from [<c064be40>] 
(device_driver_attach+0x58/0x60)
[<c064be40>] (device_driver_attach) from [<c064bf24>] 
(__driver_attach+0xdc/0x174)
[<c064bf24>] (__driver_attach) from [<c0649470>] 
(bus_for_each_dev+0x68/0xb4)
[<c0649470>] (bus_for_each_dev) from [<c064a7a4>] 
(bus_add_driver+0x158/0x214)
[<c064a7a4>] (bus_add_driver) from [<c064cdf8>] (driver_register+0x78/0x110)
[<c064cdf8>] (driver_register) from [<c0102378>] 
(do_one_initcall+0x8c/0x424)
[<c0102378>] (do_one_initcall) from [<c1001158>] 
(kernel_init_freeable+0x190/0x204)
[<c1001158>] (kernel_init_freeable) from [<c0ab7104>] 
(kernel_init+0x8/0x118)
[<c0ab7104>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee8f1fb0 to 0xee8f1ff8)
...
BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5, name: kworker/0:0
INFO: lockdep is turned off.
Preemption disabled at:
[<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W 
5.8.0-rc3-00022-g287905e68dd2 #8753
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
[<c010d250>] (show_stack) from [<c0517f04>] (dump_stack+0xbc/0xe8)
[<c0517f04>] (dump_stack) from [<c0159188>] (___might_sleep+0x288/0x2d8)
[<c0159188>] (___might_sleep) from [<c0abbd1c>] (__mutex_lock+0x48/0xb18)
[<c0abbd1c>] (__mutex_lock) from [<c0abc808>] (mutex_lock_nested+0x1c/0x24)
[<c0abc808>] (mutex_lock_nested) from [<c064590c>] (device_del+0x30/0x39c)
[<c064590c>] (device_del) from [<c0645c9c>] (device_unregister+0x24/0x64)
[<c0645c9c>] (device_unregister) from [<c01b10fc>] 
(srcu_invoke_callbacks+0xcc/0x154)
[<c01b10fc>] (srcu_invoke_callbacks) from [<c01493c4>] 
(process_one_work+0x234/0x7dc)
[<c01493c4>] (process_one_work) from [<c01499b0>] (worker_thread+0x44/0x51c)
[<c01499b0>] (worker_thread) from [<c0150bf4>] (kthread+0x158/0x1a0)
[<c0150bf4>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
Exception stack(0xee907fb0 to 0xee907ff8)
...
kobject_add_internal failed for regulator.28:cpu0 with -EEXIST, don't 
try to register things with the same name in the same directory.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


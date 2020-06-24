Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB19620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgFXIN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:13:28 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50868 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387732AbgFXIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:13:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0aKfqF_1592986404;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0aKfqF_1592986404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 16:13:24 +0800
Date:   Wed, 24 Jun 2020 16:13:24 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624081324.GA12461@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
 <57d8a558-dcb3-b318-8e38-6c016b050414@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d8a558-dcb3-b318-8e38-6c016b050414@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:48:43AM +0200, David Hildenbrand wrote:
>On 23.06.20 17:18, Michal Hocko wrote:
>> On Tue 23-06-20 17:42:58, Wei Yang wrote:
>>> For early sections, we assumes its memmap will never be partially
>>> removed. But current behavior breaks this.
>>>
>>> Let's correct it.
>>>
>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> 
>> Can a user trigger this or is this a theoretical bug?
>
>I tried to reproduce it, but somehow I get unexpected behavior.
>With a hacked QEMU I can get

David,

Thanks for your effort. Would you mind sharing your qemu command line, so that
I can have a try at my side?

>
>$ cat /proc/iomem
>[...]
>100000000-143ffffff : System RAM
>144000000-343dfffff : Persistent Memory
>  144000000-1441fffff : namespace0.0
>  144200000-144ffffff : dax0.0
>
>After
>$ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M
>
>I get
>
>$ cat /proc/iomem
>[...]
>100000000-143ffffff : System RAM
>144000000-343dfffff : Persistent Memory
>  144000000-1441fffff : namespace0.0
>  144200000-144ffffff : dax0.0
>

The memory layout seems not changed.

>I can trigger remove+re-add via 
>$ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M

Do we need to change the mode to force the reconfig?

>
>So we clearly have an overlap between System RAM and dax0.0 within a section.
>However, I never get early_section() to trigger in
>section_activate()/section_deactivate() ? That's unexpected
>
>
>Definitely something seems to go wrong after the first "ndctl create-namespace".
>Using a random page walker:
>
>[root@localhost ~]# ./page-types 

What is this page-types?

>[  387.019229] general protection fault, probably for non-canonical address 0xfdfdfdfdfdfdfdfc: 0000 [#1] SMP NOPTI
>[  387.020172] CPU: 17 PID: 1314 Comm: page-types Kdump: loaded Tainted: G        W         5.8.0-rc2 #20
>[  387.021015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
>[  387.022056] RIP: 0010:stable_page_flags+0x27/0x3f0
>[  387.022519] Code: 00 00 00 66 66 66 66 90 48 85 ff 0f 84 d2 03 00 00 41 54 55 48 89 fd 53 48 8b 57 08 48 8b 1f 48f
>[  387.024291] RSP: 0018:ffff9f8781057e58 EFLAGS: 00010202
>[  387.024775] RAX: fdfdfdfdfdfdfdfc RBX: fdfdfdfdfdfdfdfd RCX: 00007ffc4f4f1f78
>[  387.025423] RDX: 0000000000000001 RSI: 0000002000000000 RDI: ffffc590c5100000
>[  387.026052] RBP: ffffc590c5100000 R08: 0000000000000001 R09: 0000000000000000
>[  387.026696] R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffc4f4f1f80
>[  387.027324] R13: 0000000000040000 R14: 00007ffc4f4d1f80 R15: ffffffffa1577ee0
>[  387.027974] FS:  00007f91a0f9c580(0000) GS:ffff888b3f7c0000(0000) knlGS:0000000000000000
>[  387.028699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[  387.029223] CR2: 0000000000449b00 CR3: 000000007a7fc000 CR4: 00000000000006e0
>[  387.029864] Call Trace:
>[  387.030108]  kpageflags_read+0xcc/0x160
>[  387.030473]  proc_reg_read+0x53/0x80
>[  387.030809]  vfs_read+0x9d/0x150
>[  387.031114]  ksys_pread64+0x65/0xa0
>[  387.031449]  do_syscall_64+0x4d/0x90
>[  387.031783]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC9DC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03D12082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 05:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EezT+rFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgBEFiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:38:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgBEFiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580881102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmlNdj4PZ4XHeCIja+s/Hzcd8WRN+ZWicGxN1aYQTVY=;
        b=EezT+rFr+6s0XWqF6LgSoPlID2YgFU4B+08aIUs2Th837Zr7fqnpLYIctMEht7cyDjm+p8
        q8ByltrlGG64wMrdIt6cA16ZWZ4CX2E6ZOvVy+XTUQTlqEk/gkPzUGvix6tGujh+suGe/B
        rM4xnhW0Ibwm2zSF37svAbAnpc59Xbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-7AJkuYPvPG6dgY5Co-wF7A-1; Wed, 05 Feb 2020 00:38:18 -0500
X-MC-Unique: 7AJkuYPvPG6dgY5Co-wF7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA431857340;
        Wed,  5 Feb 2020 05:38:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4FE78578A;
        Wed,  5 Feb 2020 05:38:09 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com> <20200205050204.GI41358@google.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
Date:   Wed, 5 Feb 2020 13:38:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200205050204.GI41358@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On (20/02/05 13:48), Sergey Senozhatsky wrote:
>> On (20/02/05 12:25), lijiang wrote:
>> [..]
>>> [   42.111004] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>> [   42.111005] general protection fault: 0000 [#1] SMP PTI
>>> [   42.111005] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-rc7+ #4
>>> [   42.111005] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.6024.071720181717 07/17/2018
>>> [   42.111006] RIP: 0010:copy_data+0xf2/0x1e0
>>> [   42.111006] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
>>> [   42.111007] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
>>> [   42.111007] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffffff000b0
>>> [   42.111008] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa1456e00
>>> [   42.111008] RBP: 0801364600307073 R08: 0000000000002000 R09: 0801364600307073
>>> [   42.111008] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa1e98330
>>> [   42.111009] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000ffffc000
>>> [   42.111009] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlGS:0000000000000000
>>> [   42.111010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   42.111010] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 00000000003606e0
>>> [   42.111011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   42.111011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   42.111012] Call Trace:
>>> [   42.111012]  _prb_read_valid+0xd8/0x190
>>> [   42.111012]  prb_read_valid+0x15/0x20
>>> [   42.111013]  devkmsg_read+0x9d/0x2a0
>>> [   42.111013]  vfs_read+0x91/0x140
>>> [   42.111013]  ksys_read+0x59/0xd0
>>> [   42.111014]  do_syscall_64+0x55/0x1b0
>>> [   42.111014]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   42.111014] RIP: 0033:0x7f7c55740b62
>>> [   42.111015] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
>>> [   42.111015] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> [   42.111016] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c55740b62
>>> [   42.111016] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 0000000000000008
>>> [   42.111017] RBP: 0000000000000000 R08: 0000000000000100 R09: 0000000000000003
>>> [   42.111017] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe95f4c4b0
>>
>> So there is a General protection fault. That's the type of a problem that
>> kills the boot for me as well (different backtrace, tho).
> 
> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR) enabled?
> 

Yes. These two options are enabled.

CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y

Thanks.

> 	-ss
> 


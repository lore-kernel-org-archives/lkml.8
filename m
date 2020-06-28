Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D283C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337F621473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCnixC4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgF1EXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 00:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgF1EXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:23:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E758C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:23:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so5797889plk.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3w1BiBZXQWNuh7UhI1vyvg5PZS2NZZfCk+U2rU591rg=;
        b=bCnixC4UtcRysRiv5Ss7LJKDnRQNQMy7O3duST+tZbAx9yt+S3+p1FC/+zaHie9mkH
         4cY2ycskth0SU/xAqapojSwtBWhnac6SnrRH4mAMcrqZrErS7+dGIx2SO1AeMPTQ3Z12
         yxK8KfyBrSML9Nylj9/O/BY7BqjVKJOzNJ/GExaoL6jIfI9RvKbK8FiEzUPW8+mCfVc7
         nlN1hpTmt5GC4zwCSAbrn8roVv14HReRmz3/tE0Dq0SU+80mXt4IwU5fTjExYWsHqlYX
         t88Ku/9jnxMJsaKRQjNtR8JCosxgw1Sw6j7Q2Ov6UAtyknraLLjdEySX/5ZAoV+AXq5a
         KkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3w1BiBZXQWNuh7UhI1vyvg5PZS2NZZfCk+U2rU591rg=;
        b=J6YOD0X/ZHxcetQz3IB8WMGofMd1mrTqbfLhtEXWVqH2Sl7sKz7gtqtDU74RnNkHWL
         04ERslgVQYABKTIxEvEdgWwr12jer+X09yD1qF6oOxyHPBjU0eWiq5S/iRpqjzktCY8/
         TeHm3PYfv2XglLIje9l+Z9OCEBgf3KbdvoQb4Md0pGC+jk/7d6DYayPy8PK2cL3zU2m/
         G+EMEP8rcKOaV+9IkcvVglVzfuBtJgWaTWCk+li6POQ/aIIYeW+3I07O6AjYeHYozhLl
         RM+QAfauBzrktY/iIt0aZwMy9pr6ULYZZE/MeDFtfJGFGL/giXVeN4/5CS6hjiPIbLNY
         ZX1w==
X-Gm-Message-State: AOAM532krrsIxMgu+cBSohpjcO/XZIE7G1tG3enKZbWV8rW1xup9DJiw
        ql1p4ZukMTwYUpOgApilxUHBVA==
X-Google-Smtp-Source: ABdhPJyHxbwictJ5h3eTTi5bStL7CNjyknf9m2emBi2Y6g2wwsEd+/gedBRoEJMUtH1s5Nh/9oR3PQ==
X-Received: by 2002:a17:90a:8c0e:: with SMTP id a14mr967640pjo.75.1593318212990;
        Sat, 27 Jun 2020 21:23:32 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p10sm14957467pjp.52.2020.06.27.21.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 21:23:32 -0700 (PDT)
Date:   Sat, 27 Jun 2020 21:23:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     kernel test robot <lkp@intel.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm, slub] c91e241f56: WARNING:at_mm/slub.c:#kmem_cache_open
In-Reply-To: <20200627075158.GA5535@shao2-debian>
Message-ID: <alpine.DEB.2.22.394.2006272121380.591864@chino.kir.corp.google.com>
References: <20200627075158.GA5535@shao2-debian>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020, kernel test robot wrote:

> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c91e241f569e7f9b0e2946841ef884b22a09f624 ("mm, slub: introduce kmem_cache_debug_flags()-fix")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: kernel-selftests
> with following parameters:
> 
> 	group: kselftests-x86
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------+------------+------------+
> |                                       | d5cee50015 | c91e241f56 |
> +---------------------------------------+------------+------------+
> | boot_successes                        | 13         | 0          |
> | boot_failures                         | 0          | 17         |
> | WARNING:at_mm/slub.c:#kmem_cache_open | 0          | 17         |
> | EIP:kmem_cache_open                   | 0          | 17         |
> | WARNING:at_mm/slub.c:#new_slab        | 0          | 17         |
> | EIP:new_slab                          | 0          | 17         |
> | WARNING:at_mm/slub.c:#___slab_alloc   | 0          | 17         |
> | EIP:___slab_alloc                     | 0          | 17         |
> | WARNING:at_mm/slub.c:#__slab_free     | 0          | 17         |
> | EIP:__slab_free                       | 0          | 17         |
> | WARNING:at_mm/slub.c:#deactivate_slab | 0          | 4          |
> | EIP:deactivate_slab                   | 0          | 4          |
> +---------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> [    1.934611] WARNING: CPU: 0 PID: 0 at mm/slub.c:132 kmem_cache_open+0x1cc/0x346
> [    1.934612] Modules linked in:
> [    1.934614] CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc1-00274-gc91e241f569e7 #1
> [    1.934615] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    1.934615] EIP: kmem_cache_open+0x1cc/0x346
> [    1.934617] Code: 83 ca ff b9 02 00 00 00 0f bd c7 0f 44 c2 99 f7 f9 ba 0a 00 00 00 83 f8 0a 0f 47 c2 ba 05 00 00 00 83 f8 05 0f 42 c2 89 43 08 <0f> 0b 81 ff ff 0f 00 00 76 09 c7 43 18 02 00 00 00 eb 29 81 ff ff
> [    1.934618] EAX: 00000005 EBX: 8d26c820 ECX: 00000002 EDX: 00000005
> [    1.934619] ESI: 00000040 EDI: 00000040 EBP: 8d181eec ESP: 8d181ed0
> [    1.934620] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210093
> [    1.934621] CR0: 80050033 CR2: ffbff000 CR3: 0d2bc000 CR4: 000406b0
> [    1.934622] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    1.934622] DR6: fffe0ff0 DR7: 00000400
> [    1.934623] Call Trace:
> [    1.934624]  __kmem_cache_create+0x1f/0x100
> [    1.934624]  ? vprintk_emit+0x1c4/0x1ce
> [    1.934625]  ? vprintk_default+0x12/0x14
> [    1.934626]  create_boot_cache+0x59/0x79
> [    1.934626]  kmem_cache_init+0x48/0x11d
> [    1.934627]  start_kernel+0x217/0x424
> [    1.934628]  ? early_idt_handler_common+0x44/0x44
> [    1.934628]  i386_start_kernel+0x43/0x45
> [    1.934629]  startup_32_smp+0x164/0x168
> [    1.934630] ---[ end trace 19a0735aef7d3dec ]---
> 

I think this is fixed by 
mm-slab-slub-improve-error-reporting-and-overhead-of-cache_from_obj-fix.patch 
in -mm, the config here does not have CONFIG_SLUB_DEBUG enabled so the 
VM_WARN_ON_ONCE() would always be triggered without this fix.

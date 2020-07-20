Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5358EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E0520758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595223901;
	bh=wakRvmMory4MqZqdi1I4pk0bcYMsz8fBS1X8plVmQq8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=W49XFfr9/vdeZkihuafGSj5+us/iUKBr2bbgAzv1kUYdKdfv7TsB0PLL8+cwEP6JG
	 DQIhdpFZ7BGmdnQ6vMnTvNjo/b7Nk+BBg0zS1XFkTzum7bwlBbTUq6xlmSX/i+vXjK
	 247G30HfBTk0pLq5UAJJ+LFkAHQXd+A8mZRybybo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgGTFo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:44:59 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45444 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTFo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:44:59 -0400
Received: by mail-ej1-f67.google.com with SMTP id a1so16734026ejg.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P3C1c9veJT5xao6W/+BSbcnDxvOAGXZygUTBB4BI63M=;
        b=B9El2gnDdoO/txHkgE98pCXrR5BEMlIV7y5DRQWpBIChIfuF6boTqTYoozJvgxADS0
         xk2t3hFAMXb+V+ZGm/tvt8jW3Oe6jD2L80+vZO920LXSZd+tr0HndsYtmT3hj/mpagQP
         fQeKap8eqko2GZJOfqfwhB1uQFWyk/21bOnTBxGB4Rt8qSLlQjy/9gmRbdwKnsw4/cZI
         JNDJ8B6tRAK8GcCUixJn6R2WOZ+7uIjgvpNA1lwsJSL1Cz+LP1Ab+2EggVSDgvVZZZj3
         AjOkY1weIit00I87web0rC5/qs4I1ZY5Rm1+HL9lA/EzVLvJXxhG9dv3/2Oj6Zdj/Wbf
         XGGA==
X-Gm-Message-State: AOAM5338xEL3NTdXt4BQRJGZjGLT2h/UZJVidwx185RxcyhhvcxnCj5h
        0QdwDryK2TB+AOP4FT7DDog=
X-Google-Smtp-Source: ABdhPJx4zQpxMwJIHn0VevhF0Vuj5PVgTbPVRwD9foLkXQzprWtrUn9LDCPy4tD+1rxFFBZzR0kZ2w==
X-Received: by 2002:a17:906:a253:: with SMTP id bi19mr18613712ejb.338.1595223896118;
        Sun, 19 Jul 2020 22:44:56 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x64sm15073826edc.95.2020.07.19.22.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 22:44:55 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com> <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
Date:   Mon, 20 Jul 2020 07:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 07. 20, 19:44, Christian Brauner wrote:
> On Sat, Jul 18, 2020 at 07:14:07PM +0200, Oleg Nesterov wrote:
>> On 07/18, Jiri Slaby wrote:
>>>
>>> On 17. 07. 20, 14:40, Oleg Nesterov wrote:
>>>>
>>>> please see the updated patch below, lets check ptrace_unfreeze() too.
>>>
>>> Sure, dmesg attached.
>>
>> Thanks a lot!
>>
>> But I am totally confused...
>>
>>> [   94.513944] ------------[ cut here ]------------
>>> [   94.513985] do not call blocking ops when !TASK_RUNNING; state=8 set at [<000000002fe279e9>] ptrace_check_attach+0xbf/0x110
>>
>> OK, so the ptracer has already did the TASK_TRACED -> __TASK_TRACED change in
>> ptrace_freeze_traced(),
>>
>>> [   94.514019] WARNING: CPU: 16 PID: 34171 at kernel/sched/core.c:6881 __might_sleep+0x6c/0x70
>>> [   94.514020] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
>>> [   94.514082] CPU: 16 PID: 34171 Comm: strace Tainted: G            E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
>>> [   94.514084] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
>>> [   94.514087] RIP: 0010:__might_sleep+0x6c/0x70
>>> [   94.514090] Code: 41 5c 41 5d e9 25 ff ff ff 48 8b 90 68 1a 00 00 48 8b 70 10 48 c7 c7 10 45 70 8f c6 05 4f a9 68 01 01 48 89 d1 e8 7a bb fc ff <0f> 0b eb c8 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 fd
>>> [   94.514092] RSP: 0018:ffff9ffa4ba1be00 EFLAGS: 00010286
>>> [   94.514093] RAX: 0000000000000000 RBX: ffff8dc82b503e00 RCX: 0000000000000489
>>> [   94.514094] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000247
>>> [   94.514095] RBP: ffffffff8f6ffa6b R08: 0000000000000004 R09: 0000000000000489
>>> [   94.514095] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000039
>>> [   94.514096] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
>>> [   94.514098] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
>>> [   94.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   94.514100] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
>>> [   94.514103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [   94.514104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [   94.514105] Call Trace:
>>> [   94.514821]  ptrace_stop+0x1a9/0x300
>>
>> This is already wrong. But
>>
>> 	Where does this __might_sleep() come from ??? I ses no blocking calls
>> 	in ptrace_stop(). Not to mention it is called with ->siglock held and
>> 	right after this lock is dropped we take tasklist_lock.
>>
>> 	How this connects to the debugging patch I sent? Did you see this warning
>> 	without that patch?
>> 	
>>
>>> [   94.514888] WARNING: CPU: 16 PID: 34171 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
>> ...
>>> [   94.514899] RIP: 0010:ptrace_stop+0x1d8/0x300
>>
>> This is WARN_ON(current->state) added to ptrace_stop(), this can explain
>> BUG_ON() in do_notify_parent() you reported.
>>
>> So, the tracee returns from schedule() with ->state != TASK_RUNNING ???
>> This must not be possible.
>>
>> OK, perhaps task->state was changed by ptrace_unfreeze_traced()? this can
>> only happen if it races with ttwu(__TASK_TRACED) without ->siglock held,
>> nobody should do this.
>>
>> Strange.
> 
> I have tried to reproduce this with an vanilla upstream 5.8-rc4 and the
> strace test-suite with
> 
> make check -j4
> 
> and I wasn't able to after multiple retries. Jiri, just to make sure
> this is upstream 5.8-rc4 without any additional patches?

You tackled it, we cherry-picked dbfb089d360 to our kernels. Ccing more
people.

So if you try with pure vanilla 5.8-rc6 (it contains the commit), you
should be able to reproduce. I am.

OTOH 5.8-rc6 with that commit reverted -- I cannot reproduce there. So
it must be it.

> Anything special required to reproduce this in the way you run strace
> and so on?

Nothing special there. Except the HW: when I run a VM with 16+
processors, it's much more likely to be hit (usually, on the first run
of make check).

thanks,
-- 
js

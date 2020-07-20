Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A83C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3212D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595224843;
	bh=7Tm3y6ys6c5KTjSLhoUxixPeCDvJdL3nYvsmU0uU++g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=rgD0rw2dMkb3k3InEXNcart3ZmdOo2GgekWOq6IATTnoxB+zKGsgrrtqmF8feJ23m
	 15gK7e1YCXEvDjtIsnllzmCYjYTVpkzfuTSD0o53ktPlYE9/foVriYvKWZ9F7VdoUP
	 3vKWAlfJqv6suKRpqqGGlhT4IlgdaMoEjculONQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGTGAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:00:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36469 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:00:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id dg28so11885585edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PuzbMP4Fx1ZupEXT7MERkXxCqLRlatNCHClyE1DuVQ0=;
        b=UNh4GRbULjD2btj5cOElIsPKN1sWv1ZWOeuXvQfh0KEAOylR8eUOmt6LKsgkcpa3Jq
         +QdNksxtg6qOFjnJA9qprA3cJbQEd6kSGIFqV/smxMb8PC50beHaFq8ZZYJ7WXofmbhA
         n3lw6hIHpgcuHD5haOf1qYzIKhgIXOTMD919/aqx8N3Hr5MNupcwCDJhpt7IK/QRHkef
         w+G1EH7Qa+iSwzBGH9RZ5age2QnxHwbWn1+ITRazNXrtteMiQQWOnKkiWynFa5C10KT1
         RI+Aed8KucZ7L0X+Ma+qvFXakZtxHoU4mvyfH+BRr6KdmQ1PvV9sveJRIFV7TMqTYwdQ
         taDA==
X-Gm-Message-State: AOAM530dL+WrfsE8V3V6l4DwYRPpkC+DRQ2JAi+Nd2rQoOKmBV6HBbRt
        RXL+vZ+Fd5fPkfQvgifIk8wFqc9u
X-Google-Smtp-Source: ABdhPJz1ohMA094ZI2rfCq82O/bDdbi8cFKPROXehsexD2ZHup0rMjiA2aYRP38+Sg13YeWHQZqD5A==
X-Received: by 2002:a50:ed15:: with SMTP id j21mr20722218eds.246.1595224838439;
        Sun, 19 Jul 2020 23:00:38 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id j16sm13743762ejn.77.2020.07.19.23.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 23:00:37 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com> <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0deb1081-299b-1475-f368-7ca65b535a9c@kernel.org>
Date:   Mon, 20 Jul 2020 08:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718171406.GB16791@redhat.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 07. 20, 19:14, Oleg Nesterov wrote:
> On 07/18, Jiri Slaby wrote:
>>
>> On 17. 07. 20, 14:40, Oleg Nesterov wrote:
>>>
>>> please see the updated patch below, lets check ptrace_unfreeze() too.
>>
>> Sure, dmesg attached.
> 
> Thanks a lot!
> 
> But I am totally confused...
> 
>> [   94.513944] ------------[ cut here ]------------
>> [   94.513985] do not call blocking ops when !TASK_RUNNING; state=8 set at [<000000002fe279e9>] ptrace_check_attach+0xbf/0x110
> 
> OK, so the ptracer has already did the TASK_TRACED -> __TASK_TRACED change in
> ptrace_freeze_traced(),
> 
>> [   94.514019] WARNING: CPU: 16 PID: 34171 at kernel/sched/core.c:6881 __might_sleep+0x6c/0x70
>> [   94.514020] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
>> [   94.514082] CPU: 16 PID: 34171 Comm: strace Tainted: G            E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
>> [   94.514084] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
>> [   94.514087] RIP: 0010:__might_sleep+0x6c/0x70
>> [   94.514090] Code: 41 5c 41 5d e9 25 ff ff ff 48 8b 90 68 1a 00 00 48 8b 70 10 48 c7 c7 10 45 70 8f c6 05 4f a9 68 01 01 48 89 d1 e8 7a bb fc ff <0f> 0b eb c8 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 fd
>> [   94.514092] RSP: 0018:ffff9ffa4ba1be00 EFLAGS: 00010286
>> [   94.514093] RAX: 0000000000000000 RBX: ffff8dc82b503e00 RCX: 0000000000000489
>> [   94.514094] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000247
>> [   94.514095] RBP: ffffffff8f6ffa6b R08: 0000000000000004 R09: 0000000000000489
>> [   94.514095] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000039
>> [   94.514096] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
>> [   94.514098] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
>> [   94.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   94.514100] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
>> [   94.514103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   94.514104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   94.514105] Call Trace:
>> [   94.514821]  ptrace_stop+0x1a9/0x300
> 
> This is already wrong. But
> 
> 	Where does this __might_sleep() come from ??? I ses no blocking calls
> 	in ptrace_stop(). Not to mention it is called with ->siglock held and
> 	right after this lock is dropped we take tasklist_lock.

Decoded stacktrace:

> ptrace_stop (include/linux/freezer.h:57 include/linux/freezer.h:67 include/linux/freezer.h:128 include/linux/freezer.h:173 kernel/signal.c:2217)  
> ptrace_do_notify (kernel/signal.c:2272)  
> ptrace_notify (arch/x86/include/asm/paravirt.h:656 arch/x86/include/asm/qspinlock.h:55 include/linux/spinlock.h:211 include/linux/spinlock_api_smp.h:167 include/linux/spinlock.h:403 kernel/signal.c:2282)  
> syscall_trace_enter (include/linux/tracehook.h:73 include/linux/tracehook.h:104 arch/x86/entry/common.c:159)
> do_syscall_64 (arch/x86/entry/common.c:380)  
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)  

It is try_to_freeze_unsafe in try_to_freeze in freezable_schedule in
ptrace_stop.

> 
> 	How this connects to the debugging patch I sent? Did you see this warning
> 	without that patch?

I suppose this made it appear:
+CONFIG_PREEMPT_COUNT=y
-# CONFIG_DEBUG_ATOMIC_SLEEP is not set
+CONFIG_DEBUG_ATOMIC_SLEEP=y

>> [   94.514888] WARNING: CPU: 16 PID: 34171 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
> ...
>> [   94.514899] RIP: 0010:ptrace_stop+0x1d8/0x300
> 
> This is WARN_ON(current->state) added to ptrace_stop(), this can explain
> BUG_ON() in do_notify_parent() you reported.
> 
> So, the tracee returns from schedule() with ->state != TASK_RUNNING ???
> This must not be possible.
> 
> OK, perhaps task->state was changed by ptrace_unfreeze_traced()? this can
> only happen if it races with ttwu(__TASK_TRACED) without ->siglock held,
> nobody should do this.
> 
> Strange.

Please see my other e-mail, all this is with dbfb089d360b applied. Maybe
it makes more sense now?

thanks,
-- 
js

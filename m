Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9680C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808972076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594983886;
	bh=nzKMZVBx0o1i0lnPZD4WolRVx+W+FMRUlx5HJotcjV8=;
	h=Subject:From:To:References:Date:In-Reply-To:List-ID:From;
	b=yBHGxhJR8rni64x3VNmTz8KhhNWtvzPxsJtIoNS99Z4C+1sb75OAl3PEdzH3cwNoH
	 bJWgeiH5ls3mp7xM7Su+SsBQ8W1SzoHfUFl2Ju3ZINMR9e4Ba7YhK/CyF+EjRJ/0O7
	 EX7ZIJ++FUFwjBchtOARhd8LNSDRM3kBpCVLJGuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGQLEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33406 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id h28so7349560edz.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwO9ooKVAyiPOOXEnU9bXuMrqYv/InVTMqk9eon28Ew=;
        b=SR5YA6ogytSY8AIA4245VdS6xuBSz2VlF5rt1ROnJtOvYKj0iG4KdQVH9mqDMUgi0f
         l9RnbDAPXHFJ+tVQMwss/36DoPZGSf32zg6XTCuK3aPrC6b/b9PcHUlxYfuQUifs09rY
         oX55ODWiD7kwVWKBkbiD0pEburnXojZ2JpTqeZOTfBxUEUklmX85Db2vd30b+rF+8Azc
         fzWbCPqKQY1EOl5mH+O0lfV/n5oNw02ciaPG6KXACzQ00Q1KLti0VjrgrwDqSbz2gb9I
         DEv21sVMcoi8iPuRxbLVPhERbIq7jnMrX8505EFYJUYO8O/Y0Q3l1AthYiAsh17eaDxR
         saZw==
X-Gm-Message-State: AOAM531oiTREZiIy8g7HqGVZHIvmr7yRdUdZuUwUhYQUWgapp1VIiYIG
        bVnN32VDSCkjCGf4GscszKvn6F+q
X-Google-Smtp-Source: ABdhPJx61tEnahDVqdXy6ZzdBlNacQlTeSwEdtYAaf0QtVHZ8WMqCe+TIC+e7hUdsBnNoUkTIrIDIw==
X-Received: by 2002:a50:fc88:: with SMTP id f8mr8795222edq.314.1594983880523;
        Fri, 17 Jul 2020 04:04:40 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id v11sm7622129eja.113.2020.07.17.04.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:39 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
Date:   Fri, 17 Jul 2020 13:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 07. 20, 12:45, Jiri Slaby wrote:
> Hi,
> 
> the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
> and i586:

make check needs -jsomething, running is sequentially (-j1) doesn't
trigger it. After the error, I cannot run anything. Like ps to find out
what test caused the crash...

5.7 was fine.

>> kernel BUG at kernel/signal.c:1917!
>> invalid opcode: 0000 [#1] SMP NOPTI 
>> CPU: 7 PID: 18367 Comm: filter-unavaila Not tainted 5.8.0-rc4-3.g2cd7849-default #1 openSUSE Tumbleweed (unreleased)
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> RIP: 0010:do_notify_parent+0x239/0x270 
>> Code: d1 e8 41 89 c5 41 83 e5 01 48 8b 95 28 05 00 00 45 31 c0 4c 89 f6 44 89 e7 b9 01 00 00 00 e8 ce f2 ff ff e9 5b ff ff ff 0f 0b <0f> 0b 48 39 bf 50 05 00 00 75 17 48 8b 97 c0 05 00 00 48 8d 87 c0
>> RSP: 0018:ffffa05400f93d00 EFLAGS: 00010002
>> RAX: 0000000000000008 RBX: ffff9024ebb6dd00 RCX: 00000000000102f9
>> RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9024ebb6dd00
>> RBP: ffff9024ebb6dd00 R08: 0000000000000000 R09: 000000000000000d
>> R10: 00007f7813000000 R11: ffffc2690721ae80 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000009 R15: 0000000000000000
>> FS:  00007f7812ffc700(0000) GS:ffff902537dc0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f9c246a4a10 CR3: 00000001eba7c000 CR4: 00000000000406e0
>> Call Trace:
>>  exit_notify+0x1c0/0x1f0 
>>  do_exit+0x234/0x430
>>  do_group_exit+0x33/0xa0 
>>  get_signal+0x171/0x640
>>  do_signal+0x2a/0x1c0
>>  exit_to_usermode_loop+0x89/0x110
>>  __prepare_exit_to_usermode+0x92/0xd0
>>  do_syscall_64+0x59/0xd0 
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x7f78149db992
>> Code: Bad RIP value.
>> RSP: 002b:00007f7812ffbed0 EFLAGS: 00000293 ORIG_RAX: 0000000000000022
>> RAX: fffffffffffffdfe RBX: 0000000000000000 RCX: 00007f78149db992
>> RDX: 0000000000000001 RSI: 0000558a4e07e033 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f7812ffc700
>> R10: 00007f7812ffc9d0 R11: 0000000000000293 R12: 0000000000000000
>> R13: 00007ffe4853b4bf R14: 00007ffe4853b4c0 R15: 00007f7812ffc700
>> Modules linked in: ata_generic ata_piix qemu_fw_cfg e1000 nls_iso8859_1 nls_cp437 vfat fat virtio_blk virtio_mmio xfs btrfs blake2b_generic xor raid6_pq libcrc32c crc32c_intel reiserfs squashfs fuse dm_snapshot dm_bufio dm_crypt dm_mod binfmt_misc loop sg virtio_rng
>> ---[ end trace 364c3385f192fee3 ]---
> 
> Any ideas?
> 
> thanks,
> 


-- 
js

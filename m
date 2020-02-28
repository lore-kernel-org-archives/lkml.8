Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0EE246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgB1KE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:04:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46312 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1KE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:04:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2190521wrp.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dadsb0J7bGiFsc39eAlUnpOz7SBPbou+SRcpsCVNGN8=;
        b=H8QOOC5yxU3Z2kp7ETRhKCyh4p2clpISuCc/UOIqCt1kF/AWtvP9Vk4z1xTwRUtnyE
         52ljVXFt5ylUQFoqJqcR27fSy60fdoFMYeT+WLzLGd+bHmlnPdIQwczy7jHtMtEo4SR/
         QXuhhkgzPUuydz1ABCdpzFM39IUJ/aJQFCcGPgfnlaVmm4M+Bf1xDXfcjao5ISlnl+4G
         XE85OSCsb2lN0L2/vicp5ghQDLm382yLIVQ4j7zXDkMH1NOMfbuGh/3BJc8h4HYefij8
         AaYYJXU3AoiDxWPMKgTFRJU7WiX7U/dS1TtBDF3/+TH6LZ3JM0jt7kehW4WsUQOIUWES
         cBAA==
X-Gm-Message-State: APjAAAVo7ty88b6tpknCAMR31R184j9FsqbYXHhe6WjMe36J/xAVkyZh
        rEuRCrd0M3mkb32N6q2S7zo=
X-Google-Smtp-Source: APXvYqxPEhQmloLVUQcxj76B2SSA3HdPtIZa9PWkKtkT6T5KjEGdtjvwez70dxM2C9kyReH7VfM4jw==
X-Received: by 2002:adf:facc:: with SMTP id a12mr4171912wrs.100.1582884265783;
        Fri, 28 Feb 2020 02:04:25 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id n3sm1458588wmc.42.2020.02.28.02.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 02:04:25 -0800 (PST)
Subject: Re: possible deadlock in tty_unthrottle
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20200227113622.4716-1-hdanton@sina.com>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <54a3b906-790e-fd5d-6f6f-a6a9a711d08f@suse.com>
Date:   Fri, 28 Feb 2020 11:04:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200227113622.4716-1-hdanton@sina.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 02. 20, 12:36, Hillf Danton wrote:
> 
> On Thu, 27 Feb 2020 00:39:12 -0800
>> syzbot found the following crash on:
>>
>> HEAD commit:    f8788d86 Linux 5.6-rc3
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1102d22de00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=26183d9746e62da329b8
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.6.0-rc3-syzkaller #0 Not tainted
>> ------------------------------------------------------
>> syz-executor.4/20336 is trying to acquire lock:
>> ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>>
>> but task is already holding lock:
>> ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374
>>
>> which lock already depends on the new lock.

>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (sel_lock){+.+.}:
>>        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
>>        set_selection_kernel+0x3b8/0x18a0 drivers/tty/vt/selection.c:217
>>        set_selection_user+0x63/0x80 drivers/tty/vt/selection.c:181
>>        tioclinux+0x103/0x530 drivers/tty/vt/vt.c:3050
>>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364

This is ioctl(TIOCL_SETSEL).
Locks held on the path: console_lock -> sel_lock

>> -> #1 (console_lock){+.+.}:
>>        console_lock+0x46/0x70 kernel/printk/printk.c:2289
>>        con_flush_chars+0x50/0x650 drivers/tty/vt/vt.c:3223
>>        n_tty_write+0xeae/0x1200 drivers/tty/n_tty.c:2350
>>        do_tty_write drivers/tty/tty_io.c:962 [inline]
>>        tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046

This is write().
Locks held on the path: termios_rwsem -> console_lock

>> -> #0 (&tty->termios_rwsem){++++}:
>>        down_write+0x57/0x140 kernel/locking/rwsem.c:1534
>>        tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
>>        mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
>>        tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
>>        paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
>>        tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
>>        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364

This is ioctl(TIOCL_PASTESEL).
Locks held on the path: sel_lock -> termios_rwsem

>> other info that might help us debug this:
>>
>> Chain exists of:
>>   &tty->termios_rwsem --> console_lock --> sel_lock

Clearly. We have from the above:
console_lock -> sel_lock
sel_lock -> termios_rwsem
termios_rwsem -> console_lock

> The sel_lock was introduced in
> 	07e6124a1a46 ("vt: selection, close sel_buffer race")
> 
> and with it in position can we cut one lock for setting selection?
> 
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3015,8 +3015,6 @@ static struct console vt_console_driver
>   *
>   * There are some functions which can sleep for arbitrary periods
>   * (paste_selection) but we don't need the lock there anyway.
> - *
> - * set_selection_user has locking, and definitely needs it
>   */
>  
>  int tioclinux(struct tty_struct *tty, unsigned long arg)
> @@ -3035,10 +3033,8 @@ int tioclinux(struct tty_struct *tty, un
>  	switch (type)
>  	{
>  		case TIOCL_SETSEL:
> -			console_lock();
>  			ret = set_selection_user((struct tiocl_selection
>  						 __user *)(p+1), tty);
> -			console_unlock();

This won't fly. First, set_selection_user is not the only caller of
set_selection_kernel with console lock held. Second, we really have to
hold the console lock. The first thing to literally yell would be
poke_blanked_console in set_selection_user :).

But let's switch the order of the locks. Let console lock nest under
sel_lock and not vice versa. I will prepare a patch shortly.

thanks,
-- 
js
suse labs

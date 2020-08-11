Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51150C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225E02076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mqJNQ44T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgHKO7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgHKO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:59:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDCEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:59:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x6so6828429pgx.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jn3G3go0uPIm6/Hv6VYyRGg4+qh3uHywEaZstpdHmqw=;
        b=mqJNQ44TtJ6eSbTsFSka9uUnR9iHP9wmGrDflP72AxbNjpFIg5qmwC5ltvASUfNtrz
         rDC6jsr3LoS4H07TtLAAgauYI7TM1heqoJRDYDaGE+AyXRYeEzybVaRan7++hxvZ7mYT
         KA+Z4p6w4Qw0wro9ZMjIjMvclTjLbtsURAej0QvU/9GyU1LmxxZNv2MNF1pDOJwtqNtY
         aqR7OqiLNyyOerQ9XMJ3181UKcXoJDwRmnI1YszX7GJbQtKlz6YsdGQVOQAFJ5Q88smU
         ll4MgqqDX3BF1IhsVv9fOUzv3nZUOdSSPUT7sc2l9ZNRDz97dxI1Qtmbx5f7yuDPzVn4
         4FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jn3G3go0uPIm6/Hv6VYyRGg4+qh3uHywEaZstpdHmqw=;
        b=XmIR1E7wnUiD97ZE5oBRUh6NeEXHll8qXOKsfvlju3IOLJbsi/u4NKt5FjaQ0mitqi
         8ny8nnQRiYkCzdAA3wIgQa6mKle9W9a0tvbq+c7Jmt0pcAhKl4Q6CzFH0CZrr4av+taY
         tLEGSSbm/PUO8AGjfgHxufeIIPj4Xk5wcHH3Vm7L562Jus5ngg40Un0z4tCqMjVwMH4K
         oPPJTWQweUSs1PH5epmv6fGBinIH39iBcjMMgs+zsQPtN0WmTY2t74fqaetFRI1gcWmF
         IoE2hYxVDgLDrnD5UKP790G9+tJVz8c7TUfu/N0MiZINthzRZMhSLQURGaS5gu/R5ufQ
         2/Ow==
X-Gm-Message-State: AOAM531/SlAIu9NmTXpzk4ynLd+cfDj3NZqv2SK67zal0a54EmbAYNJT
        EutLqsQKWcEYtk38ihz4+9jO9g==
X-Google-Smtp-Source: ABdhPJwR2RwU3XLPwDMfiZ4lA5am8iXtiBK2wvM66c8X+SJGZdRgi5U5zFEVPVxqUa5iZurGC3XMmQ==
X-Received: by 2002:aa7:8431:: with SMTP id q17mr6925533pfn.132.1597157945813;
        Tue, 11 Aug 2020 07:59:05 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z6sm26342004pfg.68.2020.08.11.07.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:59:05 -0700 (PDT)
Subject: Re: memory leak in io_submit_sqes
To:     syzbot <syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000f50fb505ac9a72c9@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8c5db23-c3cf-7daf-6a0a-8a5f713e9803@kernel.dk>
Date:   Tue, 11 Aug 2020 08:59:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000f50fb505ac9a72c9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 7:57 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d6efb3ac Merge tag 'tty-5.9-rc1' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cb0762900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=42163327839348a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=a730016dc0bdce4f6ff5
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e877dc900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608291a900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com
> 
> executing program
> executing program
> executing program
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff888124949100 (size 256):
>   comm "syz-executor808", pid 6480, jiffies 4294949911 (age 33.960s)
>   hex dump (first 32 bytes):
>     00 78 74 2a 81 88 ff ff 00 00 00 00 00 00 00 00  .xt*............
>     90 b0 51 81 ff ff ff ff 00 00 00 00 00 00 00 00  ..Q.............
>   backtrace:
>     [<0000000084e46f34>] io_alloc_req fs/io_uring.c:1503 [inline]
>     [<0000000084e46f34>] io_submit_sqes+0x5dc/0xc00 fs/io_uring.c:6306
>     [<000000006d4e19eb>] __do_sys_io_uring_enter+0x582/0x830 fs/io_uring.c:8036
>     [<00000000a4116b07>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<0000000067b2aefc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff88811751d200 (size 96):
>   comm "syz-executor808", pid 6480, jiffies 4294949911 (age 33.960s)
>   hex dump (first 32 bytes):
>     00 78 74 2a 81 88 ff ff 00 00 00 00 00 00 00 00  .xt*............
>     0e 01 00 00 00 00 75 22 00 00 00 00 00 0f 1f 04  ......u"........
>   backtrace:
>     [<00000000073ea2ba>] kmalloc include/linux/slab.h:555 [inline]
>     [<00000000073ea2ba>] io_arm_poll_handler fs/io_uring.c:4773 [inline]
>     [<00000000073ea2ba>] __io_queue_sqe+0x445/0x6b0 fs/io_uring.c:5988
>     [<000000001551bde0>] io_queue_sqe+0x309/0x550 fs/io_uring.c:6060
>     [<000000002dfb908f>] io_submit_sqe fs/io_uring.c:6130 [inline]
>     [<000000002dfb908f>] io_submit_sqes+0x8b8/0xc00 fs/io_uring.c:6327
>     [<000000006d4e19eb>] __do_sys_io_uring_enter+0x582/0x830 fs/io_uring.c:8036
>     [<00000000a4116b07>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<0000000067b2aefc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

This one looks very odd, and I cannot reproduce it. The socket() calls
reliably fails for me, and even if I hack it to use 0 for protocol instead
of 2, I don't see anything interesting happening here. An IORING_OP_WRITEV
is submitted on the socket, which just fails with ENOTCONN.

-- 
Jens Axboe


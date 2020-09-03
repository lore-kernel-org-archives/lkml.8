Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F01C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F47120716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="arhvROiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgICOwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgICONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:13:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA2C06123B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:04:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l4so2613746ilq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D31H04mUbP+GfSuSCo4lSao/klBUc/vQDz1fdRAoRLI=;
        b=arhvROiKCh0B0OFzraDqlWOtES8RJVlS3wjLrZWs/uK0wr9n+mzsscBgaIX55vzkmO
         UGCeK89hwjdy8ds866T0uNIYWLGZzcwPJt9TPQ21Qbt8ZuosiJjnokEJlG89FxJWAUtO
         AvQ5kLibQEH1hXFKxGwez9PRbpEczSDW6GBM/AFhjv+TlUW6kqpWMXGjy9pYPe/ooujc
         ZJwyaofPEIt5tHRP7Jx0f9Q4juqQufPIAxtM/eSowCN06PRkigTjKSuyFVxGstHW+8zi
         GQr60T3r7BuWtn2iuSBB9KZL1Ho8iWzXapg7hsB4asCX5WfFufGamuO3uXvGiJtmuSoI
         36MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D31H04mUbP+GfSuSCo4lSao/klBUc/vQDz1fdRAoRLI=;
        b=NED9dk58VPcubAfsFCJG5H9A5PzxKpevIW7CBP8+HxInQRsP5SPnv67/w+94wDESLl
         OchH1lgVLk+dEyEFdK7v/kwdKLVcBW/77KhiKRJaS79/n98tdPiScDRSW56J4SU/LQBJ
         V7sKpFzDAgilG2XHyl8CsZ3ZGGKMHjqO3Q7md7m1GbFP6M+M/Ou3TIDTOWalDnm9kdGD
         CLvoUJQAmznoul4gAcy1XorLiXYvFBZRgYt8fo6nCTTBXuALYGabHKrnCd0YvP14qxlP
         S5wbYvHUF8OhelEPo6ij7jw7+60Kqwppp1kGnCRs50ULHV7dF3ozV5tK0vjFmONey79Z
         8vQg==
X-Gm-Message-State: AOAM533+FVD7S/WcCQX8ILe3i4EWL/z0lQBhyC13Yi4E2tfLfcx1Zsh3
        6QLWIHEaGV8fnHzBXXiRPtaIrw==
X-Google-Smtp-Source: ABdhPJzNX2pngMZo/p4jPhsZsLuRxbuccAvhohxEPGEsSkeD6Qa/tVfYBvZvbtTRHCwT+r3ZmuVI+Q==
X-Received: by 2002:a92:9fc9:: with SMTP id z70mr3242577ilk.91.1599141863740;
        Thu, 03 Sep 2020 07:04:23 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p3sm1497198ilq.59.2020.09.03.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 07:04:23 -0700 (PDT)
Subject: Re: [PATCH next] io_uring: fix task hung in io_uring_setup
To:     Hillf Danton <hdanton@sina.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk,
        syzbot+107dd59d1efcaf3ffca4@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Kees Cook <keescook@chromium.org>
References: <20200903132119.14564-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9bef23b1-6791-6601-4368-93de53212b22@kernel.dk>
Date:   Thu, 3 Sep 2020 08:04:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903132119.14564-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 7:21 AM, Hillf Danton wrote:
> 
> The smart syzbot found the following issue:
> 
> INFO: task syz-executor047:6853 blocked for more than 143 seconds.
>       Not tainted 5.9.0-rc3-next-20200902-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor047 state:D stack:28104 pid: 6853 ppid:  6847 flags:0x00004000
> Call Trace:
>  context_switch kernel/sched/core.c:3777 [inline]
>  __schedule+0xea9/0x2230 kernel/sched/core.c:4526
>  schedule+0xd0/0x2a0 kernel/sched/core.c:4601
>  schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
>  do_wait_for_common kernel/sched/completion.c:85 [inline]
>  __wait_for_common kernel/sched/completion.c:106 [inline]
>  wait_for_common kernel/sched/completion.c:117 [inline]
>  wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
>  io_sq_thread_stop fs/io_uring.c:6906 [inline]
>  io_finish_async fs/io_uring.c:6920 [inline]
>  io_sq_offload_create fs/io_uring.c:7595 [inline]
>  io_uring_create fs/io_uring.c:8671 [inline]
>  io_uring_setup+0x1495/0x29a0 fs/io_uring.c:8744
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> because the sqo_thread kthread is created in io_sq_offload_create() without
> being waked up. Then in the error branch of that function we will wait for
> the sqo kthread that never runs. It's fixed by waking it up before waiting.

Looks good - applied, thanks.

-- 
Jens Axboe


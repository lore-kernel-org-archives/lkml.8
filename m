Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7DFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6912078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DCEsyy1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgCaOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:53:49 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39072 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgCaOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:53:48 -0400
Received: by mail-il1-f194.google.com with SMTP id r5so19678209ilq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0eOtXIqj2oDuIMpA9Wt18PpHJkAZb38WQ9zSO73WLSY=;
        b=DCEsyy1sudgvuAcOwREzLD03ObZfHEsvNPRdxZgk+VfQ2Imj8oLebFJpuxIXDQ2IDy
         hihYJujg7pgKegXN4t/7wCE2CIcECI3go7/7QtLEa4SypgnwKguW9fvs+NmJ9KP4GrXg
         VAnkmg4ISVqeWV60nOQv33NwY3FugQzEvLWsk6mYuqTH0eBx8o1p32pVgWIukOUYGPtm
         +iBoxa9Z7NWrYbMJ9Qv2FZ0SxThA6vjB8jInBe+D5gr7TC5cJjnjRlAsAt8ddIU4B86n
         1CHjlcuQgngL94VNXDNy7CHnE6v+5ucr+lPy8oSvze0v5rTvLFuY+Q23aMixyI5EHMGq
         Vngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0eOtXIqj2oDuIMpA9Wt18PpHJkAZb38WQ9zSO73WLSY=;
        b=mMookGdqarGJ27kUphH7t0zPFfhVFEhbwtvmHi0s1Ntk5dAKlfbzBuofJRSCA47U1N
         yip8v5OSYJaWFfAm199MFPmPEOSHPO1NU65lAmVmnTi7bG9UJHqjbJY+Zz8b38HzW2yG
         xRMNWC0R8Izc6+oVKO5tgvP6vJtEsC1xottC7sZoJHHC3dxJynu/ad4uQa9lsOYGJive
         b9QWHOzcOJG9OEXwvEQUcq2tuYlIpHlIwnT7W/yD5b9DL2vs85QiKucpIluJk1OcEe1N
         qimfCGaIcU18zKNRbSXhySyi0zm7ApkW4lIBGoykyNU8BBCvBS/tWO3kgVJQq1KevdrH
         Y8OA==
X-Gm-Message-State: ANhLgQ1hIAvLbqg3R8U0tUlnHbtCXAZ3m0dbGrcRstTu6VjkL+kQz0n/
        qCYDXZuA6Q4X00LR/65dS9Bl7w==
X-Google-Smtp-Source: ADFU+vtMg5iIxOv3TcW+zVaA43LrZFv03GGnEKvbbhsJWQMg6rZLgR2wheAMS9gYsskhrwLwwr/zUg==
X-Received: by 2002:a92:3b11:: with SMTP id i17mr17172566ila.161.1585666425632;
        Tue, 31 Mar 2020 07:53:45 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d70sm5985217ill.57.2020.03.31.07.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:53:44 -0700 (PDT)
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
 (2)
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <20200331114459.17184-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a9c10c6-30b7-4177-146c-c2da2585ce5d@kernel.dk>
Date:   Tue, 31 Mar 2020 08:53:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331114459.17184-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 5:44 AM, Hillf Danton wrote:
> 
> On Tue, 31 Mar 2020 04:14:03 -0700
>>
>> syzbot has bisected this bug to:
>>
>> commit b41e98524e424d104aa7851d54fd65820759875a
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Mon Feb 17 16:52:41 2020 +0000
>>
>>     io_uring: add per-task callback handler
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115adadbe00000
>> start commit:   673b41e0 staging/octeon: fix up merge error
>> git tree:       upstream
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=135adadbe00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=155adadbe00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=acf766c0e3d3f8c6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=0c3370f235b74b3cfd97
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ac1b9de00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10449493e00000
>>
>> Reported-by: syzbot+0c3370f235b74b3cfd97@syzkaller.appspotmail.com
>> Fixes: b41e98524e42 ("io_uring: add per-task callback handler")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Looks like another line is missed in that work.
> 
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -5962,6 +5962,7 @@ static int io_sq_thread(void *data)
>  				}
>  				if (current->task_works) {
>  					task_work_run();
> +					finish_wait(&ctx->sqo_wait, &wait);
>  					continue;
>  				}
>  				if (signal_pending(current))

Can you send this as a properly formatted patch? That indeed looks like
the issue.

-- 
Jens Axboe


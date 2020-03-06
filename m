Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E00C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D020848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HXHhLtM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCFO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:57:12 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34602 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCFO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:57:11 -0500
Received: by mail-il1-f196.google.com with SMTP id c8so1893300ilm.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOBDoHnwRUB6vwJ5ZeCRAwk2NHenQL0R+1AwgPwm1qE=;
        b=HXHhLtM7yadtcuawGuR/OolVcyzzUwR6+kgjtly2wv0V5luD4vNO0QpleQk5Dk5XOb
         fdz9J2+kig02fdSVirJqAp18bp6KUZd9c7P+RAb8Gqwwrw3/BegJs72qOSJcbWYcMDn2
         e5Z3azZNgU/Akp1RU13aiVdZco/PDOn1Z/wChXDaUH+IKsgnJmC0EsptUgkj5bLRWVHq
         F0r6MkykcfjX3gImtb+R3n8BOPkWtnaAZ3j4NQPOEhOE8fLIGsmxcKLjt4nR/jSR+sTX
         xNBd+/XhD2lJ/7pZb8+DI5G2ZtpbNN3J10BRKg5xdPBGAh7MX1ohE0y5nboGn67j/r06
         5MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOBDoHnwRUB6vwJ5ZeCRAwk2NHenQL0R+1AwgPwm1qE=;
        b=imfG2C/IIAy257aRWSGgt2kuXh5ygil/YJ7q79Y4bpzF+8DMi8JtUB0x/iQ9h8EkR4
         VqfYfK/YQWiYqZ8jt2CmSfHbbHdARt72hrDMPW4l8sBQsxHWFqEdAXodZvdjqnyj44fz
         1AdHCANy/VPsd8y2eEBUMdyMmFsLE5f6EnWxFiS9GpqVvw2Hs6hHPslsxqrZ1w0u7MNi
         wVm0+9BqOz6FsECWtjfSuwikC7IQfHyaPCLXMm1fhRQ1NxGSDBjHCGA95ffnvF3NqWFy
         h7k/odFCxjxqy2sCqsGkPdvft2LVGklr6i2290Qx1NBO2Ol154fiw6/+4wojrsfGm8ND
         vSQg==
X-Gm-Message-State: ANhLgQ3Z8w4Anh4TQYmg4F9LThjrDf9cz9wmbnzW/5XC9O0u+9jAUKCn
        Rk791p7HF1Zmi25Vl2nYjj0umWYprF0=
X-Google-Smtp-Source: ADFU+vsb0EQMaZ5kM8m27eRB9mgYotBgbREMPaoSXXxO9J3hPpn3+mi0MHsuNlsVAhCgEZAhSU0zqA==
X-Received: by 2002:a92:9603:: with SMTP id g3mr3712133ilh.231.1583506630398;
        Fri, 06 Mar 2020 06:57:10 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d70sm133312ill.11.2020.03.06.06.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:57:09 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in percpu_ref_switch_to_atomic_rcu
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e017e49c39ab484ac87a@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        the arch/x86 maintainers <x86@kernel.org>
References: <00000000000067c6df059df7f9f5@google.com>
 <CACT4Y+ZVLs7O84qixsvFqk_Nur1WOaCU81RiCwDf3wOqvHB-ag@mail.gmail.com>
 <3f805e51-1db7-3e57-c9a3-15a20699ea54@kernel.dk>
 <20200306143552.GC19839@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b816920b-a211-80c0-ceca-f716954b9f96@kernel.dk>
Date:   Fri, 6 Mar 2020 07:57:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306143552.GC19839@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 7:35 AM, Dan Carpenter wrote:
> 
> There a bunch of similar bugs.  It's seems a common anti-pattern.
> 
> block/blk-cgroup.c:85 blkg_free() warn: freeing 'blkg' which has percpu_ref_exit()
> block/blk-core.c:558 blk_alloc_queue_node() warn: freeing 'q' which has percpu_ref_exit()
> drivers/md/md.c:5528 md_free() warn: freeing 'mddev' which has percpu_ref_exit()
> drivers/target/target_core_transport.c:583 transport_free_session() warn: freeing 'se_sess' which has percpu_ref_exit()
> fs/aio.c:592 free_ioctx() warn: freeing 'ctx' which has percpu_ref_exit()
> fs/aio.c:806 ioctx_alloc() warn: freeing 'ctx' which has percpu_ref_exit()
> fs/io_uring.c:6115 io_sqe_files_unregister() warn: freeing 'data' which has percpu_ref_exit()
> fs/io_uring.c:6431 io_sqe_files_register() warn: freeing 'ctx->file_data' which has percpu_ref_exit()
> fs/io_uring.c:7134 io_ring_ctx_free() warn: freeing 'ctx' which has percpu_ref_exit()
> kernel/cgroup/cgroup.c:4948 css_free_rwork_fn() warn: freeing 'css' which has percpu_ref_exit()
> mm/backing-dev.c:615 cgwb_create() warn: freeing 'wb' which has percpu_ref_exit()

The file table io_uring issue is using the ref in a funky way, switching
in and out of atomic if we need to quiesce it. That's different from
other use cases, that just use it as a "normal" reference. Hence for the
funky use case, you can potentially have a switch in progress when you
exit the ref. You really want to wait for that, the easiest solution is
to punt the exit + free to an RCU callback, if there's nothing else you
need to handle once the switch is done.

So I would not be so quick to assume that similar patterns (exit + free)
have similar issues.

-- 
Jens Axboe


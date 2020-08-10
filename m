Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4C2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597047281;
	bh=Okbfz0WpSqIQi8HvxpVtBK3YOt6ETA6kWdjGngL/7Is=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qBNqBDyuMvmIdny3NlcUE5RgF2N+yfGMfLO3+9LQfzsUUFej8078WG1NB03F3n9hy
	 Xl/mWB4FPENGa22PXisS9bX3nDVG6U5XSB1sx6olRz4GcT+WcLHb2T+W9Yd3yqG5Hc
	 7GzyQCvx1j+lD0b6JzWaO9kxGtdaSpzWDobDFIKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgHJIOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:14:40 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37291 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:14:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id qc22so8456937ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9uVZ6+5aRdc8qnC70xmBcJ8VxXcAa7s7AfoeJd4mvUw=;
        b=dU7cM6uEWxq7TZBIOL75r0Y+NFAUinb0Sezq3Ber185rtKR8+ppoeh5NsFiaWoL3HG
         aLwnPet284EYO7D6/PfrlYXr2LAEq5vMAiU/2LbvK1x4oH7nen+5wgKANCuFmFP6fJ4T
         8Q0gQY2GZCigFNAwbGZdBFQQfoMuTM6QjAjc3ELndww3f1UkKhvfUMtobdbxSytVaCFN
         GZrRMIxRt/KkIjm82UlkCS4gdNWdoDVt1Y3DTV805wK3GqoVncE5w8tj/uJd+z49NHRV
         aV5uQU+cz8xzPKMWBFDd6kkPfSkHaS1LApDZmp3o4W4UoJHnswwh3jk7lgn6c/KPzuGN
         UWwg==
X-Gm-Message-State: AOAM533IvpQcgBmFPK7rvYJvxNO7SrBLPSTPcnrutTOYUtSTHVi3FVel
        PNuIYV/JITllJvkVv4xvgVw=
X-Google-Smtp-Source: ABdhPJy7yMjZm/pgzhWqnlGGL2d+icsnZ1DsKNpxfPp4ZGUoYRXqcEAt46z3bBDafimyox9wk6IsGg==
X-Received: by 2002:a17:906:868d:: with SMTP id g13mr20116224ejx.242.1597047277275;
        Mon, 10 Aug 2020 01:14:37 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id o14sm11923185edi.27.2020.08.10.01.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 01:14:36 -0700 (PDT)
Subject: Re: [PATCH] tty/vt: fix a memory leak in con_insert_unipair
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Bond <jameslouisebond@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Denis Efremov <efremov@linux.com>,
        linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
References: <20200809221453.10235-1-jameslouisebond@gmail.com>
 <dd4ac5db-9ae7-fbf7-535b-c0d3fa098942@kernel.org>
 <20200810075122.GA1531406@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <08df63cd-c4b9-c16b-2e27-5d86580eebf2@kernel.org>
Date:   Mon, 10 Aug 2020 10:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810075122.GA1531406@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 08. 20, 9:51, Greg Kroah-Hartman wrote:
> On Mon, Aug 10, 2020 at 07:16:48AM +0200, Jiri Slaby wrote:
>> On 10. 08. 20, 0:14, James Bond wrote:
>>> Syzkaller find a memory leak in con_insert_unipair:
>>>     BUG: memory leak
>>>     unreferenced object 0xffff88804893d100 (size 256):
>>>     comm "syz-executor.3", pid 16154, jiffies 4295043307 (age 2392.340s)
>>>     hex dump (first 32 bytes):
>>>     80 af 88 4e 80 88 ff ff 00 a8 88 4e 80 88 ff ff  ...N.......N....
>>>     80 ad 88 4e 80 88 ff ff 00 aa 88 4e 80 88 ff ff  ...N.......N....
>>>     backtrace:
>>>     [<00000000f76ff1de>] kmalloc include/linux/slab.h:555 [inline]
>>>     [<00000000f76ff1de>] kmalloc_array include/linux/slab.h:596 [inline]
>>>     [<00000000f76ff1de>] con_insert_unipair+0x9e/0x1a0 drivers/tty/vt/consolemap.c:482
>>>     [<000000002f1ad7da>] con_set_unimap+0x244/0x2a0 drivers/tty/vt/consolemap.c:595
>>>     [<0000000046ccb106>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:297 [inline]
>>>     [<0000000046ccb106>] vt_ioctl+0x863/0x12f0 drivers/tty/vt/vt_ioctl.c:1018
>>>     [<00000000db1577ff>] tty_ioctl+0x4cd/0xa30 drivers/tty/tty_io.c:2656
>>>     [<00000000e5cdf5ed>] vfs_ioctl fs/ioctl.c:48 [inline]
>>>     [<00000000e5cdf5ed>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:753
>>>     [<00000000fb4aa12c>] __do_sys_ioctl fs/ioctl.c:762 [inline]
>>>     [<00000000fb4aa12c>] __se_sys_ioctl fs/ioctl.c:760 [inline]
>>>     [<00000000fb4aa12c>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:760
>>>     [<00000000f561f260>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
>>>     [<0000000056206928>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>     BUG: leak checking failed
>>>
>>> To fix this issue, we need to release the pointer p1 when the call of
>>> the function kmalloc_array fail.
...
>> Do we have some annotations for this instead?
> 
> We need something there, a comment saying "this is fine, don't touch
> it!" or something like that?  We need that in a few other places in the
> vt code as well.

Sure, comment as the last resort (to silence patch writers). But I had
some kmemleak annotation (to silence the warning) in mind.

Or better fix/tune kmemleak: why it dares to think it's a mem leak in
the first place?

thanks,
-- 
js

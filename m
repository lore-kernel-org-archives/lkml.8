Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77657C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4740C206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597036918;
	bh=/LZM9snSMh8M9WH6vOYfqd99Soo1A5P2EkyD3CiB3og=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AXBXYgMowpqZHfziKNvYrupH5p6Ryy8JGwPbXk2QxO68U604mbx8yjsyJ8BnHKHhJ
	 GsuRGOgKGtF7/1Cg+O53jX0MrneUqjGFckA0fQFu50i49tvSo3ZJS3Y3AVogC6gHFf
	 Z1usZV1NRlntH394Mw0PsXxQ7JboYEXkUYNc4PiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgHJFQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:16:54 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38024 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgHJFQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 01:16:53 -0400
Received: by mail-ej1-f66.google.com with SMTP id d6so8079335ejr.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 22:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6ciWBDMKW/np9UYq8GpBP0346Brq7bFZ1Qd1mNiFjs=;
        b=XBcGYqcqGqbsVVylu695/jNKBaMhJGnzjGmjMpsg5HkM3ypReNxd5BHhizkCLGa6AJ
         mnm3oDvvPQQDmrt5myWDxghTag11CsUmwuywLX2aDUQHmKb3Mh8t3oeRKmyVHxzOCe2L
         gygZg05cuCDHVUWaZrRil5LuXCwug45V1X9nPQAQ/c9hSAyugIbzmK08MF8uuYhEaE7I
         DIn+eeotPK6HHR0VNdwiol1f2k6uALXogfR9CCX/7vqP/aoiKWk8sTswk1L3DB6rwFie
         2JKtG6uTGc2BP0JKaIsJZ29C8sej0Hi2MTvDNtOlMx1aZpfHa7Kds/f8ISZ6vQcRFNW/
         x7Ew==
X-Gm-Message-State: AOAM5334Xu9en7UOhL5+O4CinGfyroSj6vcEUQzLEiyhUByW+ppJVaNq
        Lg+I1X3NYPkPwZuWrSVjRE0=
X-Google-Smtp-Source: ABdhPJxkRXgRpsMTaTGDYZBxrSqSsffckPumYnREfTqronVt523nXdXb63hJFgX1m6ERo2gAqEfd+g==
X-Received: by 2002:a17:906:348a:: with SMTP id g10mr19357445ejb.551.1597036611425;
        Sun, 09 Aug 2020 22:16:51 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id cm22sm11640155edb.44.2020.08.09.22.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 22:16:50 -0700 (PDT)
Subject: Re: [PATCH] tty/vt: fix a memory leak in con_insert_unipair
To:     James Bond <jameslouisebond@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Denis Efremov <efremov@linux.com>,
        linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
References: <20200809221453.10235-1-jameslouisebond@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <dd4ac5db-9ae7-fbf7-535b-c0d3fa098942@kernel.org>
Date:   Mon, 10 Aug 2020 07:16:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809221453.10235-1-jameslouisebond@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 08. 20, 0:14, James Bond wrote:
> Syzkaller find a memory leak in con_insert_unipair:
>     BUG: memory leak
>     unreferenced object 0xffff88804893d100 (size 256):
>     comm "syz-executor.3", pid 16154, jiffies 4295043307 (age 2392.340s)
>     hex dump (first 32 bytes):
>     80 af 88 4e 80 88 ff ff 00 a8 88 4e 80 88 ff ff  ...N.......N....
>     80 ad 88 4e 80 88 ff ff 00 aa 88 4e 80 88 ff ff  ...N.......N....
>     backtrace:
>     [<00000000f76ff1de>] kmalloc include/linux/slab.h:555 [inline]
>     [<00000000f76ff1de>] kmalloc_array include/linux/slab.h:596 [inline]
>     [<00000000f76ff1de>] con_insert_unipair+0x9e/0x1a0 drivers/tty/vt/consolemap.c:482
>     [<000000002f1ad7da>] con_set_unimap+0x244/0x2a0 drivers/tty/vt/consolemap.c:595
>     [<0000000046ccb106>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:297 [inline]
>     [<0000000046ccb106>] vt_ioctl+0x863/0x12f0 drivers/tty/vt/vt_ioctl.c:1018
>     [<00000000db1577ff>] tty_ioctl+0x4cd/0xa30 drivers/tty/tty_io.c:2656
>     [<00000000e5cdf5ed>] vfs_ioctl fs/ioctl.c:48 [inline]
>     [<00000000e5cdf5ed>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:753
>     [<00000000fb4aa12c>] __do_sys_ioctl fs/ioctl.c:762 [inline]
>     [<00000000fb4aa12c>] __se_sys_ioctl fs/ioctl.c:760 [inline]
>     [<00000000fb4aa12c>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:760
>     [<00000000f561f260>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
>     [<0000000056206928>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     BUG: leak checking failed
> 
> To fix this issue, we need to release the pointer p1 when the call of
> the function kmalloc_array fail.

This reminds me of:
commit 15b3cd8ef46ad1b100e0d3c7e38774f330726820
Author: Ben Hutchings <ben@decadent.org.uk>
Date:   Tue Jun 4 19:00:39 2019 +0100

    Revert "consolemap: Fix a memory leaking bug in
drivers/tty/vt/consolemap.c"

    This reverts commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac.



So NACK.


Do we have some annotations for this instead?

> Signed-off-by: James Bond <jameslouisebond@gmail.com>
> ---
>  drivers/tty/vt/consolemap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index 5947b54d92be..1e8d06c32ca1 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -489,7 +489,10 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
>  	p2 = p1[n = (unicode >> 6) & 0x1f];
>  	if (!p2) {
>  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
> -		if (!p2) return -ENOMEM;
> +		if (!p2) {
> +			kfree(p1);
> +			return -ENOMEM;
> +		}
>  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
>  	}

thanks,
-- 
js
suse labs

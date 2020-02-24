Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DAC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804C820661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXIEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:04:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40915 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:04:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so8262897wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yppdUV7+z9DVVCoH5ol/HmNgHnxU3VwqYSvc77aXwhg=;
        b=OPQ6sNEDbt7M9codyqbX4B1SyVnuh4ZJw8d4ENqMYt45UmdYrIg9Ayw/Quzc+476aD
         e0lgUSHgFyG3HxYaoKW1lTxdS1qPdNV3MfTpvDHkx1njUDANf8oKEzniWXlbjp4iLSss
         xYeDUzLiBj55sT1KgJBojInvpBhr+qghddYOteo1WKTCM3ouyfAxpLoQC8rIcijB65gh
         6pHEageBAik6ug5ot5sZMooUOTaSArbXYFIrPrz21AwpewHT/x2lJxIG/NO0qprJcUvP
         USmYP6RFbUtMf15gieqil9FKgoH6SFxfaBkpS2qQHwzB7Lg7ggB1zcg6VoSF3NrrYKUU
         Q4dQ==
X-Gm-Message-State: APjAAAX/JJG4j1mZtMSQJ5dVIPUsGMlzgpqIa8rLoXQDNiUSP+4mkedN
        IKwnnHjbaAIwTtroQqbVHTQ=
X-Google-Smtp-Source: APXvYqxz8wc0i9KaOyP5GDduUmGkLtQyQswM6tmB8N5xOihgCMmJv36f5F6gBFco9zyaSsN7RAXZRw==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr21345978wmc.137.1582531475604;
        Mon, 24 Feb 2020 00:04:35 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a22sm17564827wmd.20.2020.02.24.00.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 00:04:35 -0800 (PST)
Subject: Re: [PATCH] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual
 console
To:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <0000000000006663de0598d25ab1@google.com>
 <20200224071247.283098-1-ebiggers@kernel.org>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8fb00b38-abd0-6895-3ad2-85a6f05ee6cf@suse.com>
Date:   Mon, 24 Feb 2020 09:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200224071247.283098-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 02. 20, 8:12, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The VT_DISALLOCATE ioctl can free a virtual console while tty_release()
> is still running, causing a use-after-free in con_shutdown().  This
> occurs because VT_DISALLOCATE only considers a virtual console to be
> in-use if it has a tty_struct with count > 0.  But actually when
> count == 0, the tty is still in the process of being closed.
> 
> Fix this by treating a virtual console as in-use if it has a tty_struct
> at all, even with zero count; and by making VT_DISALLOCATE take the
> tty_mutex in order to provide synchronization with release_tty().
> 
> Reproducer:
> 	#include <fcntl.h>
> 	#include <linux/vt.h>
> 	#include <sys/ioctl.h>
> 	#include <unistd.h>
> 
> 	int main()
> 	{
> 		if (fork()) {
> 			for (;;)
> 				close(open("/dev/tty5", O_RDWR));
> 		} else {
> 			int fd = open("/dev/tty10", O_RDWR);
> 
> 			for (;;)
> 				ioctl(fd, VT_DISALLOCATE, 5);
> 		}
> 	}
> 
> KASAN report:
> 	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> 	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129
> 
> 	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
> 	Call Trace:
> 	 [...]
> 	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> 	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
> 	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
> 	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
> 	 [...]
> 
> 	Allocated by task 129:
> 	 [...]
> 	 kzalloc include/linux/slab.h:669 [inline]
> 	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
> 	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
> 	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
> 	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
> 	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
> 	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
> 	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
> 	 [...]
> 
> 	Freed by task 130:
> 	 [...]
> 	 kfree+0xbf/0x1e0 mm/slab.c:3757
> 	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
> 	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
> 	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660

That means the associated tty_port is destroyed while the tty layer
still has a tty on the top of it. That is a BUG anyway.

> Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
> Cc: <stable@vger.kernel.org> # v3.4+
> Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/tty/vt/vt_ioctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index ee6c91ef1f6cf..57d681706fa85 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -42,7 +42,7 @@
>  char vt_dont_switch;
>  extern struct tty_driver *console_driver;
>  
> -#define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
> +#define VT_IS_IN_USE(i)	(console_driver->ttys[i] != NULL)
>  #define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
>  
>  /*
> @@ -288,12 +288,14 @@ static int vt_disallocate(unsigned int vc_num)
>  	struct vc_data *vc = NULL;
>  	int ret = 0;
>  
> +	mutex_lock(&tty_mutex); /* synchronize with release_tty() */
>  	console_lock();

Is this lock dependency new or pre-existing?

Locking tty_mutex here does not sound quite right. What about switching
vc_data to proper refcounting based on tty_port? (Instead of doing
tty_port_destroy and kfree in vt_disallocate*.)

>  	if (VT_BUSY(vc_num))
>  		ret = -EBUSY;
>  	else if (vc_num)
>  		vc = vc_deallocate(vc_num);
>  	console_unlock();
> +	mutex_unlock(&tty_mutex);
>  
>  	if (vc && vc_num >= MIN_NR_CONSOLES) {
>  		tty_port_destroy(&vc->port);

thanks,
-- 
js
suse labs

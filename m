Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A10C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A389420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRNPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:15:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCRNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:15:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so30402627wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V/QZ281vfL5cHVj4/2k9ncThDHW7ATaBG2kl3gix1Tk=;
        b=BR1hIWxki4YbB8CIBbw2G9GQRlPkd3x1ddW2LVQokRAl2PN6fDJT0q+GAhWqAM2DBc
         rXMxnvgEC/ebr1KCKZ1Y/K9xci9admohssTb/2kNi56B0YkQpAFkm5+Rrfh2FR6zHOXU
         b4hUW7cU2dLL32uvrJ+wdmE3mGY4rfftiIqAcgv5l80STYtb2IigBpkwsQCnrAoe6u+r
         cvD+5VNBKXSbTcZ8fzfFR6PpL2GNESGducc7eXUnk1Ha4VslDEUyaPtMlZ30nZEQUqB9
         2UA5QAySVT26y+QxKLaYDsPmmVqmj8eUknhBZG1loQo2YyBVXlkQ63ZLDlc7EcCl2n/R
         8qnQ==
X-Gm-Message-State: ANhLgQ3de/Q6GQrTT3IC9/rRyILco6uLsUFdvZ3ScqAPaTchi9JucJl8
        p/1hXlapGHUzkMkOdySOTRpCqchm
X-Google-Smtp-Source: ADFU+vtDPUQl+Wij85avENbXUmMMRgzf8v9Z3Dmtz9xYhdBYFBtqOxb8/nS4KAW2FYZj3XBFpzVAAw==
X-Received: by 2002:adf:df82:: with SMTP id z2mr5341779wrl.46.1584537301966;
        Wed, 18 Mar 2020 06:15:01 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id f11sm9483996wrq.88.2020.03.18.06.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:15:01 -0700 (PDT)
Subject: Re: [PATCH] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual
 console
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <0000000000006663de0598d25ab1@google.com>
 <20200224071247.283098-1-ebiggers@kernel.org>
 <8fb00b38-abd0-6895-3ad2-85a6f05ee6cf@suse.com>
 <20200224081913.GA299238@sol.localdomain>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ecf5517-f802-e1d3-5d0d-ba04fba58c87@suse.cz>
Date:   Wed, 18 Mar 2020 14:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224081913.GA299238@sol.localdomain>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 02. 20, 9:19, Eric Biggers wrote:
> On Mon, Feb 24, 2020 at 09:04:33AM +0100, Jiri Slaby wrote:
>>> KASAN report:
>>> 	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
>>> 	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129
>>>
>>> 	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
>>> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
>>> 	Call Trace:
>>> 	 [...]
>>> 	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
>>> 	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
>>> 	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
>>> 	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
>>> 	 [...]
>>>
>>> 	Allocated by task 129:
>>> 	 [...]
>>> 	 kzalloc include/linux/slab.h:669 [inline]
>>> 	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
>>> 	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
>>> 	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
>>> 	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
>>> 	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
>>> 	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
>>> 	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
>>> 	 [...]
>>>
>>> 	Freed by task 130:
>>> 	 [...]
>>> 	 kfree+0xbf/0x1e0 mm/slab.c:3757
>>> 	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
>>> 	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
>>> 	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
>>
>> That means the associated tty_port is destroyed while the tty layer
>> still has a tty on the top of it. That is a BUG anyway.

...

>> Locking tty_mutex here does not sound quite right. What about switching
>> vc_data to proper refcounting based on tty_port? (Instead of doing
>> tty_port_destroy and kfree in vt_disallocate*.)
>>
> 
> How would that work?  We could make struct vc_data refcounted such that
> VT_DISALLOCATE doesn't free it right away but rather it's freed in the next
> con_shutdown().  But release_tty() still accesses tty->port afterwards, which is
> part of the 'struct vc_data' that would have just been freed.

Yes, but if it does the same as pty, i.e. throwing tty_port in
->cleanup, not ->shutdown, that would work, right?

The initial requirement from tty_port is that it outlives tty. This was
later lifted by pty to live at least till ->cleanup.

thanks,
-- 
js
suse labs

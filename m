Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62041C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A6820838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjPVEqQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgBFGbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:31:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40636 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBFGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:31:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so2067308pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 22:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EiT7U6hb4n9/ss5eLUuNHb8HbJPdrNLlNFry2pPtbL8=;
        b=cjPVEqQ8bIU4+SzkdcJ7r1Hismp60wHdUsPx0PSGD1yrI1kkCfr9ExmhcZmNl51yom
         qvyh5lNMSE1OyfMu2MIy2fOGLvCDAQNGxWKiY62A7uy2XaX7t1LYe22XoPPehCaLERFA
         FZ6s+LnHoB/yssJ/Dt/onvF9MgQM+mOGUX7+FDu/Gd8oCjfXepl4o4N8SXiCD6CDCPAt
         p3PkrdvixpY6I8Kr/BGmjNuzHVAoukZlNTH9Nz4wca+9clFk3rsjE+dprySUbZTx1KbY
         7hbv/52fy+ILZSGupGLCwpCh2gMQRoxSKjR2m4NZkxwBi7evZ2qUmBjD71JkfBZsWo2e
         O8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EiT7U6hb4n9/ss5eLUuNHb8HbJPdrNLlNFry2pPtbL8=;
        b=eCoXmsoANFgs5M6JXaYn7ToEyeVh06u2rZZTi1AH9gayohMroeeay3OnG76LYRqHeH
         XRm3bfXcIFSdQDygMDusYzKx8taC5Ij/mIsju4qkwgzT1+HxglpyhZRAsYBhJzMRd+MI
         mQZ6z2UZ4y8H7M3VhmQnE05ECo0OZn+zznAsvWjYGxkCi95RvovpNS6sRwPsvuZwqV9y
         a4gbVIzPfkeT+ozs22K0FrD5qqO5U+JU0QKmO7DyrQMA3rev4CuCxFBX0il0Je7KRLZz
         rMSRwWauor0B2FG91ovP6oqyhzkld1/2uFgSy/Tr/anAH209CC/5WO50YMSYj9XDlTZB
         FmOA==
X-Gm-Message-State: APjAAAWoDiJGndvNLJz5Mrgqw1lkXASAIM6IhTCKHrtJV7/xexkDzTga
        Q0RL7VQ8CvSWD6CxOHkWXnZbUtnR
X-Google-Smtp-Source: APXvYqypyETPNrR3JYXaNRt6EUsTEo/7X5zBbdeACiCaI8LBBQGoPGSg21OcckRO75gVWQWFVeJBpg==
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr2502314pja.27.1580970674468;
        Wed, 05 Feb 2020 22:31:14 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d26sm1798137pgv.66.2020.02.05.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 22:31:13 -0800 (PST)
Date:   Thu, 6 Feb 2020 15:31:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
Message-ID: <20200206063110.GM41358@google.com>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com>
 <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
 <877e11h0ir.fsf@linutronix.de>
 <20200205110522.GA456@jagdpanzerIV.localdomain>
 <87wo919grz.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo919grz.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/05 16:48), John Ogness wrote:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > 3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
> > 3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>
> 
> The problem was due to an uninitialized pointer.
> 
> Very recently the ringbuffer API was expanded so that it could
> optionally count lines in a record. This made it possible for me to
> implement record_print_text_inline(), which can do all the kmsg_dump
> multi-line madness without requiring a temporary buffer. Rather than
> passing an extra argument around for the optional line count, I added
> the text_line_count pointer to the printk_record struct. And since line
> counting is rarely needed, it is only performed if text_line_count is
> non-NULL.
> 
> I oversaw that devkmsg_open() setup a printk_record and so I did not see
> to add the extra NULL initialization of text_line_count. There should be
> be an initializer function/macro to avoid this danger.
> 
> John Ogness
> 
> The quick fixup:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d0d24ee1d1f4..5ad67ff60cd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
>  	user->record.text_buf_size = sizeof(user->text_buf);
>  	user->record.dict_buf = &user->dict_buf[0];
>  	user->record.dict_buf_size = sizeof(user->dict_buf);
> +	user->record.text_line_count = NULL;
>  
>  	logbuf_lock_irq();
>  	user->seq = prb_first_seq(prb);

Yes. That should do. It seems that /dev/kmsg reads/writes happen very early in
my system and all the backtraces I saw were from completely unrelated paths -
either a NULL deref at sys_clone()->do_fork()->copy_creds()->prepare_creads(),
or general protection fault in sys_keyctl()->join_session_keyring()->prepare_creds(),
or some weird crashes in ext4. And so on.

I see some more unexplainable lockups on one on my test boards, but I
can't provide more details at this time. Might not be related to the
patch set. Need to investigate further.

	-ss

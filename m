Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0AFC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBCF206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="abYLlraR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCVQ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:57:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40838 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:57:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id l184so6235905pfl.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dc2ft7jmj6hxFB83CfxE8r8hUsUgGlvpHZTaLQ9Mj8c=;
        b=abYLlraReyPJ1+n1SLVb1EZKISahqek0PA2wFE0h+NbfYdSVu980mfLzvdGwJk6IXS
         HHscNptr41y2v29Wj1Dj8cKpGcarslk7RotihDl0CGHLtiS+wbNaep63ZXK+f9s/ioiC
         KVNkSPc2TmLWA/o9l6AnHdlXQPiaJ0npLgEw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dc2ft7jmj6hxFB83CfxE8r8hUsUgGlvpHZTaLQ9Mj8c=;
        b=JIpbYKiBVzbKPIfb248Er+L+96e+siO10dKGoniICvWFedPvmsScDerH2Az7wbnHaw
         LDsZVy78Sm/t8d1Xj/1358QVjnBehJAEGGLFXCJZ8baS2euuAO/SYLQdeGwlSluL5ppr
         lp439kgh9VzHCm2Bq6oRZW7TNc04av3syfknXA7hSC375r6z5ldkg2W+8MZtqJ18hu/t
         SS0oF2bEK+UzD37B2CNY/bfES6pQ0/3+wP6ZXpexC9RqhzIWAPJ78nzkO+afhm0tqvlG
         HnLCFYRs4puU1gVwFYbrx7FC/DR31jEQVDrSirsdOBlNnzn7VXNZoG23geDNijpIEv9Y
         eLAg==
X-Gm-Message-State: ANhLgQ2znIN0XdZ7qFMfGMDwW0mO+eqgW8bgiy8/FcCn/t61g/ZFw14W
        Ax3VD5X/1vx8DqigSj4r7wuH3g==
X-Google-Smtp-Source: ADFU+vuvlYyKKsqi5xEyU7cb8qW3ImSL8Yy96K5kakEKiPLla3VrlEvzBr6kjH1Lyejqj8NIlEZceg==
X-Received: by 2002:a63:2323:: with SMTP id j35mr17960882pgj.440.1584896225995;
        Sun, 22 Mar 2020 09:57:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x24sm2124386pfn.140.2020.03.22.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:57:04 -0700 (PDT)
Date:   Sun, 22 Mar 2020 09:57:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        glider@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] libfs: fix infoleak in simple_attr_read()
Message-ID: <202003220954.24E1E2EB5E@keescook>
References: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
 <20200308023849.988264-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308023849.988264-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 06:38:49PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Reading from a debugfs file at a nonzero position, without first reading
> at position 0, leaks uninitialized memory to userspace.
> 
> It's a bit tricky to do this, since lseek() and pread() aren't allowed
> on these files, and write() doesn't update the position on them.  But
> writing to them with splice() *does* update the position:
> 
> 	#define _GNU_SOURCE 1
> 	#include <fcntl.h>
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	int main()
> 	{
> 		int pipes[2], fd, n, i;
> 		char buf[32];
> 
> 		pipe(pipes);
> 		write(pipes[1], "0", 1);
> 		fd = open("/sys/kernel/debug/fault_around_bytes", O_RDWR);
> 		splice(pipes[0], NULL, fd, NULL, 1, 0);
> 		n = read(fd, buf, sizeof(buf));
> 		for (i = 0; i < n; i++)
> 			printf("%02x", buf[i]);
> 		printf("\n");
> 	}
> 
> Output:
> 	5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a30
> 
> Fix the infoleak by making simple_attr_read() always fill
> simple_attr::get_buf if it hasn't been filled yet.
> 
> Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com
> Reported-by: Alexander Potapenko <glider@google.com>
> Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Yikes, that's an important fix!

Acked-by: Kees Cook <keescook@chromium.org>

Luckily (as Alexander mentioned too), most distros make debugfs
non-accessible by non-root (I hope):

$ ls -lda /sys/kernel/debug
drwx------ 39 root root 0 Jan  8 09:10 /sys/kernel/debug/

That function is also exposed via DEFINE_SIMPLE_ATTRIBUTE(), but those
users appear to also be mostly (all?) debugfs too.

And, just to note, for v5.3 and later, this would be fully mitigated by
booting with "init_on_alloc=1".

-Kees

> ---
>  fs/libfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index c686bd9caac6..3759fbacf522 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -891,7 +891,7 @@ int simple_attr_open(struct inode *inode, struct file *file,
>  {
>  	struct simple_attr *attr;
>  
> -	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
>  	if (!attr)
>  		return -ENOMEM;
>  
> @@ -931,9 +931,11 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	if (*ppos) {		/* continued read */
> +	if (*ppos && attr->get_buf[0]) {
> +		/* continued read */
>  		size = strlen(attr->get_buf);
> -	} else {		/* first read */
> +	} else {
> +		/* first read */
>  		u64 val;
>  		ret = attr->get(attr->data, &val);
>  		if (ret)
> -- 
> 2.25.1
> 

-- 
Kees Cook

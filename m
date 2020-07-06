Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C326820720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsAvt7AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGFPiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgGFPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:38:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F23C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:38:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so1313751pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATpAfTohhB0wfuGUkMqMOHONR2hRlnVt3ksDEAak4N8=;
        b=bsAvt7AYKGT1d3GoWDuiUbS3xYl23e/YExX/CiZF1e3lKaqw7omwYicZyD4K33eAsS
         7ZIMfQf/qoPqjJhWW12FhHXCS2kt7AO3CM1VItUVz36n8jZHYFmWy8o659Ef+lnvPG5x
         b0lnvLvVQlI3Y9GXIiskVDcncM5vqVfEJi4mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATpAfTohhB0wfuGUkMqMOHONR2hRlnVt3ksDEAak4N8=;
        b=Noqib+nyPzRxiLw0yfQHEZ915zDHi6BU0jUB12k+TFqdYdiagEWa2TD8rESx6UiGxf
         6Moj6IOn7LFTe8dN+iKg+4XxWiX7DIEX9Kpp+JGypTiA15Fa1fl8tkNgUxJI71uFFAQC
         wArUhgj7lwKZCioTOck9vKNQu4f6U0/5u0Sr0i3pbvtPBe3hp63Mvyp2Ii/+uZhYpJXx
         YnagYkwvwC0z4ecyCbYvFK9Yj1mXCOXg9G5ZoNFl9xvMINF0oX020PdgKi2P5IZkbF9X
         ui/fidC1eYzK314zPQUko4+obpe2cVNF5kaykiZ9ADxpYyHyGQMRFsHmPrSmeUBjWXMF
         xw+Q==
X-Gm-Message-State: AOAM533zR1GNHxPZDOI74hV5vrOPyQlWwVh+1zAQjjlk67WBha6Gqi7z
        PsbQ3Bwkr7XXOEsr/iybZoOXRA==
X-Google-Smtp-Source: ABdhPJxZ6foEsP4SAhTHF1W5bujeuX4IIYJtvYFXuPKaf8c3o6Cq7tyeCKxndRwo2I7N6uiYgSE+tg==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr26254102plr.152.1594049892010;
        Mon, 06 Jul 2020 08:38:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm22272708pfk.171.2020.07.06.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 08:38:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:38:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     christian@brauner.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: fix memory leak in pidfd_getfd()
Message-ID: <202007060834.5D4F78BF8A@keescook>
References: <20200706125250.GA2828@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706125250.GA2828@cosmos>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: please review recent commit history for bug fixes like this -- I
introduced this bug. :)

On Mon, Jul 06, 2020 at 06:22:55PM +0530, Vamshi K Sthambamkadi wrote:
> kmemleak backtrace:
> 
> comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 90 da d8 f6 80 d5 6f f2  ..............o.
>     b8 fb 9b ea c0 91 99 d1 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
>     [<8ff6a575>] __alloc_file+0x1e/0xe0
>     [<e1479798>] alloc_empty_file+0x45/0x100
>     [<727fe6eb>] alloc_file+0x23/0xf0
>     [<457148ef>] alloc_file_pseudo+0x98/0x100
>     [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
>     [<5edc3e9b>] shmem_file_setup+0x4c/0x70
>     [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
>     [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
>     [<62569441>] do_fast_syscall_32+0x39/0xb0
>     [<3c515b7e>] do_SYSENTER_32+0x15/0x20
>     [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc
> 
> comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
>   hex dump (first 16 bytes):
>     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
>     [<b67faec5>] security_file_alloc+0x20/0x90
>     [<ed849d41>] __alloc_file+0x40/0xe0
>     [<e1479798>] alloc_empty_file+0x45/0x100
>     [<727fe6eb>] alloc_file+0x23/0xf0
>     [<457148ef>] alloc_file_pseudo+0x98/0x100
>     [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
>     [<5edc3e9b>] shmem_file_setup+0x4c/0x70
>     [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
>     [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
>     [<62569441>] do_fast_syscall_32+0x39/0xb0
>     [<3c515b7e>] do_SYSENTER_32+0x15/0x20
>     [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc
> 
> This is because in pidfd_getfd(), the file->f_count is incremented twice
> 1) __pidfd_fget() gets file ref by incrementing f_count in __fget_files()
> 2) f_count is incremented While installing fd in __fd_install_received()
>    i.e. get_file().
> 
> Memory leak occurs because the refs count do not match, the struct file
> object is never freed.
> 
> Secondly the error validity check (ret < 0) after the call to
> fd_install_received() is not needed since this function cannot return
> negative number after incrementing f_count. So it is wrong to call fput
> on condition (ret < 0).
> 
> Change pidfd_getfd() to call fput() on file reference once its installed
> as new_fd in target process.
> 
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

Thanks! I'll get this fixed.

-Kees

> ---
>  kernel/pid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 5799ae5..d00139c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -653,8 +653,8 @@ static int pidfd_getfd(struct pid *pid, int fd)
>  		return PTR_ERR(file);
>  
>  	ret = fd_install_received(file, O_CLOEXEC);
> -	if (ret < 0)
> -		fput(file);
> +
> +	fput(file);
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Kees Cook

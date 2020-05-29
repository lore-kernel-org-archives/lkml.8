Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B92C207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GEzFK/LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgE2IOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2IOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:14:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290AC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:14:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g5so923141pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKFY0Nk0lzZnsZYwS+0R6Jqxi22p/kGuawoexff+HFM=;
        b=GEzFK/LKfNFU6UJpyxaByBf5ZKjfm5yaMIo+HTxEbbGqjeJ2NKC1wQHBTEziYuM2/c
         zdLFnp7ddR2lTanx16yKCGNuhGrn+P++lavG8tEoUTeqsy/vItUpiclup3Hw3sRiYEui
         6wOwumpgIOr98WMOxg6/ewEsbQVEUFI/4pWuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKFY0Nk0lzZnsZYwS+0R6Jqxi22p/kGuawoexff+HFM=;
        b=J9Zfz0Dy+X7kKzGr6paiNwx8V4yYEeyiImFIl1EYUqi/G0+vH4OZOK13J+clS2TwuD
         Aqk1krg1gOxAjvKzuj2uErB54BPGgqrwFI3q8soZI30I9B+Te8fFIjkYg5s51LFkq5gm
         +xzzpoHplFi6jvUt917RfGzikrGcTMX7XI0/MVBw+1icw1ZMjyGDAjz0weBLbEbmcyHw
         Y9BWFxJld72uyo39F5BoqcBYWG64CydeFpuP9mYblSceE8bTG7g6WROz6UopQc7bELe2
         NsLa5HrLeJ5DlpvB/83xeYpU78v9Nf0qZhXnmU0QzDtLRqc3IO1sbmN/+9Yl0CvoCcRd
         YoIA==
X-Gm-Message-State: AOAM531hJQGmi37tTns/3amYPVKDTLdYxLWAS4k7GABuxp5R6LGHhHGT
        UFQ8USR4d1TqtnNisyEft+ib6A==
X-Google-Smtp-Source: ABdhPJyK2FUwFmtdobHKhZ8I1QHoKW4hEbYErArP63rQknnJfHipw8t38GV0zrMxKfzrK+yxeI5VDw==
X-Received: by 2002:a62:8703:: with SMTP id i3mr7543110pfe.212.1590740092307;
        Fri, 29 May 2020 01:14:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b140sm6448091pfb.119.2020.05.29.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:14:51 -0700 (PDT)
Date:   Fri, 29 May 2020 01:14:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] fs: move binfmt_misc sysctl to its own file
Message-ID: <202005290113.53AEED2176@keescook>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-14-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-14-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:41:08AM +0000, Luis Chamberlain wrote:
> This moves the binfmt_misc sysctl to its own file to help remove
> clutter from kernel/sysctl.c.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/binfmt_misc.c | 1 +
>  kernel/sysctl.c  | 7 -------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index f69a043f562b..656b3f5f3bbf 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -821,6 +821,7 @@ static int __init init_misc_binfmt(void)
>  	int err = register_filesystem(&bm_fs_type);
>  	if (!err)
>  		insert_binfmt(&misc_format);
> +	register_sysctl_empty_subdir("fs", "binfmt_misc");
>  	return err;

Nit: let's make the dir before registering the filesystem. I can't
imagine a realistic situation where userspace is reacting so fast it
would actually fail to mount the fs on /proc/sys/fs/binfmt_misc, but why
risk it?

-Kees

>  }
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 460532cd5ac8..7714e7b476c2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -3042,13 +3042,6 @@ static struct ctl_table fs_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> -	{
> -		.procname	= "binfmt_misc",
> -		.mode		= 0555,
> -		.child		= sysctl_mount_point,
> -	},
> -#endif
>  	{
>  		.procname	= "pipe-max-size",
>  		.data		= &pipe_max_size,
> -- 
> 2.26.2
> 

-- 
Kees Cook

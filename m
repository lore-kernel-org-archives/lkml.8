Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714BAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfQXuKcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCCEli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:41:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCCElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:41:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id q4so740603pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OIF+lnlYM2nHZ+5hN/WpLBOx7gByaLC97gJmvXQCmNc=;
        b=RfQXuKcNk9hwJmHcNM/ykdo2WTuikMLeAoQqW94A5IzhV321EuAANFWSjsG6r7LrpG
         20t5pEVwMzy98MTxZ8u2uHKeL4VTAf/6lQoCuwSyfs6upw6mruIv338un7E0JgRBRBbS
         E0ub5wAd5RW485MsOLy1VOKiaLLZM5Fa6YRDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OIF+lnlYM2nHZ+5hN/WpLBOx7gByaLC97gJmvXQCmNc=;
        b=hNBHxGwjuiMvX466sklG+Bv/Md4LxVNcO0bxVHjF9eAREp9HWyMo7JXB2qc49M8fHU
         JWBJFMCef/m+WF2vnlpUYuMip0zEGvQIsOzDRnH0aUT3sCHD+S6eHQu2x4/27HRYu9jx
         SXK9jnlfHpxYbrTeAR2Q/pDEPQyltKRUEZvQv9irPoD8aL8hJxW7sulp032IuF1nJOz0
         A6e8XDchfVzZyLKL3am7B1MtaJacQafEDPCFmPHjwpcyr0hua4x7VQYCq30l9zaAE4ZI
         4XU3tZrpos5K+TnKLVS3yS4mmVZ8iLNb24b4EaokvK/QYu2H3F4hzGzMoX4tdJVWEcb+
         +wzA==
X-Gm-Message-State: ANhLgQ3r6C8G6sjYP2lwztuB8gwvZTi9AkQiwd3W3cnan5hqWgi+tbEV
        xMCzrpF10QZMcEyFEiP6t6ycbw==
X-Google-Smtp-Source: ADFU+vsd7Eo9A6dkJsYDL/ZbxnknesyWa5rkdzVNc8GdvgllaMLgURZUe65Vn00p0hPHE0d6xSbBfQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr2423171plr.201.1583210496706;
        Mon, 02 Mar 2020 20:41:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w128sm22334651pgb.55.2020.03.02.20.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:41:35 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:41:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fcntl: Distribute switch variables for initialization
Message-ID: <202003022040.40A32072@keescook>
References: <20200220062243.68809-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220062243.68809-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:22:43PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> fs/fcntl.c: In function ‘send_sigio_to_task’:
> fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
>   738 |   kernel_siginfo_t si;
>       |                    ^~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping. Can someone pick this up, please?

Thanks!

-Kees

> ---
>  fs/fcntl.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 9bc167562ee8..2e4c0fa2074b 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
>  		return;
>  
>  	switch (signum) {
> -		kernel_siginfo_t si;
> -		default:
> +		default: {
> +			kernel_siginfo_t si;
> +
>  			/* Queue a rt signal with the appropriate fd as its
>  			   value.  We use SI_SIGIO as the source, not 
>  			   SI_KERNEL, since kernel signals always get 
> @@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
>  			si.si_fd    = fd;
>  			if (!do_send_sig_info(signum, &si, p, type))
>  				break;
> +		}
>  		/* fall-through - fall back on the old plain SIGIO signal */
>  		case 0:
>  			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
> 

-- 
Kees Cook

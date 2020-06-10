Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE343C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D31206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="HgRMAuTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFJQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:46:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8CAC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:46:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so2964426iow.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KF3Wg/KxPPsJnDwGBY4BTGRIdXAYib5hVwhMtHWLfU=;
        b=HgRMAuTWMBRBanlAB5E2bZMUR3yQzh2TAR348xhZFkKLdl6VkFbd8lfpnil/ZRcEp4
         4LhjxroS+10lgG32UVuCCmD24KDsjkmYd6x9H9e6fKK74z86ggmWb9GYqt7BLRWc11Aa
         +cYfguNB5oZfimX73XONF31dxBMsZOfbKNmTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KF3Wg/KxPPsJnDwGBY4BTGRIdXAYib5hVwhMtHWLfU=;
        b=ewSt4vFcrbpNvgfGQu4JOGFB7JV6nVkG9mBvhKuoX0noLnUv4z6HUlLn4asTiLkQVj
         T/tGHZR/1ccq2CQMyoS75v1XP7SFCbsCT5OTnCad1Lgt7fTQ4QDs+9cM698EZ4QHu2c+
         cGOmVCotGHJB3c/fRcs06DY1z5l5amn+MYu212EMj8Gc1bh+7vjmpM1h8TEi5eFNtn9T
         TbeFOvv+CUcy++H7TC5r11qX8SMKpuGDFEVfo2IlH9X27vxXyrgMfUmK8fAxikuqoEYq
         wLk3jDqx62K82sS7o15KElx2gI4zbuXtn3W0OkKhZgSknrNw/7vCOILihjV7H3dzz8UE
         NBag==
X-Gm-Message-State: AOAM533LUwlVksd8QTx1Az60ufv840lDz2QRRuESw3kLTDITX5IJXvZZ
        jFfdzuVbfBjQhNcCRFM+IrUzrA==
X-Google-Smtp-Source: ABdhPJzAEl8tQK/3JovbXIeTrhwaRfdkvH2RM45wUhIv1vuHEWFFrbA6dYbpMJnhTGD1odepimGgVA==
X-Received: by 2002:a6b:7611:: with SMTP id g17mr4174027iom.110.1591807561732;
        Wed, 10 Jun 2020 09:46:01 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id b8sm190113ior.35.2020.06.10.09.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 09:46:01 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:45:59 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pidfd: Replace open-coded partial __scm_install_fd()
Message-ID: <20200610164558.GA30124@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200610045214.1175600-1-keescook@chromium.org>
 <20200610045214.1175600-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610045214.1175600-3-keescook@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:52:14PM -0700, Kees Cook wrote:
> The sock counting (sock_update_netprioidx() and sock_update_classid())
> was missing from this implementation of fd installation, compared to
> SCM_RIGHTS. Use the new scm helper to get the work done, after adjusting
> it to return the installed fd and accept a NULL user pointer.
> 
> Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> AFAICT, the following patches are needed for back-porting this to stable:
> 
> 0462b6bdb644 ("net: add a CMSG_USER_DATA macro")
> 2618d530dd8b ("net/scm: cleanup scm_detach_fds")
> 1f466e1f15cf ("net: cleanly handle kernel vs user buffers for ->msg_control")
> 6e8a4f9dda38 ("net: ignore sock_from_file errors in __scm_install_fd")
> ---
>  kernel/pid.c   | 12 ++----------
>  net/compat.c   |  2 +-
>  net/core/scm.c | 27 ++++++++++++++++++++-------
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index f1496b757162..a7ce4ba898d3 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -42,6 +42,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
> +#include <net/scm.h>
>  
>  struct pid init_struct_pid = {
>  	.count		= REFCOUNT_INIT(1),
> @@ -635,18 +636,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
>  	if (IS_ERR(file))
>  		return PTR_ERR(file);
>  
> -	ret = security_file_receive(file);
> -	if (ret) {
> -		fput(file);
> -		return ret;
> -	}
> -
> -	ret = get_unused_fd_flags(O_CLOEXEC);
> +	ret = __scm_install_fd(file, NULL, O_CLOEXEC);
>  	if (ret < 0)
>  		fput(file);
> -	else
> -		fd_install(ret, file);
> -
>  	return ret;
>  }
>  
> diff --git a/net/compat.c b/net/compat.c
> index 117f1869bf3b..f8575555b6d7 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -299,7 +299,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
>  
>  	for (i = 0; i < fdmax; i++) {
>  		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
> -		if (err)
> +		if (err < 0)
>  			break;
>  	}
>  
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 86d96152646f..e80648fb4da7 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -280,6 +280,14 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
>  }
>  EXPORT_SYMBOL(put_cmsg_scm_timestamping);
>  
> +/**
> + * __scm_install_fd() - Install received file into file descriptor table
Any reason not to rename this remote_install_* or similar, and move it to fs/?
> + *
> + * Installs a received file into the file descriptor table, with appropriate
> + * checks and count updates.
> + *
> + * Returns fd installed or -ve on error.
> + */
>  int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
>  {
>  	struct socket *sock;
> @@ -294,20 +302,25 @@ int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
>  	if (new_fd < 0)
>  		return new_fd;
>  
> -	error = put_user(new_fd, ufd);
> -	if (error) {
> -		put_unused_fd(new_fd);
> -		return error;
> +	if (ufd) {
See my comment elsewhere about not being able to use NULL here.
> +		error = put_user(new_fd, ufd);
> +		if (error) {
> +			put_unused_fd(new_fd);
> +			return error;
> +		}
>  	}
>  
> -	/* Bump the usage count and install the file. */
> +	/* Bump the usage count and install the file. The resulting value of
> +	 * "error" is ignored here since we only need to take action when
> +	 * the file is a socket and testing "sock" for NULL is sufficient.
> +	 */
>  	sock = sock_from_file(file, &error);
>  	if (sock) {
>  		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
>  		sock_update_classid(&sock->sk->sk_cgrp_data);
>  	}
>  	fd_install(new_fd, get_file(file));
> -	return 0;
> +	return new_fd;
>  }
>  
>  static int scm_max_fds(struct msghdr *msg)
> @@ -337,7 +350,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>  
>  	for (i = 0; i < fdmax; i++) {
>  		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
> -		if (err)
> +		if (err < 0)
>  			break;
>  	}
>  
> -- 
> 2.25.1
> 

Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C15C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A57420838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588867014;
	bh=+sTRjNnWHwB8S8eiOkQh8qJCetN9mW6k4KevGbYDMoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vOaEuH9F7R7tTqgyZ3F7tkT/IXknSN+Kx7aZjaZz30u3QEBOjGWzfi/bCqNPeYs2o
	 bqdYq0RtyFQLdrm1nVyZN9EajncH1bJqJk9Sq7dKJCt1oxuD57ZuvbwqZ4cAtxa8Z/
	 JF0WRDN+oPkkD0os41kq8NROwD3E0r99FOXJ/JX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgEGP4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgEGP4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:56:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEA120659;
        Thu,  7 May 2020 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588867011;
        bh=+sTRjNnWHwB8S8eiOkQh8qJCetN9mW6k4KevGbYDMoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dppe2oZSUKtcMFJAMh2EKp3ioe6doznduRkGVyPvBPwURvnMEoiewHO6W8ZXyTh+j
         TBKeadECx07JInOjUiLDyUeIWbXKIyhKxEOH+jPwogSFcVCCj3r0r2H5ZB0YVE0fpL
         RsbbSVcLuF8rhTk0UTgW1RyvcZ0ZDBOPlN+dfPN4=
Date:   Fri, 8 May 2020 00:56:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
Subject: Re: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
Message-Id: <20200508005647.dc6f79c0aeca041203af1d8d@kernel.org>
In-Reply-To: <583a49c9-c27a-931d-e6c2-6f63a4b18bea@huawei.com>
References: <583a49c9-c27a-931d-e6c2-6f63a4b18bea@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 17:23:36 +0800
Yunfeng Ye <yeyunfeng@huawei.com> wrote:

> The @data and @fd is leak in the error path of apply_xbc(), so this
> patch fix it.

Good catch! Thanks for fixing!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  tools/bootconfig/main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 16b9a420e6fd..001076c51712 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -314,6 +314,7 @@ int apply_xbc(const char *path, const char *xbc_path)
>  	ret = delete_xbc(path);
>  	if (ret < 0) {
>  		pr_err("Failed to delete previous boot config: %d\n", ret);
> +		free(data);
>  		return ret;
>  	}
> 
> @@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_path)
>  	fd = open(path, O_RDWR | O_APPEND);
>  	if (fd < 0) {
>  		pr_err("Failed to open %s: %d\n", path, fd);
> +		free(data);
>  		return fd;
>  	}
>  	/* TODO: Ensure the @path is initramfs/initrd image */
>  	ret = write(fd, data, size + 8);
>  	if (ret < 0) {
>  		pr_err("Failed to apply a boot config: %d\n", ret);
> -		return ret;
> +		goto out;
>  	}
>  	/* Write a magic word of the bootconfig */
>  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
>  	if (ret < 0) {
>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> -		return ret;
> +		goto out;
>  	}
> +out:
>  	close(fd);
>  	free(data);
> 
> -	return 0;
> +	return ret;
>  }
> 
>  int usage(void)
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

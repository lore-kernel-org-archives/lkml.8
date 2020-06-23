Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1020DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC916206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLPpC7r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbgFWKK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:10:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732005AbgFWKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592907055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9EXuJsowvJmInT502RC222CM0yXwh7m1JZTr0Jb8Os=;
        b=hLPpC7r7Ou1VcKAFREj0gshb1JOw4GsBBJy6tEqeZHt9w0PFJEfnpYH+yf0TijbZd5P7kk
        dtRdJyWXvMOTwdJ96KRWllWH+oZCpzRg+WbuB/7uL11RD+1aX9ufOey2bvxTtfK5A38R7T
        3Zw+HeL2WtaLdIAMFW8wLDZBFIuUapQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-CxvkpNFoN0qiCGAEXQW3Aw-1; Tue, 23 Jun 2020 06:10:54 -0400
X-MC-Unique: CxvkpNFoN0qiCGAEXQW3Aw-1
Received: by mail-pg1-f199.google.com with SMTP id z187so12371710pgd.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9EXuJsowvJmInT502RC222CM0yXwh7m1JZTr0Jb8Os=;
        b=GojlHqrx7YE/2rD4IQXaHBfXHEXE8gA+Ios0eFJHUWxSbP7NjMiVcqXyGkqYyFzXIt
         FdWml1hstrSQfJZeBwgTdZ5lpm87g79Jg0E4lhp7U69LdmzVsUgEFl5zGfA9wlCsRz0r
         39LX9zJQQqSUVQ4feKEwU3Uxkpn4mrhiTZEoqmo+UjvzZSjiZ+Ik2E48i29A+sA1tj8M
         nDbRpd4/tvE29vNPprGqa/yZgLvRNio1Nd5C97cKxqE2FMHbVa6mdhHUELy/BMOrPXoP
         qqyCTJv7UGpdQjH+gflXsBTOuR5vdkSjynEa3udCHEXCP87I+UHSSzd+FfNhkw/nMsb5
         gcGQ==
X-Gm-Message-State: AOAM530X5aZfhrBe/kj4ayJ5Q9ayjufSyQN1qgpuRNNK+gh8OOexkNYk
        1t/Kf46OCFCvtQha9AdfpYw5RM1sMR77kfqwVrIkmLg+TPqYCsLO9/JQgMwkK13XYs9pR5Je6z/
        tFa5O9WMjV0tsjLwxzQqi9GG8
X-Received: by 2002:a62:770d:: with SMTP id s13mr25169547pfc.266.1592907053186;
        Tue, 23 Jun 2020 03:10:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQFKTi0ccL8LbWY/VaTogGAZDzQ0HbmqM514Wc7oh3AlVmEBSQtv3qgquVhbyxVh0UM60UuQ==
X-Received: by 2002:a62:770d:: with SMTP id s13mr25169528pfc.266.1592907052957;
        Tue, 23 Jun 2020 03:10:52 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a17sm1977991pjh.31.2020.06.23.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:10:52 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:10:42 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] xattr: fix EOPNOTSUPP if fs and security xattrs disabled
Message-ID: <20200623101042.GB1523@xiangao.remote.csb>
References: <20200527044037.30414-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527044037.30414-1-hsiangkao@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On Wed, May 27, 2020 at 12:40:37PM +0800, Gao Xiang wrote:
> commit f549d6c18c0e ("[PATCH] Generic VFS fallback for security xattrs")
> introduces a behavior change of listxattr path therefore listxattr(2)
> won't report EOPNOTSUPP correctly if fs and security xattrs disabled.
> However it was clearly recorded in manpage all the time.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> 
> Noticed when reviewing Chengguang's patch for erofs [1] (together
> with ext2, f2fs). I'm not sure if it's the best approach but it
> seems that security_inode_listsecurity() has other users and it
> mainly focus on reporting these security xattrs...
> 
> [1] https://lore.kernel.org/r/20200526090343.22794-1-cgxu519@mykernel.net
> 
> Thanks,
> Gao Xiang
> 
>  fs/xattr.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 91608d9bfc6a..f339a67db521 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -352,13 +352,15 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>  	error = security_inode_listxattr(dentry);
>  	if (error)
>  		return error;
> -	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
> -		error = inode->i_op->listxattr(dentry, list, size);
> -	} else {
> -		error = security_inode_listsecurity(inode, list, size);
> -		if (size && error > size)
> -			error = -ERANGE;
> -	}
> +
> +	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR))
> +		return inode->i_op->listxattr(dentry, list, size);
> +
> +	if (!IS_ENABLED(CONFIG_SECURITY))
> +		return -EOPNOTSUPP;
> +	error = security_inode_listsecurity(inode, list, size);
> +	if (size && error > size)
> +		error = -ERANGE;
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(vfs_listxattr);
> -- 
> 2.24.0
> 


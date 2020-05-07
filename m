Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DEDC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9426E2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588867090;
	bh=NITQjEgRSoBKX5wE3WldFfda5i/NM+D9hwjjZEqYonk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n2eBc1ZYqG4D/Y2j0ic3DCeHqszb5qy6WVLszX7+HgYOKz92KXPnsEXOb50xPMsRy
	 W4O3Gl2ifdKZ6vgepF8QlMVwtwncqcVjKAWPDxu1JuEfnk33R1A73fW8JzAXiXSaOj
	 TlVcw6ujcjgn/0rjOCDKxyi1X0EfZR1gGS5MupQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEGP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgEGP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:58:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D44A20659;
        Thu,  7 May 2020 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588867089;
        bh=NITQjEgRSoBKX5wE3WldFfda5i/NM+D9hwjjZEqYonk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dbz7rPhILm+FqlSj6+mj6XquWajcLLt5/vfSaMpMTmc1ff/m+frJQnWwlt9/Joulk
         K2Ai1Z8ndhpLL3MYb6Rlz0JBjUDVVof33WPJUKGTJITfqYXj3kpIfmEsBDe8i3ircG
         hit2Ez3+NpF2xt8D7jP6jPuO4ItpSIVyoe8dVFsg=
Date:   Fri, 8 May 2020 00:58:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <hewenliang4@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tools/bootconfig: fix resource leak in apply_xbc()
Message-Id: <20200508005805.9ae13059958e36ce9ebdd5aa@kernel.org>
In-Reply-To: <20200508005647.dc6f79c0aeca041203af1d8d@kernel.org>
References: <583a49c9-c27a-931d-e6c2-6f63a4b18bea@huawei.com>
        <20200508005647.dc6f79c0aeca041203af1d8d@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 00:56:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 7 May 2020 17:23:36 +0800
> Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> 
> > The @data and @fd is leak in the error path of apply_xbc(), so this
> > patch fix it.
> 
> Good catch! Thanks for fixing!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Hi Steve, can you pick this up?

Thank you,

> > 
> > Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> > ---
> >  tools/bootconfig/main.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > index 16b9a420e6fd..001076c51712 100644
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -314,6 +314,7 @@ int apply_xbc(const char *path, const char *xbc_path)
> >  	ret = delete_xbc(path);
> >  	if (ret < 0) {
> >  		pr_err("Failed to delete previous boot config: %d\n", ret);
> > +		free(data);
> >  		return ret;
> >  	}
> > 
> > @@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_path)
> >  	fd = open(path, O_RDWR | O_APPEND);
> >  	if (fd < 0) {
> >  		pr_err("Failed to open %s: %d\n", path, fd);
> > +		free(data);
> >  		return fd;
> >  	}
> >  	/* TODO: Ensure the @path is initramfs/initrd image */
> >  	ret = write(fd, data, size + 8);
> >  	if (ret < 0) {
> >  		pr_err("Failed to apply a boot config: %d\n", ret);
> > -		return ret;
> > +		goto out;
> >  	}
> >  	/* Write a magic word of the bootconfig */
> >  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> >  	if (ret < 0) {
> >  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> > -		return ret;
> > +		goto out;
> >  	}
> > +out:
> >  	close(fd);
> >  	free(data);
> > 
> > -	return 0;
> > +	return ret;
> >  }
> > 
> >  int usage(void)
> > -- 
> > 1.8.3.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>

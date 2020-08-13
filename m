Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBCCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC162078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CYy+4Stx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:13:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAAC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:13:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so3121840pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KeLENGmTqevElfTFlicA6WgUyhusz/AdmgD9XvqU0DY=;
        b=CYy+4Stxi1ExSs8XxOGzBZtxWBHywGqeYKZtNSyDM6dlJfFfyH3UNxxFVCPYH3BKG7
         ZIihx5BXaz04hknK0hkHflHUY44qWYq5o2Y/NEn186lhJJiRnnlQJmqwocR/YT5Pbhk7
         /STbmfpiCTr8XryclbbC6Jne0mKee1RfH+WTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KeLENGmTqevElfTFlicA6WgUyhusz/AdmgD9XvqU0DY=;
        b=gBvcNjpbmad7zgLgsMzKZdfhMYf76UKXEJULyyucE5pytkPYbf+BdtkbAvPYXdG0Tz
         +qebidWb3ubAk8n0y9qg24K9lEDUrCL/n9yqX46GQJ3KZZ85KHyM9CIFOAvCn4W3zmVT
         Y/KzHu623GhG8URY4rkWognIh3yDZmZpUo0rj6gzuoXxfHOHbya7l/HbPphfRdsNuU49
         qhHqWc+AV1x4CbOq9a4dwX8EQ1z+RvSVvNoGVEzaX6f3kM4GBCaj17Y6jLkQTPK0TjfI
         HZQuPJTxva6nQwiXTsh167ollC4j9x9nO21urmT6x0PcFThKAA4iplpcCl8udz3ZXryf
         Rc7w==
X-Gm-Message-State: AOAM531KZoIUhVUhnxBxC/VIOaj4dtb8rw/GAj0QsqfA3abkOdFroSN+
        QQOPpHenm8MlCJeDIJLh1gSbvg==
X-Google-Smtp-Source: ABdhPJwu2uqwlF7LLxoIIFGQvItBNvhHuZL8emRHk0NQiRoeW/BGwcx8cO3KUI1A2Zf4QMqJ235xPA==
X-Received: by 2002:a62:8416:: with SMTP id k22mr5216638pfd.293.1597338785128;
        Thu, 13 Aug 2020 10:13:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm5755415pjn.34.2020.08.13.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 10:13:04 -0700 (PDT)
Date:   Thu, 13 Aug 2020 10:13:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] exec: Move S_ISREG() check earlier
Message-ID: <202008131012.8100400AD@keescook>
References: <20200605160013.3954297-1-keescook@chromium.org>
 <20200605160013.3954297-3-keescook@chromium.org>
 <20200813151305.6191993b@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813151305.6191993b@why>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 03:13:05PM +0100, Marc Zyngier wrote:
> On Fri,  5 Jun 2020 09:00:12 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> Hi Kees,
> 
> > The execve(2)/uselib(2) syscalls have always rejected non-regular
> > files. Recently, it was noticed that a deadlock was introduced when trying
> > to execute pipes, as the S_ISREG() test was happening too late. This was
> > fixed in commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
> > during execve()"), but it was added after inode_permission() had already
> > run, which meant LSMs could see bogus attempts to execute non-regular
> > files.
> > 
> > Move the test into the other inode type checks (which already look
> > for other pathological conditions[1]). Since there is no need to use
> > FMODE_EXEC while we still have access to "acc_mode", also switch the
> > test to MAY_EXEC.
> > 
> > Also include a comment with the redundant S_ISREG() checks at the end of
> > execve(2)/uselib(2) to note that they are present to avoid any mistakes.
> > 
> > My notes on the call path, and related arguments, checks, etc:
> > 
> > do_open_execat()
> >     struct open_flags open_exec_flags = {
> >         .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> >         .acc_mode = MAY_EXEC,
> >         ...
> >     do_filp_open(dfd, filename, open_flags)
> >         path_openat(nameidata, open_flags, flags)
> >             file = alloc_empty_file(open_flags, current_cred());
> >             do_open(nameidata, file, open_flags)
> >                 may_open(path, acc_mode, open_flag)
> > 		    /* new location of MAY_EXEC vs S_ISREG() test */
> >                     inode_permission(inode, MAY_OPEN | acc_mode)
> >                         security_inode_permission(inode, acc_mode)
> >                 vfs_open(path, file)
> >                     do_dentry_open(file, path->dentry->d_inode, open)
> >                         /* old location of FMODE_EXEC vs S_ISREG() test */
> >                         security_file_open(f)
> >                         open()
> > 
> > [1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/exec.c  | 14 ++++++++++++--
> >  fs/namei.c |  6 ++++--
> >  fs/open.c  |  6 ------
> >  3 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 30735ce1dc0e..2b708629dcd6 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -139,8 +139,13 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
> >  	if (IS_ERR(file))
> >  		goto out;
> >  
> > +	/*
> > +	 * may_open() has already checked for this, so it should be
> > +	 * impossible to trip now. But we need to be extra cautious
> > +	 * and check again at the very end too.
> > +	 */
> >  	error = -EACCES;
> > -	if (!S_ISREG(file_inode(file)->i_mode))
> > +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
> >  		goto exit;
> >  
> >  	if (path_noexec(&file->f_path))
> > @@ -860,8 +865,13 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >  	if (IS_ERR(file))
> >  		goto out;
> >  
> > +	/*
> > +	 * may_open() has already checked for this, so it should be
> > +	 * impossible to trip now. But we need to be extra cautious
> > +	 * and check again at the very end too.
> > +	 */
> >  	err = -EACCES;
> > -	if (!S_ISREG(file_inode(file)->i_mode))
> > +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
> >  		goto exit;
> >  
> >  	if (path_noexec(&file->f_path))
> > diff --git a/fs/namei.c b/fs/namei.c
> > index a320371899cf..0a759b68d66e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2835,16 +2835,18 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >  	case S_IFLNK:
> >  		return -ELOOP;
> >  	case S_IFDIR:
> > -		if (acc_mode & MAY_WRITE)
> > +		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> >  			return -EISDIR;
> 
> This seems to change (break?) the behaviour of syscalls such as execv,
> which can now return -EISDIR, whereas the existing behaviour was to
> return -EACCES. The man page never hints at the possibility of -EISDIR
> being returned, making it feel like a regression.
> 
> POSIX (FWIW) also says:
> 
> <quote>
> [EACCES]
>     The new process image file is not a regular file and the
>     implementation does not support execution of files of its type.
> </quote>
> 
> This has been picked up by the Bionic test suite[1], but can just as
> easily be reproduced with the following snippet:
> 
> $ cat x.c
> #include <unistd.h>
> #include <stdio.h>
> int main(int argc, char *argv[])
> {
> 	execv("/", NULL);
> 	perror("execv");
> 	return 0;
> }
> 
> Before this patch:
> $ ./x
> execv: Permission denied
> 
> After this patch:
> $ ./x
> execv: Is a directory

That's a good point, yes. I will submit a fix for this.

-- 
Kees Cook

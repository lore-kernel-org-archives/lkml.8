Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FAA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="ms1X1Vax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgBLLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:50:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:50:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so740274pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/Kt8yBYKJlgNHo8OSn7XhHpeaNdSfoPdFGNVhCHXhg=;
        b=ms1X1VaxpbbR8+Gk6MFJXoY/QlUkt8ucQV97uUV4Y3wVe0DRzl0usi8HObvPIVEE7X
         tT2hOzuTCvELQf557+7PiEks8opcHWEccFRMFkoOUslEFn+rVB6x9zfJ2CFSq2wmh5U7
         4E3TG1nwUHjYm7aNeC+Prq7Vb+29Uu3liB/H2xrXfVGmyWKSJIXwrXmzq5FcytNxUwLQ
         w6qBeazegpBi4rBSJmLNsTSl+Kq3QosePjngqd532wph53r4LKdLN0zest5joXIu6u0c
         BdQu8OgNtres8Z31Lyhvo3MdGMZR25tXuERPjBQtPbVcA0sdhQWKOqEfJljFfkLZ4aE1
         ieJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/Kt8yBYKJlgNHo8OSn7XhHpeaNdSfoPdFGNVhCHXhg=;
        b=sFyk2fVjI0aWY+xX4VUfjWW5cQJMrjRmJqhC+HddCZ+MQ8xiKol5C2HhB26WFzbHjz
         CoN5OHJa4W+EgwhawiyOLtGd6aL45F3c02rjPCjSvce+Xo5tEKRWH9WDADnzbfkGqMsm
         JLHswJOiOuDQPttaJF6Egqv9946oqsL+6pUtxKOdSvXvODE5HGdEK0/1fJIATeYrrud3
         mbPdgtfCQZSSy2dLtYNfk8yq/83CxHKbE/34p71AtUvH1PovP6BwJWoYZYb26Dq/PGRO
         Mz7Que83BAystuoFS/rGOrevA7UfypjEoN2zSt4x4LZcvYoBuKSkvvKzJY3pMLe22Fc/
         x/AA==
X-Gm-Message-State: APjAAAWHrL8z7Y0cznCAvLdz0dWsnbHZMOJAkFJgPvy27wiK8fHiAf3Z
        yJSxcdQi5zSaMaGHQOtbswikxw==
X-Google-Smtp-Source: APXvYqyvjba5s0JoLMVHbgm6nxAIDm5JLzYHeLGpGGZFqZiO6EA8wawgQdDDR4zlWxwLF5VroYLP0g==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr8068680pfo.139.1581508247018;
        Wed, 12 Feb 2020 03:50:47 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id a195sm663016pfa.120.2020.02.12.03.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 03:50:45 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Wed, 12 Feb 2020 17:20:35 +0530
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject:  [PATCH v2] staging:gasket:gasket_core.c:unified quoted string split
 across lines in one line
Message-ID: <20200212115035.GB21751@kaaira-HP-Pavilion-Notebook>
References: <20200211200456.GA10351@kaaira-HP-Pavilion-Notebook>
 <alpine.DEB.2.21.2002112139550.3266@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002112139550.3266@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:45:03PM +0100, Julia Lawall wrote:
> On Wed, 12 Feb 2020, Kaaira Gupta wrote:
> 
> > Whenever it tries to map a region, but the region has permissions, or it attempts to open gasket with tgid, or it releases device node the messages are displayed in one line only, respectively.
> > And it becomes confusing for the developer to search for the code based on these lines' output since they are written in separate lines in the code.
> > So, this patch fixes this 'WARNING: quoted string split across lines'
> > in three lines in the file gasket_core.c.
> 
> Congratulations on making the first submission of this round :)

Thanks!

> 
> However, some changes are needed.  The subject line needs better tags at
> the beginning to highlight what part of the kernel is affected.  Use git
> log --oneline on this file to see what others have done.  And follow the
> style used, in terms of whitespace.  Also, try to avoid the word Fix in
> the subject line, which is not very descriptive.  The word WARNING: is
> probably also not necessary.
> 
> Afterwards, the log message should also respect the 80 character limit.
> Ideally even fewer characters, because it will come out indented in the
> resulting path.
> 
> Finally, the log message should describe what it does using the
> imperative, and again should avoid the word "fix".
> 
> julia

When the driver tries to map a region, but the region has certain
permissions, or when it attempts to open gasket with tgid, or when it
realeases device node; the logs are displayed in one line only while the
code has the strings split in two lines which makes it difficult for
developers to search for code based on the log messages. So, this patch
fixes three warnings of 'quoted string split across lines' in
gasket_core.c by merging the strings in one line.

Also, I wasn't sure if I were to send a separate batch or reply with a
v2 for this one. If former was the case than please let me know.
Thanks for your time!

> 
> >
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  drivers/staging/gasket/gasket_core.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> > index cd8be80d2076..411aaf248b37 100644
> > --- a/drivers/staging/gasket/gasket_core.c
> > +++ b/drivers/staging/gasket/gasket_core.c
> > @@ -692,8 +692,7 @@ static bool gasket_mmap_has_permissions(struct gasket_dev *gasket_dev,
> >  		(vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC));
> >  	if (requested_permissions & ~(bar_permissions)) {
> >  		dev_dbg(gasket_dev->dev,
> > -			"Attempting to map a region with requested permissions "
> > -			"0x%x, but region has permissions 0x%x.\n",
> > +			"Attempting to map a region with requested permissions 0x%x, but region has permissions 0x%x.\n",
> >  			requested_permissions, bar_permissions);
> >  		return false;
> >  	}
> > @@ -1180,8 +1179,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
> >  	inode->i_size = 0;
> >
> >  	dev_dbg(gasket_dev->dev,
> > -		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
> > -		"fmode_write: %d is_root: %u)\n",
> > +		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, fmode_write: %d is_root: %u)\n",
> >  		current->tgid, task_name, filp->f_mode,
> >  		(filp->f_mode & FMODE_WRITE), is_root);
> >
> > @@ -1258,8 +1256,7 @@ static int gasket_release(struct inode *inode, struct file *file)
> >  	mutex_lock(&gasket_dev->mutex);
> >
> >  	dev_dbg(gasket_dev->dev,
> > -		"Releasing device node. Call origin: tgid %u (%s) "
> > -		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
> > +		"Releasing device node. Call origin: tgid %u (%s) (f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
> >  		current->tgid, task_name, file->f_mode,
> >  		(file->f_mode & FMODE_WRITE), is_root);
> >  	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
> > --
> > 2.17.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200211200456.GA10351%40kaaira-HP-Pavilion-Notebook.
> >

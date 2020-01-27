Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA40C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3BE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="pF+vNJbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgA0FGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:06:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42570 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0FGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:06:30 -0500
Received: by mail-il1-f194.google.com with SMTP id x2so2738376ila.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 21:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8T3JDpxBE2PuzGuLciOyK1XdDOMf7MGFDmAy+zMLvQY=;
        b=pF+vNJbJ0EtML4m5uQzN+qes0p+UYwzmj9aI3bkvvBs0Rl8aydvz1JMnKMNFu/Mbsj
         9RZat21omjBpJ6qMIf1jl3jH9nHWXOuTr3xJkuRA8o/uhTrORJwfmcGh8bSVlANt0rWY
         tzkSr0LG2JOa4DcN5Hc2cdCoPgpPqBeO/CVsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8T3JDpxBE2PuzGuLciOyK1XdDOMf7MGFDmAy+zMLvQY=;
        b=HHoeOEy64InOWjE6sekJZcYi6QPxKIE6mTUWxwTcvxsdVTOpl7fmqwM6+yb/dmv2PF
         zDEs05B67joTVIKJ/H7KW8lY+UkTKuB1Y2PmP8w99bEEbsf3fdTalsiQ8NtiuP5evhbb
         GA7XiKbotIOBTssT7zV2DwUDM5Caw2Cdbv02btVtIojrNp63QHfsGfQCWvoDtfQBVeYo
         2JJhmZ0matljrCCG6QiQOBwKsDsb3OrUtRuZZfKOJtyewqENMO0xyPSft+PyxUnCOTZg
         fChc9WjWyPQrUHPeDLJ1s8Q3+Iffw9VU574krNvVnI+GqmhOGCMc3IEhEzVohkzfbVsE
         dnyw==
X-Gm-Message-State: APjAAAXdEtwgkOxFETkTPQf7Z5MZ1huE+DL/yUcxRmWjAQnXIvlM4PMB
        4xR4OyozJjdmlzv8xTIL92IKKw==
X-Google-Smtp-Source: APXvYqzU6hFcVnk71OVfcxJiZKXDs3RdLFB+1o6wVm+OqDIQIQA2gWUGkW3N70o5On3Ded/4jvA7AQ==
X-Received: by 2002:a92:d3cc:: with SMTP id c12mr13807584ilh.266.1580101590015;
        Sun, 26 Jan 2020 21:06:30 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id b12sm3185583ion.83.2020.01.26.21.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 21:06:29 -0800 (PST)
Date:   Mon, 27 Jan 2020 05:06:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200127050627.GA21575@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
 <20200126040325.5eimmm7hli5qcqrr@yavin.dot.cyphar.com>
 <20200126041439.liwfmb4h74zmhi76@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126041439.liwfmb4h74zmhi76@yavin.dot.cyphar.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 03:14:39PM +1100, Aleksa Sarai wrote:
> On 2020-01-26, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2020-01-24, Sargun Dhillon <sargun@sargun.me> wrote:
> > >  static long seccomp_notify_recv(struct seccomp_filter *filter,
> > >  				void __user *buf)
> > >  {
> > >  	struct seccomp_knotif *knotif = NULL, *cur;
> > >  	struct seccomp_notif unotif;
> > > +	struct task_struct *group_leader;
> > > +	bool send_pidfd;
> > >  	ssize_t ret;
> > >  
> > > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> > > +		return -EFAULT;
> > >  	/* Verify that we're not given garbage to keep struct extensible. */
> > > -	ret = check_zeroed_user(buf, sizeof(unotif));
> > > -	if (ret < 0)
> > > -		return ret;
> > > -	if (!ret)
> > > +	if (unotif.id ||
> > > +	    unotif.pid ||
> > > +	    memchr_inv(&unotif.data, 0, sizeof(unotif.data)) ||
> > > +	    unotif.pidfd)
> > > +		return -EINVAL;
> > 
> > IMHO this check is more confusing than the original check_zeroed_user().
> > Something like the following is simpler and less prone to forgetting to
> > add a new field in the future:
> > 
I'm all for this, originally my patch read:

__u32 flags = 0;
swap(unotif.flags, flags);
if (memchr(&unotif, 0, sizeof(unotif))
	return -EINVAL;

--- And then check flags appropriately. I'm not sure if this is "better",
as I didn't see any other implementations that look like this in the
kernel. What do you think? It could even look "simpler", as in:

__u32 flags;

if (copy_from_user(....))
	return -EFAULT;
flags = unotif.flags;
unotif.flags = 0;
if (memchr_inv(&unotif, 0, sizeof(unotif)))
	return -EINVAL;


Are either of those preferential, reasonable, or at a minimum inoffensive?
> > 	if (memchr_inv(&unotif, 0, sizeof(unotif)))
> > 		return -EINVAL;
> 
Wouldn't this fail if flags was set to any value? We either need to zero
out flags prior to checking, or split it into range checks that exclude
flags.

> Also the check in the patch doesn't ensure that any unnamed padding is
> zeroed -- memchr_inv(&unotif, 0, sizeof(unotif)) does.
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



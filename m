Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB4EC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AD522522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581069187;
	bh=atFs7FDe799oyFOWImHiQXk9NZ6kVQ1RKLOA5Hdgsps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lXQFOe4EcrJ2YIjbm+jvPPNnmhX1WY66Zs3TS4C4igvdegbMEKBj8lPr6qsDCijGN
	 GGwgs50ozOPktvieUZ8zed85dVchgl17w48Zrx9iY3OBuxUzjv+GPTosR+EzQJEbE/
	 vh+AZByYBJLE28PSwMFqiqSEi4AHrccbgGC8EFzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGJxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgBGJxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:53:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7241220726;
        Fri,  7 Feb 2020 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581069184;
        bh=atFs7FDe799oyFOWImHiQXk9NZ6kVQ1RKLOA5Hdgsps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYRPWjK2QKBoURobzhiHCdtE7F5wVdrTUuZhMphev8FtFj0YxUtu/BS2xdiXCnzbV
         JlW8Hk3VZ8NyFyYFdh1PRvTMoK/7OwVTjduQ+OqRS4mC6cRgfC78yRC/74kqyLmH9A
         nYfd2HY59Vx5YLaCulZtP2BZLYaUKLLrLD0e9tqw=
Date:   Fri, 7 Feb 2020 10:53:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shenkai <shenkai8@huawei.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] add lock proctect to __handle_sysrq in
 write_sysrq_trigger
Message-ID: <20200207095302.GA583069@kroah.com>
References: <1581062166-27284-1-git-send-email-shenkai8@huawei.com>
 <20200207081006.GB309560@kroah.com>
 <ed0edfc4-2614-9fba-de85-b970bb0adb61@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0edfc4-2614-9fba-de85-b970bb0adb61@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:13:57PM +0800, shenkai wrote:
> 
> On 2020/2/7 16:10, Greg KH wrote:
> > On Fri, Feb 07, 2020 at 07:56:06AM +0000, Shen Kai wrote:
> > > From: Feilong Lin <linfeilong@huawei.com>
> > > 
> > > Add lock protect to __handle_sysrq to avoid race condition.
> > > __handle_sysrq will change console_loglevel without lock protect
> > > which can lead to console_loglevel to be set as an unexpected value.
> > > 
> > > Problem may occur when "echo t > /proc/sysrq-trigger" is called on
> > > multiple cpus concurrently.
> > > 
> > > In this case in __handle_sysrq, console_loglevel is set to 7 to print
> > > some head info to the console then restore it. But without lock protect
> > > in parallel execution situation, restoring may go wrong. The new
> > > loglevel may be taken as the previous loglevel incorrectly.
> > > Console_loglevel can be 7 at last, which causes the terminal to output
> > > info in most log levels.
> > > 
> > > This bug was found on linux 4.19
> > > 
> > > Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> > > Reported-by: Kai Shen <shenkai8@huawei.com>
> > > ---
> > >   drivers/tty/sysrq.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index f724962..cbb48a9 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -1087,6 +1087,8 @@ EXPORT_SYMBOL(unregister_sysrq_key);
> > >   /*
> > >    * writing 'C' to /proc/sysrq-trigger is like sysrq-C
> > >    */
> > > +static DEFINE_MUTEX(sysrq_mutex);
> > > +
> > >   static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
> > >   				   size_t count, loff_t *ppos)
> > >   {
> > > @@ -1095,7 +1097,9 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
> > >   		if (get_user(c, buf))
> > >   			return -EFAULT;
> > > +		mutex_lock(&sysrq_mutex);
> > >   		__handle_sysrq(c, false);
> > > +		mutex_unlock(&sysrq_mutex);
> > 
> > What exactly are you protecting here?  What other task is doing this at
> > the same exact time?
> > 
> > You mention different tasks hitting this sysrq-trigger at the same time,
> > but really, "just do not do that" should be the real answer, as even
> > with this lock, you don't know what the end result will be as the "last"
> > one in will have the last word, right?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > .
> > 
> 
> Here we want to protect the global variable console_loglevel
> (console_printk[0]).

But how is this single lock protecting it?

> Problem may occur when run shell programs like:
> 
> echo t > /proc/sysrq-trigger &
> echo t > /proc/sysrq-trigger &
> echo t > /proc/sysrq-trigger &
> ..

Don't do that :)

> After above operations are done, console_loglevel may be 7 instead of the
> original log level. I doubt this is what we expect though those operations
> may not be meaningful.
> 
> In this case, much info may be output to the terminal for stack info of all
> threads is a lot to print which may cause soft lockup on a non-preempt
> kernel.

Dumping loads of stuff to the console is what you asked the above things
to do.  And why would you run non-preempt?

Anyway, this feels like you are not addressing the real issue and
instead papering over it by just trying to serialize the sysrq trigger,
which is not something that we always need to do.

thanks,

greg k-h

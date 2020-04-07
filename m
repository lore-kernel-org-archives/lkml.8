Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26E8206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586271687;
	bh=pxNPNw3IOGTVnsSxXTP4d/SsOagKyM3Ug/U/XxdX8rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ExTUtVdMk72c5yE/h7ldc5Koy91sJ1rh2Bj3yA3V94yE1nKupfXuqWVGoNckgxgaI
	 UJygrCHYQSJBHqQH76HikwIISw8C7xkt4tZyCNy6jHihT2YN3RpE3ywMBpp9KBl6EO
	 Lbl9BNPmz59ZH43+VuuqkTM/jvANHQfgOjjr+bFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgDGPB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgDGPB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:01:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD36206F7;
        Tue,  7 Apr 2020 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586271685;
        bh=pxNPNw3IOGTVnsSxXTP4d/SsOagKyM3Ug/U/XxdX8rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srJU6UGhRd7eJlf2Y1S2AzLwP3reF/UMuF8d/fmIuGpSH1RCsIAKT3lKGxlAE51wp
         pTbjClrf6bKehiogfyuZQymnCoMtZdYmChQ3VSqDM5kl2awWnrjDBEFW5DfhROtf3f
         snwD49CBTipS4SgzScDJIeEGiOtnU7KH4GK1N1XU=
Date:   Tue, 7 Apr 2020 17:01:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Zhang <zhangfeionline@gmail.com>
Cc:     =?utf-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] driver core: Fix possible use after free
 on name
Message-ID: <20200407150123.GA897865@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com>
 <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
 <20200406054110.GA1638548@kroah.com>
 <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
 <20200406082857.GA1646464@kroah.com>
 <CAMZfGtURi4KDijw1=2JuTWxufcjypzS2_fEe0sGwXoAOUKbT5Q@mail.gmail.com>
 <20200406111648.GA1797430@kroah.com>
 <CAC_bin+tzPeHX2bAz+0hY+qKsBn4-vMuqFvYvW05bDGv32SzEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_bin+tzPeHX2bAz+0hY+qKsBn4-vMuqFvYvW05bDGv32SzEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 10:42:30PM +0800, Fei Zhang wrote:
> Dear  Greg
> 
>    Greg KH < gregkh@linuxfoundation.org >于2020年4月6日周一下午7:16写道：
> 
> > On Mon, Apr 06, 2020 at 06:42:46PM +0800,宋牧春wrote:
> > > Hi Greg,
> > >
> > > Greg KH < gregkh@linuxfoundation.org >于2020年4月6日周一下午4:29写道：
> > > >
> > > > A: http://en.wikipedia.org/wiki/ Top_post
> > <http://en.wikipedia.org/wiki/Top_post>
> > > > Q: Were do I find info about this thing called top-posting?
> > > > A: Because it messes up the order in which people normally read text.
> > > > Q: Why is top-posting such a bad thing?
> > > > A: Top-posting.
> > > > Q: What is the most annoying thing in e-mail?
> > > >
> > > > A: No.
> > > > Q : Should I include quotations after my reply?
> > > >
> > > > http://daringfireball.net/ 2007/07/on_top
> > <http://daringfireball.net/2007/07/on_top>
> > > >
> > > > On Mon, Apr 06, 2020 at 03:40:41PM +0800, Fei Zhang wrote:
> > > > > Dear Greg,
> > > > >
> > > > > Mostly, "class_creat" is used in kernel driver module, basically
> > > > > read-only strings,
> > > > > but it is easier to use a local variable string. When writing drive
> > module,
> > > > > it fails to judge the local variable string which cannot be passed
> > in
> > > > > only via interface.
> > > > > I found that someone else may also face the same problem.
> > > >
> > > > An individual driver should NOT be creating a class, that is not what
> > it
> > > > is there for.
> > >
> > > If someone want to create a virtual device,someone can call
> > device_create().
> > > But the first argument is type of 'struct class *class', so we have to
> > > call class_create()
> > > before create device. So an individual driver may be creating a class,
> > right?
> >
> > Again, they should not be, as classes are not what a driver creates. It
> > is what a subsystem creates, as a class is a type of common devices that
> > all talk to userspace in the same way.
> >
> > > > Class names are very "rare" and should not be dynamically created at
> > > > all.
> > >
> > > I have reviewed the code of the kstrdup_const() which is just below.
> > >
> > > const char *kstrdup_const(const char *s, gfp_t gfp)
> > > {
> > > if (is_kernel_rodata((unsigned long)s))
> > >return s;
> > >
> > > return kstrdup(s, gfp);
> > > }
> > >
> > > A readonly string which is in the kernel rodata, so we do not need to
> > > dynamically allocate
> > > memory to store the name. So with this patch applied, there is nothing
> > > changed which
> > > means that we did not waste memory. But it can prevent someone from
> > > reading stale name
> > > if an unaware user passes an address to a stack-allocated buffer.
> > >
> > > So I think it is worth fixing, right?
> >
> > Again, there is nothing to "fix" here as there is no code in the kernel
> > tree today calling this api with a class name that is not static.
> >
> > If we have code that does need to do this,and it is submitted for
> > merging, and I agree with how it is creating the class names, I will be
> > glad to take a patch at that time to make this change. Until then, this
> > is just added complexity for no benefit at all.
> 
> 
> 
> 
> 
> The interface was used by many drivers. Please refer to below link.
> 
>  https://elixir.bootlin.com/linux/latest/source/drivers/char/dsp56k.c#L507

That should just be fixed up to use the misc device interface, I'll put
it on my list of things to fix...

> > https://elixir.bootlin.com/linux/latest/source/drivers/char/pcmcia/cm4040_cs.c#L654

Does anyone still care/use pcmcia drivers?  I doubt you will ever run
this code :)

> > https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm-interface.c#L462

TPM is a valid class, nothing is wrong with that.

>   ...
> >
> Normally, class shall be created before creating the virtual device.
> > https://elixir.bootlin.com/linux/latest/source/fs/fuse/cuse.c#L628
> 
> https://elixir.bootlin.com/linux/latest/source/fs/pstore/pmsg.c#L66
> 

Those too are fine, nothing broken with them.

>   ...
> >
> I think it is worth fixing, it will make the code more stable.

The code is working just fine as-is, nothing is broken.  By adding
unneeded complexity, it will be more unstable.

Not to mention the first attempt didn't even get it correct, which if I
had accepted, would have _introduced_ a bug for no reason at all.

Again, if you have an in-kernel user that wants to somehow create a
class dynamically off of the stack like your example showed, I will be
glad to revisit this, after I review that driver's code.

thanks,

greg k-h

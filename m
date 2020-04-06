Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D8C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394BB206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586171813;
	bh=DBLgYA2jJe29u2yG1zEKM15bBvyYd8p0FiFATN1DXaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=17zb8EnSBbfWEbtAVHutrG3N9dmWEMLHSwpX/2EeV3YLWgOY2WeGP6OA4Qxhm6bis
	 gx3AiM3ZLFlRbMOHD6Vi9/kb5q9MNK1nkFWN6xW2Vm2vZTz17CfVUvXVlin3ZFQRtC
	 nMDhgFRVQ96jWX3Jgdl5FhUgwrQhgrcz+iSweRt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDFLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgDFLQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:16:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C521206F5;
        Mon,  6 Apr 2020 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586171810;
        bh=DBLgYA2jJe29u2yG1zEKM15bBvyYd8p0FiFATN1DXaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFmK3wx8/lBjaM/xGWW23dhl/t3LtuG5v7nX2lLnNOMp2ISLziWTJ5nFbRCl8H6pz
         j95wUXBqd5JYWCp1KtJ4j3GCwg1klnSk84Yojezi9AYwuNAkQMSuJPuuR7WX+UEhBK
         jBuZKNPBn5CqrheEocCA5Y4urLKN8HwbJ2EhnEKg=
Date:   Mon, 6 Apr 2020 13:16:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Cc:     Fei Zhang <zhangfeionline@gmail.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] driver core: Fix possible use after free
 on name
Message-ID: <20200406111648.GA1797430@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com>
 <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
 <20200406054110.GA1638548@kroah.com>
 <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
 <20200406082857.GA1646464@kroah.com>
 <CAMZfGtURi4KDijw1=2JuTWxufcjypzS2_fEe0sGwXoAOUKbT5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZfGtURi4KDijw1=2JuTWxufcjypzS2_fEe0sGwXoAOUKbT5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:42:46PM +0800, 宋牧春 wrote:
> Hi Greg,
> 
> Greg KH <gregkh@linuxfoundation.org> 于2020年4月6日周一 下午4:29写道：
> >
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top
> >
> > On Mon, Apr 06, 2020 at 03:40:41PM +0800, Fei Zhang wrote:
> > > Dear Greg,
> > >
> > > Mostly, "class_creat" is used in kernel driver module, basically
> > > read-only strings,
> > > but it is easier to use a local variable string. When writing drive module,
> > > it fails to judge the local variable string which cannot be passed in
> > > only via interface.
> > > I found that someone else may also face the same problem.
> >
> > An individual driver should NOT be creating a class, that is not what it
> > is there for.
> 
> If someone want to create a virtual device, someone can call device_create().
> But the first argument is type of 'struct class *class', so we have to
> call class_create()
> before create device. So an individual driver may be creating a class, right?

Again, they should not be, as classes are not what a driver creates.  It
is what a subsystem creates, as a class is a type of common devices that
all talk to userspace in the same way.

> > Class names are very "rare" and should not be dynamically created at
> > all.
> 
> I have reviewed the code of the kstrdup_const() which is just below.
> 
> const char *kstrdup_const(const char *s, gfp_t gfp)
> {
>         if (is_kernel_rodata((unsigned long)s))
>                 return s;
> 
>         return kstrdup(s, gfp);
> }
> 
> A readonly string which is in the kernel rodata, so we do not need to
> dynamically allocate
> memory to store the name. So with this patch applied, there is nothing
> changed which
> means that we did not waste memory. But it can prevent someone from
> reading stale name
> if an unaware user passes an address to a stack-allocated buffer.
> 
> So I think it is worth fixing, right?

Again, there is nothing to "fix" here as there is no code in the kernel
tree today calling this api with a class name that is not static.

If we have code that does need to do this, and it is submitted for
merging, and I agree with how it is creating the class names, I will be
glad to take a patch at that time to make this change.  Until then, this
is just added complexity for no benefit at all.

thanks,

greg k-h

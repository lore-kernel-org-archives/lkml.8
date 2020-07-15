Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B76820720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594809339;
	bh=LjsVPF/qgeE2jSt99l6d1y9hd1y4uzr0FIZK7Qzg+N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MAnIFy32CX8Y1my81hZfKZjLwdeg9fkKPY70NyAswRACPhtOF37k6ifiGZ5JsU1du
	 QcvykZTkPoXHzuyo2eG8REToCx+Cisu79gcHwveeto2XHND2dBCFOCCsxjxO8U48wi
	 ennbp7/U3/JWDmzmv7IdeeyNR7vL1Il4Z0KIFBN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgGOKfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgGOKfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:35:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 101E920656;
        Wed, 15 Jul 2020 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594809336;
        bh=LjsVPF/qgeE2jSt99l6d1y9hd1y4uzr0FIZK7Qzg+N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8sBr9AZ/+uhvmXieIj46P5R8FUbHF18JZUNtlZnEL4aKhqlDVUmmn1qnFa1KIbZM
         QRzFCayjRZVu2HnWjcHBBRwgMQRQv1nYQlHT3CxSyhMXUEGNpgVjyDEwI4G5MQSK2/
         O2/J5n+Qaar4FHnKM1ZoYApoHX+uD1KhdBexvZWw=
Date:   Wed, 15 Jul 2020 12:35:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
Message-ID: <20200715103532.GB2876510@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
 <20200715084207.7639-3-peter.enderborg@sony.com>
 <20200715093907.GC2759174@kroah.com>
 <a07943bf-fb7f-872d-4bc6-307bbaf57a3f@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07943bf-fb7f-872d-4bc6-307bbaf57a3f@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:03:19AM +0000, Enderborg, Peter wrote:
> On 7/15/20 11:39 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jul 15, 2020 at 10:42:07AM +0200, Peter Enderborg wrote:
> >> Since debugfs include sensitive information it need to be treated
> >> carefully. But it also has many very useful debug functions for userspace.
> >> With this option we can have same configuration for system with
> >> need of debugfs and a way to turn it off. This gives a extra protection
> >> for exposure on systems where user-space services with system
> >> access are attacked.
> >>
> >> It is controlled by a configurable default value that can be override
> >> with a kernel command line parameter. (debugfs=)
> >>
> >> It can be on or off, but also internally on but not seen from user-space.
> >> This no-fs mode do not register a debugfs as filesystem, but client can
> >> register their parts in the internal structures. This data can be readed
> >> with a debugger or saved with a crashkernel. When it is off clients
> >> get EPERM error when accessing the functions for registering their
> >> components.
> >>
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         | 14 +++++++
> >>  fs/debugfs/inode.c                            | 37 +++++++++++++++++++
> >>  fs/debugfs/internal.h                         | 14 +++++++
> >>  lib/Kconfig.debug                             | 32 ++++++++++++++++
> >>  4 files changed, 97 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index fb95fad81c79..805aa2e58491 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -827,6 +827,20 @@
> >>  			useful to also enable the page_owner functionality.
> >>  			on: enable the feature
> >>  
> >> +	debugfs=    	[KNL] This parameter enables what is exposed to userspace
> >> +			and debugfs internal clients.
> >> +			Format: { on, no-fs, off }
> >> +			on: 	All functions are enabled.
> >> +			no-fs: 	Filesystem is not registered but kernel clients can
> >> +			        access APIs and a crashkernel can be used to read
> >> +				its content. There is nothing to mount.
> >> +			off: 	Filesystem is not registered and clients
> >> +			        get a -EPERM as result when trying to register files
> >> +				or directories within debugfs.
> >> +				This is equilivant of the runtime functionality if
> >> +				debugfs was not enabled in the kernel at all.
> >> +			Default value is set in build-time with a kernel configuration.
> > Naming is hard.  In looking at this, should "no-fs" be called
> > "no-mount"?  That's a better description of what it does, right?
> 
> I think no-fs cover it better since it does not register a filesystem
> but provides the interfaces. Mounting is then indirectly stopped.

But "mounting" is the common term we all know.  "no-fs" doesn't really
describe what is happening here, right?  Everything works internally
just fine, but we just are forbidding the filesystem to be mounted.

> The idea start with a check for mounting but it is much more
> definitely stopped by prevention of register of the filesystem.
> I can imagine to have a forth "mode" where it register a fs but
> not allowing mounting. Such mode maybe useful for some runtime
> configuration. But this patch is about boot time configuration.

Preventing the registering of the filesystem does cut out the ability to
mount the thing quite well :)

We could change it to just prevent the superblock from mounting if you
want, as maybe we do need the fs to remain in the list of filesystems in
the kernel at that point in time?  Otherwise we are lying to userspace.

thanks,

greg k-h

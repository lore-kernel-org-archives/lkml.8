Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D336C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71A12071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584126332;
	bh=vuYul+KNbe7S1RciqI4G1/q/1GISg3EqPissVTD72I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d8GM5XT0Y+5jQBmGX44136czYm9ZP35A5cmUg5RbuoOz++/+TztH0rohnLMpV2RZO
	 UHe8UOYvtfu0j+DYn/LxwscG+3k6imPF6it+Zki7t/B6zCxWdjYc8LyPI5xj6mRZO/
	 sKKbanc+nPPtopyLpZ8NbG7Fim7faEZPAYsoOeMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCMTFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgCMTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:05:31 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF63206B7;
        Fri, 13 Mar 2020 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584126331;
        bh=vuYul+KNbe7S1RciqI4G1/q/1GISg3EqPissVTD72I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQ4CPUlWY3TDyXZr15FC+AB9KXttXeaQJdd7wPkBgHIQWZowL5sV2bVRW+YbNbfDZ
         yZZO2HFj0Y7K17wa0EzDEiGqgXcmfR8YNueYpshapexkG57KFbM3gCynW8hSzETi91
         Sq1nSNEROeqnhMJFhCwWOEco8Gc3mD9JzXzkI5TY=
Date:   Fri, 13 Mar 2020 12:05:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 3/4] docs: admin-guide: document the kernel.modprobe
 sysctl
Message-ID: <20200313190529.GB55327@gmail.com>
References: <20200312202552.241885-1-ebiggers@kernel.org>
 <20200312202552.241885-4-ebiggers@kernel.org>
 <87lfo5telq.fsf@notabene.neil.brown.name>
 <20200313010727.GT11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313010727.GT11244@42.do-not-panic.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 01:07:27AM +0000, Luis Chamberlain wrote:
> > > +modprobe:
> > > +=========
> > > +
> > > +The path to the usermode helper for autoloading kernel modules, by
> > > +default "/sbin/modprobe".  This binary is executed when the kernel
> > > +requests a module.  For example, if userspace passes an unknown
> > > +filesystem type "foo" to mount(), then the kernel will automatically
> > > +request the module "fs-foo.ko" by executing this usermode helper.
> > 
> > I don't think it is right to add the ".ko" there.  The string "fs-foo"
> > is what is passed to the named executable, and it make well end up
> > loading "bar.ko", depending what aliases are set up.
> > I would probably write  '... request the module named 'fs-foo" by executing..'
> 
> And that is just because filesystems, in this case a mount call, will
> use the fs- prefix for aliases. This is tribal knowledge in the context
> above, and so someone not familiar with this won't easily grasp this.
> 
> Is there an easier autoloading example other than filesystems we can use that
> doesn't require you to explain the aliasing thing?
> 
> What is module autoloading? Where is this documented ? If that
> can be slightly clarified this would be even easier to understand as
> well.
> 

I think we're getting too down into the weeds here.  The purpose of this patch
is just to document the modprobe sysctl, not to to give a full explanation of
how module autoloading works including modaliases and everything.  And this
sysctl isn't needed to enable module autoloading; it's enabled by default.
Most users already use module autoloading without ever touching this sysctl.

Let's just write instead:

	For example, if userspace passes an unknown filesystem type to mount(),
	then the kernel will automatically request the corresponding filesystem
	module by executing this usermode helper.  This usermode helper should
	insert the needed module into the kernel.

If someone wants to write a new documentation file that fully explains kernel
modules (I don't see any yet), they should should certainly do so.  It's more
than I set out to do, though.  IMO, just documenting this sysctl is already a
nice improvement by itself.

- Eric

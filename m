Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F0D2081A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJ7oDr3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgETEGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:06:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726273AbgETEGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589947578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=663zai6Sd7Zezu2GZIYrT8aytBhC9HVJbGSzPexsYOw=;
        b=dJ7oDr3iYDJIoUDfdoPK0FYgKmIUukbKdgBKDC8RjEB0RtZmPrMjQI98/Yhak43iE4A1aX
        HxQCCZLYyrKij7JCTYPtAVTPTwyKHKz+DNtqRwY7PjmlMsGAAwhC55NBHIdZ/PZHVq+fVR
        67pC39Rhycw+30cHQaIwPfd+x3lzvmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-SElg9MtNOSqvnt2K1CrgDQ-1; Wed, 20 May 2020 00:06:16 -0400
X-MC-Unique: SElg9MtNOSqvnt2K1CrgDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35BE3474;
        Wed, 20 May 2020 04:06:13 +0000 (UTC)
Received: from mail (ovpn-112-106.rdu2.redhat.com [10.10.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBB7E5D9C5;
        Wed, 20 May 2020 04:06:09 +0000 (UTC)
Date:   Wed, 20 May 2020 00:06:08 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Xu <peterx@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200520040608.GB26186@redhat.com>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200506193816.GB228260@xz-x1>
 <20200507131503.02aba5a6@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507131503.02aba5a6@lwn.net>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and everyone,

On Thu, May 07, 2020 at 01:15:03PM -0600, Jonathan Corbet wrote:
> On Wed, 6 May 2020 15:38:16 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > If this is going to be added... I am thinking whether it should be easier to
> > add another value for unprivileged_userfaultfd, rather than a new sysctl. E.g.:
> > 
> >   "0": unprivileged userfaultfd forbidden
> >   "1": unprivileged userfaultfd allowed (both user/kernel faults)
> >   "2": unprivileged userfaultfd allowed (only user faults)
> > 
> > Because after all unprivileged_userfaultfd_user_mode_only will be meaningless
> > (iiuc) if unprivileged_userfaultfd=0.  The default value will also be the same
> > as before ("1") 
> It occurs to me to wonder whether this interface should also let an admin
> block *privileged* user from handling kernel-space faults?  In a
> secure-boot/lockdown setting, this could be a hardening measure that keeps
> a (somewhat) restricted root user from expanding their privilege...?

That's a good question. In my view if as root in lockdown mode you can
still run the swapon syscall and setup nfs or other network devices
and load userland fuse filesystems or cuse chardev in userland, even
if you prevent userfaultfd from blocking kernel faults, kernel faults
can still be blocked by other means.

That in fact tends to be true also as non root (so regardless of
lockdown settings) since luser can generally load fuse filesystems.
There is no fundamental integrity breakage or privilege escalation
originating in userfaultfd.

The only concern here is about this: "after a new use-after-free is
discovered in some other part of the kernel (not related to
userfaultfd), how easy it is to turn the use-after-free from a mere
DoS to a more concerning privilege escalation?". userfaultfd might
facilitate the exploitation, but even if you remove userfaultfd from
the equation, there's still no guarantee an user-after-free won't
materialize as a privilege escalation by other means.

So to express it in another way: unless lockdown (no matter in which
mode) is a weak probabilistic based feature and in turn it cannot
provide any guarantee to begin with, userfaultfd sysctl set to 0|1|2
can't possibly make any difference to it.

The best mitigation for those kind of exploits remains to randomize
all kernel memory allocations, so even if the attacker can block the
fault, when it's unblocked it'll pick another page, not the one that
the attacker can predict it will use, so the attacker needs to repeat
the race many more times and hopefully it'll DoS and destabilize the
kernel before it can reproduce a privilege escalation. We got many of
those randomization features in the current kernel and it's probably
more important to enable those than to worry about this sysctl value.

One way to have a peace of mind against all use-after-free regardless
of this sysctl value, is to run each pod in a KVM instance, that's
safer than disabling syscalls or kernel features.

The default seccomp profiles of podman already block userfaultfd too,
so there's no need of virt to get extra safety if you use containers:
containers need to explicitly opt-in to enable userfaultfd through the
OCI schema seccomp object. If userfaultfd is being explicitly
whitelisted in the OCI schema of the container, well then you know
there is a good reason for it. As a matter of fact some things are
only possible to achieve with userfaultfd fully enabled.

The big value uffd brings compared to trapping sigsegv is precisely to
be able to handle kernel faults transparently. sigsegv can't do that
because every syscall would return 1) an inconsistent retval and 2) no
fault address along with the retval.

The possible future uffd userland users could be: dropping JVM dirty
bit, redis snapshot using pthread_create() instead of fork(),
distributed shared memory on pmem, new malloc() implementation never
taking mmap_sem for writing in the kernel and never modifying any vma
to allocate and free anon memory, etc.. I don't think any of them
would work with the sysctl set to "2".

The next kernel feature in uffd land that I was discussing with Peter,
is an async uffd event model to further optimize the replacement of
soft-dirty (which uffd already provides in O(1) instead of O(N)), so
the wrprotect fault won't have to block anymore until the uffd async
queue overflows. That also is unlikely to work with the sysctl set to
"2" without adding extra constraints that soft-dirty doesn't currently
have.

It would also be possible to implement the value "2" to work like
/proc/sys/kernel/unprivileged_bpf_disabled, so when you set it to "1"
as root, you can't set it to "2" or "0" and when you set it to "2" you
can't set it to "0", but personally I think it's unnecessary.

Thanks,
Andrea


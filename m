Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F46C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBB4206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvmYbToo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgGXNkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:40:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43436 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595598020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4TfOxZcpaEa2H+algx6u2vPL7TAVv/QDV7dH3yia8F8=;
        b=LvmYbTooDNM6h8L7aGM72f3PkdSNSzNOMLJh/5Cn8nByHuArLorvOZCgKV7DK+yNdYOto6
        ONtj/qfDd/BsQxNlzJh69dovBmk8T90JxpKNU9LUjzpMRMy4CGNqRyBA1h9jLI29TQ2qqY
        EybfYYgkf7sLwwPYggMXyf7+yYvRP7c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-j4KsudTFNDGx1Kcxo2JpHQ-1; Fri, 24 Jul 2020 09:40:15 -0400
X-MC-Unique: j4KsudTFNDGx1Kcxo2JpHQ-1
Received: by mail-wm1-f72.google.com with SMTP id y204so3989811wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4TfOxZcpaEa2H+algx6u2vPL7TAVv/QDV7dH3yia8F8=;
        b=bI9iYp4vc7HXRe+uAoGREtAUG0JIkZ47GKtWBkm+XKc5xM98sLWP58jL0rvf5erVVj
         3O08ozPQV4pEE65G5xTjdEkSxV8vWuF0f/WjtUGZW7eKAvAX2gK1EhQn4zP7ayl5XAeW
         g5yb2VY/X7ed1n2nU+hqDRDpjR+ho+YbNPzllRfnS3c006actyRxYE27YJgSxlTEbi5y
         4d+/Je4kJiXZ4yF6zPVR7D+2IvCsYbjR0kVXD32D7IuHdNJKDmkQfhlhGGJUKo3esJ7H
         DJkHu8TYM/PG994gCF0G8zwNpsnWJC1zF/+ebMJIxBtGWNeWEmRe1IdyLxOprHdort6J
         WOfw==
X-Gm-Message-State: AOAM530RnkjlokramA91NZIGJxqTKHf7DtdkYQO+3MrGPmZhKjpiTKF4
        I1MQUnNALbSJhyQGjcGTEkieA+bO1xXaRblQHjuxic0g7h6QJWCTYj4xDUDN5jBvMF180VuKw2x
        /TE69eOfhiJ4XPyFg9F1ZPC6u
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr8284229wmn.167.1595598013758;
        Fri, 24 Jul 2020 06:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8VnPXgqsoyC3ar0bB0O+0jlqCGTVMV4CCiYSeCno416YIN+T+netDRLs95hc35Ar3veFxTA==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr8284184wmn.167.1595598013471;
        Fri, 24 Jul 2020 06:40:13 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id p14sm1473367wrx.90.2020.07.24.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:40:12 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:40:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nick Kralevich <nnk@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com,
        Daniel Colascione <dancol@dancol.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200724093852-mutt-send-email-mst@kernel.org>
References: <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com>
 <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com>
 <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com>
 <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:13:28PM -0700, Nick Kralevich wrote:
> On Thu, Jul 23, 2020 at 10:30 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > From the discussion so far it seems that there is a consensus that
> > patch 1/2 in this series should be upstreamed in any case. Is there
> > anything that is pending on that patch?
> 
> That's my reading of this thread too.
> 
> > > > Unless I'm mistaken that you can already enforce bit 1 of the second
> > > > parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> > > > would be more a question to the Android userland team.
> > > >
> > > > The question would be: does it ever happen that a seccomp filter isn't
> > > > already applied to unprivileged software running without
> > > > SYS_CAP_PTRACE capability?
> > >
> > > Yes.
> > >
> > > Android uses selinux as our primary sandboxing mechanism. We do use
> > > seccomp on a few processes, but we have found that it has a
> > > surprisingly high performance cost [1] on arm64 devices so turning it
> > > on system wide is not a good option.
> > >
> > > [1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
> 
> As Jeff mentioned, seccomp is used strategically on Android, but is
> not applied to all processes. It's too expensive and impractical when
> simpler implementations (such as this sysctl) can exist. It's also
> significantly simpler to test a sysctl value for correctness as
> opposed to a seccomp filter.

Given that selinux is already used system-wide on Android, what is wrong
with using selinux to control userfaultfd as opposed to seccomp?


> > > >
> > > >
> > > > If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> > > > subject) should be enforceable with minor changes to the BPF
> > > > assembly. Otherwise it'd require more changes.
> 
> It would be good to understand what these changes are.
> 
> > > > Why exactly is it preferable to enlarge the surface of attack of the
> > > > kernel and take the risk there is a real bug in userfaultfd code (not
> > > > just a facilitation of exploiting some other kernel bug) that leads to
> > > > a privilege escalation, when you still break 99% of userfaultfd users,
> > > > if you set with option "2"?
> 
> I can see your point if you think about the feature as a whole.
> However, distributions (such as Android) have specialized knowledge of
> their security environments, and may not want to support the typical
> usages of userfaultfd. For such distributions, providing a mechanism
> to prevent userfaultfd from being useful as an exploit primitive,
> while still allowing the very limited use of userfaultfd for userspace
> faults only, is desirable. Distributions shouldn't be forced into
> supporting 100% of the use cases envisioned by userfaultfd when their
> needs may be more specialized, and this sysctl knob empowers
> distributions to make this choice for themselves.
> 
> > > > Is the system owner really going to purely run on his systems CRIU
> > > > postcopy live migration (which already runs with CAP_SYS_PTRACE) and
> > > > nothing else that could break?
> 
> This is a great example of a capability which a distribution may not
> want to support, due to distribution specific security policies.
> 
> > > >
> > > > Option "2" to me looks with a single possible user, and incidentally
> > > > this single user can already enforce model "2" by only tweaking its
> > > > seccomp-bpf filters without applying 2/2. It'd be a bug if android
> > > > apps runs unprotected by seccomp regardless of 2/2.
> 
> Can you elaborate on what bug is present by processes being
> unprotected by seccomp?
> 
> Seccomp cannot be universally applied on Android due to previously
> mentioned performance concerns. Seccomp is used in Android primarily
> as a tool to enforce the list of allowed syscalls, so that such
> syscalls can be audited before being included as part of the Android
> API.
> 
> -- Nick
> 
> -- 
> Nick Kralevich | nnk@google.com


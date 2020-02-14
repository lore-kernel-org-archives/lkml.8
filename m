Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A61C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA292168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vrn2eOFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392020AbgBNRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:21:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35932 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391849AbgBNRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:21:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so10132030oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyrhKNeMU7eJT6PQUqEykdJHGU1Beqa7yTElEjUp1E0=;
        b=Vrn2eOFlzFF/53jUFp1t0oYF9TfJcGmQyncWKIriM2ZXKwsnnVwXyPEwMYBT9SoOvv
         M9+pzijsccF6LKpwqVNwH7arNG/hJkR82XFRmVPyeQfsr2WEzgiC7PjODsswCoLGSpaY
         LaKRFh+AbvxODIzDTc9/KjTYvCJBjUXvMcY0lndjCM6xdnpAlg8uqBx3b/me3q46lm3g
         3BVL3n1uIIzcduNMraAfMFs20elqdxaKxcGWiqzInJy8oFts0UuFlfQstgm5hh/nVuyG
         KEqS6DZpZ/3ejce9GGRl8uDlBf7GeSu1Ldi9wOUcn9yptQaljIzYAeog+BBmqeGJgZ48
         s6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyrhKNeMU7eJT6PQUqEykdJHGU1Beqa7yTElEjUp1E0=;
        b=dJ2LePilXPZPJ4kBypeayIbvXjDy+yDSaexCUnE0KfZMrMeJwBVlljaJC8voPu/25M
         uVCzkwG4S9ih3btWfEw5/ps7ILNVNHOcNqHdFYXA4P/zzilZTt/9Zj47PkwlPeRXcxPY
         fMPnX0JuKCCTTL1uCms9kaKYeYi0pzIwSbXGQRnToCWDkjRTxNTjw7zxgTgudAZ6YZ6f
         Eeft4ywM8/ieKIjJXCXf+y/OhWOUyRi5C3pWuKO3GbUQowSTaZo+zKfqJ5PujTs3Eqrq
         67QlgnhnB/sDUgf72/nosn9o8nLmFshYe/QgKc9dwHMZNjDfh2aeUic8AlBkP8pi1T3E
         s1wQ==
X-Gm-Message-State: APjAAAUNNVHap0c7c8xqNj78OgcU0i4DlB9q/vT0xV55wFcJFgx5Xh+7
        VsLGZxIbgycU9zbjHXlQeFKrGeE1V9xEgTE640n1rQ==
X-Google-Smtp-Source: APXvYqzW5wCMUPDZUW8FlhlD0lFevf/gsf9pfcTNJvNRaLJB2Qb+Yl5ryjulc4AOX27A438sIlR0pFuhqlw/4hCWscQ=
X-Received: by 2002:a54:458d:: with SMTP id z13mr2670272oib.32.1581700902393;
 Fri, 14 Feb 2020 09:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200214032635.75434-1-dancol@google.com>
 <20200214032635.75434-3-dancol@google.com> <9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov>
In-Reply-To: <9ca03838-8686-0007-0971-ee63bf5031da@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 14 Feb 2020 09:21:04 -0800
Message-ID: <CAKOZuev-=7Lgu35E3tzpHQn0m_KAvvrqi+ZJr1dpqRjHERRSqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Teach SELinux about anonymous inodes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, paul@paul-moore.com,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:38 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/13/20 10:26 PM, Daniel Colascione wrote:
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1659b59fb5d7..6de0892620b3 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2915,6 +2915,62 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >       return 0;
> >   }
> >
> > +static int selinux_inode_init_security_anon(struct inode *inode,
> > +                                         const struct qstr *name,
> > +                                         const struct file_operations *fops,
> > +                                         const struct inode *context_inode)
> > +{
> > +     const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +     struct common_audit_data ad;
> > +     struct inode_security_struct *isec;
> > +     int rc;
> > +
> > +     if (unlikely(IS_PRIVATE(inode)))
> > +             return 0;
>
> This is not possible since the caller clears S_PRIVATE before calling
> and it would be a bug to call the hook on an inode that was intended to
> be private, so we shouldn't check it here.
>
> > +
> > +     if (unlikely(!selinux_state.initialized))
> > +             return 0;
>
> Are we doing this to defer initialization until selinux_complete_init()
> - that's normally why we bail in the !initialized case?  Not entirely
> sure what will happen in such a situation since we won't have the
> context_inode or the allocating task information at that time, so we
> certainly won't get the same result - probably they would all be labeled
> with whatever anon_inodefs is assigned via genfscon or
> SECINITSID_UNLABELED by default.
> If we instead just drop this test and
> proceed, we'll inherit the context inode SID if specified or we'll call
> security_transition_sid(), which in the !initialized case will just
> return the tsid i.e. tsec->sid, so it will be labeled with the creating
> task SID (SECINITSID_KERNEL prior to initialization).  Then the
> avc_has_perm() call will pass because everything gets allowed until
> initialization. So you could drop this check and userfaultfds created
> before policy load would get the kernel SID, or you can keep it and they
> will get the unlabeled SID.  Preference?

The kernel SID seems safer. Thanks for the explanation!

> > +
> > +     isec = selinux_inode(inode);
> > +
> > +     /*
> > +      * We only get here once per ephemeral inode.  The inode has
> > +      * been initialized via inode_alloc_security but is otherwise
> > +      * untouched.
> > +      */
> > +
> > +     if (context_inode) {
> > +             struct inode_security_struct *context_isec =
> > +                     selinux_inode(context_inode);
> > +             if (IS_ERR(context_isec))
> > +                     return PTR_ERR(context_isec);
>
> This isn't possible AFAICT so you don't need to test for it or handle
> it.  In fact, even the test for NULL in selinux_inode() is bogus and
> should get dropped AFAICT; we always allocate an inode security blob
> even before policy load so it would be a bug if we ever had a NULL there.

Thanks. Will fix.

> > +             isec->sid = context_isec->sid;
> > +     } else {
> > +             rc = security_transition_sid(
> > +                     &selinux_state, tsec->sid, tsec->sid,
> > +                     SECCLASS_FILE, name, &isec->sid);
> > +             if (rc)
> > +                     return rc;
> > +     }
>
> Since you switched to using security_transition_sid(), you are not using
> the fops parameter anymore nor comparing with userfaultfd_fops, so you
> could drop the parameter from the hook and leave the latter static in
> the first patch.

That's true, but I figured different LSMs might want different rules
that depend on the fops. I'm also okay with removing this parameter
for now, since we're not using it.

> That's assuming you are ok with having to define these type_transition
> rules for the userfaultfd case instead of having your own separate
> security class.  Wondering how many different anon inode names/classes
> there are in the kernel today and how much they change over time; for a
> small, relatively stable set, separate classes might be ok; for a large,
> dynamic set, type transitions should scale better.

I think we can get away without a class per anonymous-inode-type. I do
wonder whether we need a class for all anonymous inodes, though: if we
just give them the file class and use the anon inode type name for the
type_transition rule, isn't it possible that the type_transition rule
might also fire for plain files with the same names in the last path
component and the same originating sid? (Maybe I'm not understanding
type_transition rules properly.) Using a class to encompass all
anonymous inodes would address this problem (assuming the problem
exists in the first place).

> We might still need
> to create a mapping table in SELinux from the names to some stable
> identifier for the policy lookup if we can't rely on the names being stable.

Sure. The anonymous inode type names have historically been stable,
though, so maybe we can just use the names from anon_inodes directly
for now and then add some kind of remapping if we want to change those
names in the core, remaping to the old name for SELinux
type_transition purposes.

Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7515C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EFE204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2gEr4aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgETSDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgETSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:03:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F94C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:03:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f15so1664879plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4gedS5z2xUBNPz+Ub7NmjuaMewCM/6KJ5Nb+BZM0cYA=;
        b=i2gEr4aClpisfvaW3sWRRYnHudnywtDQIglybb1KsEhteuY0ZA+C5QXF9Vn2+gfm4u
         aSgjm29EaaoEB1GVZMwTIr4V930XxzwhlTKSlKueYKSueV5uUB5mb74Pj/mS9rSioi3z
         wlv2GINuwEzIenvfv+tdIb2MObGfqp9IcxGH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gedS5z2xUBNPz+Ub7NmjuaMewCM/6KJ5Nb+BZM0cYA=;
        b=mp4EACrsY99KRR+s4i+58M5vxNpSgR+ml0poE4JY3Ie7XfuvUp7soHRywI+1vSKRV9
         yPk9TeD4kvUIDy+AWKJCEs/PEdrX6eVH9+tPsTh1ft31poJm0Wkz0+dtFwVLi3EAs1+X
         VKtcZpYS601X+DDwKOGcPovYjq3I18BrauNI0qCciemhCN2WldqazrqieC2k5ufkeq6W
         V9ejMSZrguJbEnzI1hndkyxm9jh2dgC/Ko7RqS47hHASiquWkKevmLNDHFj1J3JkXWdS
         1DAo8MWiw8zgAmq5ObudNbn8ZmIwQ7exVW5wYD6uIkko/b6R6YQaHQwq8kp4WLvrasCR
         eBtQ==
X-Gm-Message-State: AOAM533am+QHxGPHlG9VDpTdqZXkxTJBkTi8rQdCSfV5dCXoyoszhjBg
        xuPM5N8jBn6Gjr5kxyQ2Uass/A==
X-Google-Smtp-Source: ABdhPJywSUMv3OTUOybuNLK/NiW3pp8eDXdsEFZpG/7jR7fa0zoJ1fFAxDsUgkID05OkZNOsz/CHKg==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7mr5718198plb.136.1589997821983;
        Wed, 20 May 2020 11:03:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm2389595pgg.17.2020.05.20.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:03:40 -0700 (PDT)
Date:   Wed, 20 May 2020 11:03:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <202005200921.2BD5A0ADD@keescook>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
 <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520045938.GC26186@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:59:38AM -0400, Andrea Arcangeli wrote:
> Hello everyone,
> 
> On Fri, May 08, 2020 at 12:54:03PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 08, 2020 at 12:52:34PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> > > > This sysctl can be set to either zero or one. When zero (the default)
> > > > the system lets all users call userfaultfd with or without
> > > > UFFD_USER_MODE_ONLY, modulo other access controls. When
> > > > unprivileged_userfaultfd_user_mode_only is set to one, users without
> > > > CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
> > > > will fail with EPERM. This facility allows administrators to reduce
> > > > the likelihood that an attacker with access to userfaultfd can delay
> > > > faulting kernel code to widen timing windows for other exploits.
> > > > 
> > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > 
> > > The approach taken looks like a hard-coded security policy.
> > > For example, it won't be possible to set the sysctl knob
> > > in question on any sytem running kvm. So this is
> > > no good for any general purpose system.

Not all systems run unprivileged KVM. :)

> > > What's wrong with using a security policy for this instead?
> > 
> > In fact I see the original thread already mentions selinux,
> > so it's just a question of making this controllable by
> > selinux.
> 
> I agree it'd be preferable if it was not hardcoded, but then this
> patchset is also much simpler than the previous controlling it through
> selinux..
> 
> I was thinking, an alternative policy that could control it without
> hard-coding it, is a seccomp-bpf filter, then you can drop 2/2 as
> well, not just 1/6-4/6.

Err, did I miss a separate 6-patch series? I can't find anything on lore.

> 
> If you keep only 1/2, can't seccomp-bpf enforce userfaultfd to be
> always called with flags==0x1 without requiring extra modifications in
> the kernel?

Please no. This is way too much overhead for something that a system
owner wants to enforce globally. A sysctl is the correct option here,
IMO. If it needs to be a per-userns sysctl, that would be fine too.

> Can't you get the feature party with the CAP_SYS_PTRACE capability
> too, if you don't wrap those tasks with the ptrace capability under
> that seccomp filter?
> 
> As far as I can tell, it's unprecedented to create a flag for a
> syscall API, with the only purpose of implementing a seccomp-bpf
> filter verifying such flag is set, but then if you want to control it
> with LSM it's even more complex than doing it with seccomp-bpf, and it
> requires more kernel code too. We could always add 2/2 later, such
> possibility won't disappear, in fact we could also add 1/6-4/6 later
> too if that is not enough.
> 
> If we could begin by merging only 1/2 from this new series and be done
> with the kernel changes, because we offload the rest of the work to
> the kernel eBPF JIT, I think it'd be ideal.

I'd agree that patch 1 should land, as it appears to be required for any
further policy considerations. I'm still a big fan of a sysctl since
this is the kind of thing I would absolutely turn on globally for all my
systems.

-- 
Kees Cook

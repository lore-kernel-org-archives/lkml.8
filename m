Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD62E24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8Uvap6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgA1MUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:20:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39906 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgA1MUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:20:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id z2so10078949oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 04:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdMgsrTiGncdYOgcbUb9mlCe9olQ7xYagcxpFIcd6+E=;
        b=j8Uvap6kQWXoH1g7T0rcgZ04DrKktnfIlbnAjWMfP6Xff15gUkzPDQyaJudmsL1yDt
         Pb+vDR13QDZ1Ao2bxVflMcVglbNMcWn9vAZMCrxHoLBYDoD6bY2lDG7asXPOG50omDI8
         dk5DIW0lN8yO+3QsjLezBreSJU6k/SztMUCNHfHgKIc2Cg5MDJi/GcJ/7WIZcrVJi1kh
         0zHT2ERZ9mrZaEMn2TbChsjOz7VewVpcBB1/Yf2BzW2fvghPbhLKD4ANgvNUlOkS8sa8
         /8X4lSS3iRshCXuyTobDjzOHPqKpmwm1o88j0yDlyTev/lDOnbA4duQ/Ybwk7zHH2N3s
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdMgsrTiGncdYOgcbUb9mlCe9olQ7xYagcxpFIcd6+E=;
        b=k5Rxh+su/EZ7gey4bnjY723gVPz94CzlM6oXdH8+jiMkq1MN03Gh1CYCCm/ORjNfb5
         SsifWrUl/BigYLZeeN0FhoF4Czrcb6jH0qg8lns07vfyx3DGVeGOXTwBaFIfii8zI3R7
         S8d/2aQpmCt+FeBb1dVX0W9fUzLyW9dUb8jfAiO2tI/UdmRaIuaSuyUYE6KMB5+5rkPf
         dla+pEKXjlwoJgmSpLtOIkfUTboesJ4ddxFHJH2RIlhGo0q2x8rp6k6QJOvZowuWVP/P
         srBU6kZ9S+XDk9lYfj8fm/m2gW+29v7aDweIOrYsdrOqS2o3A87xvCTtLeJ2anSiLBXy
         cbkA==
X-Gm-Message-State: APjAAAWGw66yYLrZ1ICRa55n/r75Ww0J9nujW/+G8BjRpDzjeXNUwIpq
        0NHBbG0NsUrlhau+/KEY3nKlizD61e/hLGRj/DrI2w==
X-Google-Smtp-Source: APXvYqwwSdhkpILefSxxqrnVL+VKYNPBwrpZU6sJ2/ZVOmEzczQj7qFdKeGZ86K4BmlSR3uvTKTfV/rKVZTC9oqDg/Y=
X-Received: by 2002:a54:4716:: with SMTP id k22mr2625237oik.39.1580214023416;
 Tue, 28 Jan 2020 04:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20200128072740.21272-1-frextrite@gmail.com> <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128114818.GA17943@redhat.com>
In-Reply-To: <20200128114818.GA17943@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Jan 2020 13:19:56 +0100
Message-ID: <CAG48ez2rJZGQyhOcgWe7NwLOxk-CBJugUFMM0Oa9JyuPamRwCg@mail.gmail.com>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Amol Grover <frextrite@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:48 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 01/28, Jann Horn wrote:
> > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> >
> > task_struct.cred doesn't actually have RCU semantics though, see
> > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > it would probably be more correct to remove the __rcu annotation?
>
> Yes, but get_task_cred() assumes it has RCU semantics...

Oh, huh. AFAICS get_task_cred() makes no sense semantically, and I
think it ought to be deleted.


There are the following users at the moment:

rdtgroup_task_write_permission() - uses it for acting on a task as
object, should be using objective credentials instead.

__cgroup1_procs_write() - same thing.

task_state() - should also be using objective credentials instead, you
wouldn't want a task to show up as belonging to root in there just
because it's in the middle of some overlayfs filesystem method or
something like that.

apparmor_getprocattr() - same thing as for task_state()

rpcauth_bind_root_cred() - should also be using objective credentials
instead, if init is in overlayfs or whatever, you probably wouldn't
want that to have an effect here

prepare_kernel_cred() - most callers pass NULL and don't hit this
codepath, and those that don't pass NULL use `current`, so there can
be no concurrent modification. Maybe this could be rewritten to
something like this:

if (daemon) {
  BUG_ON(daemon != current);
  old = get_current_cred();
} else {
 ...
}

or maybe it could just use the objective creds, it shouldn't matter
here, I think.

> To be honest I didn't know we have this helper.

Same here.

> Can't it race with revert_creds() in
> do_faccessat() ?

Yeah, I think you can probably trigger use-after-free reads with that.
I also remember seeing something fishy in Smack at some point that had
similar issues... smack_file_send_sigiotask() does
smk_of_task(smack_cred(tsk->cred)), which looks very wrong.

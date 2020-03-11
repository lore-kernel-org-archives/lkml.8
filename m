Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC95C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FC32073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkrnUftX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgCKRqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:46:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41094 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgCKRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:46:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id o10so3306580ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlpzXRhsMRDH1YY7GqVuVp0TT22uI+TLEFO2W2lrSms=;
        b=bkrnUftXBQZT9mtbI/EX+cveDpBLPJw5YgtyI66gzgie3phE0v0QHsOzjvTZVZ9Sk5
         LZ2SeHAHTgtVv59iU8D+Q7y72uG/GpzZXa2WL2mVl0sVqSY9OOVxXTrzzW8TJ3QRqwR9
         D3x7FIW1oNXUbRu0geCKaQRCITuGpqDhunFslSWLg1b6t8soT29RKgj1UEZczzHuamxP
         yr+uoZzFijDhwi/CPUOKKeXaPBi1t9Y7X22XObnK9HSc8gmO1V2npZZUMOpOPRT7DKRu
         Erbbj3Pp4Dkg6QYdOABx0A91KfBGxJP1nWbHQGaUBWPLpbU60f66M0QrmL1Q2AQsT5hk
         kJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlpzXRhsMRDH1YY7GqVuVp0TT22uI+TLEFO2W2lrSms=;
        b=MNLjLetse+WFozw0d4/oeyQjqyuHOsszLPKInj9JVKsA18PgfRAHYZ9SSZun9O5/NG
         cWmViFc2yYfE77NXeGTZAljAc0ErnxCY6PZtM6j3jtaUQPPiEwl+iDawtCHPsGOOmh9V
         Bd/abr34Q72wyFwJUwhkTea4o/Yq4x3YeQjIpaPbAs0aQMJ3n+Bx21R+A/juk4upj/bC
         +Yc3sq9GspMOOFWzxgtUkbFNcuhS9VOZ0tVUZ7y9w8sj6BswwCd9GMYHy2doTIXf3pvG
         g/mkfeE9vZ1izYmQSj/Gg3Yel7DGRg0Aaq4/CVtju3OCte38C4Wh08b0s+4lGyBV5P5j
         4t3g==
X-Gm-Message-State: ANhLgQ13i3fDzd1Lgx5FDpeIqhDGJsBHKmyLGdhXA21aEvXuJ35xJylv
        YJ62BvMsJ1R/7fCECx6vOWmUfeYIo68c+QmE9nzClg==
X-Google-Smtp-Source: ADFU+vuv+Ke3zgGZnAERPw2KandsCR0n/RBp6MbjM/E+G39q41RYqt5YG3ZNzNUI16R+eGmxfkbQj35WzkWRmnMEg4Q=
X-Received: by 2002:a2e:800a:: with SMTP id j10mr2690722ljg.23.1583948811038;
 Wed, 11 Mar 2020 10:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200219183231.50985-1-balejs@google.com> <20200303134855.GA186184@mtj.thefacebook.com>
In-Reply-To: <20200303134855.GA186184@mtj.thefacebook.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 11 Mar 2020 10:46:15 -0700
Message-ID: <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
To:     Tejun Heo <tj@kernel.org>
Cc:     Marco Ballesio <balejs@google.com>, Roman Gushchin <guro@fb.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pm@vger.kernel.org, Minchan Kim <minchan@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 5:48 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Feb 19, 2020 at 10:32:31AM -0800, Marco Ballesio wrote:
> > @@ -94,6 +94,18 @@ The following cgroupfs files are created by cgroup freezer.
> >    Shows the parent-state.  0 if none of the cgroup's ancestors is
> >    frozen; otherwise, 1.
> >
> > +* freezer.killable: Read-write
> > +
> > +  When read, returns the killable state of a cgroup - "1" if frozen
> > +  tasks will respond to fatal signals, or "0" if they won't.
> > +
> > +  When written, this property sets the killable state of the cgroup.
> > +  A value equal to "1" will switch the state of all frozen tasks in
> > +  the cgroup to TASK_INTERRUPTIBLE (similarly to cgroup v2) and will
> > +  make them react to fatal signals. A value of "0" will switch the
> > +  state of frozen tasks to TASK_UNINTERRUPTIBLE and they won't respond
> > +  to signals unless thawed or unfrozen.
>
> As Roman said, I'm not too sure about adding a new cgroup1 freezer
> interface at this point. If we do this, *maybe* a mount option would
> be more minimal?

I'd still prefer a cgroup flag. A mount option is a bigger
compatibility risk and isn't really any simpler than another cgroup
flag. A mount option will affect anything using the cgroup mount
point, potentially turning non-killable frozen processes into killable
ones unexpectedly. (Sure, you could mount multiple times, but only one
location is canonical, and that's the one that's going to get the flag
flipped.) A per-cgroup flag allows people to opt into the new behavior
only in specific contexts, so it's safer.

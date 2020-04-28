Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7FC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94806208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAN0XTlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgD1S3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729252AbgD1S2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:28:50 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C0C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:28:50 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id u12so22422046uau.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/XwBbLkEh8phQ95fLV4nvFtsIP3mkVsJnj8xG8scE8=;
        b=WAN0XTlq4dxb8wrs+nT2PbnjlpSq7chuyteuwEMn96/7AOOGem7ekWgRWtzAvwOzKx
         PKFEOhSLdIedo07x1i2sgt8oyyJVlNtGLZf2UUelfLvgsNssf6PmkU/DZOSBku1fn+48
         OM/Cs9HsIxN93Hr7u/8WWv4Agtv+tZ1dsW6Q2da3fFo5tr21cwe46RREHNZ+xX5al3vc
         8CgYRONb/4XpoVwHbTiEaaGAM13dU9pdzGwGllHcJv63WrOlrHJggnIDErviQ0HrASH8
         qChjz/di+PTzVhNl9LYssncj5PLEW3HyAkC6Z3wvqpUtoCSTnIBS7n/Srba0s14wbwcU
         uRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/XwBbLkEh8phQ95fLV4nvFtsIP3mkVsJnj8xG8scE8=;
        b=dqloDcinq6pxskcGRIiONyE2SnGHGukfA+FBiIxTLOG8D2I2OCzr+iIeCyO+5DIEwz
         AOurmtGfczK90pvjPuDW+79bJmaZDTuYzukBiMhA0qJCEGNdbrmwCysoMHy41ThFfuf5
         iFyr5gOLQj9K4aHm3JQVBZqtzR2DFSVOtu8PR7rKJz1yUp69POF3gojp60pQ1DhUK7cV
         GYSJCPR6Ven9qy9BgUGRujLYOkyOoMrGZrfUi/FpRkxtekkPxgU8wtzQmk2zoNTj2L1X
         0gsrU0HsGBLOEmPpBlxTdsZC9hoEDBtmeoCotsKBm8XOHmEtzp2LysopJRfjf+hzWJoK
         0w8w==
X-Gm-Message-State: AGi0PuYzFT9VQ3WexVwamCOuFxXxBDsiSJvY2WHtE3LYL4SKQCB+V4td
        L29Decl4KIqzQ7afr7o/6itsND7YAHF20hYdCvPZ2esZ3Ok=
X-Google-Smtp-Source: APiQypIPLpbzHNNLZpXEAf+650jmQB3r/F3EhRmGSbAU3pN+aqynUxnOr1EpW493XzMnY2Q7G6nEyiS9OKt8CKFC2NA=
X-Received: by 2002:a67:dd98:: with SMTP id i24mr23242699vsk.239.1588098529151;
 Tue, 28 Apr 2020 11:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153859.GA1481119@chrisdown.name> <CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com>
 <CAJuCfpFhsN1=kDK0tU8aWeNt5Dj6U_1rC_dVT-27a4TL_hF0gA@mail.gmail.com> <20200428113456.GA2170292@chrisdown.name>
In-Reply-To: <20200428113456.GA2170292@chrisdown.name>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 28 Apr 2020 11:28:37 -0700
Message-ID: <CAJuCfpH+einwioO4bKxFaE0jPKDgFG5P2+fx-4D6OvKst9dvVQ@mail.gmail.com>
Subject: Re: PSI poll() support for unprivileged users
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 4:34 AM Chris Down <chris@chrisdown.name> wrote:
>
> Hey Suren,
>
> Suren Baghdasaryan writes:
> >> > I'm building a userspace daemon for desktop users which notifies based on
> >> > pressure events, and it's particularly janky to ask people to run such a
> >> > notifier as root: the notification mechanism is usually tied to the user's
> >> > display server auth, and the surrounding environment is generally pretty
> >> > important to maintain. In addition to this, just in general this doesn't feel
> >> > like the kind of feature that by its nature needs to be restricted to root --
> >> > it seems reasonable that there would be unprivileged users which want to use
> >> > this, and that not using RT threads would be acceptable in that scenario.
> >>
> >> For these cases you can provide a userspace privileged daemon that
> >> will relay pressure notifications to its unprivileged clients. This is
> >> what we do on Android - Android Management Server registers its PSI
> >> triggers and then relays low memory notifications to unprivileged
> >> apps.
> >> Another approach is taken by Android Low Memory Killer Daemon (lmkd)
> >> which is an unprivileged process but registers its PSI triggers. The
> >> trick is that the init process executes "chmod 0664
> >> /proc/pressure/memory" from its init script and further restrictions
> >> are enforced by selinux policy granting only LMKD write access to this
> >> file.
> >>
> >> Would any of these options work for you?
>
> Hmm, I think these are reasonable options when you have control over the
> system, but not so great if you don't. For example, I want to get pressure
> notifications for my logind seat, but that doesn't necessarily imply that I
> have administrative access to the machine.
>
> >> > Have you considered making the per-cgroup RT threads optional? If the
> >> > processing isn't done in the FIFO kthread for unprivileged users, I think it
> >> > should be safe to allow them to write to pressure files (perhaps with some
> >> > additional limits or restrictions on things like the interval, as needed).
> >>
> >> I didn't consider that as I viewed memory condition tracking that
> >> consumes kernel resources as being potentially exploitable. RT threads
> >> did make that more of an issue but even without them I'm not sure we
> >> should allow unprivileged processes to create unlimited numbers of
> >> triggers each of which is not really free.
>
> There's precedent for other similar issues like this in the kernel, eg. rates
> for some ICMP packets, where we enforce a static limit in the kernel for
> unprivileged users. I'd imagine we can do something similar here, too.
>
> >Thinking some more about this. LMKD in the above-mentioned usecase is
> >not a privileged process but it is granted access to PSI triggers by a
> >privileged init process+sepolicy and it needs RT threads to react to
> >memory pressure promptly without being preempted. If we allow only the
> >privileged users to have RT threads for PSI triggers then that
> >requirement would break this scenario and LMKD won't be able to use RT
> >threads.
>
> Well, fiddlesticks :-)
>
> If we needed to have both, I don't know what the interface would look like, but
> yes, it sounds overcomplicated. I'll think about it some more.

Yeah, the only idea I could come up with was to tie RT thread usage to
some selinux policy instead of using file permissions or being root.
But I have very little experience with selinux to tell you whether
there might be issues with such an approach.

>
> Thanks,
>
> Chris

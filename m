Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72187C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B95920792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591993014;
	bh=QUC9Vj/fPspnjGFKP3D4+NQHhBpL1neIBtQNzVUWW4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LDea6K+63v1RcAF1PMRZPeg7GWy0pxm2e3143I3cmAdVuikAvFl1MqwDZfJBffVrX
	 E+ly73w8laKtT4Tk7BCvASNaVbSx9fajoO9i0yJfstl1g36irAe650tLiby+rLpgCE
	 rTsMPqy7kwMCUmJyknvOCzkH56SNuHlRgTzwDCxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:16:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C1C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:16:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so12459245ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjHcaOx4S1RfVqvh9kuI/Bcyvm42oiPgyVgZu0Sg6m4=;
        b=AfAWySfN821FeNR16WQmuw215qJR8AVMOkTfpVB24lCp6KOteA+4AblFeJWJG2aZPS
         MVQj9LgFumRvVDeZvVsJWoEVtPQuVl2/ODmbIUHAjSKxDelM38hAFwle+FhIZi+jVCR4
         KPuzs+SwqJKh0LF5IUO5bkcVXqzNsgfv1mW8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjHcaOx4S1RfVqvh9kuI/Bcyvm42oiPgyVgZu0Sg6m4=;
        b=FwHirTRqT7Pej3zzuhkvwd6H8CyDi7eSu232BtWRQQuuhPRCM/oclsEec9YwBl5EAr
         qHf3lBqYiCoFrlxVzGe3fZX+B4MBLksXJ10s5nJKXN5KPMVw5k2InBBUiazFsKDPSMm7
         PhX93IqsVe31kR++YWO1/YNriHqLarElFv5Zo184Kn8fm9LCPMj7GOd8Z07okwd6Fq3t
         bXKK4zswZLvedPKQvsTeRnJxUjJ/PT9UknHFh5uskbF5ScM/NND8JyQBETLX9too51Jx
         whJ34WcmiA1duo5SGgpSiePCUvyuOxIrHVPN/swdc4HvWjS5ClO6CSbqBSN5njN42/q+
         QYcQ==
X-Gm-Message-State: AOAM533KyXfCvfVwcVx+Xmk/g/koDWsIf6Ly3T37JSjLmYITLndNx9v0
        TkCUbLW1OgBlJ5RVrLWyuJDmLuxMpq4=
X-Google-Smtp-Source: ABdhPJyWpnCrUAFTGbWeNDPcp5gZvFzZJbFEEjMRxPTAhRSqHGvBgDX9qonkrRCkXJScuwtYWYX2+A==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr7981256ljl.130.1591993002394;
        Fri, 12 Jun 2020 13:16:42 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i24sm762804lfg.83.2020.06.12.13.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 13:16:41 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id e4so12523888ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:16:41 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr8089466ljj.312.1591993000764;
 Fri, 12 Jun 2020 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <875zc8kxyg.fsf@x220.int.ebiederm.org> <87zh9atx0x.fsf@x220.int.ebiederm.org>
 <871rmkozf5.fsf_-_@x220.int.ebiederm.org> <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
 <87v9jwm4s7.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9jwm4s7.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 13:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
Message-ID: <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
Subject: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I have a sense that a use after free that anyone can trigger could be a
> bit dangerous, and despite not being the only virtual filesystem in the
> kernel proc is the only virtual filesystem that called new_inode_pseudo.

So the reason I pulled that change despite my questions was that I do
agree with the whole "there's probably little point to use
new_inode_pseudo() here" argument.

But at the same time, I ghet the feeling that this partly just is
papering over the problem. If fsnotify causes problems with a
new_inode_pseudo() inode, then fsnotify should be _checking_ for that
case.

And if fsnotify were to check for it, then the reason for /proc to use
it would largely go away. Maybe the debug check for umount matters,
but honestly it doesn't really seem to be a big deal.

A pseudo-inode is basically independent of the filesystem it was
mounted as, so the generic_shutdown_super() check not triggering for
them is sensible, I feel.

But yeah, we could also make the rule go the other way, and simply
make sure that "new_inode_pseudo()" itself checks that the super-block
you give it is something fundamenally unmountable and was created with
'kern_mount()'.

That would have also figured out that the /proc case was broken.

So the main objection I have here is really that this fix feels
incomplete, and doesn't really reflect the underlying issue, just
fixes the symptom.

Either the underlying issue is that you shouldn't call 'fsnotify' on
/proc, or the underlying issue is that /proc was using a bad inode and
nobody even noticed until the fsnotify issue.

This is not a huge deal. I think you've fixed the bug, I just have
this itch that the thing that triggered it shouldn't have happened in
the first place.

             Linus

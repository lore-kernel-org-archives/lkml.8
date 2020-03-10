Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B84A215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0WefFmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCJTMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:12:13 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38762 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:12:12 -0400
Received: by mail-ot1-f53.google.com with SMTP id i14so14315570otp.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f/ZIdPcYSXzyxew8zIk4AJ4DOH6Pen1hOIrk5wOGuM=;
        b=J0WefFmTNOhOFZfuP45RhnlFcgePPbh0WTKAXHMYkK6WpB792ZvmtCF0IY9fwLL+D9
         JYJva+8s2L8brQt+mP0QlFI7Ubx3EtJuWV5oTHXRO+WY28LuJwAyn/8SxV+0Qyy7CD76
         /aczONR6PbSmyO4Jpl0ndluwcRjeuPxynXS2PAiNIKnzmcG8zQ+rRLwuSK3v7H/42U7s
         3gBiwksatm7XW6OgKd+S9mlSz2ZH4IjWEd7jU44IaTUcLYGy0AfPrWXWEqjPK8Ug+Ff/
         4HY4RTJ54vfJgBDg9xuGCcljL/Sz5iU602XYFQ1/oJw+1pqY892w0lM1AOzT3wGCOwp6
         gkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f/ZIdPcYSXzyxew8zIk4AJ4DOH6Pen1hOIrk5wOGuM=;
        b=hU2TL1EYilFCEZJVVYUMeBvX7nhHoOBlbaQUVgoB+EpYfxaCBd/lmWCzZbVMiv+Etc
         S6PsdNrgyAOlic2qao9TkMvfe7TklmNxiPN1ljstptfC9DBrinXAdcIZk/b2gdY+Q30Z
         DrxuTO+xMGzsXFKYEWcWNqpKAt/nlOmKDM379ZG2m4/gbSw0rG/ff2sx9SYv0ltJ+w3y
         q+6Y4+nCRUTnL5py9uZ9Sp0oq09vQs4ijfxdgQ5/QqHCDwmtKXRxoqztuGIJz8tBnuTc
         ci+KgfN0Jv/Wbb4CdtpxlOJuNjffK9nG4RAy7UQhd5VHB0ibVABV9c4QlJU8UUaX8meH
         gBDQ==
X-Gm-Message-State: ANhLgQ3c5WSFW67CdJNdG94VCqIDE9pWUCxBRImQaC0mzCEHGqEuji8H
        QRlZT1G9V1g+zOlUfs9dMMtXfGNl7CmU3zgAzDMDgQ==
X-Google-Smtp-Source: ADFU+vtpoR0syrUpVW9+sWGjnb2mV+Evtc2BNWvaZAC67ZRm+H1x48AKs6JQmohLa3X8uvKP9YzaVUlGmxjfz8k3eXs=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr17635080oti.32.1583867531366;
 Tue, 10 Mar 2020 12:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
In-Reply-To: <20200310184814.GA8447@dhcp22.suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 20:11:45 +0100
Message-ID: <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 7:48 PM Michal Hocko <mhocko@kernel.org> wrote:
> On Tue 10-03-20 19:08:28, Jann Horn wrote:
> > Hi!
> >
> > >From looking at the source code, it looks to me as if using
> > MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> > possible, even if other processes still have the same page mapped. Is
> > that correct?
> >
> > If so, that's probably bad in environments where many processes (with
> > different privileges) are forked from a single zygote process (like
> > Android and Chrome), I think? If you accidentally call it on a CoW
> > anonymous mapping with shared pages, you'll degrade the performance of
> > other processes. And if an attacker does it intentionally, they could
> > use that to aid with exploiting race conditions or weird
> > microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> > talks about "the assumption that attackers can provoke page faults or
> > microcode assists for (arbitrary) load operations in the victim
> > domain").
> >
> > Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> > pages with mapcount>1, or something like that? Or does it already do
> > that, and I just missed the check?
>
> I have brought up side channel attacks earlier [1] but only in the
> context of shared page cache pages. I didn't really consider shared
> anonymous pages to be a real problem. I was under impression that CoW
> pages shouldn't be a real problem because any security sensible
> applications shouldn't allow untrusted code to be forked and CoW
> anything really important. I believe we have made this assumption
> in other places - IIRC on gup with FOLL_FORCE but I admit I have
> very happily forgot most details.

Android has a "zygote" process that starts up the whole Java
environment with a bunch of libraries before entering into a loop that
fork()s off a child every time the user wants to launch an app. So all
the apps, and even browser renderer processes, on the device share
many CoW VMAs. See
<https://developer.android.com/topic/performance/memory-overview#SharingRAM>.

I think Chrome on Linux desktop systems also forks off renderers from
a common zygote process after initializing libraries and so on. See
<https://chromium.googlesource.com/chromium/src.git/+/master/docs/linux/zygote.md>.
(But they use a relatively strict seccomp sandbox that e.g. doesn't
permit MADV_PAGEOUT.)

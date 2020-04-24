Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071AC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D88320767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PE4Z7472"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDXWrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:47:06 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C7DC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 15:47:06 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z16so11183673uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqoWkPod62vtLldVs0viBwEcjaQG1uJSxCA5RSruES0=;
        b=PE4Z7472mC8WXJ/X3lwDxJorOxFO08Hc1GMdoUUHFUWaodhbxlDJRRVNXxU43yTpw2
         xePijjvNq+QmTNw+E4JgoTampdtfLoy4TQ7w/Genwb4fcJyWRqTmjmA6D5UywKSuLd83
         c7Tz7Q6Ap6O3eVuREMGaDpW6m+JldG8PgPBgeo1EMVoWvDlmCYUpi++5l0qyov31ch+M
         NdTzfuVbu3kj0h00LzriYIp6Dr1pDhlvH+LhKcfVRl29eXnqiAUaxu1SopvcEx9D1/11
         i6aegSyTnQuD/LfjCmLYnq9bSzA9aJE+JA6rg5JC8fLtsfFuqlnzmcz6Bgu6lKps09RD
         tEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqoWkPod62vtLldVs0viBwEcjaQG1uJSxCA5RSruES0=;
        b=FdoB7WABR9R8sLZQKYa61I81MaErEF4T+/LaPhvgdI/alcug57a7wQO6mASr9pljKP
         va+5fuxEaRLfEXHe5kJUSm0eNhee/HKZ2V7C23H4LsqxyffSnInYVWQPbuXRsv0UsIZg
         pkSwEri2JisROiLZWzcXujAVXEosr3g0JxPe1wxl7c8giBv4M9xUa50GeMJRGhKOVhBi
         tqbFNmAWL82XF12zup2YW5xaAl75Z1PKWnl2xyYqIrDV/dBw7o2l0HD5m9J9b89uU1Ko
         aFCVJqTRnyqiK6W0owDrV130ba4TJNk5dDCRu7XU7QK86r8AFr/Sv1ed4N0QtMcLkCFX
         2S7w==
X-Gm-Message-State: AGi0PuYpypspSR5ncXV7IDRCIwS1mTzK+JUAHQA/FZRGWMKMB/LTYdbq
        T2rUxi1fKEwlvgePv34OvgVKe2DdqxvULUc/HNgpaJu/9qF94w==
X-Google-Smtp-Source: APiQypLnEE+Tq5JlVfPxShpPVQjlJaXz7f9jkTd5X5SvO8G//da2iXMVpknaTOv6h0AWEB/gqn0ltx8T6zphRXQFZ9U=
X-Received: by 2002:ab0:485:: with SMTP id 5mr9514255uaw.86.1587768425431;
 Fri, 24 Apr 2020 15:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153859.GA1481119@chrisdown.name> <CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com>
In-Reply-To: <CAJuCfpGnJBEvQTUeJ_U6+rHmPcMjw_pPL+QFj7Sec5fHZPH67w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Apr 2020 15:46:54 -0700
Message-ID: <CAJuCfpFhsN1=kDK0tU8aWeNt5Dj6U_1rC_dVT-27a4TL_hF0gA@mail.gmail.com>
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

On Fri, Apr 24, 2020 at 12:43 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Apr 24, 2020 at 8:39 AM Chris Down <chris@chrisdown.name> wrote:
> >
> > Hi Suren,
>
> Hi Chris,
>
> >
> > I noticed that one restriction of the PSI poll() interface is that currently
> > only root can set up new triggers. Talking to Johannes, it seems the reason for
> > this was that you end up with a realtime kernel thread for every cgroup where a
> > trigger is set, and this could be used by unprivileged users to sap resources.
> >
>
> This reasoning is correct and IIRC the enforcement of this is just the
> way /proc/pressure files are created:
>
> proc_create("pressure/io", 0, NULL, &psi_io_fops);
> proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
> proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
>
> IOW there are no additional capability checks performed on the PSI
> trigger users.
>
> > I'm building a userspace daemon for desktop users which notifies based on
> > pressure events, and it's particularly janky to ask people to run such a
> > notifier as root: the notification mechanism is usually tied to the user's
> > display server auth, and the surrounding environment is generally pretty
> > important to maintain. In addition to this, just in general this doesn't feel
> > like the kind of feature that by its nature needs to be restricted to root --
> > it seems reasonable that there would be unprivileged users which want to use
> > this, and that not using RT threads would be acceptable in that scenario.
>
> For these cases you can provide a userspace privileged daemon that
> will relay pressure notifications to its unprivileged clients. This is
> what we do on Android - Android Management Server registers its PSI
> triggers and then relays low memory notifications to unprivileged
> apps.
> Another approach is taken by Android Low Memory Killer Daemon (lmkd)
> which is an unprivileged process but registers its PSI triggers. The
> trick is that the init process executes "chmod 0664
> /proc/pressure/memory" from its init script and further restrictions
> are enforced by selinux policy granting only LMKD write access to this
> file.
>
> Would any of these options work for you?
>
> > Have you considered making the per-cgroup RT threads optional? If the
> > processing isn't done in the FIFO kthread for unprivileged users, I think it
> > should be safe to allow them to write to pressure files (perhaps with some
> > additional limits or restrictions on things like the interval, as needed).
>
> I didn't consider that as I viewed memory condition tracking that
> consumes kernel resources as being potentially exploitable. RT threads
> did make that more of an issue but even without them I'm not sure we
> should allow unprivileged processes to create unlimited numbers of
> triggers each of which is not really free.

Thinking some more about this. LMKD in the above-mentioned usecase is
not a privileged process but it is granted access to PSI triggers by a
privileged init process+sepolicy and it needs RT threads to react to
memory pressure promptly without being preempted. If we allow only the
privileged users to have RT threads for PSI triggers then that
requirement would break this scenario and LMKD won't be able to use RT
threads.

>
> >
> > Thanks!
> >
> > Chris
>
> Thanks,
> Suren.

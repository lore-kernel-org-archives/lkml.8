Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3410C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55D5206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCTFDwlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCLPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:15:55 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45405 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:15:55 -0400
Received: by mail-oi1-f180.google.com with SMTP id v19so5794664oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSTFM8/WdvLF0ae3U5Pe/dfIhwqQ/fRGMD5U9ltFSU0=;
        b=qCTFDwluq+BMNWVlMj7j9pxcr8xJNHb/X3tPT6I/w+ZcHawky11wfNujEo51HzirkP
         AldXdYOGclnzlpfbSaL4BxbMgyWnOFy/Z+2TAzFteCz2//DJyDZhzBCjmRji13aIzRHi
         PW9IXXtafsjLnpwGdtnsxrA7UfSqvyKX/uwrgxh85dRh/yhj7iVwXWTe7SliAsjrRuhk
         8iUH0KPD/+MWIJ/42dn8jWer/B0rcVgDSp/N5gLydkrUpXX+SMahFDj53hCiy4AXYdt/
         2LMrJ5nDI5B3G1WS9taS27TPOtna6Bjbe6RAS9dLKrygImRFFdt4l7GQ8dfuiFTmlgCv
         4hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSTFM8/WdvLF0ae3U5Pe/dfIhwqQ/fRGMD5U9ltFSU0=;
        b=FuNId3ubnMux3Rk8pXRcZ9d3LBEiQjnaE1L/d7ReZghKKiJLkvIVxtvIJHNe/F1ch6
         rl8iQ1RyK3A+RDfKF4cnDKxokaBAIQoXBni4TWBVBpRfmCppp60Kz4AjF2pfVSJg6eQ8
         81Wnmi7fllc+P7UYPGxsfECFCM+WX5qElTZlOWN0+uJT8VP/FkFd+S0Lan7MNtldpGNc
         FeevKURiGDAJkuJDvN6GN2ZKijT2VbUEMmvukE+qB3id//i+WYyBetPflsXcOAIvaJff
         P5WYtiCmzWVn4x5Zf8y40YiKegKFR3+J+rwBB6ad1Gjviq4jcQn9Ugm7CL2okY/iq6wO
         BjLg==
X-Gm-Message-State: ANhLgQ1pQ2tMVsaSF/3JDyGGB/uiqzt2yiYS3nM7a2rQubR6OcU7lbkF
        BEXOJmnbTtZMi094ByNAZ4k5pseDGhxga1WGlEJfIw==
X-Google-Smtp-Source: ADFU+vs+ysDXPcJo7dLHwfyBtgXL38eh6PqTY+/HIUA4DU/FG8I4c7ikrHwIMLCoYVOWfG1TnP8Zk7M3cn13Ju51Bz8=
X-Received: by 2002:aca:af93:: with SMTP id y141mr2863661oie.144.1584026154099;
 Thu, 12 Mar 2020 08:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz> <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz> <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
 <20200311084513.GD23944@dhcp22.suse.cz> <CALvZod6b73_ay_kxph143Aj+XBq04Np0z2bK4Rfn8qppihrmTw@mail.gmail.com>
 <20200312001849.GA96953@google.com> <CAKOZuev1XzbsCPJtOA=v9QMuVpEBKc0_5ZE4Oc4tzmKdFHy2Dg@mail.gmail.com>
In-Reply-To: <CAKOZuev1XzbsCPJtOA=v9QMuVpEBKc0_5ZE4Oc4tzmKdFHy2Dg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 Mar 2020 08:15:42 -0700
Message-ID: <CALvZod6y87aJxq90p=99orPajxN30jOf_RohSw7OSRdrXg6-Ag@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 7:04 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Wed, Mar 11, 2020 at 5:18 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Wed, Mar 11, 2020 at 04:53:17PM -0700, Shakeel Butt wrote:
> > > On Wed, Mar 11, 2020 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> > > > > Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> > > > > only let it affect the *local* process.  We could still put the page in
> > > > > the swap cache, we just wouldn't go do the rmap walk.
> > > >
> > > > Is it really worth medling with the reclaim code and special case
> > > > MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
> > > > implementation that doesn't really touch shared pages because that can
> > > > lead to all sorts of hard to debug and unexpected problems. So I would
> > > > much rather go with a simple patch to check map count first and see
> > > > whether somebody actually cares about those shared pages and go from
> > > > there.
> > > >
> > > > Minchan, do you want to take my diff and turn it into the proper patch
> > > > or should I do it.
> > > >
> > >
> > > What about the remote_madvise(MADV_PAGEOUT)? Will your patch disable
> > > the pageout from that code path as well for pages with mapcount > 1?
> >
> > Maybe, not because process_madvise syscall needs more previliedge(ie,
> > PTRACE_MODE_ATTACH_FSCREDS) so I guess it would be more secure.
> > So in that case, I want to rely on the LRU chance for shared pages.
>
> I don't want the behavior of an madvise command to change depending on
> *how* the command is invoked. MADV_PAGEOUT should do the same thing
> regardless. If you want to allow purging of shared pages as well,
> please add a new MADV_PAGEOUT_ALL or something and require a privilege
> to use it.
>

I would like to have a way to pageout the shared pages and
MADV_PAGEOUT_ALL approach looks fine to me.

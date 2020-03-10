Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962EF2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtEB11BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJHj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:39:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34224 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCJHj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:39:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so3726652ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=906zhF/DpvO92DB5R6S0wKpZldy8rKqVy+oJ+1hJ7tc=;
        b=BtEB11BT+4+x6r+b85nmuZMZ8WSrwLKlB0krXkFlYtK/dt/V0+0cQ1Frx8fN6Hue/k
         QvYC/Ts8BlFWAQBRhsuef51j6c+dDP+y6aDpYkx37otX2Olc9aN5vNUYWR6YV72xgMsT
         RNe23fDPZUnMoYJsX8juilalfY8nmbt66QqhMJDDzumYkG6oewRtMqeD3d3TlWhpoP3Y
         NXMzqKMcG9SPa+YJIfKYc9xjsawr9XZtBwDQpQYcFFxbFXMoXR0C6j1P8JqrFIbbbj9w
         3Ct6dJ5klaUnlzXCxNHwm1MA2RYg5Kzf+H3jD+ykeX+Xw1CSjA0ZDv7Atcpx4qUJWfLX
         3BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=906zhF/DpvO92DB5R6S0wKpZldy8rKqVy+oJ+1hJ7tc=;
        b=mfNyz8msK5wG5Q+r1e1AkXVG3BInwuLXwVpbL8slLiRjzOZpXFockhaxIPoMcXk1gA
         ZFiLm27hH23LLzgLhSD3c7gQZuTusnmpXSBTH4MgoxS6CMd1gYFkVBnd9iMeLi/hgxZP
         eTq9lygmkKmbiqbRrE24f0Vu9WcJl2sQs5lxE8dsTsUW69p3BIq3azQgNc3wNRQRsZY2
         o8uEPtDAUHsKFAwG2cfm7fgkr/ix/dcwZLiPPI47wq1+3Q6AMK1Nq/a/Rg+aGG4iQDxU
         HABXx1RVqwjIiRfj2OyNhwhdIXH6k2Ju918Rcp43ku8lnzR59wjgGhYmAcKiHKgh0dsF
         gpIw==
X-Gm-Message-State: ANhLgQ0KnUkUddueZRiH+mgo3UQ7StNqKsoEGzwGzvU5a4U/s4cWsGH7
        qpWxVXG9u8uGBFOkPDdm0LsANYbp0ngZbYKcygo=
X-Google-Smtp-Source: ADFU+vtHLABgcs/RKfCTtvB3II9owxZ2QnhPDfOiSQ1n+T6t0IDdSv3kohhSda5dj81+KqxJIFnQjjP954hSrE7ioYY=
X-Received: by 2002:a2e:880d:: with SMTP id x13mr200983ljh.190.1583825993683;
 Tue, 10 Mar 2020 00:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200309113141.167289-1-shaju.abraham@nutanix.com>
 <20200309115818.GK8447@dhcp22.suse.cz> <CAGxeL8CxaeKsqEMtLMZL8mdxUXPcH6ZkpMNjUmzZJ6q603B-_g@mail.gmail.com>
 <20200309161230.GT8447@dhcp22.suse.cz>
In-Reply-To: <20200309161230.GT8447@dhcp22.suse.cz>
From:   Shaju Abraham <shajunutanix@gmail.com>
Date:   Tue, 10 Mar 2020 13:09:42 +0530
Message-ID: <CAGxeL8B97OUFaceKW9g95CpwULfLO8HLPBAxrPmbB4D3uPkVew@mail.gmail.com>
Subject: Re: [PATCH] mm/vmpressure.c: Include GFP_KERNEL flag to vmpressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Shaju Abraham <shaju.abraham@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 9:42 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 09-03-20 21:02:50, Shaju Abraham wrote:
> > On Mon, Mar 9, 2020 at 5:28 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > > On Mon 09-03-20 11:31:41, Shaju Abraham wrote:
> > > > The VM pressure notification flags have excluded GFP_KERNEL with the
> > > > reasoning that user land will not be able to take any action in case of
> > > > kernel memory being low. This is not true always. Consider the case of
> > > > a user land program managing all the huge memory pages. By including
> > > > GFP_KERNEL flag whenever the kernel memory is low, pressure notification
> > > > can be send, and the manager process can split huge pages to satisfy
> > > kernel
> > > > memory requirement.
> > >
> > > Are you sure about this reasoning? GFP_KERNEL = __GFP_FS | __GFP_IO |
> > > __GFP_RECLAIM
> > > Two of the flags mentioned there are already listed so we are talking
> > > about __GFP_RECLAIM here. Including it here would be a more appropriate
> > > change than GFP_KERNEL btw.
> > >
> > > But still I do not really understand what is the actual problem and how
> > > is this patch meant to fix it. vmpressure is triggered only from the
> > > reclaim path which inherently requires to have __GFP_RECLAIM present
> > > so I fail to see how this can make any change at all. How have you
> > > tested it?
> > >
> > >    We have a user space application which waits on memory pressure events.
>
> > Upon receiving the event, the user space program will free up huge
> > pages to make more memory available in the system.  This mechanism
> > works fine if the memory is being consumed by other user space
> > applications. To test this, we wrote a test program which will
> > allocate all the memory available in the system using malloc() and
> > touch the allocated pages. When the free memory level becomes low,
> > the pressure event is fired and the process gets notified about it .
> > The same test is repeated with kmalloc() instead of malloc(). A test
> > kernel module is developed, which will allocate all the available
> > memory with kmalloc(GFP_KERNEL) flag.  The OOM killer gets invoked in
> > this case. The memory pressure event is not fired.  After modifying
> > the vmpressure.c with the attached patch, the pressure event gets
> > triggered.  Swap is disabled in the system we were testing.
>
> Are you sure this is really the case? I am either missing something here
> or your test might simply be timing specific because
>
>         GFP_KERNEL & (__GFP_FS | __GFP_IO) = true
>
> so I really do not see how the current code could bail out on the test
> you are patching so that the patch would make any change. The only real
> difference this patch makes is to trigger events for __GFP_RECLAIM
> allocations which could be GFP_NOIO. All non-sleepable allocations would
> wake kswapd and that would in turn reclaim with _GFP_FS | __GFP_IO set
> so the check doesn't change anything.
>
> Am I missing something?
 No . You are right. The pressure event does get generated from kernel
but before the
 user space gets time to act, OOM killer is invoked.

Regards
Shaju



> --
> Michal Hocko
> SUSE Labs

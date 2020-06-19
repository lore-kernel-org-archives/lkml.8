Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0684C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FE72073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgFSHqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:46:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbgFSHqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:46:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D9FDB18D;
        Fri, 19 Jun 2020 07:45:56 +0000 (UTC)
Date:   Fri, 19 Jun 2020 09:45:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
Message-ID: <20200619074555.GF3617@alley>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
 <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley>
 <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com>
 <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 13:11:05, jim.cromie@gmail.com wrote:
> On Thu, Jun 18, 2020 at 12:17 PM Jason Baron <jbaron@akamai.com> wrote:
> > Yes, I'm wondering as well if people are really going to use the
> > new flags and filter flags - I mentioned that here:
> > https://lkml.org/lkml/2020/6/12/732
> 
> yes, I saw, and replied there.

No, the repply only explains how the interface might be used. There is
no prove that people would actually use it.

> but since that was v1, and we're on v3, we should refresh.
> 
> the central use-case is above, 1-liner version summarized here:
> 
> 1- enable sites as you chase a problem with +up
> 2- examine them with grep =pu
> 3- change the set to suit, either by adding or subtracting callsites.
> 4- continue debugging, and changing callsites to suit
> 5- grep =pu control > ~/debugging-session-task1-callsites
> 6- echo up-p >control   # disable for now, leave u-set for later
> 7- do other stuff
> 8 echo uP+p >control # reactivate useful debug-state and resume

In short, this feature allows repeatedly enable/disable some
slowly growing maze of debug messages. Who need this, please? !!!

If I am debugging then I add/remove debug messages. But I never
enable/disable all of them repeatedly.

Also this is far from the original problem. It was about debugging
a single driver (venus, drm). In this case, people need something
easy to use. The following is the easy way:

   drm.debug = area_of_interest
   venus.debug = level_of_interest

   echo module=drm group=area_of_interest +p >control  [*]
   echo module=venus group=level_of_interes +p >control

Anyway, why filtering and 'u' flag would be necessary to debug these drivers?
Is anyone going to use it?

I would really like to hear the motivation for these features.
Has anyone asked for them?
Or are these just some "interesting" ideas from some brainstorming?


[*] Well, I wonder if the dyndbg interface would even be useful for drm
    because it it is actually split into many modules. So it might require
    creating/maintaining several filters.


Best Regards,
Petr

PS: This is probably my last mail in this thread. It goes in cycle.
    You repeatedly explain how many possibilities the new features
    allow. I repeatedly doubt that they are worth it.

    I also proposed another solution for the original problem (venus)
    but it has never been commented.

    I just hope that these features will not get merged without
    a clear interest in them.

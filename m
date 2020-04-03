Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC7D2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yIAUATGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgDCTZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:25:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgDCTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:25:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id de14so10640768edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65rVr9Q9wr51d57tXR6aU7HcBrvBAcXIjk9gkyTDJto=;
        b=yIAUATGpTxycCd6OS4/9mbNgMIuLoAjFDHvlIkWj8Rpv7U2iT8eIT5UEq669+by3O6
         +2+9cS0/w5X+eP5/Q5HUbCaRkVlwKDEdIj1Vf0AjvJG5Ask5EmrfhNdxzn4zUyOHakUu
         i3qNWoKuZo4fTjdi09Wnjz9Tgz3tHK/PWPXXlHWl8LdbMLwO/gLxuNomGnjp4lAJ0yjT
         vpVVbxk1lGRrb+yIss3+VldnsIrapiNJQkCvCIlN6Mx1BX54F8XWFuN6Huh3hHskDkrm
         V7OIbPIA+McTO9XXT3A4jwi+48+SZtr6ZvTDu15U+ATosiHv0Qhn6ePOPdv2zsUQmGlb
         dvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65rVr9Q9wr51d57tXR6aU7HcBrvBAcXIjk9gkyTDJto=;
        b=YYo3pX4RWcae7FbjFN0XJI0KA03XW6n70lXRFyJm3Qea8X/rtU0ADEss6ApeWogRks
         fy/Fvm2RRT+cMnuhOmw4fR2y/huDfusxmgELLm8pai/1MsE/sZ2yhFB6PLoquEtQK2az
         klGnWsbsZcc4gN4pFX5228TwIm5x7bSrRZUu7KmQvUuXjySEoeZlrdA225uf9Qi1v/5p
         lu57TOepw2vmAa/rkFPww2rkXuyst11HFQmktDbbVq4DL3fAsaiI/RN0/fF5KsA674VI
         jyaoXA+hsOiNKOfb/52/RQEYJuMw8MH+C/y51PA+lDFzXzNL9IjLCTp9jcn9gAsF9xke
         Nr2A==
X-Gm-Message-State: AGi0PuYSIa+V3O2IKSg01e3gIn2dietEqNznGt3/Ofbf8BYOsXvqlnxs
        v5QNNqSlDhiUB8aPRnd0r6BscHhPm61De0XNQF08
X-Google-Smtp-Source: APiQypIZXiwhRJiYQ//8F1YOVZN8BCmsRLIweQL3yqTmNbA6vuDSg3BLgdnvN3ElHRl4kaEFeY8Y9PTi9EbazfoxGjw=
X-Received: by 2002:a17:906:583:: with SMTP id 3mr9741790ejn.308.1585941953025;
 Fri, 03 Apr 2020 12:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200402055640.6677-1-frextrite@gmail.com> <20200402055640.6677-3-frextrite@gmail.com>
 <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com> <20200403075613.GA2788@workstation-portable>
In-Reply-To: <20200403075613.GA2788@workstation-portable>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Apr 2020 15:25:42 -0400
Message-ID: <CAHC9VhRFFoRQfOa=UkO2fNP-KNANrrKPnr0j+gNr7gtJp94W4A@mail.gmail.com>
Subject: Re: [PATCH 3/3 RESEND] auditsc: Do not use RCU primitive to read from
 cred pointer
To:     Amol Grover <frextrite@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 3:56 AM Amol Grover <frextrite@gmail.com> wrote:
> On Thu, Apr 02, 2020 at 08:56:36AM -0400, Paul Moore wrote:
> > On Thu, Apr 2, 2020 at 1:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > > task_struct::cred is only used task-synchronously and does
> > > not require any RCU locks, hence, rcu_dereference_check is
> > > not required to read from it.
> > >
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > ---
> > >  kernel/auditsc.c | 15 +++++----------
> > >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > This is the exact same patch I ACK'd back in February, yes?
> >
> > https://lore.kernel.org/linux-audit/CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com
> >
>
> Hi Paul,
>
> That's correct. I've resend the series out of the fear that the first 2
> patches might've gotten lost as it's been almost a month since I last
> sent them. Could you please ack this again, and if you don't mind could
> you please go through the other 2 patches and ack them aswell?

If you hadn't changed the patch at all, and it doesn't look like you
did, you could have (and likely should have) just carried over my ACK.
Regardless, I'll re-ACK it now (below).  As far as the other two
patches are concerned, they look okay to me but I would defer my ACK
to maintainer of that code.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com

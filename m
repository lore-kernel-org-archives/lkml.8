Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76211C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F7920737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BqhEXmar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDCVoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:44:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36040 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:44:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id i7so11098118edq.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrK7vwUeUnQBBKtc7jLVryrHjAhV8bpINdD94AtArAQ=;
        b=BqhEXmarpha79beDhAorB7lrnB2lI2KqeqEc9AalPy8EKuqfwoJUOFuhlDZM0NCIp7
         HYaQ3xyxEV40Uz96yFvPMayjvCC1LJJzKF6j2T8RKSsyGrWS1YzFBBmbQtz77rHlnCeh
         IctJOBWK1WJPBhECOIuCiEm7oE+XykwiB2gqVQcOaUUkfhBjgNwKahFWqyugap3x+UQq
         AZSMWWuYDVfRTjAAw9pn9KztugTIxD7EZ+GEijrCzzLS4EXkqSYDYbdDiwYmA+di2JSP
         F9ks/fvOHQDQdBpdEaSudpR/AdtMfrZ+Fi6ZxkFvnJhuncgORpMdFbSNnXAzXFvGFe66
         Wq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrK7vwUeUnQBBKtc7jLVryrHjAhV8bpINdD94AtArAQ=;
        b=lFIX5OchvqbvyUadRdRZZuD5ChdsYeDa9t1dkftHNpmuB/qUft9RJFrjUgnoPxb5Li
         s82eeSB0sKe1be7ep4Tsu1+bGdU1rrKPUwGpu2lUdSz91g6LDwxPvLQrSPqs3vArUPko
         cDVTGR+6/dUVP35D8wv35C2BOISCqXHoFEhGihcTBjVKZPRirVom2U5s74PomTOzDSwO
         sZxhedjXSmdfe/FrKQ4MkWHn6tUcywaDf96v73877KXvCmG8yIWK6VD6rUq+oCrBXzO5
         vJdzykquK3xWtnMp2FEWoQA77TUT6aWqXdwPT52DiYWOCBb/I57zc+lXmzFxRniqXmy+
         R71Q==
X-Gm-Message-State: AGi0PuZWrJT+30ITkrO0ASe8QiJGNsu7JDlqc1JVF4dolhH6tTWbWtfk
        gsnib687oXF8Qp9RjjsOD0/Xhp3KWaslTUvK9igQ
X-Google-Smtp-Source: APiQypL59OxS7QNGPWqemd6Y/5Vu/44PzNASHeGhEZ++QX22x2xMJLmmDasdvS6/rH/XJN9sN5fraRX5tZkWBVbXnpo=
X-Received: by 2002:a17:906:b2c7:: with SMTP id cf7mr10678793ejb.271.1585950247447;
 Fri, 03 Apr 2020 14:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200402055640.6677-1-frextrite@gmail.com> <20200402055640.6677-3-frextrite@gmail.com>
 <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com>
 <20200403075613.GA2788@workstation-portable> <20200403212138.kr72jr57ppzsv6rm@madcap2.tricolour.ca>
In-Reply-To: <20200403212138.kr72jr57ppzsv6rm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 3 Apr 2020 17:43:56 -0400
Message-ID: <CAHC9VhTKPvJCsqS9dNg_MSfR1xaHuxhVSJixNPLoAgdC+WqeeA@mail.gmail.com>
Subject: Re: [PATCH 3/3 RESEND] auditsc: Do not use RCU primitive to read from
 cred pointer
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Amol Grover <frextrite@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        James Morris <jamorris@linux.microsoft.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 5:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-03 13:26, Amol Grover wrote:
> > On Thu, Apr 02, 2020 at 08:56:36AM -0400, Paul Moore wrote:
> > > On Thu, Apr 2, 2020 at 1:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > task_struct::cred is only used task-synchronously and does
> > > > not require any RCU locks, hence, rcu_dereference_check is
> > > > not required to read from it.
> > > >
> > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > > ---
> > > >  kernel/auditsc.c | 15 +++++----------
> > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > >
> > > This is the exact same patch I ACK'd back in February, yes?
> > >
> > > https://lore.kernel.org/linux-audit/CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com
> > >
> >
> > Hi Paul,
> >
> > That's correct. I've resend the series out of the fear that the first 2
> > patches might've gotten lost as it's been almost a month since I last
> > sent them. Could you please ack this again, and if you don't mind could
> > you please go through the other 2 patches and ack them aswell?
>
> Via who's tree are you expecting this will make it upstream?

When I asked a similar question back in February the response was
basically not the audit tree.

-- 
paul moore
www.paul-moore.com

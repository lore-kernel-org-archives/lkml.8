Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64A2C2BA17
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE2F20737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcgEkRgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDDCxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgDDCx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585968808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MLlUu/KBqpNQ9j9WA/dLvHKGWxsB53wUD6hlU/RrFUk=;
        b=IcgEkRgfuqrFkuZigjZcDNFRtrJqsDCr2Y72ef9JaQKntEaVnak8u6Nr6aCuWoL+IMfF2P
        Yqb89khKa0zCmTpZIqL0HJsNkpD/JUY56Dl5SHxMZDH1Sr+/J4RzAHcWqwnODnZmV4SiRZ
        A+YRW+yiITdUgkQ3EM7lM3QTrLMV08c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-ZwPsPAlBMeeGXr2VcAle2A-1; Fri, 03 Apr 2020 22:53:23 -0400
X-MC-Unique: ZwPsPAlBMeeGXr2VcAle2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D1113F8;
        Sat,  4 Apr 2020 02:53:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF1D55C28F;
        Sat,  4 Apr 2020 02:53:07 +0000 (UTC)
Date:   Fri, 3 Apr 2020 22:53:04 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
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
Subject: Re: [PATCH 3/3 RESEND] auditsc: Do not use RCU primitive to read
 from cred pointer
Message-ID: <20200404025304.llfj5xw23sapifgm@madcap2.tricolour.ca>
References: <20200402055640.6677-1-frextrite@gmail.com>
 <20200402055640.6677-3-frextrite@gmail.com>
 <CAHC9VhTUKepKiGZgAaWDADyTPnnM5unbM65T7jXZ3p8MFTNUuQ@mail.gmail.com>
 <20200403075613.GA2788@workstation-portable>
 <20200403212138.kr72jr57ppzsv6rm@madcap2.tricolour.ca>
 <CAHC9VhTKPvJCsqS9dNg_MSfR1xaHuxhVSJixNPLoAgdC+WqeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTKPvJCsqS9dNg_MSfR1xaHuxhVSJixNPLoAgdC+WqeeA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-03 17:43, Paul Moore wrote:
> On Fri, Apr 3, 2020 at 5:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-04-03 13:26, Amol Grover wrote:
> > > On Thu, Apr 02, 2020 at 08:56:36AM -0400, Paul Moore wrote:
> > > > On Thu, Apr 2, 2020 at 1:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > > task_struct::cred is only used task-synchronously and does
> > > > > not require any RCU locks, hence, rcu_dereference_check is
> > > > > not required to read from it.
> > > > >
> > > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > > > ---
> > > > >  kernel/auditsc.c | 15 +++++----------
> > > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > >
> > > > This is the exact same patch I ACK'd back in February, yes?
> > > >
> > > > https://lore.kernel.org/linux-audit/CAHC9VhQCbg1V290bYEZM+izDPRpr=XYXakohnDaMphkBBFgUaA@mail.gmail.com
> > > >
> > >
> > > Hi Paul,
> > >
> > > That's correct. I've resend the series out of the fear that the first 2
> > > patches might've gotten lost as it's been almost a month since I last
> > > sent them. Could you please ack this again, and if you don't mind could
> > > you please go through the other 2 patches and ack them aswell?
> >
> > Via who's tree are you expecting this will make it upstream?
> 
> When I asked a similar question back in February the response was
> basically not the audit tree.

Well, I went checking mingo and akpm's trees and didn't find 1/3 and 2/3
there even though I thought 3/3 was in audit/stable-5.6.  I was mistaken,
that patch in audit/stable-5.6 is a previous rcu fix for auditd_conn and
not 3/3.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635


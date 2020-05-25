Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A851C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2597B2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHBKsrIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbgEYNSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:18:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403779AbgEYNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590412684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJttDWRjUB0iYxqsplzNq2BTjGePNN+JTxhPLsQCxlQ=;
        b=NHBKsrIYKHmzC90qHZMJdi57JFMW1oxFhbTvbIjQ7I2ThXtgPhXjnfTNnOo7/3yoZ4qewr
        6Kqsja6U7jLB2pIpqy2cVLSvv9W1CkFw+ZesSEWLA0SYNTT4TJeRm5AR8CusoCOVnbCUdo
        Hwdi5p7VUMFsp/YJm1o+YY5AbOphFpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-jG5GRwolOYeYfIkBpcRzNw-1; Mon, 25 May 2020 09:18:00 -0400
X-MC-Unique: jG5GRwolOYeYfIkBpcRzNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823521005512;
        Mon, 25 May 2020 13:17:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85F6310013D6;
        Mon, 25 May 2020 13:17:44 +0000 (UTC)
Date:   Mon, 25 May 2020 09:17:41 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
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
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-audit@redhat.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/3 RESEND] sched: Remove __rcu annotation from cred
 pointer
Message-ID: <20200525131741.s6lgb263fpo5uszk@madcap2.tricolour.ca>
References: <20200402055640.6677-1-frextrite@gmail.com>
 <20200524081117.GA29@workstation-LAP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524081117.GA29@workstation-LAP.localdomain>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24 13:41, Amol Grover wrote:
> On Thu, Apr 02, 2020 at 11:26:38AM +0530, Amol Grover wrote:
> > task_struct::cred (subjective credentials) is *always* used
> > task-synchronously, hence, does not require RCU semantics.
> > 
> > task_struct::real_cred (objective credentials) can be used in
> > RCU context and its __rcu annotation is retained.
> > 
> > However, task_struct::cred and task_struct::real_cred *may*
> > point to the same object, hence, the object pointed to by
> > task_struct::cred *may* have RCU delayed freeing.
> > 
> > Suggested-by: Jann Horn <jannh@google.com>
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> Hello everyone,
> 
> Could you please go through patches 1/3 and 2/3 and if deemed OK, give
> your acks. I sent the original patch in beginning of February (~4 months
> back) and resent the patches again in beginning of April due to lack of
> traffic. Paul Moore was kind enough to ack twice - the 3/3 and its
> resend patch. However these 2 patches still remain. I'd really
> appreciate if someone reviewed them.

I asked on April 3 which upstream tree you expect this patchset to go
through and I did not see a reply.  Do you have a specific target or is
the large addressee list assuming someone else is taking this set?  All
we have seen is that it is not intended to go through the audit tree.

> Thanks
> Amol

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635


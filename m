Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CE8206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQt1HWBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbgEYSEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEYSEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:04:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 11:04:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so9066286pfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PAB8InMNdHtw1sY8dxXS0+RSR7K8nRd/W2k8ffZ4Q3w=;
        b=dQt1HWBCWLmDUW4sY0Mjq7AsizTnXYbIqlA07X17hC7kRvqZXOW0r5uLSBi7HIboJy
         1oaEhozTeWEe0OMESdA0thK5z5GakMN70IXUvYQptEkgg6WxQ3OF/ZtuzZ5QLrDwvxE9
         Jzlu2CivysdX9LI7xIfqdUKF2roCZCnzYPwtnWUJyVt4ddzDV1MUwy5zxdOUrBnx9wDM
         PGCkHPAt5bZp95Z+al59oUl1263zfkAQWD7cCBlM2WAXvB8POff8EF+5wMtPIpGMdg7F
         coqtJIBArB+oepQtEqTJszeDkudWjkWEHw76Jkuqd+LljrBB0qFp3UQT/MlNKFd0/OGM
         HyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAB8InMNdHtw1sY8dxXS0+RSR7K8nRd/W2k8ffZ4Q3w=;
        b=gDtoVJbqrp42/IEYLmmQLUcPYAFsCkoMWAJOfzBVoCH201ph9OzTAk4LLoJsiO2VV/
         01mAJHvDjcaTl8DFZABnYuVQ3AckUy1AcdriXy+SGecDgAN+edsvM0WPPdK5Y9KOZw+E
         Rm9gIsRaExWNngqK0Z/UDNkBro5kaHOR6gakYa5VIsmYUzvqzfFhYNJT0NwUJ0BJBT+l
         70F4lGjJmIV4y7+busokT2UFNcFYkgUVWAeVVPTaET36yvgF2hA/2Hzgp0FMWhBXIXiP
         BbwcbZw7qjZlCbsSitwgVYKHLnzwKUYckSDI9YR7thQbUE+4QrgB6gidw225IKHD/gK0
         3D9Q==
X-Gm-Message-State: AOAM530Kg/Dxu67KBfLPiUA/BpIa4kMRimEtFPs2SeIExEujQ0CzkrQY
        8vSyQHoOH6wAtAC0s/dbDIs=
X-Google-Smtp-Source: ABdhPJyezKLdoitt2fakdRXnl6cL2BqFHQ3TU7kenobJ/b2iPakDh/rya/euYiDtrb6NEdZdJ/Onzg==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr27470706pge.294.1590429878562;
        Mon, 25 May 2020 11:04:38 -0700 (PDT)
Received: from workstation-LAP.localdomain ([103.87.56.138])
        by smtp.gmail.com with ESMTPSA id k2sm13946901pfd.108.2020.05.25.11.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:04:37 -0700 (PDT)
Date:   Mon, 25 May 2020 23:34:21 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Richard Guy Briggs <rgb@redhat.com>
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
Message-ID: <20200525180421.GA19@workstation-LAP.localdomain>
References: <20200402055640.6677-1-frextrite@gmail.com>
 <20200524081117.GA29@workstation-LAP.localdomain>
 <20200525131741.s6lgb263fpo5uszk@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525131741.s6lgb263fpo5uszk@madcap2.tricolour.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 09:17:41AM -0400, Richard Guy Briggs wrote:
> On 2020-05-24 13:41, Amol Grover wrote:
> > On Thu, Apr 02, 2020 at 11:26:38AM +0530, Amol Grover wrote:
> > > task_struct::cred (subjective credentials) is *always* used
> > > task-synchronously, hence, does not require RCU semantics.
> > > 
> > > task_struct::real_cred (objective credentials) can be used in
> > > RCU context and its __rcu annotation is retained.
> > > 
> > > However, task_struct::cred and task_struct::real_cred *may*
> > > point to the same object, hence, the object pointed to by
> > > task_struct::cred *may* have RCU delayed freeing.
> > > 
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > 
> > Hello everyone,
> > 
> > Could you please go through patches 1/3 and 2/3 and if deemed OK, give
> > your acks. I sent the original patch in beginning of February (~4 months
> > back) and resent the patches again in beginning of April due to lack of
> > traffic. Paul Moore was kind enough to ack twice - the 3/3 and its
> > resend patch. However these 2 patches still remain. I'd really
> > appreciate if someone reviewed them.
> 
> I asked on April 3 which upstream tree you expect this patchset to go
> through and I did not see a reply.  Do you have a specific target or is
> the large addressee list assuming someone else is taking this set?  All
> we have seen is that it is not intended to go through the audit tree.
> 

Apologies for it. As Paul Moore replied, initially I assumed this
patchset to not go through the audit tree as the audit specific changes
were secondary to the main change (though certainly I did not think
which upstream tree the patchset would go through). But now I am okay
with the patchset making it to upstream via audit tree if it is fine by
the maintainers.

Thanks
Amol

> > Thanks
> > Amol
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
> 

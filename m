Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF666C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2C5207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q1G6ImSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgEZMeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389076AbgEZMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:34:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3EC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:34:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs4so17499545edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUFqBLf1RiIPnvjRp2NeVt7jf0hFenXjeR9kjT+Rdf0=;
        b=Q1G6ImSRc/01YqdhB6mWCmEe/l4IF827QZZCdkXZi5fpxWvRPUQLlrm6r3Aqsf+Q5p
         i7C9AzPEpnqFga5IAaazmqb0xjO2eq24t34iW7ZdFGDkmS8zo8ojsurxUDg1u2enqyFv
         8Bm/L705TWD6kTYco6/L6nYO7BudiVhZjXMJD7N3P/Cn9wV2pdYXLlrkSPuW/MAWxutu
         Ve1d5ejarNGPbce+dqUHzszZqDGXomMcuIlE4U2wrY11wMy0dF62LuvytGOQmzjqnKvP
         gWn3PVFimungMQz+ZhioqxaziPvDG/GW1qNjStXmyLSCKPkIJChDzfLQyE+4joc9Cpsw
         jX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUFqBLf1RiIPnvjRp2NeVt7jf0hFenXjeR9kjT+Rdf0=;
        b=SS+MaeFI61Nv3Hpz8rXzee4Yo4+kDI2SNy68eSzB5wp30FYBCEb1w1fTt8VrJsqG6n
         eNo8GnBG/B5de3u9pwUWJ8AOuIltbqNXZhaTYe+ZgYhwNGBwTpttE5lpBruNvlHCcgY/
         9XVq/Ayf380nOstStvJfu01mBNiX7V6JldcBsUeafZNHRMxws73T+blERJpM/fh+DOcr
         6rBbJ/COCtCCyCFZlLGFYNu85Z21AheFwZQQ72IZyli66hicRWXzq1nCH9l8vz2qiIcK
         smBAYZ6YXoUHGFUQVIhj/LCJmsZWZ1TqkNjGs0pfDWAHxtUDdLkWlVF83I0l/2TZLBhM
         V0Bg==
X-Gm-Message-State: AOAM532EVBAax84rIrIz35UjzCzOvbliUErpSYDf9p1ACPaBwQfeweqb
        2xyvODlsDWsktK5zrz641MswUkvmuLfECjMifevk
X-Google-Smtp-Source: ABdhPJwVhTK/f1+ttt/wIH/DF4otAgZkYmCBshCaTHZu+pV434ay6yyTjaqEoYxYdPBJpQQXAqjcQZ1DMw1Wtx1TaHg=
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr16099251edy.128.1590496483906;
 Tue, 26 May 2020 05:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200402055640.6677-1-frextrite@gmail.com> <20200524081117.GA29@workstation-LAP.localdomain>
 <20200525131741.s6lgb263fpo5uszk@madcap2.tricolour.ca> <20200525180421.GA19@workstation-LAP.localdomain>
In-Reply-To: <20200525180421.GA19@workstation-LAP.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 May 2020 08:34:33 -0400
Message-ID: <CAHC9VhQ_jNbNFChy3i6AfmOkEQtER_pxrd5uCJwpfNeedyUM4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3 RESEND] sched: Remove __rcu annotation from cred pointer
To:     Amol Grover <frextrite@gmail.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-audit@redhat.com, Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 2:04 PM Amol Grover <frextrite@gmail.com> wrote:
> On Mon, May 25, 2020 at 09:17:41AM -0400, Richard Guy Briggs wrote:
> > On 2020-05-24 13:41, Amol Grover wrote:
> > > On Thu, Apr 02, 2020 at 11:26:38AM +0530, Amol Grover wrote:
> > > > task_struct::cred (subjective credentials) is *always* used
> > > > task-synchronously, hence, does not require RCU semantics.
> > > >
> > > > task_struct::real_cred (objective credentials) can be used in
> > > > RCU context and its __rcu annotation is retained.
> > > >
> > > > However, task_struct::cred and task_struct::real_cred *may*
> > > > point to the same object, hence, the object pointed to by
> > > > task_struct::cred *may* have RCU delayed freeing.
> > > >
> > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > >
> > > Hello everyone,
> > >
> > > Could you please go through patches 1/3 and 2/3 and if deemed OK, give
> > > your acks. I sent the original patch in beginning of February (~4 months
> > > back) and resent the patches again in beginning of April due to lack of
> > > traffic. Paul Moore was kind enough to ack twice - the 3/3 and its
> > > resend patch. However these 2 patches still remain. I'd really
> > > appreciate if someone reviewed them.
> >
> > I asked on April 3 which upstream tree you expect this patchset to go
> > through and I did not see a reply.  Do you have a specific target or is
> > the large addressee list assuming someone else is taking this set?  All
> > we have seen is that it is not intended to go through the audit tree.
> >
>
> Apologies for it. As Paul Moore replied, initially I assumed this
> patchset to not go through the audit tree as the audit specific changes
> were secondary to the main change (though certainly I did not think
> which upstream tree the patchset would go through). But now I am okay
> with the patchset making it to upstream via audit tree if it is fine by
> the maintainers.

This patchset is not appropriate for the audit tree as the most
significant changes are not audit related.

My ACK on patch 3/3 was, and is, conditional on the previous patches
being acceptable to the greater kernel community; this is the main
reason why I didn't ACK patch 1/3 or 2/3.

-- 
paul moore
www.paul-moore.com

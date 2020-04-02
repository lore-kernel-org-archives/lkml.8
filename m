Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3EFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90B02078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585846659;
	bh=X3PlfBlbIWLeP0CMCgHZC7mjUaCakvnwr6GNUHzqNcM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j/8K//cX9ATPFv1bryc9jUM/cseSpxQ2puODoTX+0YQ6FFO7cEd9p9goWq+lPtprZ
	 yNHTrb/76zDV8UuPAp6kLtnbVsMLl7bWR99ZB/L2jE7DCMrjhy775+bwjY44s9rZVy
	 DXg57PgsXd8mij4bHmhT93fFdbbt6PEsrug4vAao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgDBQ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbgDBQ5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:57:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B277420737;
        Thu,  2 Apr 2020 16:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585846657;
        bh=X3PlfBlbIWLeP0CMCgHZC7mjUaCakvnwr6GNUHzqNcM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J4YVuxmJ6og07F0T/oP2MNLLaNO5WKhKFTnErKaZYhoAS/KPlPlGtkMRteYfzQT0a
         OY8qmQQqBdRXMD8fXMSSEB72DF62PW2I9oc9v8Rjf9qP4TtR1MycHOKYLqwMRakYMW
         i050cCPPsNykKhgYT4mE9Y+omVEAs6NhHLK7NQjY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7FADD3521885; Thu,  2 Apr 2020 09:57:37 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:57:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200402165737.GQ19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200402155406.GP19865@paulmck-ThinkPad-P72>
 <4134872A-3D1D-4860-9C1B-2FD9C00272BB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4134872A-3D1D-4860-9C1B-2FD9C00272BB@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:19:54PM -0400, Qian Cai wrote:
> 
> 
> > On Apr 2, 2020, at 11:54 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > I do run this combination quite frequently, but only as part of
> > rcutorture, which might not be a representative workload.  For one thing,
> > it has a minimal userspace consisting only of a trivial init program.
> > I don't recall having ever seen this.  (I have seen one recent complaint
> > about an IPI being sent to an offline CPU, but I cannot prove that this
> > was not due to RCU bugs that I was chasing at the time.)
> 
> Yes, a trivial init is tough while running systemd should be able to catch it as it will use cgroup.

Not planning to add systemd to my rcutorture runs.  ;-)

							Thanx, Paul

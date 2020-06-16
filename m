Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24341C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0563520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgFPTB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPTBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:01:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12227207C4;
        Tue, 16 Jun 2020 19:01:23 +0000 (UTC)
Date:   Tue, 16 Jun 2020 15:01:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH -tip V6 0/6] kprobes: Fixes mutex, rcu-list warnings and
 cleanups
Message-ID: <20200616150122.4a71d56d@oasis.local.home>
In-Reply-To: <20200614153728.GA2009260@krava>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
        <20200527234941.a15490ee50669812df8183dc@kernel.org>
        <20200614153728.GA2009260@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 17:37:28 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, May 27, 2020 at 11:49:41PM +0900, Masami Hiramatsu wrote:
> > (Oops, I missed Jiri in loop.)
> > 
> > Hi Ingo,
> > 
> > Could you take this series?
> > These are not adding any feature, but fixing real bugs.  
> 
> Hi,
> I still can't see this being pulled in, did I miss it?
> 

I'm getting a pull request ready for -rc2. I can pull these in with that.

-- Steve

Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DC3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29607207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592404846;
	bh=5IXhG08RaY+ws/8l5Bcnobd1yXqVXjT6sPryKwp0qYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cvimIqJ6LxdnbdWmWkdoDS686DxbKpTR5X0Fu4tBVJKZj80sqm0PLLrCzhpChLs0/
	 4a+JczvAUExtnvLJiZ2zzom+hwujxEZRvOzS+U4TsaNeY1iR/eGEO/2I4MhTdAUKH8
	 zfklswhcq/7TIu2RRpqZTREzYdp2WHFgyyfm2Ass=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFQOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:40:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60E420773;
        Wed, 17 Jun 2020 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592404842;
        bh=5IXhG08RaY+ws/8l5Bcnobd1yXqVXjT6sPryKwp0qYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nklIa/0lP/rE260xCKtcvTllCpmiaUdOTITCjTeuPYypKvAEvBcEQ2EfiMqqr0t3y
         cUOmcGrQ7JMPJtRuH76jPYIlVI2nLDjML0gEbPZUhuOmK7/lmtY57xKzktc6+X3zfJ
         wJVn4e7Yusys6QCRz8OZIpNGHEkVO1EJAJsNO1lw=
Date:   Wed, 17 Jun 2020 23:40:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <20200617234036.24c54da366f0c35d5c701359@kernel.org>
In-Reply-To: <20200616150122.4a71d56d@oasis.local.home>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
        <20200527234941.a15490ee50669812df8183dc@kernel.org>
        <20200614153728.GA2009260@krava>
        <20200616150122.4a71d56d@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 15:01:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 14 Jun 2020 17:37:28 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Wed, May 27, 2020 at 11:49:41PM +0900, Masami Hiramatsu wrote:
> > > (Oops, I missed Jiri in loop.)
> > > 
> > > Hi Ingo,
> > > 
> > > Could you take this series?
> > > These are not adding any feature, but fixing real bugs.  
> > 
> > Hi,
> > I still can't see this being pulled in, did I miss it?
> > 
> 
> I'm getting a pull request ready for -rc2. I can pull these in with that.

Great! Thank you so much!


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5390C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7AD2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGsna6YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgFPTpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:45:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730630AbgFPTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592336705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyqueuFjC37VTOe25MsKub4gwfM3sfG08StS+6GkW5Y=;
        b=XGsna6YYQ6p6k6+PMAOtWlC0hioU3mU5/dQm9cyPdCxaDX9igEMn5dlGvVzVkBfvmJSZ2k
        iXLNJzba0ZMXfX6J//y+1DgJRxGYOkJ0I2zTeU8kPPAdpRCAp6gamhwJq83TnFHYNMc/wM
        qLq6vta4EPLMMDKbvx1830RbjWazWb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-6vyUyC-aPkWpBITbqg5EYQ-1; Tue, 16 Jun 2020 15:45:00 -0400
X-MC-Unique: 6vyUyC-aPkWpBITbqg5EYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD5D835BB8;
        Tue, 16 Jun 2020 19:44:55 +0000 (UTC)
Received: from krava (unknown [10.40.193.177])
        by smtp.corp.redhat.com (Postfix) with SMTP id EFA577CAB9;
        Tue, 16 Jun 2020 19:44:51 +0000 (UTC)
Date:   Tue, 16 Jun 2020 21:44:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20200616194451.GA2210496@krava>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
 <20200527234941.a15490ee50669812df8183dc@kernel.org>
 <20200614153728.GA2009260@krava>
 <20200616150122.4a71d56d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616150122.4a71d56d@oasis.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:01:22PM -0400, Steven Rostedt wrote:
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

that'd be awesome, thanks!

jirka


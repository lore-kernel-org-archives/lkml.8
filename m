Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C3DC35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BCC206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsBiTwGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWTgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 14:36:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582486602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TXVTKlDKKROSDXmOjqzvvw610aPgU4vf2Wf84SZQ8E=;
        b=bsBiTwGMlM812Vxv3gPVnwN0To+QmEDBiIAlRiUOKBbLnPi7bItRxKpkTrydBYFvFa2QPp
        J2LzPs4Kv/Tr4LJ6E5QNmAiVH3qFvjtp5DluoaAk88T+H0tErKTizlDOZBfKyfIPuJSC03
        VeLam2tJmhWwHwzIjP05dzKo8T7d5aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-ZnEfOCjkNKK_6y6xFrmgdw-1; Sun, 23 Feb 2020 14:36:35 -0500
X-MC-Unique: ZnEfOCjkNKK_6y6xFrmgdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766215F9;
        Sun, 23 Feb 2020 19:36:32 +0000 (UTC)
Received: from krava (ovpn-204-19.brq.redhat.com [10.40.204.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C6019C69;
        Sun, 23 Feb 2020 19:36:27 +0000 (UTC)
Date:   Sun, 23 Feb 2020 20:36:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200223193624.GA16664@krava>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223141147.GA53531@shbuild999.sh.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 10:11:47PM +0800, Feng Tang wrote:
> Hi Jiri,

hi,

> 
> On Fri, Feb 21, 2020 at 02:20:48PM +0100, Jiri Olsa wrote:
> 
> > > We are also curious that the commit seems to be completely not
> > > relative to this scalability test of signal, which starts a task
> > > for each online CPU, and keeps calling raise(), and calculating
> > > the run numbers.
> > > 
> > > One experiment we did is checking which part of the commit
> > > really affects the test, and it turned out to be the change of
> > > "struct pmu". Effectively, applying this patch upon 5.0-rc6 
> > > which triggers the same regression.
> > > So likely, this commit changes the layout of the kernel text
> > > and data, which may trigger some cacheline level change. From
> > > the system map of the 2 kernels, a big trunk of symbol's address
> > > changes which follow the global "pmu",
> > 
> > nice, I wonder we could see that in perf c2c output ;-)
> > I'll try to run and check
> 
> Thanks for the "perf c2c" suggestion. 

I'm fighting with lkp tests.. looks like it's not fedora friendly ;-)

which specific test is doing this? perhaps I can dig it out and run
without the script machinery..

> 
> I tried to use perf-c2c on one platform (not the one that show
> the 5.5% regression), and found the main "hitm" points to the
> "root_user" global data, as there is a task for each CPU doing
> the signal stress test, and both __sigqueue_alloc() and
> __sigqueue_free() will call get_user() and free_uid() to inc/dec
> this root_user's refcount.
> 
> Then I added some alignement inside struct "user_struct" (for
> "root_user"), then the -5.5% is gone, with a +2.6% instead.

could you share the change?

> 
> One c2c report log is attached.

could you also post one (for same data) without the callchains?

  # perf c2c report --stdio --call-graph none

it should show the read/write/offset for cachelines in more
readable way

I'd be also interested to see the data if you can share (no worries
if not) ... I'd need the perf.data and bz2 file from 'perf archive'
run on the perf.data

> 
> One thing I don't understand is, this -5.5% only happens in
> one 2 sockets, 96C/192T Cascadelake platform, as we've run
> the same test on several different platforms. In therory,
> the false sharing may also take effect? 

I don't have access to cascade lake, but AFAICT the bigger
machine the bigger issues with false sharing ;-)

jirka


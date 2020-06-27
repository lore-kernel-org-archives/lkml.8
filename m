Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82202089D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593262460;
	bh=npZu00EqtjjHhhLbNHM54uplSnD3S/cKOTJ2mxbwLW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r0WNYar2lS65eOvVdLQOCDoeYZrZrjWisf59epXsEsS6N021f1Dr9cGycCU6WAbPD
	 Ne/zIxCN3qcw+pxSt4dbgr8hQUJ0m1L16tnOtkqhVN0rO9iGng+j2i6klUPVQk+XFG
	 O+1BIIMvRMxJMhkWQfvYFsVqwZXMB7j7AkvQ32dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgF0Mqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgF0Mqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:46:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278E921548;
        Sat, 27 Jun 2020 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593262012;
        bh=npZu00EqtjjHhhLbNHM54uplSnD3S/cKOTJ2mxbwLW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2zI4gF8mRDVjiriIxbXqLIKwNC6A9/bN79lgc8sBtWt3OchkS8pEr5gPhTMxWCV2
         kJW/FK6SjLTcl/p3xtJ9GdWab2EPwh5l8jZwoM6x3UHuamWSJUJDR4/Y7bwE2h6Euv
         SDqFcfUWavXTZ4RlD57eh7nVLr+8yWak2w59uSqo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46CB0405FF; Sat, 27 Jun 2020 09:46:50 -0300 (-03)
Date:   Sat, 27 Jun 2020 09:46:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200627124650.GE29008@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626212522.GF818054@tassilo.jf.intel.com>
 <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 26, 2020 at 02:44:14PM -0700, Ian Rogers escreveu:
> On Fri, Jun 26, 2020 at 2:25 PM Andi Kleen <ak@linux.intel.com> wrote:
> > On Fri, Jun 26, 2020 at 09:47:10PM +0200, Jiri Olsa wrote:
> > > this patchset is adding the support to reused metric in another
> > > metric. The metric needs to be referenced by 'metric:' prefix.

> > Why is the prefix needed?

> > Could just look it up without prefix.

> The name could be a metric or an event, the logic for each is quite
> different. You could look up an event and when it fails assume it was
> a metric, but I like the simplicity of this approach. Maybe this
> change could be adopted more widely with something like "perf stat -e
> metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> 1000".

Humm, the more concise, the better, so I think that we should use
metric: when we notice ambiguity, i.e. we should first lookup the
provided name as an event, and even if it resolves, look it up as well
as a metric, if both lookups work, then one need to disambiguate.

But then, why should we pick a name for a metric that is also a name for
an event? Can you think about a concrete case? Can't we detect this at
build time, when introducing the new metric and bail out?

- Arnaldo

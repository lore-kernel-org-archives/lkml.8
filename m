Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91A5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CDE20842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOYBsmgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgAJRij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:38:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgAJRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cKP4lKxnIk04w8+g1orc/YxqCBY4uhvN1DKL/5O4vXk=; b=HOYBsmgPw0vmlmtFTaFV5XMEI
        1IRk96plOMwNCGBoLTt4MOBxNxENKYl04zUkaEMfYbJSo6jtrc6kghQQK3W4UEZ35NZF3AEsmKbFd
        2n+nrEcJRjN7xzv2M7Eor+XVq9K99nmYsM6qITXZVTDkm+UpkMUZYW6Yk4CHSnbcx2uGXKLcebWOf
        Cit9tTxQPlQttf9mY1cceE30gdYlfi4WF75d0pfbnK5gv0uhxd/TahSoQ38rBSwZev1NQUS5QiZLb
        3SE7MdYk5rSDN9sxRMGG2rcevUemBSbMe/J93w/9wheB7HJrOs4AjsGWi2OO8DxXFeCHHu53iBEEw
        OVtJm+1Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipyEs-0005zq-1B; Fri, 10 Jan 2020 17:38:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E1B5305EDF;
        Fri, 10 Jan 2020 18:36:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B1A8201D9417; Fri, 10 Jan 2020 18:38:23 +0100 (CET)
Date:   Fri, 10 Jan 2020 18:38:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per
 Cycle Events
Message-ID: <20200110173823.GQ2844@hirez.programming.kicks-ass.net>
References: <20191114183720.19887-1-kim.phillips@amd.com>
 <20191114183720.19887-3-kim.phillips@amd.com>
 <20191220120945.GG2844@hirez.programming.kicks-ass.net>
 <ca10060f-f78f-695f-4929-fe4bc30c6712@amd.com>
 <20200110150958.GP2844@hirez.programming.kicks-ass.net>
 <f83eacb7-6346-6823-6429-27ee1d44f2df@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83eacb7-6346-6823-6429-27ee1d44f2df@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:22:10AM -0600, Kim Phillips wrote:
> On 1/10/20 9:09 AM, Peter Zijlstra wrote:
> > On Wed, Jan 08, 2020 at 04:26:47PM -0600, Kim Phillips wrote:
> >> On 12/20/19 6:09 AM, Peter Zijlstra wrote:
> >>> On Thu, Nov 14, 2019 at 12:37:20PM -0600, Kim Phillips wrote:
> >> One problem I see with your change in the "not already used" fastpath
> >> area, is that the new mask variable gets updated with position 'i'
> >> regardless of any previous Large Increment event assignments.
> > 
> > Urgh, I completely messed that up. Find the below delta (I'll push out a
> > new version to queue.git as well).
> 
> OK, I tested what you pushed on your perf/amd branch, and it passes all my tests.

Excellent!

> BTW, a large part of the commit message went missing, hopefully it'll be brought back before being pushed further upstream?

Argh.. it's those ---- lines, my script things they're cuts. I'll go
fix it up.

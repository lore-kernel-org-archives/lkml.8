Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE646C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4ED206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgHFRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:45:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:11127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgHFQih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:38:37 -0400
IronPort-SDR: fE0GVkJOzDvZFi9c+cQSHzm6Kwn6tKCMAJDuCnq+64C7u5C2+4HbO5755dcdHPGMkRynQeee/m
 D3yab4csLR7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140707733"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="140707733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 08:32:06 -0700
IronPort-SDR: 9dqFfthCWP0LCXusvT7/YdIN2LUfL+dM8a7cOSPw//37suISlg4AYceONUhkp3L97Q2vJ28zie
 pSeFYhboG0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="276413105"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2020 08:32:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 76CC6301CAC; Thu,  6 Aug 2020 08:32:05 -0700 (PDT)
Date:   Thu, 6 Aug 2020 08:32:05 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200806153205.GA1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806083530.GV2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This adds an opt-in flag to the perf_event_open() syscall to retain
> > sibling events after their file descriptors are closed. In this case, the
> > actual events will be closed with the group leader.
> 
> So having the 1:1 relation with filedesc imposes a resource limit on
> userspace.
> 
> This patch breaks that and enables a user to basically DoS the system by
> creating unbound events.

The idea was to account the events in the locked memory allocation too.
Not sure that made it into the patch though.

It has a minor issue that it might break some existing setups that rely
on the mmap fitting exactly into the mmap allocation, but that could
be solved by allowing a little slack, since the existing setups
likely don't have that many events.

There's also a secondary issue of DoS the kernel by creating very long
lists to iterate, but I suppose this is already quite possible, so probably
not a new issue.

-Andi


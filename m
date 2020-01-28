Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C1C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920672468C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aSc5fKvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgA1MBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:01:07 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41605 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgA1MBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580212866; x=1611748866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=G4XawBinOQE3v9IrgHKbrUqOdbum+3a/Cn7jH1Qi8Yw=;
  b=aSc5fKvB8YePM3uNCu1NRKIj2hhFv7p3skrYTQ2WuyOdXOiM1RHgyeB5
   Q8NXhVc4ZedCJNtphX7IlP+b8Psa6i9hFAQvrywf7ANJtTdUFqtf8O5NL
   +eObG9FEDbYZg6VlTXHL3S7Yl8poCzNgUltNoMf+wLy1JZiFEc/PZG1ui
   U=;
IronPort-SDR: eKQ9cgKWSjxfguOEiVl1w4CH1plajgwFhyokzCeQzCrOWS6XGUcwATYiT8fVCgmuR6xPMSMWRk
 OwuzHAQstfbQ==
X-IronPort-AV: E=Sophos;i="5.70,373,1574121600"; 
   d="scan'208";a="15092337"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 28 Jan 2020 12:01:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id E9ED3A1F50;
        Tue, 28 Jan 2020 12:00:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 12:00:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.117) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 12:00:46 +0000
From:   <sjpark@amazon.com>
CC:     <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Jan 2020 13:00:33 +0100
Message-ID: <20200128120033.27016-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <41BBD985-4B3D-4F87-B69D-D8CFE6EC0EBE@lca.pw> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.117]
X-ClientProxiedBy: EX13D37UWA004.ant.amazon.com (10.43.160.23) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To: Qian Cai <cai@lca.pw>

On Tue, 28 Jan 2020 06:20:29 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Jan 28, 2020, at 5:50 AM, sjpark@amazon.com wrote:
> > 
> > For the comments from perf maintainers, I added Steven Rostedt and Arnaldo
> > Carvalho de Melo first, but I might missed someone.  If you recommend some more
> > people, I will add them to recipients.
> > 
> > I made DAMON as a new subsystem because I think no existing subsystem fits well
> > to be a base of DAMON, due to DAMON's unique goals and mechanisms described
> > below in the original cover letter.
> > 
> > The existing subsystem that most similar to DAMON might be 'mm/page_idle.c'.
> > However, there are many conceptual differences with DAMON.  One biggest
> > difference I think is the target.  'page_idle' deals with physical page frames
> > while DAMON deals with virtual address of specific processes.
> > 
> > Nevertheless, if you have some different opinion, please let me know.
> 
> I thought everyone should know to go to the MAINTAINERS file and search PERFORMANCE EVENTS SUBSYSTEM.

I worried whether it could be a bother to send the mail to everyone in the
section, but seems it was an unnecessary worry.  Adding those to recipients.
You can get the original thread of this patchset from
https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/

> 
> It might be difficult but there is a perf subcommand for some subsystems like sched: tracing/measuring of scheduler actions and latencies.

Seems like you are suggesting to implement the DAMON's core logic as a
subcommand of perf in user space.  Because DAMON's logic inherently require
frequent interaction with privileged features that need to be done inside the
kernel space, I think it will incur frequent context switch and might not
fulfill its performance requirement.

As far as I understand, we normally add a data source in the kernel and
implement sophisticated handlings or visualizations in the perf.  I think DAMON
is a source of a new primitive data (data access pattern).


Thanks,
SeongJae Park

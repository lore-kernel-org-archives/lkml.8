Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC687C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B3F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 03:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJD5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 22:57:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51877 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgBJD5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 22:57:47 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01A3vOwI089837;
        Mon, 10 Feb 2020 12:57:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Mon, 10 Feb 2020 12:57:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01A3vNQ5089833;
        Mon, 10 Feb 2020 12:57:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id 01A3vNNU089831;
        Mon, 10 Feb 2020 12:57:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: RE: [PATCH RFC] =?ISO-2022-JP?B?dmlydGlvX2JhbGxvb246IGNvbnNlcnZhdGl2ZSBi?=
 =?ISO-2022-JP?B?YWxsb29uIHBhZ2Ugc2hyaW5raW5n?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>
MIME-Version: 1.0
Date:   Mon, 10 Feb 2020 12:57:23 +0900
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp> <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang, Wei W wrote:
> On Saturday, February 8, 2020 8:33 PM, Tetsuo Handa wrote:
> > 
> > Is this NUMA aware? Can "node-A's NR_FILE_PAGES is already 0 and
> > node-B's NR_FILE_PAGES is not 0, but allocation request which triggered this
> > shrinker wants to allocate from only node-B" happen? 
> 
> No, it's a global counter.
> 
> >Can some thread keep
> > this shrinker defunctional by keep increasing NR_FILE_PAGES?
> 
> Yes. Actually it's our intention - as long as there are pagecache pages,
> balloon pages are avoided to be reclaimed.

Then, "node-A's NR_FILE_PAGES is already 0 and node-B's NR_FILE_PAGES is not 0, but
allocation request which triggered this shrinker wants to allocate from only node-A"
would be confused by this change, for the pagecache pages for allocating thread's
interested node are already depleted but the balloon cannot shrink when it should
because the pagecache pages for allocating thread's uninterested nodes are not yet
depleted.

> 
> 
> > 
> > Is this patch from "Re: Balloon pressuring page cache" thread? I hope that
> > the guest could start reclaiming memory based on host's request (like OOM
> > notifier chain) which is issued when host thinks that host is getting close to
> > OOM and thus guests should start returning their unused memory to host.
> > Maybe "periodically (e.g. 5 minutes)" in addition to "upon close to OOM
> > condition" is also possible.
> 
> That's about the host usages. The host side management software decides when to
> issue a request to balloon (either periodically or event driven), I think there
> isn't anything we need to do in the balloon driver here.

Well, my comment is rather: "Do not try to reserve guest's memory. In other words,
do not try to maintain balloons on the guest side. Since host would be able to cache
file data on the host's cache, guests would be able to quickly fetch file data from
host's cache via normal I/O requests." ;-)

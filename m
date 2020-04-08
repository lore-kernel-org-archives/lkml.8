Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC998C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA9F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586315698;
	bh=0N3k3hrw1Wr+J1lrG8rUq6HXElqTf+oumNfxCX+bX8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P2eXQ5ZsHzQT8MpbH5Au73/VCoxP1HpkPJ/8RW5o0SJ+LBtjwf0iEGaov67FUk1A8
	 xo0bGLcto8LXPtbOxgrQ3YQ44H1+nQnR1qY1AQXL3qOmwb1e1o+Xy2yUT8N2ErQsmx
	 Jx2v7L/PsElDvE14WhBxtVgSA1Al2aQxjntPuZpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDHDO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHDO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:14:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F8020730;
        Wed,  8 Apr 2020 03:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586315696;
        bh=0N3k3hrw1Wr+J1lrG8rUq6HXElqTf+oumNfxCX+bX8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YjKrfYjX107+Sj6BZaePOJGDGgucHOSmDqHPt3FzjCM2nBQZz5pen9MCVdE66LhvD
         KTxZxp2uUBSyJ6KLvYjLFwd5KoCcSZut5TkCJaWe2M/426wHSsRq3xqCRYkwNl6Q3q
         EpvPCODAr3zfY6QXMRo6tyQwaiOoHZ93vgtMKVUQ=
Date:   Wed, 8 Apr 2020 12:14:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: perf probe + uprobes missing events
Message-Id: <20200408121452.eef4eb8e66367677f295f9ea@kernel.org>
In-Reply-To: <20200407213943.3a92e040d4ce30dc55e9aa1f@kernel.org>
References: <20200406145356.GA32649@kernel.org>
        <20200407213943.3a92e040d4ce30dc55e9aa1f@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

This seems like a perf (perf's ringbuffer?) issue.

Actually, we can not enable perf and ftrace on same uprobe event yet, but the hit counter (uprobe_profile) works.

1) Setup the event.

$ sudo ./perf probe -x ./perf expr__parse expr:string
Added new event:
  probe_perf:expr__parse (on expr__parse in /home/mhiramat/ksrc/linux/tools/perf/perf with expr:string)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:expr__parse -aR sleep 1

$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                                0

2) run the test command

$ sudo ./perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/9789 probe_perf:expr__parse(__probe_ip: 94836726971904, expr_string: "1+1")

$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               12

OK, this shows the perf trace command only shows 1 event, but uprobe_event itself hits 12 times.

3) run the test command again

$ sudo ./perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "1+1")
     0.014 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "FOO+BAR")
     0.018 perf/9847 probe_perf:expr__parse(__probe_ip: 94778335464960, expr_string: "(BAR/2)%2")
$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               24

Again, the perf trace shows only 3 events, but uprobe event hits +12 times

4) run the test command with ftrace.

$ echo 1 | sudo tee /sys/kernel/debug/tracing/events/probe_perf/enable 
1
$ ./perf test -F expr
 7: Simple expression parser                              : Ok
$ sudo cat /sys/kernel/debug/tracing/uprobe_profile
  /home/mhiramat/ksrc/linux/tools/perf/perf expr__parse                                               36

Hit +12 times and the ftrace shows all events correctly.

$ sudo cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 24/24   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            perf-9883  [003] d...  9287.936678: expr__parse: (0x55ea35ce9e00) expr_string="1+1"
            perf-9883  [003] d...  9287.936694: expr__parse: (0x55ea35ce9e00) expr_string="FOO+BAR"
            perf-9883  [003] d...  9287.936699: expr__parse: (0x55ea35ce9e00) expr_string="(BAR/2)%2"
            perf-9883  [003] d...  9287.936704: expr__parse: (0x55ea35ce9e00) expr_string="1 - -4"
            perf-9883  [003] d...  9287.936707: expr__parse: (0x55ea35ce9e00) expr_string="(FOO-1)*2 + (BAR/2)%2 - -4"
            perf-9883  [003] d...  9287.936712: expr__parse: (0x55ea35ce9e00) expr_string="1-1 | 1"
            perf-9883  [003] d...  9287.936716: expr__parse: (0x55ea35ce9e00) expr_string="1-1 & 1"
            perf-9883  [003] d...  9287.936719: expr__parse: (0x55ea35ce9e00) expr_string="min(1,2) + 1"
            perf-9883  [003] d...  9287.936723: expr__parse: (0x55ea35ce9e00) expr_string="max(1,2) + 1"
            perf-9883  [003] d...  9287.936726: expr__parse: (0x55ea35ce9e00) expr_string="1+1 if 3*4 else 0"
            perf-9883  [003] d...  9287.936731: expr__parse: (0x55ea35ce9e00) expr_string="FOO/0"
            perf-9883  [003] d...  9287.936734: expr__parse: (0x55ea35ce9e00) expr_string="BAR/"

It seems that the perf ring buffer returns only early events
(since expr_string="1+1" is always shown), so I guess there is
a timing issue when the ring buffer is read.

Can we delay the read timing?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

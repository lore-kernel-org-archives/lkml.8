Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99425C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF1820757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgEAOVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEAOVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:21:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5899120757;
        Fri,  1 May 2020 14:21:15 +0000 (UTC)
Date:   Fri, 1 May 2020 10:21:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for
 dash, etc.
Message-ID: <20200501102113.151d38c1@gandalf.local.home>
In-Reply-To: <158834025077.28357.15141584656220094821.stgit@devnote2>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ FYI, Shuah responds better from her linuxfoundation.org email ]

Shuah,

Feel free to take the first two patches of this series (I acked one, and
reviewed the other).

The last patch I had some issues with, and is still under discussion.

Thanks!

-- Steve



On Fri,  1 May 2020 22:37:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are some patches to update ftracetest to fix some issues.
>  - [1/3] Fix coloring of XFAIL
>  - [2/3] Fix a testcase not to expect just one event entry
>  - [3/3] Do not use built-in echo because the behavior is different
>          on dash and bash. (Thanks Liu for reporting!)
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       selftests/ftrace: Make XFAIL green color
>       selftests/ftrace: Pick only the first kprobe event to test
>       selftests/ftrace: Use /bin/echo instead of built-in echo
> 
> 
>  tools/testing/selftests/ftrace/ftracetest          |    2 +-
>  tools/testing/selftests/ftrace/test.d/functions    |    3 +++
>  .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
>  .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
>  .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
>  .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
>  6 files changed, 12 insertions(+), 5 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


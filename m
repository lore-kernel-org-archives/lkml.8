Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93133C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA2620849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589984564;
	bh=0KQyo8UdRMkIcGaMdLxSxaIbtmxzWJO28gXwA2MXpeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a8xqXa5KI6OI77HOomfImhp+fs3A+mF01WqUjfJjF5PHkJ5kolD1ML0WhsCa6L8Ks
	 QLM6HU6ZlTBjJDqOmMCQDdcG6ISPyktT4uxXn2hUtr38PhVRixvzYXJ3W90R24UdNg
	 cgZiU/rBTVXZp947SyUn5JTrXT/PEND87ph7+OSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgETOWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgETOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:22:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815D9205CB;
        Wed, 20 May 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589984543;
        bh=0KQyo8UdRMkIcGaMdLxSxaIbtmxzWJO28gXwA2MXpeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ma9mGE3baOMl907jY5WV1VgEBfFNjnh/XkoRUlaoAV9QG/306Qr0ZaRmGHJI3AUki
         dXPtqWyOqcvwSYwQa5wyQtQVs+GmfBnnTb2FU1EqYpeSa9NfzleTVrA2GBPwARIgSB
         zfsloof6SF9lCC1YinWGo1LLuZtvL78q/7YR4x6g=
Date:   Wed, 20 May 2020 23:22:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] tracing/kprobes: Fix event generation API etc.
Message-Id: <20200520232220.ec89497aab17d7e6507b9886@kernel.org>
In-Reply-To: <158779373972.6082.16695832932765258919.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

It seems this fixes are not picked up yet.
Would you have any consideration?

Thank you,

On Sat, 25 Apr 2020 14:48:59 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Here are bugfix/cleanup patches for the kprobe tracer, [1/3]
> is a typo fix, [2/3] is fixing boot-time tracer and [3/3] is
> error checking for the new in-kernel kprobe event API.
> 
> Tom, I found that your commit 29a154810546 ("tracing: Change
> trace_boot to use kprobe_event interface") broke the boot-time
> tracer's kprobe event because of wrong API usage. Could you
> review it?
> 
> I marked [3/3] as a bugfix, because if the loc == NULL, 
> __kprobe_event_gen_cmd_start() obviously does not work.
> But it reports actual error at kprobe_event_gen_cmd_end().
> That is not good for developers to debug it.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing/kprobes: Fix a double initialization typo
>       tracing/boottime: Fix kprobe event API usage
>       tracing/kprobes: Reject new event if loc is NULL
> 
> 
>  kernel/trace/trace_boot.c   |   20 ++++++++------------
>  kernel/trace/trace_kprobe.c |    8 +++++++-
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>

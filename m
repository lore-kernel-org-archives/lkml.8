Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C60C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FE420738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgFDPQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgFDPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:16:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC9420738;
        Thu,  4 Jun 2020 15:16:21 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:16:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Message-ID: <20200604111620.1168c2d9@gandalf.local.home>
In-Reply-To: <20200605000850.9dc797919133e3e245ceda99@kernel.org>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
        <159108891139.42416.16735397217311780715.stgit@devnote2>
        <20200602092145.06afaf72@gandalf.local.home>
        <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
        <20200603103343.2db5b5c6@gandalf.local.home>
        <20200605000850.9dc797919133e3e245ceda99@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 00:08:50 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Thanks, and I've already sent v3.
> 
> https://lkml.kernel.org/r/159115200085.70027.6141550347953439240.stgit@devnote2

I tested that too, and you can keep my Reviewed-by on the patch set.

Shuah,

Want to take v3 for 5.9?

-- Steve

Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF9DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B27D20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgEONPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:15:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053BF206D4;
        Fri, 15 May 2020 13:15:14 +0000 (UTC)
Date:   Fri, 15 May 2020 09:15:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <bobo.shaobowang@huawei.com>, <huawei.libin@huawei.com>,
        <chenwandun@huawei.com>, <mingo@redhat.com>
Subject: Re: [PATCH] ftrace: show debugging information when panic_on_warn
 set
Message-ID: <20200515091513.4947ff02@gandalf.local.home>
In-Reply-To: <20200515100828.7091-1-cj.chengjian@huawei.com>
References: <20200515100828.7091-1-cj.chengjian@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 10:08:28 +0000
Cheng Jian <cj.chengjian@huawei.com> wrote:

> When an anomaly is detected in the function call modification
> code, ftrace_bug() is called to disable function tracing as well
> as give some warn and information that may help debug the problem.
> 
> But currently, we call FTRACE_WARN_ON_ONCE() first in ftrace_bug(),
> so when panic_on_warn is set, we can't see the debugging information
> here. Call FTRACE_WARN_ON_ONCE() at the end of ftrace_bug() to ensure
> that the debugging information is displayed first.
> 
> after this patch, the dmesg looks like:
> 

Thanks, I'll add this to my queue.

-- Steve

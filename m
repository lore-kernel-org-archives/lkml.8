Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC25C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853AA206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TG4lRW1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHKDEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:04:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62167 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgHKDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:04:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597115079; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=72kmcwcMRmFwy2125JyAEHHi3lGljGJFChkfWzOuzJs=; b=TG4lRW1nD5N8bnmmqJLzXeLlLoKllMB7KOx8S5gTH5qWhkB4FOkyCF58W5gSWqdndm9i4JKy
 ZHb5RGx5WoLFQUga15Cdw56aMzYFF9k611QqlzooG/RJvHXuc5Kk2R0trO3wsVih50XfM456
 M40X8UmZQIDQwycqEWVLFwsShq4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f320abb668ab3fef6271f34 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 03:04:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17AF0C43391; Tue, 11 Aug 2020 03:04:27 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79DE7C433C9;
        Tue, 11 Aug 2020 03:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79DE7C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 11 Aug 2020 11:04:18 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200811030418.GA1893@codeaurora.org>
References: <20200728013359.2326-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728013359.2326-1-tingwei@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
On Tue, Jul 28, 2020 at 09:33:53AM +0800, Tingwei Zhang wrote:
> Ftrace has ability to export trace packets to other destination.
> Currently, only function trace can be exported. This series extends the
> support to event trace and trace_maker. STM is one possible destination to
> export ftrace. Use separate channel for each CPU to avoid mixing up
> packets
> from different CPUs together.
> 
> Change from v2:
> Change flag definition to BIT(). (Steven)
> Add comment in stm_ftrace_write() to clarify it's safe to use 
> smp_processor_id() here since preempt is disabled. (Steven) 

Thanks for your comments, Steven.  I've addressed all your comments in v3.
Do you have more comments on v3? Is there anything I need to do to merge
this series to Linux Kernel?

> 
> Change from v1:
> All changes are suggested by Steven Rostedt.
> User separate flag to control function trace, event trace and trace mark.
> Allocate channels according to num_possible_cpu() dynamically.
> Move ftrace_exports routines up so all ftrace can use them.
> 
> Tingwei Zhang (6):
>   stm class: ftrace: change dependency to TRACING
>   tracing: add flag to control different traces
>   tracing: add trace_export support for event trace
>   tracing: add trace_export support for trace_marker
>   stm class: ftrace: enable supported trace export flag
>   stm class: ftrace: use different channel accroding to CPU
> 
>  drivers/hwtracing/stm/Kconfig  |   2 +-
>  drivers/hwtracing/stm/ftrace.c |   7 +-
>  include/linux/trace.h          |   7 +
>  kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
>  4 files changed, 159 insertions(+), 127 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

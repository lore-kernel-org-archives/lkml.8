Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D1EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC1E2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgG0TIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgG0TIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:08:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E76420729;
        Mon, 27 Jul 2020 19:08:14 +0000 (UTC)
Date:   Mon, 27 Jul 2020 15:08:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] stm class: ftrace: use different channel
 accroding to CPU
Message-ID: <20200727150812.3051fa7d@oasis.local.home>
In-Reply-To: <20200726025931.30510-7-tingwei@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
        <20200726025931.30510-7-tingwei@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 10:59:31 +0800
Tingwei Zhang <tingwei@codeaurora.org> wrote:

> --- a/drivers/hwtracing/stm/ftrace.c
> +++ b/drivers/hwtracing/stm/ftrace.c
> @@ -37,8 +37,9 @@ static void notrace
>  stm_ftrace_write(struct trace_export *export, const void *buf, unsigned int len)
>  {
>  	struct stm_ftrace *stm = container_of(export, struct stm_ftrace, ftrace);
> +	unsigned int cpu = smp_processor_id();

Probably should add a comment to the above stating that this is called
from the tracing system with preemption disabled.

Other than my two comments:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  
> -	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
> +	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
>  }
>  
>  static int stm_ftrace_link(struct stm_source_data *data)

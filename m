Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F8320714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BuOwFYfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgG1A2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:28:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32381 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG1A2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:28:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595896118; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+om2piDGXGBlw4ipkgZQ7yTsnGbyw5aoar8ai8lEEUc=; b=BuOwFYfxbpPDBRUIxzHyfkyLPCL9T6buBCEr4EkaXt6yILpdiIboGD5HaAycIxKlfXE/eiwk
 aGCH6E6EBbc/RTnr6SSfsyu+iPEe5bbk0Lssu8+EJq3AJZvqJcMpoXcyx34o5hREhKIKMTPK
 QOhT7iOkOIizgC0eFh1Die4nN54=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f1f71307186ea1ee15ac688 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 00:28:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C360C43391; Tue, 28 Jul 2020 00:28:32 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D2CEC433C9;
        Tue, 28 Jul 2020 00:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D2CEC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 28 Jul 2020 08:28:23 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] stm class: ftrace: use different channel
 accroding to CPU
Message-ID: <20200728002823.GA10290@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
 <20200726025931.30510-7-tingwei@codeaurora.org>
 <20200727150812.3051fa7d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727150812.3051fa7d@oasis.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
On Tue, Jul 28, 2020 at 03:08:12AM +0800, Steven Rostedt wrote:
> On Sun, 26 Jul 2020 10:59:31 +0800
> Tingwei Zhang <tingwei@codeaurora.org> wrote:
> 
> > --- a/drivers/hwtracing/stm/ftrace.c
> > +++ b/drivers/hwtracing/stm/ftrace.c
> > @@ -37,8 +37,9 @@ static void notrace
> >  stm_ftrace_write(struct trace_export *export, const void *buf, unsigned
> int len)
> >  {
> >  	struct stm_ftrace *stm = container_of(export, struct stm_ftrace,
> ftrace);
> > +	unsigned int cpu = smp_processor_id();
> 
> Probably should add a comment to the above stating that this is called
> from the tracing system with preemption disabled.
> 

Good point. I'll add that comment in next revision.

Thanks,
Tingwei

> Other than my two comments:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> >  
> > -	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
> > +	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
> >  }
> >  
> >  static int stm_ftrace_link(struct stm_source_data *data)

Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7633AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4589E206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NV4P+yQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgIAXZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:25:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43636 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAXZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:25:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599002737; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ZkW7ty3uIzuXHYRN5kYKENLHrMZzk/bA3jjECy/fIlU=; b=NV4P+yQzBU2X6Z4SZix163mbPj820MdOSEyywio0p39l+XvNqVu0cGIXXe0EgRmfZRJDk5RL
 ZRPD8kI8nr0dTfP2XpWjrFnUygBYLA/ESpQPzBDgSgVUCKJM10sWJUnEQv/UQhCLXAz6flrv
 A1jZXHvVTdgD2wltLyE/Z9jZZR4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f4ed86ed3d3df8c3987699c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 23:25:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71159C43395; Tue,  1 Sep 2020 23:25:34 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC6E8C433C6;
        Tue,  1 Sep 2020 23:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC6E8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Wed, 2 Sep 2020 07:25:25 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200901232524.GA13346@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
 <20200901063740.GB13784@codeaurora.org>
 <20200901170549.GA236120@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901170549.GA236120@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:05:49AM +0800, Mathieu Poirier wrote:
> On Tue, Sep 01, 2020 at 02:37:40PM +0800, Tingwei Zhang wrote:
> > Hi Mathieu,
> > 
> > May I know your comments for this patch set?
> 
> I do not maintain any of these files.
> 
Sorry for my wrong assumption.

> > 
> > Thanks,
> > Tingwei
> > 
> > On Thu, Aug 13, 2020 at 09:45:46AM +0800, Tingwei Zhang wrote:
> > > Ftrace has ability to export trace packets to other destination.
> > > Currently, only function trace can be exported. This series extends
> the
> > > support to event trace and trace_maker. STM is one possible
> destination to
> > > export ftrace. Use separate channel for each CPU to avoid mixing up
> > > packets
> > > from different CPUs together.
> > > 
> > > Change from v2:
> > > Change flag definition to BIT(). (Steven)
> > > Add comment in stm_ftrace_write() to clarify it's safe to use 
> > > smp_processor_id() here since preempt is disabled. (Steven) 
> > > 
> > > Change from v1:
> > > All changes are suggested by Steven Rostedt.
> > > User separate flag to control function trace, event trace and trace
> mark.
> > > Allocate channels according to num_possible_cpu() dynamically.
> > > Move ftrace_exports routines up so all ftrace can use them.
> > > 
> > > Tingwei Zhang (6):
> > >   stm class: ftrace: change dependency to TRACING
> > >   tracing: add flag to control different traces
> > >   tracing: add trace_export support for event trace
> > >   tracing: add trace_export support for trace_marker
> > >   stm class: ftrace: enable supported trace export flag
> > >   stm class: ftrace: use different channel accroding to CPU
> > > 
> > >  drivers/hwtracing/stm/Kconfig  |   2 +-
> > >  drivers/hwtracing/stm/ftrace.c |   7 +-
> > >  include/linux/trace.h          |   7 +
> > >  kernel/trace/trace.c           | 270
> ++++++++++++++++++---------------
> > >  4 files changed, 159 insertions(+), 127 deletions(-)
> > > 
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > > a Linux Foundation Collaborative Project
> > > 

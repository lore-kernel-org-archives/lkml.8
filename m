Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CFC2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BA12078B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fxTSfqp3";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aMItw1CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgIKCtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:49:47 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:34530
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599792582;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=5KK85+dfJXgPi6ADBxmN30HWzErDUq8NOg2n9wo+q88=;
        b=fxTSfqp3nOCaY1PkZUV4uWWfXKSt3NJbNZce/gINk9DlTE7DRfNRtkV8IDwx0UAE
        32FDQpUjytwKsHsMgyaBN/TAke6gs7JVKhvT5Yl/c/Bjq2tqmBQUFUaqumx7pMgs/WN
        HZLj6Iv1R4WtlCA82xLGhdRjgu0T3KgKXr8IfhSI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599792582;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=5KK85+dfJXgPi6ADBxmN30HWzErDUq8NOg2n9wo+q88=;
        b=aMItw1COIrlhQZk4m/Qyqu1YkgvhS/RnpQpaT+ccPGpGQPsvdSSKDwSD0TNN1Wed
        nSMvPU07JVIc13A1PqD6FdXgEIT9s4JLgizwXXGeXFTMHbiBKtbR0yvvdkwtn9lTQBL
        VkR96Qku+5TILGjt2zOGztILJtlJbc+6b1vfdmzc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62866C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Fri, 11 Sep 2020 02:49:42 +0000
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/24] coresight: etm: perf: Fix warning caused by
 etm_setup_aux failure
Message-ID: <010101747b118e3c-ed32d3e5-f1ed-4c6d-993d-cf7355832c82-000000@us-west-2.amazonses.com>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-9-tingwei@codeaurora.org>
 <20200910222840.GB590446@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910222840.GB590446@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 06:28:40AM +0800, Mathieu Poirier wrote:
> On Fri, Aug 21, 2020 at 11:44:29AM +0800, Tingwei Zhang wrote:
> > When coresight_build_path() fails on all the cpus, etm_setup_aux
> > calls etm_free_aux() to free allocated event_data.
> > WARN_ON(cpumask_empty(mask) will be triggered since cpu mask is empty.
> > Check event_data->snk_config is not NULL first to avoid this
> > warning.
> > 
> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> What happend to the Fixed tag that was in V8?  This is casting doubts on
> the
> reset of this set.  
> 
Hi Mathieu,

Sorry about the mess here. I pushed the change to Android mainline and missed
fix tag when making V10.

To make sure there's no other missing, I compared all V8 and V10 patches and
rechecked all comments on V8.

Two issues were found.
1. Reviewed-by from you on [patch 5/24] should not be added.
2. MODULE_LICENSE("GPL v2") was missed in V10.

I'll fix all issues on V11.

Shall I send V11 when it's ready or wait for your comments on other patches?

Thanks,
Tingwei

> > ---
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
> b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index dcb0592418ae..3728c44e5763 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -126,10 +126,10 @@ static void free_sink_buffer(struct etm_event_data
> *event_data)
> >  	cpumask_t *mask = &event_data->mask;
> >  	struct coresight_device *sink;
> >  
> > -	if (WARN_ON(cpumask_empty(mask)))
> > +	if (!event_data->snk_config)
> >  		return;
> >  
> > -	if (!event_data->snk_config)
> > +	if (WARN_ON(cpumask_empty(mask)))
> >  		return;
> >  
> >  	cpu = cpumask_first(mask);
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > a Linux Foundation Collaborative Project
> > 

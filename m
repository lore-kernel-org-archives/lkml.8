Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2206C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="A4eoImj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEHIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:40:16 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37554 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbgEHIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:40:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588927215; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=U8WB7PXvDyOOGWwi9MUE50MiskyrC0/FxTzenx6c3WM=; b=A4eoImj5MRR/7sFRlYGd9mBK61cOO60TNQ5Y6zUiM2w5FIedIWHHT0VIIIa33kzK1JyMIYTv
 MXlku1BBa17TrbhwB+t7pH2iI2WCKAQrjhnDgfsTEv7jnh6iCqAOXd3DLPWw1S9ll4YCeVF9
 RXYIdrbvyarxhvkQ8zUa7TS/z0Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb51aea.7fb6b5562768-smtp-out-n01;
 Fri, 08 May 2020 08:40:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 726B3C44792; Fri,  8 May 2020 08:40:09 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5BB3C433BA;
        Fri,  8 May 2020 08:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5BB3C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Fri, 8 May 2020 14:10:02 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 1/4] sched/core: Introduce per_cpu counter to track latency
 sensitive tasks
Message-ID: <20200508084002.GK19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-2-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507133723.18325-2-parth@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:07:20PM +0530, Parth Shah wrote:
> The "nr_lat_sensitive" per_cpu variable provides hints on the possible
> number of latency-sensitive tasks occupying the CPU. This hints further
> helps in inhibiting the CPUIDLE governor from calling deeper IDLE states
> (next patches includes this).
> 

Can you please explain the intended use case here? Once a latency sensitive
task is created, it prevents c-state on a CPU whether the task runs again
or not in the near future.

I assume, either these latency sensitive tasks won't be around for long time
or applications set/reset latency sensitive nice value dynamically.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

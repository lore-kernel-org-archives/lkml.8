Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F62C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9BB2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dJTopR/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDGL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:29:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:17416 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgDGL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:29:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586258946; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZqIKa/adNoURxS84sdyk+/pbhzhboQnmhn2fnf8Bnbk=;
 b=dJTopR/qzXaRE8wIIRqPQDX26rMFTdeK4lCeE19eSFSirz1BRt73sX9C1M8X45w//Z7kKbFH
 pkGyuA2brzdMK2J3lD84plNekL/7YP4OS7M0KoD2zz5hQpsgF0CnosHkDwIhWEDH3gPZk0Wd
 GoHNGsSNfL4bKc8ssixpafFOtwM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c6402.7ff5dc09b8b8-smtp-out-n03;
 Tue, 07 Apr 2020 11:29:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D972C44788; Tue,  7 Apr 2020 11:29:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 760AEC433F2;
        Tue,  7 Apr 2020 11:29:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Apr 2020 16:59:05 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mike.leach@linaro.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        swboyd@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH] coresight: dynamic-replicator: Fix handling of
 multiple connections
In-Reply-To: <906d374d-a4d6-f2f2-6845-88b97a5ff7d9@arm.com>
References: <20200405102819.28460-1-saiprakash.ranjan@codeaurora.org>
 <CAJ9a7VgQzK1XSCvLwuqODwkWfvo=6Wwps7Db+pL5xYDeCuktrg@mail.gmail.com>
 <6c0f45488f8a44bf860759e00fcabd09@codeaurora.org>
 <906d374d-a4d6-f2f2-6845-88b97a5ff7d9@arm.com>
Message-ID: <39a2b3fff165a108fa59d72b630b5f14@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

Thanks for looking into this issue.

On 2020-04-07 15:54, Suzuki K Poulose wrote:
> On 04/07/2020 10:46 AM, Sai Prakash Ranjan wrote:
> 
> There seems to be two replicators back to back here. What is connected
> to the other output of both of them ? Are there any TPIUs ? What 
> happens
> if you choose a sink on the other end of "swao_replicator" (ETB ?)
> 

The other outport of swao replicator is connected to EUD which is a
QCOM specific HW which can be used as a sink like USB.
And the other outport of other replicator(replicator_out) is connected 
to
TPIU.

> After boot, what do the idfilter registers read for both the 
> replicators ?
> 

Added some prints in replicator_probe.

  replicator probe ret=-517 devname=6046000.replicator idfilter0=0x0 
idfilter1=0x0
  replicator probe ret=0 devname=6b06000.replicator idfilter0=0xff 
idfilter1=0xff
  replicator probe ret=0 devname=6046000.replicator idfilter0=0xff 
idfilter1=0xff

> 
> I believe we need to properly assign the TRACE_IDs for tracing 
> sessions,
> (rather than static ids) in a way such that we could filter them and 
> use
> the multiple sinks in parallel for separate trace sessions and this is
> not simple (involves kernel driver changes and the perf tool to be able
> to decode the trace id changes too).
> 
> 
> So for the moment, we need to :
> 
> 1) Disallow turning the replicator ON, when it is already turned ON
> 2) Do what your patch does. i.e, disable the other end while one end
>    is turned on.
> 
> Thoughts ?
> 

Sounds good to me, Mike would have some comments.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

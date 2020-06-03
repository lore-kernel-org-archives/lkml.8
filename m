Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B6120678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HPC31y7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFCMPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:15:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49532 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgFCMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:15:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591186507; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JbS524Cnw2NfPr05sWSsjesDpzR7nsPveFPmkLicFCE=;
 b=HPC31y7F6gP+8cLfU7A1e9TiYrqfVyETumlxRV65uDKYa61CF5PTYgNBgZGyD+DGnJ2IaI7S
 ydybXfkxJ2xXWjBFjR9KUIIM2kdKROuGapnosj6V0S8u026n6jZ7ZwPdAZiA+AE//4SkHeOi
 OovHFlwBYZKS+GLO1DpHzhPEPtc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ed79436eca06aba7e194fe0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 12:14:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FBB8C43387; Wed,  3 Jun 2020 12:14:46 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3729C433CA;
        Wed,  3 Jun 2020 12:14:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 17:44:45 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, robin.murphy@arm.com
Subject: Re: [PATCH 2/2] coresight: tmc: Add shutdown callback for TMC ETR/ETF
In-Reply-To: <CAJ9a7Vj9STJw4jBxWU_9wHftj4Q7+k8o1nTc8tr21KjYi0RkpQ@mail.gmail.com>
References: <cover.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <28123d1e19f235f97555ee36a5ed8b52d20cbdea.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <20200601212858.GB24287@xps15>
 <6d759cc28628ea72767c1304883630eb@codeaurora.org>
 <CAJ9a7VhMbdqVBHxEXGYxFkgPnnQqNnDAz=wkHP3s7Ntw0iLmKA@mail.gmail.com>
 <f0357072de96970b641bbd0da98c1d61@codeaurora.org>
 <CAJ9a7Vj9STJw4jBxWU_9wHftj4Q7+k8o1nTc8tr21KjYi0RkpQ@mail.gmail.com>
Message-ID: <4a09cd2e054836d85f2e024ca4435e91@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2020-06-03 16:57, Mike Leach wrote:
> Hi,
> 
> On Wed, 3 Jun 2020 at 11:24, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi Mike,
>> 
>> Thanks again for looking at this.
>> 
>> On 2020-06-03 03:42, Mike Leach wrote:
>> [...]
>> 
>> >>
>> >> SMMU/IOMMU won't be able to do much here as it is the client's
>> >> responsiblity to
>> >> properly shutdown and SMMU device link just makes sure that
>> >> SMMU(supplier) shutdown is
>> >> called only after its consumers shutdown callbacks are called.
>> >
>> > I think this use case can be handled slightly differently than the
>> > general requirements for modular CoreSight drivers.
>> >
>> > What is needed here is a way of stopping the underlying ETR hardware
>> > from issuing data to the SMMU, until the entire device has been shut
>> > down, in a way that does not remove the driver, breaking existing
>> > references and causing a system crash.
>> >
>> > We could introduce a new mode to the ETR driver - e.g.
>> > CS_MODE_SHUTDOWN.
>> >
>> > At the end of the block tmc_shutdown(struct amba_device *adev), set
>> > drvdata->mode to CS_MODE_SHUTDOWN & remove the coresight_unregister().
>> > This new mode can be used to  prevent the underlying hardware from
>> > being able to restart until the device is re-powered.
>> >
>> > This mode can be detected in the code that enables / disables the ETR
>> > and handled appropriately (updates to tmc_enable_etr_sink and
>> > tmc_disable_etr_sink).
>> > This mode will persist until the device is re-started - but because we
>> > are on the device shutdown path this is not an issue.
>> >
>> > This should leave the CoreSight infrastructure stable until the
>> > drivers are shut down normally as part of the device power down
>> > process.
>> >
>> 
>> Sounds good to me, but if the coresight_unregister() is the trouble
>> point
>> causing these crashes, then can't we just remove that from
>> tmc_shutdown()
>> callback? This would be like maintaining the same behaviour as now 
>> where
>> on reboot/shutdown we basically don't do anything except for disabling
>> ETR.
> 
> No - the new mode prevents race conditions where the thread shutting
> down the SMMU does the ETR shutdown, but then another thread happens
> to be trying to start trace and restarts the ETR.
> It also prevents the condition Mathieu discussed where a thread might
> be attempting to shutdown trace - this could try to disable the
> hardware again re-releasing resources/ re-flushing and waiting for
> stop.
> 

I do not think there will a race between SMMU shutdown and ETR shutdown.
Driver core takes care of calling SMMU shutdown after its consumer
shutdown callbacks via device link, otherwise there would already be
bugs in all other client drivers.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245720719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BhcfFCPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbgCPQhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:37:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63326 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732158AbgCPQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:37:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584376638; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Z4SetJr+WVQFYQOeb4040xyBonyw20d7MV9fV+K7/JQ=;
 b=BhcfFCPsPB+KXj9dIKdRt5nsrjqx6jqRE3toBvbjYvN1UyHTCwBfsLZVGhbSNGomoEx2qpCr
 KdmgLEJcZrJ09pCzK0CXme6RcOeKOqZfhXcFpFcdHXkQWcOalhTvbKTQ9z9JDIbypD1GTbW2
 sBsmViLxhJZmriqo2MGbkr7cH68=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6fab33.7f12f8660068-smtp-out-n02;
 Mon, 16 Mar 2020 16:37:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5D97C4478F; Mon, 16 Mar 2020 16:37:05 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B31C432C2;
        Mon, 16 Mar 2020 16:37:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 22:07:04 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, joro@8bytes.org,
        ohad@wizery.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        agross@kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
In-Reply-To: <20200316155028.GB18704@infradead.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200316155028.GB18704@infradead.org>
Message-ID: <8cfddb6cbc424b131c9ab823c0c0f3f1@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christoph,
Thanks for taking time to review
the series.

On 2020-03-16 21:20, Christoph Hellwig wrote:
> On Mon, Mar 09, 2020 at 11:52:52PM +0530, Sibi Sankar wrote:
>> The Q6 modem sub-system has direct access to DDR through memnoc and
>> an indirect access routed through a SMMU which MSS CE (crypto engine
>> sub-component of MSS) uses during out of reset sequence. Request 
>> direct
>> mapping for the modem-firmware subdevice since smmu is not expected
>> to provide access control/translation for these SIDs (sandboxing of 
>> the
>> modem is achieved through XPUs engaged using SMC calls).
> 
> Please fix your device tree so that the device isn't bound to an
> IOMMU.

the bindings proposed in the series
would add a sub-device with an iommu
property.

modem_pil: remoteproc@xxxxx {
...
    modem-firmware {
         iommus = <&apps_smmu 0x460 0x1>;
    };
...
};

Remoteproc device will not have a iommu
property but modem-firmware sub-device
will.

With ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT y,
we would want to configure the SID either
in direct mapping or bypass (either will
do since protection is achieved through
other means)

https://lore.kernel.org/lkml/497e40b8-300f-1b83-4312-93a58c459d1d@arm.com/

Currently the restructuring is trending
towards whats discussed in the ^^ thread.
i.e either direct mapping/bypass will be
done in the SoC specific corner of the
SMMU driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

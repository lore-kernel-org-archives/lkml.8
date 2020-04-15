Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A1C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEC020775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pWFnNubA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896360AbgDOKND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:13:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26676 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896285AbgDOKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:11:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586945489; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=6Fmu2bYxuswkx5JslalXSUya4FFPt0PklF5SeocK9A0=; b=pWFnNubAbbhO64QKx5c8+UHZbyWr1833gK0rSJmQPSmRqRGaoV8Hvm0+r3ytZTgDvmqN86t3
 rq9nUl0IWXXrU6dXQiGw20OoK6PF+LZ2M8wHaAp6L+jroA0Y0W4Jjd1HaVemE0vcccXGz1lZ
 i86RjZ4aR/ATBhQZhYrMpHe/vBM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e96ddc9.7f76bbeaa960-smtp-out-n05;
 Wed, 15 Apr 2020 10:11:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99783C432C2; Wed, 15 Apr 2020 10:11:20 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBE8FC433F2;
        Wed, 15 Apr 2020 10:11:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Apr 2020 15:41:19 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
Message-ID: <44be117e4661f9ccb64480912644420f@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020-04-13 20:42, Jordan Crouse wrote:
> On Thu, Apr 09, 2020 at 04:31:24PM -0700, Matthias Kaehlcke wrote:
>> On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
>> > Hello Robin, Will
>> >
>> > On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
>> > > This series allows drm devices to set a default identity
>> > > mapping using iommu_request_dm_for_dev(). First patch is
>> > > a cleanup to support other SoCs to call into QCOM specific
>> > > implementation and preparation for second patch.
>> > > Second patch sets the default identity domain for drm devices.
>> > >
>> > > Jordan Crouse (1):
>> > >   iommu/arm-smmu: Allow client devices to select direct mapping
>> > >
>> > > Sai Prakash Ranjan (1):
>> > >   iommu: arm-smmu-impl: Convert to a generic reset implementation
>> > >
>> > >  drivers/iommu/arm-smmu-impl.c |  8 +++--
>> > >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
>> > >  drivers/iommu/arm-smmu.c      |  3 ++
>> > >  drivers/iommu/arm-smmu.h      |  5 ++++
>> > >  4 files changed, 65 insertions(+), 6 deletions(-)
>> >
>> > Any review comments?
>> 
>> Ping
>> 
>> What is the status of this series, is it ready to land or are any 
>> changes
>> needed?
>> 
>> Thanks
>> 
>> Matthias
> 
> I think this is up in the air following the changes that Joerg 
> suggested:
> https://lists.linuxfoundation.org/pipermail/iommu/2020-April/043017.html
> 

1st patch for generic reset in this series is independent and can be 
merged.
But seems like requesting direct mapping fails with the joerg's patch 
series.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

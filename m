Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4559C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A909120857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DseFGZDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgDKJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 05:20:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23469 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgDKJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:20:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586596827; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=m64rlGIY/ze74hM+6TJxI24Fs9sSBQEMm8EnQhf5+Gs=;
 b=DseFGZDVKeLKQbyMLjK9d0Oh15b/EKcDQy1gmuQqxhNSpOGroBmWRSaR2M/lO7ZZsPCdb7Kt
 rO3cpvqAL1421nBCyhxgB+K6veJ5ENrTINW1h94dXruZ8WHk75UGv1nagV3sd9OrzQmrRaGE
 uBOQ3oxpUwyxIza4tpmE1Ib3R4M=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e918bce.7fea463b8b58-smtp-out-n03;
 Sat, 11 Apr 2020 09:20:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAD9CC4478F; Sat, 11 Apr 2020 09:20:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01845C433CB;
        Sat, 11 Apr 2020 09:20:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Apr 2020 14:50:12 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <20200409233124.GW199755@google.com>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <7761534cdb4f1891d993e73931894a63@codeaurora.org>
 <20200409233124.GW199755@google.com>
Message-ID: <6714ba4f73f6518e5f2f427a0bcc6c53@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2020-04-10 05:01, Matthias Kaehlcke wrote:
> On Tue, Feb 04, 2020 at 11:12:17PM +0530, Sai Prakash Ranjan wrote:
>> Hello Robin, Will
>> 
>> On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
>> > This series allows drm devices to set a default identity
>> > mapping using iommu_request_dm_for_dev(). First patch is
>> > a cleanup to support other SoCs to call into QCOM specific
>> > implementation and preparation for second patch.
>> > Second patch sets the default identity domain for drm devices.
>> >
>> > Jordan Crouse (1):
>> >   iommu/arm-smmu: Allow client devices to select direct mapping
>> >
>> > Sai Prakash Ranjan (1):
>> >   iommu: arm-smmu-impl: Convert to a generic reset implementation
>> >
>> >  drivers/iommu/arm-smmu-impl.c |  8 +++--
>> >  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
>> >  drivers/iommu/arm-smmu.c      |  3 ++
>> >  drivers/iommu/arm-smmu.h      |  5 ++++
>> >  4 files changed, 65 insertions(+), 6 deletions(-)
>> 
>> Any review comments?
> 
> Ping
> 
> What is the status of this series, is it ready to land or are any 
> changes
> needed?
> 

I am wondering the same :)

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

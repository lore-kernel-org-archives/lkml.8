Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EEAC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289982087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="e1IPwZj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBDRmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:42:22 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:15058 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbgBDRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:42:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580838141; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3GsEF9tQsQwX5+o3nKkgPwf7PL4h+Nm6qziK+o3nvkQ=;
 b=e1IPwZj6i2+fR3CdwA6aLpeXC1sxrF0rai5JlSMW/jpHl3CjqH2ynYftVGBvaZqX4aHQuzRj
 Zh9ckzPnaqurX3qVwWqz9fOs5dn2rvGORP7uBZVi8vM5IkRkIG4XhXNeusMIo+d1Eo2YGnHb
 Il1nBFk1FGOMY3t1vZdrw2c7scs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e39acfc.7f20bdd449d0-smtp-out-n02;
 Tue, 04 Feb 2020 17:42:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D97CC447A6; Tue,  4 Feb 2020 17:42:18 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B58DC433CB;
        Tue,  4 Feb 2020 17:42:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Feb 2020 23:12:17 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
In-Reply-To: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <7761534cdb4f1891d993e73931894a63@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin, Will

On 2020-01-22 17:18, Sai Prakash Ranjan wrote:
> This series allows drm devices to set a default identity
> mapping using iommu_request_dm_for_dev(). First patch is
> a cleanup to support other SoCs to call into QCOM specific
> implementation and preparation for second patch.
> Second patch sets the default identity domain for drm devices.
> 
> Jordan Crouse (1):
>   iommu/arm-smmu: Allow client devices to select direct mapping
> 
> Sai Prakash Ranjan (1):
>   iommu: arm-smmu-impl: Convert to a generic reset implementation
> 
>  drivers/iommu/arm-smmu-impl.c |  8 +++--
>  drivers/iommu/arm-smmu-qcom.c | 55 +++++++++++++++++++++++++++++++++--
>  drivers/iommu/arm-smmu.c      |  3 ++
>  drivers/iommu/arm-smmu.h      |  5 ++++
>  4 files changed, 65 insertions(+), 6 deletions(-)

Any review comments?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6327C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4EA24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Hufku/C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgCJOBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:01:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:34379 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgCJOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:01:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583848911; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=czufNzXPZ6lBC2QNJ+K0CqApWW5+g5vWavRGt2Bpfjc=;
 b=Hufku/C0i+Nq0pBVt3sNwZtgdB7rt8tLIODsnLxOVS4Rswlx3POy7DriJi4482Kh3KppXSpg
 tg4yp2hVsbVK8yuoFLRepuGlJwwxB7qgiCK6s5t7DvXuq5jV+q+6rTEC0AVC/cJwUZHB2cU0
 3OTf2D0k4GXEPBhWpHzA/G8pLUI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e679d94.7fd90d2dea78-smtp-out-n03;
 Tue, 10 Mar 2020 14:00:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2CC5C4478C; Tue, 10 Mar 2020 14:00:50 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F530C432C2;
        Tue, 10 Mar 2020 14:00:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 19:30:50 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        agross@kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
In-Reply-To: <20200310112332.GG3794@8bytes.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
 <20200310112332.GG3794@8bytes.org>
Message-ID: <4ed6ddd667a3e6f670084a443d141474@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joerg,
Thanks for taking time to review
the series!

On 2020-03-10 16:53, Joerg Roedel wrote:
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
> So the DMA accesses are initiated by the firmware and need to be direct
> mapped? Which memory region do they access?

The accesses are initiated by the firmware
and they access modem reserved regions.
However as explained in ^^ any accesses
outside the region will result in a violation
and is controlled through XPUs (protection units).

With ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT y
the firmware SIDs will explicitly need to
be directly mapped to avoid observing
global faults in the absence of secure
firmware (TrustZone) programming the modem
SIDs as S2CR-Bypass.

> 
> Regards,
> 
> 	Joerg

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

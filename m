Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA65C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFA020781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b7SDv7iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgHMFhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:37:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30630 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgHMFhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:37:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597297044; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FWAfiwn/2LtjfC+jVU8NoR3c1nS9gxFfZo5aGupJqbI=; b=b7SDv7iJCkO6Ozh49tuDhhKmkehIZIXT2eDvUCN42hex/JrNgrGHfSGrVRcYmdHglKnWQbmM
 CcW+Aq+Zd4oB/Hfgc5/hT3P4Bj1hUeHCKXUfOf0wiWc4BN7wdHdEfzOCvFTJGp8HT3hAVUop
 zY07jXicwuxb0+mA3UEenh5l2Ys=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f34d1932f4952907d9ad366 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 05:37:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1914CC433C9; Thu, 13 Aug 2020 05:37:23 +0000 (UTC)
Received: from [192.168.43.216] (unknown [157.48.144.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6075CC433C6;
        Thu, 13 Aug 2020 05:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6075CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, kernel-team@android.com
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
 <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
 <20200812151608.GG3721@8bytes.org>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <b6c7eb2b-d1f5-058f-943c-1b7c14fe1f7c@codeaurora.org>
Date:   Thu, 13 Aug 2020 11:06:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812151608.GG3721@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2020 8:46 PM, Joerg Roedel wrote:
> On Mon, Aug 03, 2020 at 03:30:48PM +0530, Vijayanand Jitta wrote:
>> ping?
> 
> Please repost when v5.9-rc1 is released and add
> 
> 	Robin Murphy <robin.murphy@arm.com>
> 
> on your Cc list.
> 
> Thanks,
> 
> 	Joerg
> 

Sure, will do.

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D5C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C7021D95
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pBNYSv1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506623AbgDPLqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:46:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:38255 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504857AbgDPK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:26:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587032793; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7e7yje6Jk92q2KWOzUZdbFCXe9Taa4CbqlpJEFe/hWg=;
 b=pBNYSv1opwwNWkriETMzldswAcDR1LsnGCkke6wQRxF6NYHI/9SP6hTK2Lz64Z7qeJ1dba8y
 EzaAVRgt5Nn03C11y7H7oXOZ1AwNmRhRvq9jKPC0J+Qs6o5M07JapcAkmDJk07qkH4C2NRZS
 0rFMY0PzVY3vR71l9ZITBj3yVLs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9832d6.7ff68f8d8490-smtp-out-n02;
 Thu, 16 Apr 2020 10:26:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41C33C44788; Thu, 16 Apr 2020 10:26:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BE44C433F2;
        Thu, 16 Apr 2020 10:26:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 15:56:28 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/8] Relax sanity checking for mismatched AArch32 EL1
In-Reply-To: <a86108a91975cacf94adc2a2101fba1b@codeaurora.org>
References: <20200414213114.2378-1-will@kernel.org>
 <a86108a91975cacf94adc2a2101fba1b@codeaurora.org>
Message-ID: <e801954c0a14bf9483c084845c18dbfd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-16 14:09, Sai Prakash Ranjan wrote:
> On 2020-04-15 03:01, Will Deacon wrote:
>> Hi all,
>> 
>> For better or worse, there are SoCs in production where some, but not
>> all of the CPUs, support AArch32 at EL1 and above. Right now, that
>> results in "SANITY CHECK" warnings during boot and an unconditional
>> kernel taint.
>> 
>> This patch series tries to do a bit better: the only time we care 
>> about
>> AArch32 at EL1 is for KVM, so rather than throw our toys out of the
>> pram, we can instead just disable support for 32-bit guests on these
>> systems. In the unlikely scenario of a late CPU hotplug being the 
>> first
>> time we notice that AArch32 is not available, then we fail the hotplug
>> (right now we let the thing come online, which leads to hilarious
>> results for any pre-existing 32-bit guests).
>> 
>> Feedback welcome,
>> 
>> Will
>> 
> 
> Thanks Will, tested this series on QCOM SC7180 and SM8150 SoCs.
> 
> For the entire series,
> 
> Tested-by: saiprakash.ranjan@codeaurora.org
> 

Urgh sorry, it should be

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

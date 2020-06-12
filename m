Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA46C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D43120792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PeAruZbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFLN5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:57:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60552 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgFLN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:57:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591970261; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Nnwzt7zuQMOUqUoSvTtGqjQ2ZaQh545isYVqaS3gMII=; b=PeAruZbCvaFGZvq+6sebTUV12a9i0bOGqMGzJhZbafuFb+zebQ2WmeIur772esI2p8bgkjOM
 gDekolHZ4MsK9rxzsMAapGQlrcmcwHtTmVOqbiDONwcd59qjzZksmABq3yKqDtwGEbZ9+NZ0
 bmBjBzmwrx+C4//OGideU2Gp9Vc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ee389cba3d8a44743905998 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 13:57:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFF69C433C8; Fri, 12 Jun 2020 13:57:30 +0000 (UTC)
Received: from [10.213.44.202] (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sthombre)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97A90C433CB;
        Fri, 12 Jun 2020 13:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97A90C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sthombre@codeaurora.org
Subject: Re: [PATCH] arm64: mm: reset address tag set by kasan sw tagging
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will.deacon@arm.com, ard.biesheuvel@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, sashal@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jcrouse@codeaurora.org
References: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
 <20200610113626.GI26099@gaia>
From:   Shyam Thombre <sthombre@codeaurora.org>
Message-ID: <809f4dc3-cba1-25b9-36cf-492e3b434530@codeaurora.org>
Date:   Fri, 12 Jun 2020 19:27:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610113626.GI26099@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 6/10/2020 5:06 PM, Catalin Marinas wrote:
> On Wed, Jun 10, 2020 at 04:39:44PM +0530, Shyam Thombre wrote:
>> KASAN sw tagging sets a random tag of 8 bits in the top byte of the pointer
>> returned by the memory allocating functions. So for the functions unaware
>> of this change, the top 8 bits of the address must be reset which is done
>> by the function arch_kasan_reset_tag().
>>
>> Signed-off-by: Shyam Thombre <sthombre@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e7fbc62..eae7655 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -723,6 +723,7 @@ int kern_addr_valid(unsigned long addr)
>>   	pmd_t *pmdp, pmd;
>>   	pte_t *ptep, pte;
>>   
>> +	addr = arch_kasan_reset_tag(addr);
>>   	if ((((long)addr) >> VA_BITS) != -1UL)
>>   		return 0;
> 
> It would be interesting to know what fails without this patch. The only
> user seems to be read_kcore() and, at a quick look, I don't see how it
> can generate tagged addresses.
> 

This issue is seen in downstream GPU drivers. It currently doesn't look 
to impact any upstream users.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

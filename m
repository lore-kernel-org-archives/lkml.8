Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4271C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBBC207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n5p84T7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgFKE2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:28:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40987 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKE2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:28:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591849696; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=gVV31ZvrsQs/Uco3J5gyDfKMY3IQRdWuUqs0bs1YP7o=; b=n5p84T7j7kTLloRCQIwTMk7jKtNEk3iMLZTS+wYWUl6snloQKr9MyytuAZPm4KI2wZuMJEuo
 7loPZ0NgNqPMjp9SgS6HSoJdpiFJju6wE20/9GT8kPYDgy+ld+kv0nk9Oj75ChnKb2UE1hOy
 bPQJRcoVH20vuVtZtAYICeVnBHE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5ee1b2d70206ad41d1d7a877 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 04:28:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EC63C433C6; Thu, 11 Jun 2020 04:28:06 +0000 (UTC)
Received: from [192.168.0.105] (unknown [183.83.153.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF7D7C433CA;
        Thu, 11 Jun 2020 04:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF7D7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V2 2/2] mtd: rawnand: qcom: set BAM mode only if not set
 already
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
 <1591701056-3944-3-git-send-email-sivaprak@codeaurora.org>
 <20200609160352.60cbad80@xps13>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <2abac8fb-28ac-5137-70cc-47cbd20613b7@codeaurora.org>
Date:   Thu, 11 Jun 2020 09:57:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609160352.60cbad80@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Thanks for the review.

On 6/9/2020 7:33 PM, Miquel Raynal wrote:
> Hi Sivaprakash,
>
> Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Tue,  9 Jun
> 2020 16:40:56 +0530:
>
>> BAM mode is set by writing BAM_MODE_EN bit on NAND_CTRL register.
>> NAND_CTRL is an operational register and in BAM mode operational
>> registers are read only.
>>
>> So, before writing into NAND_CTRL register check if BAM mode is already
>> enabled by bootloader, and set BAM mode only if it is not set already.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>>   drivers/mtd/nand/raw/qcom_nandc.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
>> index e0afa2c..7740059 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -2779,7 +2779,14 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>>   	/* enable ADM or BAM DMA */
>>   	if (nandc->props->is_bam) {
>>   		nand_ctrl = nandc_read(nandc, NAND_CTRL);
>> -		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>> +		/* NAND_CTRL is an operational registers, and CPU
>> +		 * access to operational registers are read only
>> +		 * in BAM mode. So update the NAND_CTRL register
>> +		 * only if it is not in BAM mode. In most cases BAM
>> +		 * mode will be enabled in bootloader
>> +		 */
>> +		if (!(nand_ctrl | BAM_MODE_EN))
>> +			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>>   	} else {
>>   		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
>>   	}
> Does this currently produces an issue at runtime?
>
> If yes, you should have a Fixes/CC: stable pair of tags.
>
> Also, what is BAM mode? Please tell us in the commit log.

Currently this is not causing any issue on run time.

The writes to this register is silently ignored.

However, this could be an issue in future Hardware designs.

BAM is the DMA engine on QCOM IPQ platforms, sure will explain this

mode in next patchset.

>
> Thanks,
> Miquèl

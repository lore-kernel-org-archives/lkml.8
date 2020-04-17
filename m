Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C0C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F5620857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UsRWRTMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgDQNoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:44:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54048 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbgDQNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:44:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HDi4iG016739;
        Fri, 17 Apr 2020 08:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587131044;
        bh=8HgdONqfTSBVvtKMiJSwkisfx9dXqvr3Nfz+IeFgm9c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UsRWRTMsdPPVJJTGhgGWOwSECgNOXbOwOVI48+g77GQ5BXRgYXNYNk3mdLk/6AUkN
         tqPRGlay6S2OIkPBCTlIEpjeFFUoPDUIaxp3g2f3tcy3OSO+o/lKaRSt+XeeVeS80A
         IiVQ+KUGDxpExl2gMRvp5Za1fYVZ3AuFR9BVvDVQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HDi3i4048316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 08:44:04 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 08:44:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 08:44:03 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDi3Mp040253;
        Fri, 17 Apr 2020 08:44:03 -0500
Subject: Re: [PATCH v2 4/7] remoteproc: Use kstrdup_const() rather than
 kstrup()
To:     Alex Elder <elder@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <Markus.Elfring@web.de>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-5-mathieu.poirier@linaro.org>
 <14b12ca8-823b-8115-bafa-281180e92c70@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <3f0a602a-64ff-8092-3cca-b63bab8a79f0@ti.com>
Date:   Fri, 17 Apr 2020 08:44:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <14b12ca8-823b-8115-bafa-281180e92c70@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 4:25 PM, Alex Elder wrote:
> On 4/15/20 3:48 PM, Mathieu Poirier wrote:
>> For cases where @firmware is declared "const char *", use function
>> kstrdup_const() to avoid needlessly creating another copy on the
>> heap.
>>
>> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Looks good.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 4 ++--
>>   include/linux/remoteproc.h           | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 9899467fa1cf..ebaff496ef81 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1982,7 +1982,7 @@ static const struct device_type rproc_type = {
>>   static int rproc_alloc_firmware(struct rproc *rproc,
>>   				const char *name, const char *firmware)
>>   {
>> -	char *p;
>> +	const char *p;
>>   
>>   	if (!firmware)
>>   		/*
>> @@ -1991,7 +1991,7 @@ static int rproc_alloc_firmware(struct rproc *rproc,
>>   		 */
>>   		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);

So, to be consistent for both paths, should we be using 
kvasprintf_const() here and kfree_const() in release. The kfree_const() 
is needed to account for the kstrdup_const below for sure.

regards
Suman

>>   	else
>> -		p = kstrdup(firmware, GFP_KERNEL);
>> +		p = kstrdup_const(firmware, GFP_KERNEL);
>>   
>>   	if (!p)
>>   		return -ENOMEM;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 9c07d7958c53..38607107b7cb 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -489,7 +489,7 @@ struct rproc {
>>   	struct list_head node;
>>   	struct iommu_domain *domain;
>>   	const char *name;
>> -	char *firmware;
>> +	const char *firmware;
>>   	void *priv;
>>   	struct rproc_ops *ops;
>>   	struct device dev;
>>
> 


Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED36C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ECE20748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vJ4vyijK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCZOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:01:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgCZOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:01:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02QE1ZnH081454;
        Thu, 26 Mar 2020 09:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585231295;
        bh=zYArPMmVw6lKGB9faTlm/kbugEnXXS+Ts1oLp9FmQFE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vJ4vyijKkiE5LXCT8trbn0i+6MUcSGmcRJFPXmQrmhG/c9PYzUi571SU8vAHqK1Sm
         baxE7yBoC5KL5caR+IrSEytt+QpFsRjmErivsFChO01QSV+SaiDuhj9eXrKJSdfPZC
         PSEDMhGovS73cq5VsSRR3xN5cICyoTiKulBjdW84=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02QE1Zfn120305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2020 09:01:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 26
 Mar 2020 09:01:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 26 Mar 2020 09:01:35 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02QE1YQA035082;
        Thu, 26 Mar 2020 09:01:34 -0500
Subject: Re: [PATCH 2/7] remoteproc: use a local copy for the name field
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-3-s-anna@ti.com> <20200326054234.GA59436@builder>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2089a4a8-d5e4-e4f5-e7bc-7d053f654204@ti.com>
Date:   Thu, 26 Mar 2020 09:01:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200326054234.GA59436@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/26/20 12:42 AM, Bjorn Andersson wrote:
> On Tue 24 Mar 13:18 PDT 2020, Suman Anna wrote:
> 
>> The current name field used in the remoteproc structure is simply
>> a pointer to a name field supplied during the rproc_alloc() call.
>> The pointer passed in by remoteproc drivers during registration is
>> typically a dev_name pointer, but it is possible that the pointer
>> will no longer remain valid if the devices themselves were created
>> at runtime like in the case of of_platform_populate(), and were
>> deleted upon any failures within the respective remoteproc driver
>> probe function.
>>
>> So, allocate and maintain a local copy for this name field to
>> keep it agnostic of the logic used in the remoteproc drivers.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
>>  include/linux/remoteproc.h           | 2 +-
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index aca6d022901a..6e0b91fa6f11 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1989,6 +1989,7 @@ static void rproc_type_release(struct device *dev)
>>  
>>  	kfree(rproc->firmware);
>>  	kfree(rproc->ops);
>> +	kfree(rproc->name);
>>  	kfree(rproc);
>>  }
>>  
>> @@ -2061,7 +2062,13 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>>  	}
>>  
>>  	rproc->firmware = p;
>> -	rproc->name = name;
>> +	rproc->name = kstrdup(name, GFP_KERNEL);
> 
> Let's use kstrdup_const() instead here (and kfree_const() instead of
> kfree()), so that the cases where we are passed a constant we won't
> create a duplicate on the heap.
> 
> And the "name" in struct rproc can remain const.

Agreed, that's better functions to use for this.

> 
>> +	if (!rproc->name) {
>> +		kfree(p);
>> +		kfree(rproc->ops);
>> +		kfree(rproc);
>> +		return NULL;
> 
> Perhaps we can rearrange the hunks here slightly and get to a point
> where we can rely on the release function earlier?

Not sure I understand. I don't see any release function, all failure
paths in rproc_alloc() directly unwind the previous operations. You mean
move this to before the alloc for rproc structure, something similar to
what we are doing with firmware?

regards
Suman


> 
> Regards,
> Bjorn
> 
>> +	}
>>  	rproc->priv = &rproc[1];
>>  	rproc->auto_boot = true;
>>  	rproc->elf_class = ELFCLASS32;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index ddce7a7775d1..77788a4bb94e 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -490,7 +490,7 @@ struct rproc_dump_segment {
>>  struct rproc {
>>  	struct list_head node;
>>  	struct iommu_domain *domain;
>> -	const char *name;
>> +	char *name;
>>  	char *firmware;
>>  	void *priv;
>>  	struct rproc_ops *ops;
>> -- 
>> 2.23.0
>>


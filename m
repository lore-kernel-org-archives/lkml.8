Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF77C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B80520679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ub0lcGhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgDUONC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:13:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49500 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:13:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03LECiI2017761;
        Tue, 21 Apr 2020 09:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587478364;
        bh=ElGkPbcupAqEe3NPdkjZhWdkXVXqVGDVIz5MNWLMAtU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ub0lcGhWdSlaf4EXGPuUOmrlnFsfKFp6N/NxwQMMc+BoLNy4qEQmfZ0nWVK2QIC6k
         uMzRoUL/BhPysQUoyaTUUnmYIu8gDalon8mcC4Rq/3l0od2/qVwLFD7o1BjUiOdYpj
         ydFxtOUtLeliKdLOzvZ77cphfyqxCeDt/6cMlIuw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03LECibO021697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Apr 2020 09:12:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Apr 2020 09:12:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Apr 2020 09:12:44 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03LECh1l124572;
        Tue, 21 Apr 2020 09:12:43 -0500
Subject: Re: [PATCH 1/2] remoteproc: Add prepare and unprepare ops
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>
References: <20200417002036.24359-1-s-anna@ti.com>
 <20200417002036.24359-2-s-anna@ti.com> <20200421025254.GK1868936@builder.lan>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2feee391-9f8e-410e-2a20-5b5bdd949940@ti.com>
Date:   Tue, 21 Apr 2020 09:12:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421025254.GK1868936@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 9:52 PM, Bjorn Andersson wrote:
> On Thu 16 Apr 17:20 PDT 2020, Suman Anna wrote:
> 
>> From: Loic Pallardy <loic.pallardy@st.com>
>>
>> On some SoC architecture, it is needed to enable HW like
>> clock, bus, regulator, memory region... before loading
>> co-processor firmware.
>>
>> This patch introduces prepare and unprepare ops to execute
>> platform specific function before firmware loading and after
>> stop execution.
>>
>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Do we have an inbound user of these new oops?

Yes, both the TI K3 R5F and DSP remoteproc drivers use these ops, the 
patches are already on the lists.

regards
Suman

> 
> Regards,
> Bjorn
> 
>> ---
>> v1:
>>   - Make the direct ops into inline helper functions in line
>>     with the comments on the MCU sync series (v1 comments).
>>     No change in functionality.
>>   - Picked up the Reviewed-by tags
>> v0: https://patchwork.kernel.org/patch/11456383/
>>
>>   drivers/remoteproc/remoteproc_core.c     | 15 ++++++++++++++-
>>   drivers/remoteproc/remoteproc_internal.h | 16 ++++++++++++++++
>>   include/linux/remoteproc.h               |  4 ++++
>>   3 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index d681eeb962b6..e38f627059ac 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1394,12 +1394,19 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>   		return ret;
>>   	}
>>   
>> +	/* Prepare rproc for firmware loading if needed */
>> +	ret = rproc_prepare_device(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
>> +		goto disable_iommu;
>> +	}
>> +
>>   	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>>   
>>   	/* Load resource table, core dump segment list etc from the firmware */
>>   	ret = rproc_parse_fw(rproc, fw);
>>   	if (ret)
>> -		goto disable_iommu;
>> +		goto unprepare_rproc;
>>   
>>   	/* reset max_notifyid */
>>   	rproc->max_notifyid = -1;
>> @@ -1433,6 +1440,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>   	kfree(rproc->cached_table);
>>   	rproc->cached_table = NULL;
>>   	rproc->table_ptr = NULL;
>> +unprepare_rproc:
>> +	/* release HW resources if needed */
>> +	rproc_unprepare_device(rproc);
>>   disable_iommu:
>>   	rproc_disable_iommu(rproc);
>>   	return ret;
>> @@ -1838,6 +1848,9 @@ void rproc_shutdown(struct rproc *rproc)
>>   	/* clean up all acquired resources */
>>   	rproc_resource_cleanup(rproc);
>>   
>> +	/* release HW resources if needed */
>> +	rproc_unprepare_device(rproc);
>> +
>>   	rproc_disable_iommu(rproc);
>>   
>>   	/* Free the copy of the resource table */
>> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
>> index b389dc79da81..101e6be8d240 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -64,6 +64,22 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>>   struct rproc_mem_entry *
>>   rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>>   
>> +static inline int rproc_prepare_device(struct rproc *rproc)
>> +{
>> +	if (rproc->ops->prepare)
>> +		return rproc->ops->prepare(rproc);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_unprepare_device(struct rproc *rproc)
>> +{
>> +	if (rproc->ops->unprepare)
>> +		return rproc->ops->unprepare(rproc);
>> +
>> +	return 0;
>> +}
>> +
>>   static inline
>>   int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>   {
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 38607107b7cb..b8481ac969f1 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -355,6 +355,8 @@ enum rsc_handling_status {
>>   
>>   /**
>>    * struct rproc_ops - platform-specific device handlers
>> + * @prepare:	prepare device for code loading
>> + * @unprepare:	unprepare device after stop
>>    * @start:	power on the device and boot it
>>    * @stop:	power off the device
>>    * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>> @@ -373,6 +375,8 @@ enum rsc_handling_status {
>>    *		panic at least the returned number of milliseconds
>>    */
>>   struct rproc_ops {
>> +	int (*prepare)(struct rproc *rproc);
>> +	int (*unprepare)(struct rproc *rproc);
>>   	int (*start)(struct rproc *rproc);
>>   	int (*stop)(struct rproc *rproc);
>>   	void (*kick)(struct rproc *rproc, int vqid);
>> -- 
>> 2.26.0
>>


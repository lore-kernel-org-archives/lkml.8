Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB9C20757
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 23:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lSP9Dzy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDHXjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:39:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39918 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:39:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038Ndhfx027199;
        Wed, 8 Apr 2020 18:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586389183;
        bh=dNLr8EfQEXOPmFeqYhnB4WKln9Z3bKnjLvo8cSm4Gh0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lSP9Dzy49fvXCphbuMSVSaoWvHFMRMYVfQ/a5EQHFMjSQFbIEemgllMqQM5g3wyw7
         5ALK4dq/xgrov9t/SyT5oS7bClMmt+k0JKn1hXKVT/Cm7U5IVulRTBvvjdcaRbxEiN
         6r8cVq36hN6S9zSP93+dW+SAmrPL96M0y3510sN8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 038NdhN8127485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2020 18:39:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 18:39:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 18:39:43 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038NdgBU041435;
        Wed, 8 Apr 2020 18:39:42 -0500
Subject: Re: [PATCH 1/7] remoteproc: add prepare and unprepare ops
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-2-s-anna@ti.com> <20200406172018.GA11572@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <042074fb-46b3-f6d9-8203-27a8bc540666@ti.com>
Date:   Wed, 8 Apr 2020 18:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200406172018.GA11572@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 4/6/20 12:20 PM, Mathieu Poirier wrote:
> Good morning Suman,
> 
> I have started to work on this set - comments will come in over the next few
> days...
> 
> On Tue, Mar 24, 2020 at 03:18:13PM -0500, Suman Anna wrote:
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
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++++++++-
>>  include/linux/remoteproc.h           |  4 ++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 26f6947267d2..aca6d022901a 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1394,12 +1394,22 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>  		return ret;
>>  	}
>>  
>> +	/* Prepare rproc for firmware loading if needed */
>> +	if (rproc->ops->prepare) {
>> +		ret = rproc->ops->prepare(rproc);
> 
> In my patchset on MCU synchronisation I have moved ops->{start/stop} to
> remoteproc_internal.h and called them rproc_start/stop_device() (after Loic's
> suggestion).  In order to be consistent and remove boiler plate code in the core
> we could do the same, i.e have rproc_prepare/unprepare_device() in
> remoteproc_internal.h .

Yes, I will update so for v2. I plan to separate out this patch and the
next patch for v2 to go alongside your cleanup and Alex's patch on the
idr_init move.

regards
Suman

> 
> With the above:
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Thanks,
> Mathieu
> 
>> +		if (ret) {
>> +			dev_err(dev, "can't prepare rproc %s: %d\n",
>> +				rproc->name, ret);
>> +			goto disable_iommu;
>> +		}
>> +	}
>> +
>>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>>  
>>  	/* Load resource table, core dump segment list etc from the firmware */
>>  	ret = rproc_parse_fw(rproc, fw);
>>  	if (ret)
>> -		goto disable_iommu;
>> +		goto unprepare_rproc;
>>  
>>  	/* reset max_notifyid */
>>  	rproc->max_notifyid = -1;
>> @@ -1433,6 +1443,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>  	kfree(rproc->cached_table);
>>  	rproc->cached_table = NULL;
>>  	rproc->table_ptr = NULL;
>> +unprepare_rproc:
>> +	/* release HW resources if needed */
>> +	if (rproc->ops->unprepare)
>> +		rproc->ops->unprepare(rproc);
>>  disable_iommu:
>>  	rproc_disable_iommu(rproc);
>>  	return ret;
>> @@ -1838,6 +1852,10 @@ void rproc_shutdown(struct rproc *rproc)
>>  	/* clean up all acquired resources */
>>  	rproc_resource_cleanup(rproc);
>>  
>> +	/* release HW resources if needed */
>> +	if (rproc->ops->unprepare)
>> +		rproc->ops->unprepare(rproc);
>> +
>>  	rproc_disable_iommu(rproc);
>>  
>>  	/* Free the copy of the resource table */
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 07bd73a6d72a..ddce7a7775d1 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -355,6 +355,8 @@ enum rsc_handling_status {
>>  
>>  /**
>>   * struct rproc_ops - platform-specific device handlers
>> + * @prepare:	prepare device for code loading
>> + * @unprepare:	unprepare device after stop
>>   * @start:	power on the device and boot it
>>   * @stop:	power off the device
>>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>> @@ -371,6 +373,8 @@ enum rsc_handling_status {
>>   * @get_boot_addr:	get boot address to entry point specified in firmware
>>   */
>>  struct rproc_ops {
>> +	int (*prepare)(struct rproc *rproc);
>> +	int (*unprepare)(struct rproc *rproc);
>>  	int (*start)(struct rproc *rproc);
>>  	int (*stop)(struct rproc *rproc);
>>  	void (*kick)(struct rproc *rproc, int vqid);
>> -- 
>> 2.23.0
>>
> 


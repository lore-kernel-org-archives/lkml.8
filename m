Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6ADC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEA524696
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PP04jrRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393572AbgBNQdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:33:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56278 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404396AbgBNQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:33:42 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EGItpi024101;
        Fri, 14 Feb 2020 17:33:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=FqrCBz+3agjMqApE7aZAkM3XkaVjmcUYrFs4JAJSv7M=;
 b=PP04jrRR2Iv9tjWgbRcn51egilM5HUdtPi/2AK3vj+e51UL+LrM9NXb7bfO3OHUIbswc
 PYeslyIK6g5PcbYcCugnLn8Xa5Vut00K6MYvvvD2Ibd/lb0nesY+LPMIGuMiRIz3Ji7P
 5oxLTaP3i0kwskxOydOUw/5NdPEdYtXxVHQ4/XSBgXbClLGRHiLmjSEGQaWdn35gedU+
 73nORmyv8VEE3p8ShkNDQqPTfPXsdecGy45aEZJM5fol0ve5cnxYobfMs1qCIwPbBrKv
 uwoWymFusAdWfDnteYVvhly7qOmEtJ353AUpxwXxZCBoIyBVda12tTRxJnzqI91d3hoo wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1udacy6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 17:33:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39175100038;
        Fri, 14 Feb 2020 17:33:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8EC02BF9A9;
        Fri, 14 Feb 2020 17:33:29 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.46) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 17:33:29 +0100
Subject: Re: [PATCH v5 1/3] remoteproc: add support for co-processor loaded
 and booted before kernel
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-2-arnaud.pouliquen@st.com>
 <20200213200813.GA14415@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <24947b31-bef6-cfb3-686e-80bef6f974e3@st.com>
Date:   Fri, 14 Feb 2020 17:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213200813.GA14415@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_05:2020-02-12,2020-02-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2/13/20 9:08 PM, Mathieu Poirier wrote:
> Good day,
> 
> On Tue, Feb 11, 2020 at 06:42:03PM +0100, Arnaud Pouliquen wrote:
>> From: Loic Pallardy <loic.pallardy@st.com>
>>
>> Remote processor could boot independently or be loaded/started before
>> Linux kernel by bootloader or any firmware.
>> This patch introduces a new property in rproc core, named skip_fw_load,
>> to be able to allocate resources and sub-devices like vdev and to
>> synchronize with current state without loading firmware from file system.
>> It is platform driver responsibility to implement the right firmware
>> load ops according to HW specificities.
>>
>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++------
>>  include/linux/remoteproc.h           |  2 +
>>  2 files changed, 55 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 097f33e4f1f3..876b5420a32b 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>  	return ret;
>>  }
>>  
>> -/*
>> - * take a firmware and boot a remote processor with it.
>> +/**
>> + * rproc_fw_boot() - boot specified remote processor according to specified
>> + * firmware
>> + * @rproc: handle of a remote processor
>> + * @fw: pointer on firmware to handle
>> + *
>> + * Handle resources defined in resource table, load firmware and
>> + * start remote processor.
>> + *
>> + * If firmware pointer fw is NULL, firmware is not handled by remoteproc
>> + * core, but under the responsibility of platform driver.
>> + *
>> + * Returns 0 on success, and an appropriate error value otherwise.
>>   */
>>  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>  {
>> @@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>  	if (ret)
>>  		return ret;
>>  
>> -	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>> +	if (fw)
>> +		dev_info(dev, "Booting fw image %s, size %zd\n", name,
>> +			 fw->size);
>> +	else
>> +		dev_info(dev, "Synchronizing with preloaded co-processor\n");
>>  
>>  	/*
>>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
>> @@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>   * rproc_boot() - boot a remote processor
>>   * @rproc: handle of a remote processor
>>   *
>> - * Boot a remote processor (i.e. load its firmware, power it on, ...).
>> + * Boot a remote processor (i.e. load its firmware, power it on, ...) from
>> + * different contexts:
>> + * - power off
>> + * - preloaded firmware
>> + * - started before kernel execution
>> + * The different operations are selected thanks to properties defined by
>> + * platform driver.
>>   *
>> - * If the remote processor is already powered on, this function immediately
>> - * returns (successfully).
>> + * If the remote processor is already powered on at rproc level, this function
>> + * immediately returns (successfully).
>>   *
>>   * Returns 0 on success, and an appropriate error value otherwise.
>>   */
>>  int rproc_boot(struct rproc *rproc)
>>  {
>> -	const struct firmware *firmware_p;
>> +	const struct firmware *firmware_p = NULL;
>>  	struct device *dev;
>>  	int ret;
>>  
>> @@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
>>  
>>  	dev_info(dev, "powering up %s\n", rproc->name);
>>  
>> -	/* load firmware */
>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>> -	if (ret < 0) {
>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
>> -		goto downref_rproc;
>> +	if (!rproc->skip_fw_load) {
>> +		/* load firmware */
>> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
>> +		if (ret < 0) {
>> +			dev_err(dev, "request_firmware failed: %d\n", ret);
>> +			goto downref_rproc;
>> +		}
>> +	} else {
>> +		/*
>> +		 * Set firmware name pointer to null as remoteproc core is not
>> +		 * in charge of firmware loading
>> +		 */
>> +		kfree(rproc->firmware);
>> +		rproc->firmware = NULL;
> 
> If the MCU with pre-loaded FW crashes request_firmware() in
> rproc_trigger_recovery() will return an error and rproc_start()
> never called.

Right, something is missing in the recovery function to prevent request_firmware call if skip_fw_load is set

We also identify an issue if recovery fails:
In case of recovery issue the rproc state is RPROC_CRASHED, so that it is no more possible to load a new firmware from
user space.
This issue is not linked to this patchset. We have patches on our shelves for this.

>>  	}
>>  
>>  	ret = rproc_fw_boot(rproc, firmware_p);
>> @@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
>>  	/* create debugfs entries */
>>  	rproc_create_debug_dir(rproc);
>>  
>> -	/* if rproc is marked always-on, request it to boot */
>> -	if (rproc->auto_boot) {
>> +	if (rproc->skip_fw_load) {
>> +		/*
>> +		 * If rproc is marked already booted, no need to wait
>> +		 * for firmware.
>> +		 * Just handle associated resources and start sub devices
>> +		 */
>> +		ret = rproc_boot(rproc);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else if (rproc->auto_boot) {
>> +		/* if rproc is marked always-on, request it to boot */
> 
> I spent way too much time staring at this modification...  I can't decide if a
> system where the FW has been pre-loaded should be considered "auto_boot".
> Indeed the result is the same, i.e the MCU is started at boot time without user
> intervention.

The main difference is that the firmware is loaded by the Linux remote proc in case of auto-boot.
In auto-boot mode the remoteproc loads a firmware, on probe, with a specified name without any request from user space.
One constraint of this mode is that the file system has to be accessible before the rproc probe.
This is not necessary the case, even if EPROBE_DEFER is used. In this case the driver has to be build as kernel module.

Thanks,
Arnaud
> 
> I'd welcome other people's opinion on this.
> 
>>  		ret = rproc_trigger_auto_boot(rproc);
>>  		if (ret < 0)
>>  			return ret;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 16ad66683ad0..4fd5bedab4fa 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -479,6 +479,7 @@ struct rproc_dump_segment {
>>   * @table_sz: size of @cached_table
>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>> + * @skip_fw_load: remote processor has been preloaded before start sequence
>>   * @dump_segments: list of segments in the firmware
>>   * @nb_vdev: number of vdev currently handled by rproc
>>   */
>> @@ -512,6 +513,7 @@ struct rproc {
>>  	size_t table_sz;
>>  	bool has_iommu;
>>  	bool auto_boot;
>> +	bool skip_fw_load;
>>  	struct list_head dump_segments;
>>  	int nb_vdev;
>>  };
>> -- 
>> 2.17.1
>>

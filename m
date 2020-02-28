Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756DC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A6C21556
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sPuGsD1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgB1Dk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:40:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgB1Dk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:40:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S3em9f024433;
        Thu, 27 Feb 2020 21:40:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582861248;
        bh=nFHa3nPck9OMXyJJrWEfYBYfsZn16z2PgDyatq9xoXs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sPuGsD1isLJOejYNCqmSS9rULVfhxpM8DxiVWUP+jeuRiyRxw0faahFqHm6/6VgBX
         oRYin1xWqYnk73WK8eZJJvhMTZ1uEysnFISDbHjpZ2sZxJPiPOJfOHT/gekpfFP8LC
         vX5pREEtm4HvKOnAEh6odAkPy/2yXAxsLEGp/Nuw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S3emtI117655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 21:40:48 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 21:40:47 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 21:40:47 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01S3ell0119905;
        Thu, 27 Feb 2020 21:40:47 -0600
Subject: Re: [PATCH v5 1/3] remoteproc: add support for co-processor loaded
 and booted before kernel
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-2-arnaud.pouliquen@st.com>
 <20200213200813.GA14415@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1c259bf8-6cfa-c9b3-4707-e4d67a5e4483@ti.com>
Date:   Thu, 27 Feb 2020 21:40:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200213200813.GA14415@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2/13/20 2:08 PM, Mathieu Poirier wrote:
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
> 
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

I am still catching up on all the various responses on this particular
thread, but this particular path will have an issue for one of the
usecases (#2 below) that I have for TI drivers.

We have couple of use-cases for TI drivers:
1. The regular early-boot & late-attach case, where the processor is
booted earlier by a bootloader, and we establish the virtio stack in
kernel. We do want to support the regular remoteproc operations
thereafter - stop the remoteproc using sysfs (userspace control to be
able to stop, change firmware and boot the new firmware), support
error-recovery (using the same firmware).
2. Support a userspace loader with the kernel only providing the hooks
for actually processing the vrings, and starting the processor (the boot
control registers are not exposed). We support this by enhancing our
platform driver to provide some ioctl support, and set skip_fw_load and
clear auto_boot for this, but the above path takes will fail this.
3. A third subset usecase of #1, where kernel is only responsible for
establishing the the IPC. Linux won't be able to stop and/or start the
processors, and perform any error recovery either. I use a combination
of above flags + recovery_disabled + platform driver support + an
additional flag where I do not allow any userspace start/stop that I
have posted a while ago [1].

>> +	} else if (rproc->auto_boot) {
>> +		/* if rproc is marked always-on, request it to boot */
> 
> I spent way too much time staring at this modification...  I can't decide if a
> system where the FW has been pre-loaded should be considered "auto_boot".
> Indeed the result is the same, i.e the MCU is started at boot time without user
> intervention.

Yeah, #2 usecase falls in this category where it is not auto_boot.

FYI, [2] is the patch that I was using on downstream TI kernels that
looks slightly different to this patch - it uses two flags instead for
skip_fw_load and skip_fw_request instead of clearing the fw, but even
that one probably doesn't cater to all the combinations being discussed
in this thread.

regards
Suman

[1] https://patchwork.kernel.org/patch/10601325/
[2]
https://git.ti.com/gitweb?p=rpmsg/remoteproc.git;a=commitdiff;h=c1a632fc83e364aa8fd82e949b47b36db64523c5

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


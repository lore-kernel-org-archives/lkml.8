Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2924696
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zUk8zGjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393619AbgBNQee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:34:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7434 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387823AbgBNQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:34:29 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EGJApR022703;
        Fri, 14 Feb 2020 17:34:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=IDcJAhgQjtxPC/OrQ8RnxJzkwvOSmDQi1PRaGPnHPEY=;
 b=zUk8zGjh4i2vxLAeptqpRly1WmMosqXpdUhBLv9nJVfNz/x0vkBhvlJ2ClRfhzYD8XFH
 3c4i/t1JVKu8vK0mis6RLdpcKWZbbBUNRHxdY8W1dvNLLYIxQxITIi35MlGR0pku8E6z
 l2DjuWEVQV/vluo/bJf1cG89vjQXEGsg0k4zGO1VvODEPlfdmXo8SA4KWxZktkyBIwe5
 XlhA+5TM8X5a5BMEj3t8kyT+1QXcalRy0A4zElFiwGHHbyIXO1i0cPlWrdIVn/xjf8tP
 2t/1ipibxusDoYOMfWLbwuVnGdsMgeyQKtNYABhggPcWhQTzKu9HbDNmLU1fumr4qQuX lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urhvykr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 17:34:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A56FE10002A;
        Fri, 14 Feb 2020 17:34:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 96A3F2BF9B5;
        Fri, 14 Feb 2020 17:34:20 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 17:34:19 +0100
Subject: Re: [PATCH v5 1/3] remoteproc: add support for co-processor loaded
 and booted before kernel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-2-arnaud.pouliquen@st.com> <20200214025512.GQ1443@yoga>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <ff04e4ed-201a-877f-7500-f594820cab15@st.com>
Date:   Fri, 14 Feb 2020 17:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214025512.GQ1443@yoga>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_05:2020-02-12,2020-02-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2/14/20 3:55 AM, Bjorn Andersson wrote:
> On Tue 11 Feb 09:42 PST 2020, Arnaud Pouliquen wrote:
> 
>> From: Loic Pallardy <loic.pallardy@st.com>
>>
>> Remote processor could boot independently or be loaded/started before
>> Linux kernel by bootloader or any firmware.
>> This patch introduces a new property in rproc core, named skip_fw_load,
>> to be able to allocate resources and sub-devices like vdev and to
>> synchronize with current state without loading firmware from file system.
> 
> This sentence describes the provided patch.
> 
> As I expressed in the earlier version, in order to support remoteprocs
> that doesn't need firmware loading, e.g. running from some ROM or
> dedicated flash storage etc, this patch looks really good.
> 
>> It is platform driver responsibility to implement the right firmware
>> load ops according to HW specificities.
> 
> But this last sentence describes a remoteproc that indeed needs
> firmware and that the purpose of this patch is to work around the core's
> handling of the firmware.

I will update or suppress the last sentence.

> 
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
> [..]
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
> As stated before, I think it would be more appropriate to allow a
> remoteproc driver for hardware that shouldn't have firmware loaded to
> never set rproc->firmware.
> 
> And I'm still curious how you're dealing with a crash or a restart on
> this remoteproc. Don't you need to reload your firmware in these
> circumstances? Do you perhaps have a remoteproc that's both
> "already_booted" and "skip_fw_load"?

Yes the crash management is the main point here. Even if the firmware has been 
preloaded and started by the bootloader, a crash can occur (e.g. watchdog) and have to be be treated.
In this case on stm32 platform we trig a crash recovery to shutdown the firmware.
Then application has possibility to reload the same firmware (copy of the fw in FS),
to load a new firmware(e.g.for diagnostic or a clean shutdown), reset the platform.

Implementing a specific driver would not give such flexibility.

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
> 
> Again, this describes a system where the remoteproc is already booted,
> not a remoteproc that doesn't need firmware loading.

Right, i will change the comment.

Thanks,
Arnaud
> 
> Regards,
> Bjorn
> 

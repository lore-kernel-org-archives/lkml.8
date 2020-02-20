Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F237C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C48B207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="i4l3wns6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTItn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:49:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgBTItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:49:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K8meXW020417;
        Thu, 20 Feb 2020 09:49:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=S5q9Ccf8BOo2PkevHXUiUGrg9bP7AFEyhsJFWCqfbU8=;
 b=i4l3wns6Hn6EEtrK2zY9uHtzneAHnYfd1osV/2K2QMrqcJnmkrFKtQ+XHqErJ02tL9hd
 Uo6Oq4vGND7hxp/fK33EMUEkzneb0ZxZUmP5mqGOu4kQzraEd9epglEizy7N6vjwbkK9
 wJv3DrvbPP4LDjs9JRcJAiD/o1wTuRLjWPbxKR4mjJ0uZqrEG4unxSBiRqyPGZKRp/gm
 AhkEi+5YqcHbB7cHDftxN3DCQgONzUjDjwwJhYWXsKpfhWmeeC+h9YHirSfOZ6v/t7Rz
 UtPJY/xSy6HQ5BDD278+istL5nR3bEuG2kIPHzDNLYTmbI0MU1wbJvZij01NCqiXwUI6 /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y8uafqufs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 09:49:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D28F10003B;
        Thu, 20 Feb 2020 09:49:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6150F22243F;
        Thu, 20 Feb 2020 09:49:27 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 09:49:26 +0100
Subject: Re: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
To:     Peng Fan <peng.fan@nxp.com>, "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
 <0d90b2c2-cb02-d052-57cb-b11c5f815f07@st.com>
 <AM0PR04MB4481F7E58E9D09F1779E279988100@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <a3263739-a201-835a-c6a7-849f57bee51f@st.com>
Date:   Thu, 20 Feb 2020 09:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4481F7E58E9D09F1779E279988100@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/20 4:40 PM, Peng Fan wrote:
> 
>> Subject: Re: [PATCH 3/9] remoteproc: add support to skip firmware load when
>> recovery
>>
>> Hi,
>>
>> On 2/19/20 8:27 AM, peng.fan@nxp.com wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Remote processor such as M4 inside i.MX8QXP is not handled by Linux
>>> when it is configured to run inside its own hardware partition by
>>> system control unit(SCU). So even remote processor crash reset, it is
>>> handled by SCU, not linux. To such case, firmware load should be
>>> ignored, So introduce skip_fw_load_recovery and platform driver should
>>> set it if needed.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 19 +++++++++++--------
>>>  include/linux/remoteproc.h           |  1 +
>>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>> b/drivers/remoteproc/remoteproc_core.c
>>> index 876b5420a32b..ca310e3582bf 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -1678,20 +1678,23 @@ int rproc_trigger_recovery(struct rproc *rproc)
>>>  	if (ret)
>>>  		goto unlock_mutex;
>>>
>>> -	/* generate coredump */
>>> -	rproc_coredump(rproc);
>>> +	if (!rproc->skip_fw_load_recovery) {
>>> +		/* generate coredump */
>>> +		rproc_coredump(rproc);
>>>
>>> -	/* load firmware */
>>> -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "request_firmware failed: %d\n", ret);
>>> -		goto unlock_mutex;
>>> +		/* load firmware */
>>> +		ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "request_firmware failed: %d\n", ret);
>>> +			goto unlock_mutex;
>>> +		}
>>
>> Any specific reason to not reuse skip_fw_load here?
> 
> Just thought firmware needs to be loaded by Linux when remote
> processor crash, even if it initially booted ealy.
> 
> skip_fw_load just handles first boot which no need firmware.
> But if recovery boot needs firwarem, skip_fw_load will not handle.
> 
> So I add this new bool.
> 
> Actually to my platform, skip_fw_load could work when recovery,
> I just think other platforms might need firware load when recovery.

Thanks for the clarification. For the ST platform, we can have both usecase
By clearing skip_fw_load in case of crash we s should be able to handle this usecase.
Anyway as discussion is still on going for the preloaded firmware topic, we have at least to take into account your
use case.

Thanks,
Arnaud

 
> 
> Regards,
> Peng. 
> 
>> FYI i'm reworking the Loic's patch and i plan to implement the recovery part
>> using skip_fw_load...
> 
> 
> 
>>
>> Regards
>> Arnaud
>>
>>>  	}
>>>
>>>  	/* boot the remote processor up again */
>>>  	ret = rproc_start(rproc, firmware_p);
>>>
>>> -	release_firmware(firmware_p);
>>> +	if (!rproc->skip_fw_load_recovery)
>>> +		release_firmware(firmware_p);
>>>
>>>  unlock_mutex:
>>>  	mutex_unlock(&rproc->lock);
>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>> index 4fd5bedab4fa..fe6ee253b385 100644
>>> --- a/include/linux/remoteproc.h
>>> +++ b/include/linux/remoteproc.h
>>> @@ -514,6 +514,7 @@ struct rproc {
>>>  	bool has_iommu;
>>>  	bool auto_boot;
>>>  	bool skip_fw_load;
>>> +	bool skip_fw_load_recovery;
>>>  	struct list_head dump_segments;
>>>  	int nb_vdev;
>>>  };
>>>

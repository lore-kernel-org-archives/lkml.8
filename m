Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEEF20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lse8lrrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgFVUYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:24:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52326 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgFVUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:24:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05MKOcbu046999;
        Mon, 22 Jun 2020 15:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592857478;
        bh=TLOmjnW8sOkYfjB1lvZvwzzA4gy5pYwNnSPTHqBMPzQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lse8lrrCqtNndXqrWhq0MvVkyVnmSCZBB8zs1BAdmUHZ5M4zTVUjZ/sDC7Z8zwuez
         9x1CcjMjKsaYryGDI3GY7c9c28ysTWud5pENiuLdGAjotEVUj/CoO1h1PRFvmLZ9FB
         BzYT6pF2ka5onDNWnieM0WuX1cjA2R3rz6gVCdao=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05MKOcVB006502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 15:24:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Jun 2020 15:24:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Jun 2020 15:24:38 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05MKOcaO049424;
        Mon, 22 Jun 2020 15:24:38 -0500
Subject: Re: [PATCH v3 2/6] remoteproc: k3: Add TI-SCI processor control
 helper functions
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200612224914.7634-1-s-anna@ti.com>
 <20200612224914.7634-3-s-anna@ti.com> <20200622173540.GA1820962@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <39989eb0-8d3d-ad6c-6352-73d54b8876d9@ti.com>
Date:   Mon, 22 Jun 2020 15:24:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622173540.GA1820962@xps15>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/22/20 12:35 PM, Mathieu Poirier wrote:
> Hi Suman,
> 
> Apologies for the late reply, this one slipped through the cracks...

No problem :)

> 
> 
> On Fri, Jun 12, 2020 at 05:49:10PM -0500, Suman Anna wrote:
>> Texas Instruments' K3 generation SoCs have specific modules/register
>> spaces used for configuring the various aspects of a remote processor.
>> These include power, reset, boot vector and other configuration features
>> specific to each compute processor present on the SoC. These registers
>> are managed by the System Controller such as DMSC on K3 AM65x SoCs.
>>
>> The Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>> is used to communicate to the System Controller from various compute
>> processors to invoke specific services provided by the firmware running
>> on the System Controller.
>>
>> Add a common processor control interface header file that can be used by
>> multiple remoteproc drivers. The helper functions within this header file
>> abstract the various TI SCI protocol ops for the remoteproc drivers, and
>> allow them to request the System Controller to be able to program and
>> manage various remote processors on the SoC. The remoteproc drivers are
>> expected to manage the life-cycle of their ti_sci_proc_dev local
>> structures.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> v3: New to this series, but the patch is identical to the one from the
>>      K3 R5F series posted previously, with patch title adjusted
>>      https://patchwork.kernel.org/patch/11456379/
>>
>>   drivers/remoteproc/ti_sci_proc.h | 102 +++++++++++++++++++++++++++++++
>>   1 file changed, 102 insertions(+)
>>   create mode 100644 drivers/remoteproc/ti_sci_proc.h
>>
>> diff --git a/drivers/remoteproc/ti_sci_proc.h b/drivers/remoteproc/ti_sci_proc.h
>> new file mode 100644
>> index 000000000000..e42d8015b8e7
>> --- /dev/null
>> +++ b/drivers/remoteproc/ti_sci_proc.h
>> @@ -0,0 +1,102 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Texas Instruments TI-SCI Processor Controller Helper Functions
>> + *
>> + * Copyright (C) 2018-2020 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Suman Anna
>> + */
>> +
>> +#ifndef REMOTEPROC_TI_SCI_PROC_H
>> +#define REMOTEPROC_TI_SCI_PROC_H
>> +
>> +/**
>> + * struct ti_sci_proc - structure representing a processor control client
>> + * @sci: cached TI-SCI protocol handle
>> + * @ops: cached TI-SCI proc ops
>> + * @dev: cached client device pointer
>> + * @proc_id: processor id for the consumer remoteproc device
>> + * @host_id: host id to pass the control over for this consumer remoteproc
>> + *	     device
>> + */
>> +struct ti_sci_proc {
>> +	const struct ti_sci_handle *sci;
>> +	const struct ti_sci_proc_ops *ops;
>> +	struct device *dev;
> 
> Please include the proper header files for the above structures.  

OK, I will move the #include <linux/soc/ti/ti_sci_protocol.h> from the 
driver source files to here.

I would also
> have expected the name of the structure to be ti_sci_rproc but that choice is
> entirely your.

This follows the terminology used in the TI SCI protocol and firmware 
code. I will leave it unchanged.

> 
> With the proper header files included:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, I will await any comments from Rob on the bindings patch before 
I refresh this series.

regards
Suman

> 
>> +	u8 proc_id;
>> +	u8 host_id;
>> +};
>> +
>> +static inline int ti_sci_proc_request(struct ti_sci_proc *tsp)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->request(tsp->sci, tsp->proc_id);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor request failed: %d\n",
>> +			ret);
>> +	return ret;
>> +}
>> +
>> +static inline int ti_sci_proc_release(struct ti_sci_proc *tsp)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->release(tsp->sci, tsp->proc_id);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor release failed: %d\n",
>> +			ret);
>> +	return ret;
>> +}
>> +
>> +static inline int ti_sci_proc_handover(struct ti_sci_proc *tsp)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->handover(tsp->sci, tsp->proc_id, tsp->host_id);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor handover of %d to %d failed: %d\n",
>> +			tsp->proc_id, tsp->host_id, ret);
>> +	return ret;
>> +}
>> +
>> +static inline int ti_sci_proc_set_config(struct ti_sci_proc *tsp,
>> +					 u64 boot_vector,
>> +					 u32 cfg_set, u32 cfg_clr)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->set_config(tsp->sci, tsp->proc_id, boot_vector,
>> +				   cfg_set, cfg_clr);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor set_config failed: %d\n",
>> +			ret);
>> +	return ret;
>> +}
>> +
>> +static inline int ti_sci_proc_set_control(struct ti_sci_proc *tsp,
>> +					  u32 ctrl_set, u32 ctrl_clr)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->set_control(tsp->sci, tsp->proc_id, ctrl_set, ctrl_clr);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor set_control failed: %d\n",
>> +			ret);
>> +	return ret;
>> +}
>> +
>> +static inline int ti_sci_proc_get_status(struct ti_sci_proc *tsp,
>> +					 u64 *boot_vector, u32 *cfg_flags,
>> +					 u32 *ctrl_flags, u32 *status_flags)
>> +{
>> +	int ret;
>> +
>> +	ret = tsp->ops->get_status(tsp->sci, tsp->proc_id, boot_vector,
>> +				   cfg_flags, ctrl_flags, status_flags);
>> +	if (ret)
>> +		dev_err(tsp->dev, "ti-sci processor get_status failed: %d\n",
>> +			ret);
>> +	return ret;
>> +}
>> +
>> +#endif /* REMOTEPROC_TI_SCI_PROC_H */
>> -- 
>> 2.26.0
>>


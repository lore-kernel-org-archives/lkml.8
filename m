Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B00CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A872083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ovvSPpNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDIWBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:01:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41208 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDIWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:01:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 039M13xW030654;
        Thu, 9 Apr 2020 17:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586469663;
        bh=1M+jwazQX4BDpMZKdqu/6bX8vsrM9v22p6tALsFhTxo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ovvSPpNcKyvxXg82NJUPUvrdqfAySOrq32XSWMJAs6XmnocP6RYdWcVLlNoWlAb+B
         LbN3BgvVPbcmHKIEJRshorcFvq0Qm9HOd42XvaRgshF/tG7biFlg1RhDGJcsYFc9kd
         DeYp9OM3QfLHkuOEHyMxmFzmG//8Pe6Zt/Xw6src=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 039M12UF067248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Apr 2020 17:01:02 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 17:01:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 17:01:02 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 039M12ax068082;
        Thu, 9 Apr 2020 17:01:02 -0500
Subject: Re: [PATCH 6/7] remoteproc/k3-r5: Initialize TCM memories for ECC
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200324201819.23095-1-s-anna@ti.com>
 <20200324201819.23095-7-s-anna@ti.com> <20200409213633.GB32029@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b7dfa5d6-53cc-362d-dd76-941639dfbf29@ti.com>
Date:   Thu, 9 Apr 2020 17:01:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200409213633.GB32029@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 4:36 PM, Mathieu Poirier wrote:
> On Tue, Mar 24, 2020 at 03:18:18PM -0500, Suman Anna wrote:
>> The R5F processors on K3 SoCs all have two TCMs (ATCM and BTCM) that
>> support 32-bit ECC. The TCMs are typically loaded with some boot-up
>> code to initialize the R5 MPUs to further execute code out of DDR.
>> The ECC for the TCMs is enabled by default on K3 SoCs due to internal
>> default tie-off values, but the TCM memories are not initialized on
>> device power up. Any read access without the corresponding TCM memory
>> location initialized will generate an ECC error, and any such access
>> from a A72 or A53 core will trigger a SError.
>>
>> So, zero initialize both the TCM memories before loading any firmware
>> onto a R5F in remoteproc mode. Any R5F booted from U-Boot/SPL would
>> require a similar initialization in the bootloader. Note that both
>> the TCMs are initialized unconditionally as the TCM enable config bits
>> only manage the access and visibility from R5. The Core1 TCMs are not
>> used and accessible in LockStep mode, so they are only initialized
>> in Split-mode.
> 
> Everything was going well with this changelog until the last sentence.
> Intuitively one is looking for the code that avoids the initialisation for
> "Core1" in the patch but it is not there, and rightly so.  In locksetup mode the
> second core is not registered with the remoteproc core and as such the
> associated TCMs won't be initialised.
> 
> Simply put, I would just remove the last sentence as all it does (at least for
> me) is add confusion.

Yep, that was more of a "NOTE: " type comment on overall behavior. I
will drop the sentence for v2.

regards
Suman

> 
> With that:
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> index 655f8f14c37d..8c9b7ae5d8b7 100644
>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> @@ -366,6 +366,17 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>>  		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
>>  			ret);
>>  
>> +	/*
>> +	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
>> +	 * affected by ATCM & BTCM enable configuration values) so that ECC
>> +	 * can be effective on all TCM addresses.
>> +	 */
>> +	dev_dbg(dev, "zeroing out ATCM memory\n");
>> +	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
>> +
>> +	dev_dbg(dev, "zeroing out BTCM memory\n");
>> +	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
>> +
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.23.0
>>


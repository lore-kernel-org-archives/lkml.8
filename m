Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03623C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837720767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yHYX0qbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCTVi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54826 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02KLcOeU043981;
        Fri, 20 Mar 2020 16:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584740304;
        bh=0NN4MNZ/hF1UQNXaLNMovZy4BsamJlFbU9vvVUiEgr4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yHYX0qbjyyV71a66TP8YBNLfIXoTdy+QDzFD/HweoSR6iYGi5jWJOa/4DwVvPXZZL
         ygEBOiHq+amg/mWk6ErfBj2pBCBk9nd+EQ2FQM/cohfRjYOqYgE3tbD/3hF4vjRA+T
         Xiun0FLNjp2CDVrdUwiO08bv2hLPL/kY6lEj2n9A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02KLcOXY017875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 16:38:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 16:38:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 16:38:24 -0500
Received: from [10.250.86.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02KLcOp8108796;
        Fri, 20 Mar 2020 16:38:24 -0500
Subject: Re: [PATCHv8 RESEND 03/15] remoteproc/omap: Add a sanity check for
 DSP boot address alignment
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
References: <20200313081718.30612-4-t-kristo@ti.com>
 <20200314004334.26509-1-s-anna@ti.com> <20200320203409.GC16145@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2d186bf1-db04-5f69-62a8-d1970e0592a4@ti.com>
Date:   Fri, 20 Mar 2020 16:38:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200320203409.GC16145@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 3:34 PM, Mathieu Poirier wrote:
> On Fri, Mar 13, 2020 at 07:43:34PM -0500, Suman Anna wrote:
>> The DSP remote processors on OMAP SoCs require a boot register to
>> be programmed with a boot address, and this boot address needs to
>> be on a 1KB boundary. The current code is simply masking the boot
>> address appropriately without performing any sanity checks before
>> releasing the resets. An unaligned boot address results in an
>> undefined execution behavior and can result in various bus errors
>> like MMU Faults or L3 NoC errors. Such errors are hard to debug and
>> can be easily avoided by adding a sanity check for the alignment
>> before booting a DSP remote processor.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Andrew F. Davis <afd@ti.com>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>> v8-Resend: Updated to fix compilation issues against rproc-next
>>
>>  drivers/remoteproc/omap_remoteproc.c | 20 ++++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
>> index d47d5ded651a..fe11cb709770 100644
>> --- a/drivers/remoteproc/omap_remoteproc.c
>> +++ b/drivers/remoteproc/omap_remoteproc.c
>> @@ -121,14 +121,23 @@ static void omap_rproc_kick(struct rproc *rproc, int vqid)
>>   * @rproc: handle of a remote processor
>>   *
>>   * Set boot address for a supported DSP remote processor.
>> + *
>> + * Return: 0 on success, or -EINVAL if boot address is not aligned properly
>>   */
>> -static void omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
>> +static int omap_rproc_write_dsp_boot_addr(struct rproc *rproc)
>>  {
>> +	struct device *dev = rproc->dev.parent;
>>  	struct omap_rproc *oproc = rproc->priv;
>>  	struct omap_rproc_boot_data *bdata = oproc->boot_data;
>>  	u32 offset = bdata->boot_reg;
>>  
>> -	regmap_write(bdata->syscon, offset, rproc->bootaddr);
>> +	if (rproc->bootaddr & (SZ_1K - 1)) {
>> +		dev_err(dev, "invalid boot address 0x%llx, must be aligned on a 1KB boundary\n",
>> +			rproc->bootaddr);
> 
> Yes it does fix the compilation problem but after that patch 7 doesn't apply
> anymore.

git am -3 should apply the patch. I didn't resend that one since there
were no code changes.

regards
Suman

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	return regmap_write(bdata->syscon, offset, rproc->bootaddr);
>>  }
>>  
>>  /*
>> @@ -145,8 +154,11 @@ static int omap_rproc_start(struct rproc *rproc)
>>  	int ret;
>>  	struct mbox_client *client = &oproc->client;
>>  
>> -	if (oproc->boot_data)
>> -		omap_rproc_write_dsp_boot_addr(rproc);
>> +	if (oproc->boot_data) {
>> +		ret = omap_rproc_write_dsp_boot_addr(rproc);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>>  	client->dev = dev;
>>  	client->tx_done = NULL;
>> -- 
>> 2.23.0
>>


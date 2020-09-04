Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F987C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A59206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lxSjsu4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgIDPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:45:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50492 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgIDPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:45:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 084FiqR4092216;
        Fri, 4 Sep 2020 10:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599234292;
        bh=VMqTGjL4kKzi7jmztgA4JEXaWUBhgkQR8WYr0H/I7mI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lxSjsu4JmAjAg0vZflqKAZIvrbSitOutL8rmv4vVTYvi5LLVONym2+l8XxGHXxtBj
         K0vTqc4YCNj0p/hOj+d4jy6B+mETTyhistNWGbWz9WiBapzL9+ghUgWlA8QgWdzxGF
         J0hYeqzDEceIuz8mMSirPPsiPNhGEmeav+U9MKhE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 084Fiq8Q116315;
        Fri, 4 Sep 2020 10:44:52 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 10:44:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 10:44:52 -0500
Received: from [10.250.71.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 084Fipsu125901;
        Fri, 4 Sep 2020 10:44:51 -0500
Subject: Re: [PATCH -next] remoteproc: k3-dsp: Fix return value check in
 k3_dsp_rproc_of_get_memories()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200902140614.28636-1-yuehaibing@huawei.com>
 <20200902165904.GB280378@xps15>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <70ad695c-4200-7927-7274-dc4d5bd32920@ti.com>
Date:   Fri, 4 Sep 2020 10:44:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902165904.GB280378@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 11:59 AM, Mathieu Poirier wrote:
> On Wed, Sep 02, 2020 at 10:06:14PM +0800, YueHaibing wrote:
>> In case of error, the function devm_ioremap_wc() returns NULL pointer
>> not ERR_PTR(). The IS_ERR() test in the return value check should be
>> replaced with NULL test.
>>
>> Fixes: 87218f96c21a ("remoteproc: k3-dsp: Add support for C71x DSPs")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> index 9011e477290c..f373df35d7d0 100644
>> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
>> @@ -445,10 +445,10 @@ static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
>>  
>>  		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
>>  							 resource_size(res));
>> -		if (IS_ERR(kproc->mem[i].cpu_addr)) {
>> +		if (!kproc->mem[i].cpu_addr) {
>>  			dev_err(dev, "failed to map %s memory\n",
>>  				data->mems[i].name);
>> -			return PTR_ERR(kproc->mem[i].cpu_addr);
>> +			return -EBUSY;
> 
> Shouldn't this be -ENOMEM?

Indeed, thanks for catching it.

I will fix these same issues on the K3 R5F driver for v4.

regards
Suman

> 
>>  		}
>>  		kproc->mem[i].bus_addr = res->start;
>>  		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
>> -- 
>> 2.17.1
>>
>>


Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD09FC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7865E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DqTcfhEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgIKPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:15:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbgIKPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:12:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDlfdN016391;
        Fri, 11 Sep 2020 15:50:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=LedGIkihyb95sarwl6GH6FHkhiz/ZEZc+nrtI6/KHRQ=;
 b=DqTcfhEOyT+mjya84EPGVrM1imjDeblcaBYwSTzOxQYWNd7Sxj+G2zkIvTMr27NXSkLH
 YwCMK1oAw8clCxnrvtktuamiNqy3/2L5FGqPVJAKmXMtlLIAZkgL7Xb9lwNXt/zlwjj+
 g/tXBi70Q0H/h5xkp10E1dsHKe9RbmMr4/IdRhqw+t7MhfiT3cbMIjPqJ3ATFTEH45l8
 8U1HEraZ7IV/4NAm8H2Pph2HvEftW9I5xblkFqbHCkuDZMdoIXPZV1JeKWL11M0eHx5i
 AKn8VypoIsE50fhMd/ZeHzv7iv0OpJ0zhr4c1hWKq8Rbjx414URLPZsvqup0j/irA8Lf zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33c1jfhyq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 15:50:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA153100038;
        Fri, 11 Sep 2020 15:50:02 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag3node4.st.com [10.75.127.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D99F2AD9FD;
        Fri, 11 Sep 2020 15:50:02 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by GPXDAG3NODE4.st.com
 (10.75.127.71) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 15:50:00 +0200
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: stm32_rproc: update for
 firmware synchronization
To:     Rob Herring <robh@kernel.org>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20200827072101.26588-1-arnaud.pouliquen@st.com>
 <20200827072101.26588-3-arnaud.pouliquen@st.com>
 <20200909202251.GA2975092@bogus>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <c9d45617-6de9-7e49-0c82-151e67fff61d@st.com>
Date:   Fri, 11 Sep 2020 15:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909202251.GA2975092@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To GPXDAG3NODE4.st.com
 (10.75.127.71)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 9/9/20 10:22 PM, Rob Herring wrote:
> On Thu, Aug 27, 2020 at 09:21:00AM +0200, Arnaud Pouliquen wrote:
>> Add new properties description used to attach to a pre-loaded
>> firmware according to the commit 9276536f455b3
>> ("remoteproc: stm32: Parse syscon that will manage M4 synchronisation")
>> which updates the driver part.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 4ffa25268fcc..e50957d86b1c 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> @@ -96,6 +96,25 @@ properties:
>>          3rd cell: register bitmask for the deep sleep bit
>>      maxItems: 1
>>  
>> +  st,syscfg-m4-state:
>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> +    description: |
>> +      Reference to the tamp register which exposes the Cortex-M4 state.
>> +        1st cell: phandle to syscon block
>> +        2nd cell: register offset containing the Cortex-M4 state
>> +        3rd cell: register bitmask for the Cortex-M4 state
>> +    maxItems: 1
>> +
>> +  st,syscfg-rsc-tbl:
>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> +    description: |
>> +      Reference to the tamp register which references the Cortex-M4
>> +      resource table address.
>> +        1st cell: phandle to syscon block
>> +        2nd cell: register offset containing the resource table address
>> +        3rd cell: register bitmask for the resource table address
>> +    maxItems: 1
> 
> Why can't these be implied? You can lookup the tamp syscon by 
> compatible.

I just made a copy/past of the  "st,syscfg-pdds" syscon description available in the same file [1]
  
I can provide a shorter descriptions, something like this:

   description: |
     Reference to the tamp syscon register and bitmask which contains the Cortex-M4
      resource table address.
   maxItems: 1

Would this meet your expectations? If yes, I will also add in next version an extra patch to fix [1]

[1] https://elixir.bootlin.com/linux/v5.9-rc3/source/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml#L90

> 
> Please add these to the example.

I will extend the example with these properties

Thanks,
Arnaud

> 
>> +
>>    st,auto-boot:
>>      $ref: /schemas/types.yaml#/definitions/flag
>>      description:
>> -- 
>> 2.17.1
>>

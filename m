Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7CE20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G6bkOMjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEUTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:06:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38346 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgEUTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:06:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LJ6An4026452;
        Thu, 21 May 2020 14:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590087970;
        bh=TsE8Woh4zkRDEYdrJ4szky2f76HNP2vRTH83cKZFVYw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G6bkOMjEAsuxKVKPsCnDAuLxmCjCWKUiG33hlFw2mv7smJKWSjhixJX/8O+k5Io+t
         NOoBOzAiaD4X/jVU3vX4XnezShs1pabJEG28E+RI4iL2A/g9xEwp0D7oHgf12ciX1D
         gTf5Yz0CIcBg43CoNVB+6rMZkj2yX5f8DTVl+3/o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LJ6AQf067299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 14:06:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 14:06:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 14:06:09 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LJ6994034395;
        Thu, 21 May 2020 14:06:09 -0500
Subject: Re: [PATCH 2/4] remoteproc: introduce version element into resource
 type field
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-3-s-anna@ti.com> <20200521175421.GI408178@builder.lan>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b338480e-c586-f988-f5b6-784551b7beb6@ti.com>
Date:   Thu, 21 May 2020 14:06:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521175421.GI408178@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/21/20 12:54 PM, Bjorn Andersson wrote:
> On Wed 25 Mar 13:46 PDT 2020, Suman Anna wrote:
> 
>> The current remoteproc core has supported only 32-bit remote
>> processors and as such some of the current resource structures
>> may not scale well for 64-bit remote processors, and would
>> require new versions of resource types. Each resource is currently
>> identified by a 32-bit type field. Introduce the concept of version
>> for these resource types by overloading this 32-bit type field
>> into two 16-bit version and type fields with the existing resources
>> behaving as version 0 thereby providing backward compatibility.
>>
>> The version field is passed as an additional argument to each of
>> the handler functions, and all the existing handlers are updated
>> accordingly. Each specific handler will be updated on a need basis
>> when a new version of the resource type is added.
>>
> 
> I really would prefer that we add additional types for the new
> structures, neither side will be compatible with new versions without
> enhancements to their respective implementations anyways.

OK.

> 
>> An alternate way would be to introduce the new types as completely
>> new resource types which would require additional customization of
>> the resource handlers based on the 32-bit or 64-bit mode of a remote
>> processor, and introduction of an additional mode flag to the rproc
>> structure.
>>
> 
> What would this "mode" indicate? If it's version 0 or 1?

No, for indicating if the remoteproc is 32-bit or 64-bit and adjust the 
loading handlers if the resource types need to be segregated accordingly.

> 
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c    | 25 +++++++++++++++----------
>>   drivers/remoteproc/remoteproc_debugfs.c | 17 ++++++++++-------
>>   include/linux/remoteproc.h              |  8 +++++++-
>>   3 files changed, 32 insertions(+), 18 deletions(-)
>>
> [..]
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 77788a4bb94e..526d3cb45e37 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -86,7 +86,13 @@ struct resource_table {
>>    * this header, and it should be parsed according to the resource type.
>>    */
>>   struct fw_rsc_hdr {
>> -	u32 type;
>> +	union {
>> +		u32 type;
>> +		struct {
>> +			u16 t;
>> +			u16 v;
>> +		} st;
> 
> I see your "type" is little endian...

Yeah, definitely a draw-back if we want to support big-endian rprocs. Do 
you have any remoteprocs following big-endian? All TI remoteprocs are 
little-endian except for really old ones.

regards
Suman

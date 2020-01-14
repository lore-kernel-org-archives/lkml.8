Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04354C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D8324680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgANKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:03:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:4432 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbgANKDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 02:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="397461736"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2020 02:03:52 -0800
Received: from [10.226.39.11] (unknown [10.226.39.11])
        by linux.intel.com (Postfix) with ESMTP id 9DAA75802B1;
        Tue, 14 Jan 2020 02:03:51 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: reset: intel,rcu-gw: Fix intel,global-reset
 schema
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20200113214515.3950-1-robh@kernel.org>
 <6594eba7-fb23-b741-4490-da27573fe132@linux.intel.com>
Message-ID: <6cbc1500-6526-f985-6060-962ffd87ac25@linux.intel.com>
Date:   Tue, 14 Jan 2020 18:03:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6594eba7-fb23-b741-4490-da27573fe132@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

My bad, please ignore my response.
I just directly jumped into the error and felt you are suggesting me to 
send a separate patch to fix the error.
After sending the mail i realized by reading the subject that you 
already submitted the fix patch.
Please ignore it,

Thanks for doing it.
Regards,
Dilip

On 1/14/2020 5:54 PM, Dilip Kota wrote:
>
> On 1/14/2020 5:45 AM, Rob Herring wrote:
>> The intel,rcu-gw binding example has an error:
>>
>> Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml:
>>    reset-controller@e0000000: intel,global-reset: [[16, 30]] is too 
>> short
>>
>> The error isn't really correct as the problem is in how the data is
>> encoded and the schema is not fixed up by the tooling correctly.
>> However, array properties should describe the elements in the array, so
>> lets do that which fixes the error in the process.
>
> Sure, i will add the change describing the array properties and push 
> as a fix patch.
>
>
> Regards,
>
> Dilip
>
>>
>> Fixes: b7ab0cb00d08 ("dt-bindings: reset: Add YAML schemas for the 
>> Intel Reset controller")
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Dilip Kota <eswara.kota@linux.intel.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml 
>> b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>> index 246dea8a2ec9..8ac437282659 100644
>> --- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>> +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>> @@ -23,7 +23,11 @@ properties:
>>       description: Global reset register offset and bit offset.
>>       allOf:
>>         - $ref: /schemas/types.yaml#/definitions/uint32-array
>> -      - maxItems: 2
>> +    items:
>> +      - description: Register offset
>> +      - description: Register bit offset
>> +        minimum: 0
>> +        maximum: 31
>>       "#reset-cells":
>>       minimum: 2

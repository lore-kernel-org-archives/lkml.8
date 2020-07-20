Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017C8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E0B22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fxzjk4pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgGTPZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:25:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:25:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KFPpvb013547;
        Mon, 20 Jul 2020 10:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595258751;
        bh=ao8BlmMy90h2RgJvinWkQ1VowSR9siCrviTWF7w3VIA=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=Fxzjk4pKB03BZhfihhejJV/0jYEJ2NfKzhAtuqw/1dohc7GDWsw0wdlR0UC4rQ/+Z
         XcCoHehLKdysvdODa5iH8QZHhlZ9yNuZAjGff41M2uUHH4cQRD9FW8msPDL53KUgER
         1PEA7Vd3ksgVpanbBixpkZ55rkNSRwxRUfFXf2sI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06KFPpjv006911
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 10:25:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 10:25:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 10:25:51 -0500
Received: from [10.250.74.234] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KFPogP012081;
        Mon, 20 Jul 2020 10:25:50 -0500
Subject: Re: [PATCH 1/2 v2] net: hsr: fix incorrect lsdu size in the tag of
 HSR frames for small frames
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        <vinicius.gomes@intel.com>
References: <20200717145510.30433-1-m-karicheri2@ti.com>
 <0e064d93-546d-e999-e36a-499d37137ba4@ti.com>
 <ad869a7c-fe39-8b75-c235-d65005cd9c32@ti.com>
Message-ID: <a1a6c820-d096-8236-5af9-49ae04d32704@ti.com>
Date:   Mon, 20 Jul 2020 11:25:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad869a7c-fe39-8b75-c235-d65005cd9c32@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygoii,

On 7/20/20 10:08 AM, Murali Karicheri wrote:
> Grygorii,
> 
> On 7/17/20 1:39 PM, Grygorii Strashko wrote:
>>
>>
>> On 17/07/2020 17:55, Murali Karicheri wrote:
>>> For small Ethernet frames with size less than minimum size 66 for HSR
>>> vs 60 for regular Ethernet frames, hsr driver currently doesn't pad the
>>> frame to make it minimum size. This results in incorrect LSDU size being
>>> populated in the HSR tag for these frames. Fix this by padding the frame
>>> to the minimum size applicable for HSR.
>>>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> ---
>>>   no change from original version
>>>   Sending this bug fix ahead of PRP patch series as per comment
>>>   net/hsr/hsr_forward.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>>   Sending this bug fix ahead of PRP patch series as per comment
>>> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
>>> index ed13760463de..e42fd356f073 100644
>>> --- a/net/hsr/hsr_forward.c
>>> +++ b/net/hsr/hsr_forward.c
>>> @@ -127,6 +127,9 @@ static void hsr_fill_tag(struct sk_buff *skb, 
>>> struct hsr_frame_info *frame,
>>>       int lane_id;
>>>       int lsdu_size;
>>> +    /* pad to minimum packet size which is 60 + 6 (HSR tag) */
>>> +    skb_put_padto(skb, ETH_ZLEN + HSR_HLEN);
>>
>> It may fail.
>> And i worry that it might be not the right place to do that
>> (if packet is small it will be called for every copy of the packet).
>> May be it has to be done once when packet enters LRE device?
>>
> A better place may be to add it at the beginning of
> hsr_fill_frame_info() at which point there is one copy and after that
> code enters hsr_forward_do() to replicate. I don't think we can place it
> anywhere before that code.
> 
> hsr_dev_xmit()
>     - hsr_forward_skb()
>        - hsr_fill_frame_info()
> 
> Inside hsr_fill_frame_info() we could do
> 
>      if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
>          frame->is_vlan = true;
>          /* FIXME: */
>          netdev_warn_once(skb->dev, "VLAN not yet supported");
>      }
> +    min_size = ETH_ZLEN + HSR_HLEN;
> +       if (frame->is_vlan)
> +        min_size += 4;
> +    ret = skb_put_padto(skb, min_size))
> +    if (ret)
> +         return ret;
> 
> At this point, it will be ready to tag the frame. Frame will be either a
> supervision frame which is already tagged or standard frame from upper
> layer. Either case, padto() is required. So looks like the right place
> to avoid doing it twice.
> 
> And packet would get dropped at the caller if skb_put_padto() fails. So
> we could return the return value to the caller.
> 
> This also eliminates similar padto() call in 
> send_hsr_supervision_frame() as well.
> 
> What do you think?

Dave has already applied the patch. So I will send a follow up
patch that fixes the original issue to check for the return type.

The patch to optimize this at the correct location (second part
of your concern) can be a separate patch that will send as a follow up
to the PRP series as that code touches this as well. So better to
optimize this after the PRP series IMO.

I plan to fix similar issue in the PRP series as well ( not
checking for return type) and re-spin. Don't want to delay merge
of PRP series for this optimization that can be addressed
separately as I have said.

Murali
> 
> Murali
>>> +
>>>       if (port->type == HSR_PT_SLAVE_A)
>>>           lane_id = 0;
>>>       else
>>>
>>
> 

-- 
Murali Karicheri
Texas Instruments

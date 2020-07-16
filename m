Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88590C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CACE207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgGPNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:34:13 -0400
Received: from foss.arm.com ([217.140.110.172]:49518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgGPNeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:34:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E07F331B;
        Thu, 16 Jul 2020 06:34:11 -0700 (PDT)
Received: from [10.57.35.46] (unknown [10.57.35.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2E63F66B;
        Thu, 16 Jul 2020 06:34:09 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: arm: rockchip: add A95X Z2
 description
To:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20200620134659.4592-1-jbx6244@gmail.com>
 <20200620134659.4592-2-jbx6244@gmail.com> <20200715192935.GA684031@bogus>
 <14b39efe-f38b-b471-560d-1ecaeafc5dd5@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <56b1447d-6c62-9e73-a7ce-08fb70096a97@arm.com>
Date:   Thu, 16 Jul 2020 14:34:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14b39efe-f38b-b471-560d-1ecaeafc5dd5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-16 13:05, Johan Jonker wrote:
> Hi Rob,
> 
> The A95X Z2 boxes are sold by various vendors/manufacturers/web shops.
> The box it self only shows a label with a model name.
> Determining the true vendor is a kind of tricky for a outsider of the
> business.
> Could you advise what would be a save choice to the rather rigid vendor
> requirements.
> Is for example this a option:
> 
>    "^a95x,.*":
>      description: A95X
> 
> Is there someone who can give more info on this subject?

FWIW we already have some "A95X" branded things attributed to Nexbox in 
upstream DTs, however, the evidence from scraping around the internet 
suggests that the closest thing to an original vendor for the "A95X Z2" 
model is probably these folks:

https://zkmagic.en.alibaba.com/

Robin.

> 
> Kind regards,
> 
> Johan Jonker
> 
> On 7/15/20 9:29 PM, Rob Herring wrote:
>> On Sat, Jun 20, 2020 at 03:46:58PM +0200, Johan Jonker wrote:
>>> Add A95X Z2 description for a board with rk3318 processor.
>>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> index d4a404509..3d44b3cf0 100644
>>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>>> @@ -25,6 +25,11 @@ properties:
>>>             - const: vamrs,rock960
>>>             - const: rockchip,rk3399
>>>   
>>> +      - description: A95X Z2
>>> +        items:
>>> +          - const: a95x,z2
>>
>> Need to document vendor prefix.
>>
>>> +          - const: rockchip,rk3318
>>> +
>>>         - description: Amarula Vyasa RK3288
>>>           items:
>>>             - const: amarula,vyasa-rk3288
>>> -- 
>>> 2.11.0
>>>
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

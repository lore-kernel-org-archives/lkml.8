Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974552073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="jaAKaoE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbgEYNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:00:29 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:45453 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388756AbgEYNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:00:27 -0400
X-Greylist: delayed 1305 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 09:00:26 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 987E44011A99A
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:58:27 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id dCNMjFsilEfyqdCNMjwZ0a; Mon, 25 May 2020 07:38:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2TljW7JsW+WCZFc/vJnuFILXikxQwHFnuGlW+UY2ObY=; b=jaAKaoE9zh9aAvTL7GhKDpQNfZ
        eCkF23JYStQG4EZq2qZzqP49go5dOw9ojs1PsnVGvyLai1KxDT0AnuEHSZvt78SEUFG+kIeKJSNGm
        AywzfK60JlfYclTVBVEX/O13c507O3NL15Y4kkECBAyR+/rsBt1CgI57jNHVHol3waSbwKkicclDh
        byKVOqwGT+T5D2Qi2dW56i2rq6Kd1g6EeQeS1wQYX/6LduDjKI08Rzu3w48VIyPCsL2C2on24UlnZ
        s55pwtE+N4dhLk3lwOZ7O+IOUvl34wTmWtY9SGSZjZpgXHK0NySh8NAyoOr5hA3zZNwtRX/8W6zbv
        BnZy0WJg==;
Received: from [191.31.196.240] (port=53056 helo=[192.168.15.5])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jdCNM-002LnX-Dr; Mon, 25 May 2020 09:38:40 -0300
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: actions: Document Caninos Loucos
 Labrador
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20200525013008.108750-1-matheus@castello.eng.br>
 <20200525013008.108750-3-matheus@castello.eng.br>
 <8fc7b0d0-6516-ecd4-ce9c-a63a3cba7e9a@suse.de>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <752b0710-ba99-ef19-d3c2-78cca5c6bdf2@castello.eng.br>
Date:   Mon, 25 May 2020 09:38:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <8fc7b0d0-6516-ecd4-ce9c-a63a3cba7e9a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.240
X-Source-L: No
X-Exim-ID: 1jdCNM-002LnX-Dr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [191.31.196.240]:53056
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 10
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Em 5/25/20 7:41 AM, Andreas Färber escreveu:
> Hi,
> 
> Am 25.05.20 um 03:30 schrieb Matheus Castello:
>> Update the documentation to add the Caninos Loucos Labrador. Labrador
>> project consists of a computer on module based on the Actions Semi S500
>> processor and the Labrador base board.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml 
>> b/Documentation/devicetree/bindings/arm/actions.yaml
>> index ace3fdaa8396..2187e1c5bc73 100644
>> --- a/Documentation/devicetree/bindings/arm/actions.yaml
>> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
>> @@ -19,6 +19,11 @@ properties:
>>                 - allo,sparky # Allo.com Sparky
>>                 - cubietech,cubieboard6 # Cubietech CubieBoard6
>>             - const: actions,s500
>> +      - items:
>> +          - enum:
>> +              - caninos,labrador-v2 # Labrador Core v2
>> +              - caninos,labrador-base-m # Labrador Base Board M v1
> 
> This enum still strikes me as wrong, it means either-or. (Was planning 
> to look into it myself, but no time yet...) caninos,labrador-v2 should 
> be a const one level down: board, SoM, SoC from most specific to most 
> generic. Compare Guitar below.

I got it, I agree make sense, I will send the v6.

> 
>> +          - const: actions,s500
>>         - items:
>>             - enum:
>>                 - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board 
>> rev. B
> 
> Regards,
> Andreas
> 

Best Regards,
Matheus Castello

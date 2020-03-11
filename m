Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1965EC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7F21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="M2w0nZx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCKEE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:04:26 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.35]:45931 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgCKEE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:04:26 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 0E25548B3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:04:25 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id BsbZj6zBaAGTXBsbZjYVQq; Tue, 10 Mar 2020 23:04:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3mQ8efzp5o0AkNF9bZhfeVXit4yUM1qXe8Qn2DoH+uM=; b=M2w0nZx0+GhH4CQngfIEQ9sxdq
        dPBJpztWkuF97hxTB23jiqquuyEfWqRtGR/dz6LZfloO8lVT6HRJBDCzlEgubKv2IueRb5FraSCwc
        MZSd1X4ZFG8dJmaoRIn41Qh5FHZp4U4C1FQfc+zUnKbDr22t5pmLrfnPezI+nnvl5njb5lvQ2KWBm
        0S/z022YqNNU0omGKoOKzoDJRKsIUFNQKG8p6BFMh9sQFvWrh5rEp549fjZc5EcgtBUv/lyoaTcI+
        sZPFNjYuVX/3d4DFlVT75XME5sVGqYzR5Sc+yMA+NL5z9oCUri+zjNGywSZkWHU8uRqHuWv/7ptnK
        PQxQcQoQ==;
Received: from [191.31.204.9] (port=54190 helo=[192.168.15.3])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jBsbY-001Nn8-Lh; Wed, 11 Mar 2020 01:04:24 -0300
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     manivannan.sadhasivam@linaro.org, mark.rutland@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br
References: <20200229104358.GB19610@mani>
 <20200307002453.350430-1-matheus@castello.eng.br>
 <20200307002453.350430-2-matheus@castello.eng.br>
 <62e115af-9d8c-572a-a400-91bdef9d9292@suse.de>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <143fea2e-3361-445a-a261-1860ffc435eb@castello.eng.br>
Date:   Wed, 11 Mar 2020 01:04:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <62e115af-9d8c-572a-a400-91bdef9d9292@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.204.9
X-Source-L: No
X-Exim-ID: 1jBsbY-001Nn8-Lh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.3]) [191.31.204.9]:54190
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 7
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Em 3/7/20 9:34 AM, Andreas Färber escreveu:
> Hi Matheus,
> 
> Am 07.03.20 um 01:24 schrieb Matheus Castello:
>> The Caninos Loucos Program develops Single Board Computers with an open
>> structure. The Program wants to form a community of developers to use
>> the IoT technology and disseminate the learning of embedded systems in
> 
> I would suggest "IoT technologies" without "the".
> 

ack

>> Brazil.
>>
>> The boards are designed and manufactured by LSI-TEC NPO.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml 
>> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 9e67944bec9c..3e974dd563cf 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -167,6 +167,8 @@ patternProperties:
>>       description: Calxeda
>>     "^capella,.*":
>>       description: Capella Microsystems, Inc
>> +  "^caninos,.*":
>> +    description: Caninos Loucos LSI-TEC NPO
> 

I will change this to "Caninos Loucos Program"

> Alphabetical order: n goes before p.
> 
> I'm confused by the description... Either this Caninos Loucos is an 
> independent vendor and gets its own prefix, or it's LSI-Tec and uses 
> something like lsi-tec,caninosloucos-foo. Please clarify commit message 
> and/or description line, at least by inserting something like "program 
> by", "brand by" or the like rather than just concatenating names. Maybe 
> compare UDOO by SECO. Is caninos,foo unique enough or should it be 
> caninosloucos,foo? (crazy canines?)
> 

Yes "Caninos Loucos" means crazy canines (or mad dog) in Portuguese. 
This is a initiative that have as co-founder the Jon Maddog Hall, 
because of Jon we have the "maddog", but in Portuguese, on the name of 
program.

 From their website: https://caninosloucos.org/en/program-en/:
"It is an initiative of the Technological Integrated Systems Laboratory 
(LSI-TEC) with the support of Polytechnic School of the University of 
São Paulo (Poli-USP) and Jon “Maddog” Hall"

So I think we can put this instead "The boards are designed and 
manufactured by LSI-TEC NPO." on description.

Let me know what you think about this.

> Note that I usually attempt to CC the organizations I'm assigning a 
> vendor prefix for. Do you represent them or coordinated with them?
>

Thanks for the review and tips. I am adding Edgar Bernardi Righi and 
Igor Ruschi from Caninos team as CC on this patch series.

Best Regards,
Matheus Castello

> Regards,
> Andreas
>
>>     "^cascoda,.*":
>>       description: Cascoda, Ltd.
>>     "^catalyst,.*":
> 

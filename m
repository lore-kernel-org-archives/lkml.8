Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17922077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFDIoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:44:55 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58318 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgFDIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:44:55 -0400
Received: from [37.160.65.106] (port=1535 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jglUY-000GFK-U3; Thu, 04 Jun 2020 10:44:51 +0200
Subject: Re: [RFC 3/4] regulator: lp87565: dt: add LP87524-Q1 variant
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-4-luca@lucaceresoli.net> <20200604060142.GQ3714@dell>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <5bfe9fb4-8792-ef21-bd02-7948d74a837d@lucaceresoli.net>
Date:   Thu, 4 Jun 2020 10:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604060142.GQ3714@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 04/06/20 08:01, Lee Jones wrote:
> On Wed, 03 Jun 2020, Luca Ceresoli wrote:
> 
>> Add the LP87524-Q1 to the lp87565 bindings document along with an example.
> 
> Keep the way to describe model numbers consistent.
> 
> I suggest LP87565 here (even though the filename is in lower case).

Ok.

>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../devicetree/bindings/mfd/lp87565.txt       | 47 ++++++++++++++++++-
> 
> This is an MFD patch.
> 
> Please change the patch subject to reflect that.

Done that here and in patch 2 as well, and also changed from "dt:" to a
"dt-bindings:" prefix. This will be in v2:

  dt-bindings: mfd: lp87565: add LP87524-Q1 variant

>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> index b75ae23a1ef3..839eac6b75c2 100644
>> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
>> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> @@ -1,7 +1,8 @@
>>  TI LP87565 PMIC MFD driver
>>  
>>  Required properties:
>> -  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
>> +  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1",
>> +			"ti,lp87524-q1"
> 
> Maybe have 2 per line.  It would really help with my OCD!

Ok.

-- 
Luca

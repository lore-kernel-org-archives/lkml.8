Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C51C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C4C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XOKkedUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgAJK5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:57:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgAJK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:57:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00AAvakJ052718;
        Fri, 10 Jan 2020 04:57:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578653856;
        bh=jcTyAyRtrcD73f6Tyow/ueJfOVG81D6QLodR2fJHMvY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XOKkedUqoHp+t5964azmwZU2yCe3gILekp4p0iTLAd4a/WJXJIBwDKO7FDexkamil
         GeiX0BABqH8ae/tlXlmIjamwYYnlSvoWo0gfBQlC38Gm5kwfkqRD9eYT28t5VGhD2R
         GgSLxInwyMSt1P8DtX9bAmzHqfSBCrkIlCNlZeQ0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00AAvaCo010013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jan 2020 04:57:36 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Jan 2020 04:57:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Jan 2020 04:57:36 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00AAvXYQ048117;
        Fri, 10 Jan 2020 04:57:34 -0600
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add PHY_TYPE_DP definition
To:     Jyri Sarha <jsarha@ti.com>, <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <rogerq@ti.com>
References: <cover.1578471433.git.jsarha@ti.com>
 <e38387d6bfc38c76e2335b549da409291366e9ac.1578471433.git.jsarha@ti.com>
 <1bccf7b6-3cc0-e39f-f7b9-3ec0b0553804@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c42d061d-2fd4-5a79-8555-147f53409b32@ti.com>
Date:   Fri, 10 Jan 2020 16:29:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1bccf7b6-3cc0-e39f-f7b9-3ec0b0553804@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/20 4:57 PM, Jyri Sarha wrote:
> On 08/01/2020 10:30, Jyri Sarha wrote:
>> Add definition for DisplayPort phy type.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Kishon, maybe you could pick only this patch phy-next, so that we avoid
> nasty cross dependencies if I get to push DisplayPort dts patches to
> mainline early.

Sure. Picked them now.

Thanks
Kishon

> 
> Best regards,
> Jyri
> 
>> ---
>>  include/dt-bindings/phy/phy.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
>> index b6a1eaf1b339..1f3f866fae7b 100644
>> --- a/include/dt-bindings/phy/phy.h
>> +++ b/include/dt-bindings/phy/phy.h
>> @@ -16,5 +16,6 @@
>>  #define PHY_TYPE_USB2		3
>>  #define PHY_TYPE_USB3		4
>>  #define PHY_TYPE_UFS		5
>> +#define PHY_TYPE_DP		6
>>  
>>  #endif /* _DT_BINDINGS_PHY */
>>
> 
> 

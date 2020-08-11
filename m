Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9546FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666122076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tyan8PK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgHKRHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:07:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47488 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHKRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:07:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07BH7JbR038660;
        Tue, 11 Aug 2020 12:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597165639;
        bh=0Uod0ZsKogiy0hAZ1QvXFWCmrhC6bXLrN4FQiX676XY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tyan8PK9D4AkYSrOMQdfT/LbHRMOR8DHwioYL58bbUdjapkmaOnV+0NGhCemu8u+x
         Ji6lH/Tp4aWKwqGXzGuqGmDpJC3duRB6MLCodSlnZBP8iH9ieiLD21+42Wv8Xi/Ry/
         V1vdAw9EiK3j5vZNBS7KG1lPhoqDZ8L3FdTSaTSA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07BH7JUb008455;
        Tue, 11 Aug 2020 12:07:19 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 11
 Aug 2020 12:07:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 11 Aug 2020 12:07:19 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07BH7JpU080863;
        Tue, 11 Aug 2020 12:07:19 -0500
Subject: Re: [PATCH v32 1/6] dt: bindings: lp50xx: Introduce the lp50xx family
 of RGB drivers
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <robh@kernel.org>,
        <marek.behun@nic.cz>, <devicetree@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200722153146.8767-1-dmurphy@ti.com>
 <20200722153146.8767-2-dmurphy@ti.com>
 <20200811102028.tjea7oqbzb5jjqip@duo.ucw.cz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <92d1448f-8b17-0ce6-0464-b60ff6a6eb16@ti.com>
Date:   Tue, 11 Aug 2020 12:07:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811102028.tjea7oqbzb5jjqip@duo.ucw.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 8/11/20 5:20 AM, Pavel Machek wrote:
> Hi!
> On Wed 2020-07-22 10:31:41, Dan Murphy wrote:
>> Introduce the bindings for the Texas Instruments LP5036, LP5030, LP5024,
>> LP5018, LP5012 and LP5009 RGB LED device driver.  The LP5036/30/24/18/12/9
>> can control RGB LEDs individually or as part of a control bank group.
>> These devices have the ability to adjust the mixing control for the RGB
>> LEDs to obtain different colors independent of the overall brightness of
>> the LED grouping.
>>
>> Datasheet:
>> http://www.ti.com/lit/ds/symlink/lp5012.pdf
>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>> http://www.ti.com/lit/ds/symlink/lp5036.pdf
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
>> +           multi-led@1 {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               reg = <0x1>;
>> +               color = <LED_COLOR_ID_MULTI>;
>> +               function = LED_FUNCTION_CHARGING;
> These are just examples, but we should really separate "MULTI" colors
> and "RGB".

If we do then the LP55xx was not updated when the change was made.

I will change it to RGB since I have to touch this file and probably 
submit the LP55xx patch as well.

Dan


> Best regards,
> 									Pavel

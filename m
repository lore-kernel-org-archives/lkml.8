Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4750C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F33E20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WQb/MWpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHGNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:43:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57000 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHGNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:43:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 077DgW7v106231;
        Fri, 7 Aug 2020 08:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596807752;
        bh=8oAMjKTzBttcGF2U7YjFY7PkZVk3qPMxinswoiWxaY0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=WQb/MWpNWDYl4NXzkOFu2fBbeSOntRtQ03v/KJEKfVQdFGg2nkzYJl/37mUPPuXYm
         iUIv/tb9h3LLZoMp+Touc3zhiNxSeBIiKgGlV73xVTR4VgKC92ehFaF2/HQEZJ8hmp
         LFyGdr8+tBTjQj9QKJS/jTratAw+3ipgeMIecDXw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 077DgWX2091036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Aug 2020 08:42:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 7 Aug
 2020 08:42:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 7 Aug 2020 08:42:32 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 077DgWgq050044;
        Fri, 7 Aug 2020 08:42:32 -0500
Subject: Re: [PATCH v32 1/6] dt: bindings: lp50xx: Introduce the lp50xx family
 of RGB drivers
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh@kernel.org>,
        <marek.behun@nic.cz>
CC:     <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200722153146.8767-1-dmurphy@ti.com>
 <20200722153146.8767-2-dmurphy@ti.com>
 <285e2038-6a90-e59a-d414-19cc0f8789e6@ti.com>
 <4c595ccd-f4bc-3ac2-6f3f-9778c1170af5@ti.com>
Message-ID: <67c903e9-4ffe-ed86-fd95-b343321c02a3@ti.com>
Date:   Fri, 7 Aug 2020 08:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4c595ccd-f4bc-3ac2-6f3f-9778c1170af5@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 8/4/20 2:55 PM, Dan Murphy wrote:
> Pavel
>
> On 7/28/20 8:39 AM, Dan Murphy wrote:
>> Pavel
>>
>> On 7/22/20 10:31 AM, Dan Murphy wrote:
>>> Introduce the bindings for the Texas Instruments LP5036, LP5030, 
>>> LP5024,
>>> LP5018, LP5012 and LP5009 RGB LED device driver.  The 
>>> LP5036/30/24/18/12/9
>>> can control RGB LEDs individually or as part of a control bank group.
>>> These devices have the ability to adjust the mixing control for the RGB
>>> LEDs to obtain different colors independent of the overall 
>>> brightness of
>>> the LED grouping.
>>
>> Were you going to pull this in as a user of the Multicolor framework?
>>
> Gentle ping.  I saw you were going to push the Omnia these should be 
> ready too
>
Did you need me to rebase these patches and add the Ack from Linus on 
the defconfig patch?

Dan


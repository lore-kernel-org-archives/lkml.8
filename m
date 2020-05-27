Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98775C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D190207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rg8aWjyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbgE0PFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:05:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgE0PFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:05:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04RF5aPc038795;
        Wed, 27 May 2020 10:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590591936;
        bh=gFdGje1XRt56yWr2NSWkBVQQ++h4DofQvUPzQIlD/tY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rg8aWjyEpbTpryMACNiDZkZHMGpD3Gbp+TcuXmgh1mhO5/ZyCdoDrCVHgcu1RG/31
         6Q+rbPXf+QDb2psv+iBaL8jLCMQZiz4Yjc5aAoBJe67kidu6EN3jxsJlRDXvjht4EL
         9iIQtTfNI9X+gnd3VI5bnKSaEVGTkmd1tywZnzKc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04RF5ZPL097368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 10:05:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 10:05:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 10:05:35 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RF5W3p120957;
        Wed, 27 May 2020 10:05:33 -0500
Subject: Re: [PATCH v25 03/16] dt: bindings: lp50xx: Introduce the lp50xx
 family of RGB drivers
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <robh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200526164652.2331-1-dmurphy@ti.com>
 <20200526164652.2331-4-dmurphy@ti.com> <20200527135848.GB5011@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d22658c2-07e2-74e6-dc2b-4b64fd9789dd@ti.com>
Date:   Wed, 27 May 2020 10:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527135848.GB5011@amd>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 5/27/20 8:58 AM, Pavel Machek wrote:
> Hi!
>
>
>> +          There can only be one instance of the ti,led-bank
>> +          property for each device node.  This is a required node is the LED
>> +          modules are to be backed.
> I don't understand the second sentence. Pretty sure it is not valid
> english.


If I make these changes is this still viable for 5.8 or would you then 
go into 5.9?

I mean v25 patchset was around for about 3+ weeks and now I have more 
changes.

Dan

>
> Best regards,
> 								Pavel
> 								

Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187AC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE45206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kYn2kHMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD0RSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:18:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35114 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0RSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:18:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RHIGbl099207;
        Mon, 27 Apr 2020 12:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588007896;
        bh=gw15huvP9C6ksLpZxmQ8j6LkYJ9pKHUk1POa4qZjyFY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kYn2kHMvF1fAB9e3F1fEBPzhxjFOnmMDUZXqjPgo01/RvrM0ETHYASCBaToNDZ7gy
         LXJykLEsOuNRlax2+/Hq9qGL+xPyEaxi/bZTOxzfgA3M2aNamVfIzwzXtR9tEWSwkg
         HNr3LZ1IGAAaSW3oOdr6N/gwCCM1LUsS2qEkD5Sw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RHIGFZ089320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 12:18:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 12:18:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 12:18:15 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RHIFBP072358;
        Mon, 27 Apr 2020 12:18:15 -0500
Subject: Re: [PATCH v20 02/17] leds: Add multicolor ID to the color ID list
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200423155524.13971-1-dmurphy@ti.com>
 <20200423155524.13971-3-dmurphy@ti.com> <20200425195242.GA1143@bug>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <003891b8-a697-6d55-3862-5773e23a466a@ti.com>
Date:   Mon, 27 Apr 2020 12:12:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425195242.GA1143@bug>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 4/25/20 2:52 PM, Pavel Machek wrote:
> On Thu 2020-04-23 10:55:09, Dan Murphy wrote:
>> Add a new color ID that is declared as MULTICOLOR as with the
>> multicolor framework declaring a definitive color is not accurate
>> as the node can contain multiple colors.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Please merge with previous patch, and you can keep reviews.

Not sure we should do that.  The previous patches deals directly with 
the bindings and this is code.

I thought the rule was to keep bindings and code separated.

It made sense to squash the bindings header patch to the bindings 
document patch but it does not make sense to squash this patch to the 
bindings.

Please let me know if you want me to proceed with the squash.

Dan


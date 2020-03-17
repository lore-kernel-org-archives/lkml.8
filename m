Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E43C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF0820663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KNL1OXo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCQMEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:04:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:04:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02HC1j8I000556;
        Tue, 17 Mar 2020 07:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584446505;
        bh=wjn4Q51nWQESg+W49NEoLzwZmi+vaAV5Ld0LLIhWlMU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KNL1OXo9R7zP4eMivWB4YnLEg888FaJWaGkzMD5YYZcsng8pfehS7k6fR7PvpulCz
         ZjYhiCPs7bBFO6fdxT0GWADv1bDM5eKivS1hatnQNu3sosUujTF+qlvEc5qqKdv7wc
         9SRMgnYWYt4NvxqtEC4khpx4utYWlHORTpjYAxoA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02HC1j8g024334
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Mar 2020 07:01:45 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 07:01:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 07:01:45 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02HC1ggs013068;
        Tue, 17 Mar 2020 07:01:43 -0500
Subject: Re: [PATCH] arm: dts: ti: k3-am654-main: Update otap-del-sel values
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>
References: <20200109085152.10573-1-faiz_abbas@ti.com>
 <5dc0bca0-502d-01b8-554b-4c4bc06688a8@ti.com>
 <54c5abfd-7ac5-92ba-e89b-aeae9ee4e275@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <3b721020-7ef2-410f-325c-6e17bdffc4a6@ti.com>
Date:   Tue, 17 Mar 2020 14:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <54c5abfd-7ac5-92ba-e89b-aeae9ee4e275@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2020 09:11, Faiz Abbas wrote:
> Tero,
> 
> On 17/01/20 1:38 pm, Tero Kristo wrote:
>> On 09/01/2020 10:51, Faiz Abbas wrote:
>>> According to the latest AM65x Data Manual[1], a different output tap
>>> delay value is optimum for a given speed mode. Update these values.
>>>
>>> [1] http://www.ti.com/lit/gpn/am6526
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>
>> I believe this patch is going to be updated, as the dt binding has
>> received comments. As such, going to ignore this for now.
>>
> 
> Those other series are merged now so you should be able to pick this up.

There were no changes to the DT binding?

Can you resend the DTS patch, and refer to the merged dt-binding? I 
deleted the whole series from my inbox already based on above.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

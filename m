Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A3CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA782312A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mEvy7ECN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgEMJuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:50:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35056 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbgEMJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:50:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D9oLng128304;
        Wed, 13 May 2020 04:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589363421;
        bh=hYJrqFqxOZldiuTXDyZ85es/GhABW0MVidKFOlcmr6o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mEvy7ECNG8Vto3uFzSjltSPQwZieKkX2ecTXo/WCk7kzwlC64gITO7ZaPeitZIiDV
         cnvzXHsEHZpSt11Sa7Xw0yz3uYsznCt4QtrN2EwrWsvOD7RH8U+ZI9ZiR3VAa8av3G
         sOrBGDx8ybCNH79VqojtM+VMdOuTQ5T6uHk4+sYw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D9oLWW072378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 04:50:21 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 04:50:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 04:50:21 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D9oHsn096634;
        Wed, 13 May 2020 04:50:19 -0500
Subject: Re: [PATCH v3 0/2] Misc. rproc fixes around fixed memory region
 support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200420160600.10467-1-s-anna@ti.com>
 <181b6c56-420c-f306-f2cf-53380ad1f37b@ti.com>
 <0a2aa179-9a97-003d-d682-283a8c354ea7@ti.com>
 <20200512231022.GC16107@builder.lan>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <cb6f76cb-1188-75e1-5986-718d7609ed7c@ti.com>
Date:   Wed, 13 May 2020 12:50:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200512231022.GC16107@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 02:10, Bjorn Andersson wrote:
> On Fri 08 May 08:14 PDT 2020, Suman Anna wrote:
> 
>> Hi Bjorn,
>>
>> On 5/2/20 1:29 PM, Suman Anna wrote:
>>> Hi Bjorn,
>>>
>>> On 4/20/20 11:05 AM, Suman Anna wrote:
>>>> Hi Bjorn,
>>>>
>>>> This is another minor revision of the fixes around fixed memory region
>>>> support [1] series. Patch 1 is revised to go back to the logic used in v1
>>>> after a long discussion on the v2 version [2]. The other suggestions can
>>>> be future improvments as they would require corresponding platform driver
>>>> changes. Please look through the discussion there and let us know your
>>>> preference. Patches are based on v5.7-rc1.
>>>>
>>>> I really appreciate it if you can target the series for the current
>>>> 5.7 -rc's.
>>>> The fixes would apply for all 5.1+ kernels.
>>>
>>> Ping on these.
>>
>> The patches have been reviewed and/or acked by both Mathieu and Arnaud.
> 
> Thanks for the reviews!
> 
>> Can you please get these into the current -rc's?
>>
> 
> The offending patch appeared in 5.1, so I have a hard time claiming that
> this is a regression in 5.7-rc. I've added Cc: stable and picked the two
> patches for 5.8.

Thanks Bjorn,

I believe 5.8 should be fine, we can backport this internally if needed.

-Tero

> 
> Thanks,
> Bjorn
> 
>> Thanks,
>> Suman
>>
>>>
>>> regards
>>> Suman
>>>
>>>>
>>>> Please see the v1 cover-letter [1] for the details on the issues.
>>>>
>>>> regards
>>>> Suman
>>>>
>>>> [1] https://patchwork.kernel.org/cover/11422723/
>>>> [2] https://patchwork.kernel.org/comment/23274389/
>>>>
>>>> Suman Anna (1):
>>>>     remoteproc: Fix and restore the parenting hierarchy for vdev
>>>>
>>>> Tero Kristo (1):
>>>>     remoteproc: Fall back to using parent memory pool if no dedicated
>>>>       available
>>>>
>>>>    drivers/remoteproc/remoteproc_core.c   |  2 +-
>>>>    drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
>>>>    2 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

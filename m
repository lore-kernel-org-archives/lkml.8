Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A72C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2232070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gqQ4IG3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgG0Jhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:37:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41492 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbgG0Jhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:37:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R9Vv0S028187;
        Mon, 27 Jul 2020 11:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=y6Q3xzmtzgK/GB+c33+XKmkK12IGii6dx3KQjUYpn1I=;
 b=gqQ4IG3KwKmqVB4G4SP7n92qV1QJ62/Z9QSHCmtwfW+GnN5jyEkeUp21uyVhn2CUPfOI
 PRcyC0x/uvw0i3JduFz8jHqkTBy46/732LDz2BvD2vi3G5L457JuQ7+fH4MAhovhZOHk
 P7nZpXWHfKlk3fUFB2N7xMUFgve0XQJUFDOuXtbvOXY7/vajgBd64Oez6RtySTV3hEGo
 N87wkYcblGQIPurwAZxgn5VEcvMaLxYjxnpag/Ipye7PwLtSxtONM/8yQC6ZGBDLj63F
 +1Gtr1de2XmWFw5ZQU8skzPUSkraSuqvUFGM35hnxVLQszbKDi5+bHrsm8ZYptQtevpI Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gbmg08wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 11:37:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4234510002A;
        Mon, 27 Jul 2020 11:37:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E53B2AE6D4;
        Mon, 27 Jul 2020 11:37:25 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 27 Jul
 2020 11:37:23 +0200
Subject: Re: [PATCH v3 0/3] Add USB role switch support to DWC2
To:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20200724104711.5474-1-amelie.delaunay@st.com>
 <4c44f596-d2c3-6d2f-bf28-9e3964b6e6f1@st.com> <878sf9owcw.fsf@kernel.org>
 <fcff5f96-8383-fd84-35f1-3eb291cd65df@st.com> <871rl0q46a.fsf@kernel.org>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <94748764-43b2-f11e-fd12-20ef3970c09a@st.com>
Date:   Mon, 27 Jul 2020 11:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rl0q46a.fsf@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_06:2020-07-27,2020-07-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/24/20 6:16 PM, Felipe Balbi wrote:
> Amelie DELAUNAY <amelie.delaunay@st.com> writes:
> 
>> Hi,
>>
>> On 7/24/20 3:50 PM, Felipe Balbi wrote:
>>>
>>> (no top-posting, please)
>>>
>>> Hi,
>>>
>>> Amelie DELAUNAY <amelie.delaunay@st.com> writes:
>>>> Series dropped.
>>>
>>> what do you mean with this? Should I drop all patches related with this series?
>>>
>>
>> As v1 patches were in your next branch, I've prepared a new patchset
>> which contains fixes, on top of you next branch :
>> https://lore.kernel.org/patchwork/project/lkml/list/?series=454959
>>
>>
>> What do you prefer ? Drop all patches related to the v1 "Add USB role
>> switch support to DWC2" series and I send a v4 in replacement or keep
>> all patches and wait for new series review ?
> 
> I've dropped those because they caused the build breakage :-) I can take
> a new series, let's take the opportunity to avoid the build regression.
> 

Sure! I've sent the v4, rebased on your testing/next because your next 
still contains the v1 patches, with the fix for build issue, and 
adressing Martin's comments. I drop the fixes series.

Regards,
Amelie

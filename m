Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8171A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wX0oUzSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBJLam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:30:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27016 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgBJLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:30:42 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ABRfpc012404;
        Mon, 10 Feb 2020 12:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=phLs9lGm8x/+ZAJsH4kNU4veeVEhZ4t1zwWsPOWVrgA=;
 b=wX0oUzSeCVCvJoxOSMLNDqK7lfESIwMA6DFIOGWEwzBSQ5KEoAEBlIgPxopV7amhbH9O
 6k2CM6B2ZjcZOsRaE7jL+DTf+pWSbeye6QvImhi1EqPRyosJazk04AR5sZ9LwCGN0q/a
 qB4tXwiZjcXMAuzjQBvXGM83lWBjK4cSm4PcyvZl3W6PYCg3RzuNy1n/Hw4/JgHZ7RFT
 eP83YjYOWBHNNQ42V4dCPhhgI3epMzLQx39zo1XPEc3fkarjowrFckm9DXm9F/iqBzCu
 dNb5nJVpMKzSAGTZeNOzikaxReGONyfIGlyUudcvPqs1XNL+nUf85Tk86wsiiXygJUt8 0w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1uvd1b4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 12:30:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 789B610002A;
        Mon, 10 Feb 2020 12:30:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68C372CD05A;
        Mon, 10 Feb 2020 12:30:23 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 10 Feb
 2020 12:30:22 +0100
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        youling 257 <youling257@gmail.com>
CC:     <yoshihiro.shimoda.uh@renesas.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <saravanak@google.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com>
 <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
 <CAOzgRdb5QfJDQzbtoHQry4wxUg52LwX5XFCPzzaYa=z+RqNWOQ@mail.gmail.com>
 <8bd72269-16ae-b24a-7144-44d22d668dc6@ti.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
Date:   Mon, 10 Feb 2020 12:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8bd72269-16ae-b24a-7144-44d22d668dc6@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_02:2020-02-10,2020-02-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 2/10/20 9:08 AM, Kishon Vijay Abraham I wrote:
> Hi Alexandre,
> 
> On 07/02/20 12:27 PM, youling 257 wrote:
>> test this diff, dwc3 work for my device, thanks.
>>
>> 2020-02-07 13:16 GMT+08:00, Kishon Vijay Abraham I <kishon@ti.com>:
>>> Hi,
>>>
>>> On 06/02/20 7:09 PM, youling257 wrote:
>>>> This patch cause "dwc3 dwc3.3.auto: failed to create device link to
>>>> dwc3.3.auto.ulpi" problem.
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206435
>>>
>>> I'm suspecting there is some sort of reverse dependency with dwc3 ULPI.
>>> Can you try the following diff?
>>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index 2eb28cc2d2dc..397311dcb116 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>>> @@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const char
>>> *string)
>>>
>>>          get_device(&phy->dev);
>>>
>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>>>          if (!link) {
>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>                          dev_name(phy->dev.parent));
>>> @@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
>>> struct device_node *np,
>>>                  return phy;
>>>          }
>>>
>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>>>          if (!link) {
>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>                          dev_name(phy->dev.parent));
>>> @@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct device
>>> *dev, struct device_node *np,
>>>          *ptr = phy;
>>>          devres_add(dev, ptr);
>>>
>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>>>          if (!link) {
>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>                          dev_name(phy->dev.parent));Parent
> 
> Can you check if this doesn't affect the suspend/resume ordering?

With this fix, suspend/resume ordering is broken on my side. What do you 
think to keep the STATELESS flag and to only display a warn if 
"device_link_add" returns an error ? It's not "smart" but it could 
solved our issue.

As a lot of improvements have been recently done on device link topic by 
Saravana, we could check with him what is the way to follow.

Regards
Alex

> 
> Thanks
> Kishon
> 

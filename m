Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8CC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CA12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vfsnzG50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBJMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:15:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43474 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:15:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01ACEsrX098789;
        Mon, 10 Feb 2020 06:14:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581336894;
        bh=SLpBExsKZLtK2SHmY9lMw5K33/QC+xtpwOOSBm+kc1I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vfsnzG50PyID/eSEXaNAjwpZk6RY2mHtR19qpsQxppBrTL5S0M5G5L/DcLYs2rah7
         v9wCswU+oLzVr8BfI30suD2f2+OiSRffhtL48F2uBkmwO1NJrbgskx2wvIrkKFOiNO
         yTUo8bRNk4UJmJJiWGGXVM7gCfWFPmlxgINzbFYA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01ACEsmo062021
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 06:14:54 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 06:14:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 06:14:54 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01ACEp0N103304;
        Mon, 10 Feb 2020 06:14:52 -0600
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        youling 257 <youling257@gmail.com>
CC:     <yoshihiro.shimoda.uh@renesas.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <saravanak@google.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com>
 <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
 <CAOzgRdb5QfJDQzbtoHQry4wxUg52LwX5XFCPzzaYa=z+RqNWOQ@mail.gmail.com>
 <8bd72269-16ae-b24a-7144-44d22d668dc6@ti.com>
 <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c2950949-6a9d-afe0-7c44-4378018b9d95@ti.com>
Date:   Mon, 10 Feb 2020 17:48:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/02/20 5:00 PM, Alexandre Torgue wrote:
> Hi Kishon,
> 
> On 2/10/20 9:08 AM, Kishon Vijay Abraham I wrote:
>> Hi Alexandre,
>>
>> On 07/02/20 12:27 PM, youling 257 wrote:
>>> test this diff, dwc3 work for my device, thanks.
>>>
>>> 2020-02-07 13:16 GMT+08:00, Kishon Vijay Abraham I <kishon@ti.com>:
>>>> Hi,
>>>>
>>>> On 06/02/20 7:09 PM, youling257 wrote:
>>>>> This patch cause "dwc3 dwc3.3.auto: failed to create device link to
>>>>> dwc3.3.auto.ulpi" problem.
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206435
>>>>
>>>> I'm suspecting there is some sort of reverse dependency with dwc3 ULPI.
>>>> Can you try the following diff?
>>>>
>>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>>> index 2eb28cc2d2dc..397311dcb116 100644
>>>> --- a/drivers/phy/phy-core.c
>>>> +++ b/drivers/phy/phy-core.c
>>>> @@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const char
>>>> *string)
>>>>
>>>>          get_device(&phy->dev);
>>>>
>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>> +       link = device_link_add(dev, &phy->dev,
>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>          if (!link) {
>>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>>                          dev_name(phy->dev.parent));
>>>> @@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
>>>> struct device_node *np,
>>>>                  return phy;
>>>>          }
>>>>
>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>> +       link = device_link_add(dev, &phy->dev,
>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>          if (!link) {
>>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>>                          dev_name(phy->dev.parent));
>>>> @@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct device
>>>> *dev, struct device_node *np,
>>>>          *ptr = phy;
>>>>          devres_add(dev, ptr);
>>>>
>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>> +       link = device_link_add(dev, &phy->dev,
>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>          if (!link) {
>>>>                  dev_err(dev, "failed to create device link to %s\n",
>>>>                          dev_name(phy->dev.parent));Parent
>>
>> Can you check if this doesn't affect the suspend/resume ordering?
> 
> With this fix, suspend/resume ordering is broken on my side. What do you
> think to keep the STATELESS flag and to only display a warn if
> "device_link_add" returns an error ? It's not "smart" but it could
> solved our issue.

yeah, that sounds reasonable for now. Can you find out the dependencies
between dwc3 and ulpi and what exactly breaks. That would help Saravana
to suggest a fix?
> 
> As a lot of improvements have been recently done on device link topic by
> Saravana, we could check with him what is the way to follow.
Thanks
Kishon

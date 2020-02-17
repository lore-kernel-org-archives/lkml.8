Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B1C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87EF2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OyMeDoX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgBQIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:37:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33526 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBQIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:37:04 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01H8asrf086875;
        Mon, 17 Feb 2020 02:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581928614;
        bh=sczcBOPrF75pBOiynxh2GFPAIgvpFvCIJSIuGMHORFM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OyMeDoX6Ur9CAp000kS0hyeT0nwuGQS1W8vRqm9nAzZLtAhR6zxCOOHqcjEEYNfOu
         qPvmCEU3itmf2Pas0++3W6W9MM6DY7QMExNljjHQWg4Jwi3IKqbRKe3k/je2cbUOrq
         SVTWStFXgO48daBabGBpVTaMMz5LH0e+50uvIVCw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01H8asxJ039993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Feb 2020 02:36:54 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 02:36:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 02:36:54 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01H8apvH016342;
        Mon, 17 Feb 2020 02:36:52 -0600
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     youling 257 <youling257@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, <saravanak@google.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com>
 <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
 <CAOzgRdb5QfJDQzbtoHQry4wxUg52LwX5XFCPzzaYa=z+RqNWOQ@mail.gmail.com>
 <8bd72269-16ae-b24a-7144-44d22d668dc6@ti.com>
 <1cd5885d-7db4-59b9-ef2d-e3556f60ca68@st.com>
 <CAHp75VcbPYNKfrnkuSfdN8t100kZFdq05hkbWxJKgRWJknRgxQ@mail.gmail.com>
 <3afc9783-813c-ab61-b4f4-e925a32df947@st.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <176af3ee-36ce-5ecd-0e9e-ff1c52ea3389@ti.com>
Date:   Mon, 17 Feb 2020 14:10:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3afc9783-813c-ab61-b4f4-e925a32df947@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/02/20 2:05 pm, Alexandre Torgue wrote:
> Hi,
> 
> On 2/14/20 7:46 PM, Andy Shevchenko wrote:
>> On Mon, Feb 10, 2020 at 1:32 PM Alexandre Torgue
>> <alexandre.torgue@st.com> wrote:
>>> On 2/10/20 9:08 AM, Kishon Vijay Abraham I wrote:
>>>> On 07/02/20 12:27 PM, youling 257 wrote:
>>>>> test this diff, dwc3 work for my device, thanks.
>>>>>
>>>>> 2020-02-07 13:16 GMT+08:00, Kishon Vijay Abraham I <kishon@ti.com>:
>>>>>> On 06/02/20 7:09 PM, youling257 wrote:
>>>>>>> This patch cause "dwc3 dwc3.3.auto: failed to create device link to
>>>>>>> dwc3.3.auto.ulpi" problem.
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206435
>>
>> +1 to the report.
>> Please revert for v5.6 or provide a fix ASAP!
>>
> 
> Kishon, do you plan to do the fix? If not, I'll send it quickly.

Please send a fix for it.

Thanks
Kishon

> 
> Thanks
> Alex
> 
>>>>>>
>>>>>> I'm suspecting there is some sort of reverse dependency with dwc3
>>>>>> ULPI.
>>>>>> Can you try the following diff?
>>>>>>
>>>>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>>>>> index 2eb28cc2d2dc..397311dcb116 100644
>>>>>> --- a/drivers/phy/phy-core.c
>>>>>> +++ b/drivers/phy/phy-core.c
>>>>>> @@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const
>>>>>> char
>>>>>> *string)
>>>>>>
>>>>>>           get_device(&phy->dev);
>>>>>>
>>>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>>>> +       link = device_link_add(dev, &phy->dev,
>>>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>>>           if (!link) {
>>>>>>                   dev_err(dev, "failed to create device link to
>>>>>> %s\n",
>>>>>>                           dev_name(phy->dev.parent));
>>>>>> @@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
>>>>>> struct device_node *np,
>>>>>>                   return phy;
>>>>>>           }
>>>>>>
>>>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>>>> +       link = device_link_add(dev, &phy->dev,
>>>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>>>           if (!link) {
>>>>>>                   dev_err(dev, "failed to create device link to
>>>>>> %s\n",
>>>>>>                           dev_name(phy->dev.parent));
>>>>>> @@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct
>>>>>> device
>>>>>> *dev, struct device_node *np,
>>>>>>           *ptr = phy;
>>>>>>           devres_add(dev, ptr);
>>>>>>
>>>>>> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
>>>>>> +       link = device_link_add(dev, &phy->dev,
>>>>>> DL_FLAG_SYNC_STATE_ONLY);
>>>>>>           if (!link) {
>>>>>>                   dev_err(dev, "failed to create device link to
>>>>>> %s\n",
>>>>>>                           dev_name(phy->dev.parent));Parent
>>>>
>>>> Can you check if this doesn't affect the suspend/resume ordering?
>>>
>>> With this fix, suspend/resume ordering is broken on my side. What do you
>>> think to keep the STATELESS flag and to only display a warn if
>>> "device_link_add" returns an error ? It's not "smart" but it could
>>> solved our issue.
>>>
>>> As a lot of improvements have been recently done on device link topic by
>>> Saravana, we could check with him what is the way to follow.
>>>
>>> Regards
>>> Alex
>>>
>>>>
>>>> Thanks
>>>> Kishon
>>>>
>>
>>
>>

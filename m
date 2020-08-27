Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C40C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0D022BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgH0IAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:00:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:18800 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0IAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:00:48 -0400
IronPort-SDR: 9RrsowQtcQBMiE1qlKFvKBSMYtx+dbV8dFdJNc7/US+x8MNZ4HVVWYjvYE49TkrS5LXDR4Cy9S
 SPnlVDGTcdCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153860693"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="153860693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 01:00:47 -0700
IronPort-SDR: vBlE8G0sFynYcM8sdc9gJbZvGMTIHnQtFOnPL2GGarlfPnhq6xrMi2y+aJQgtOxbF8vHCFc45P
 pPbFuQLdbMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="373647850"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2020 01:00:47 -0700
Received: from [10.249.76.175] (vramuthx-MOBL1.gar.corp.intel.com [10.249.76.175])
        by linux.intel.com (Postfix) with ESMTP id 27FAD5806C6;
        Thu, 27 Aug 2020 01:00:42 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v3 1/1] extcon: ptn5150: Set the VBUS and POLARITY
 property capability
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CGME20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb@epcas1p3.samsung.com>
 <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <e0ac8482-d607-6095-0d9b-2918f0e7a0f2@samsung.com>
 <47fef2ec-012c-03c7-13ef-0882b4f7146b@linux.intel.com>
 <b0e5e2e7-0ac6-4b0b-6d56-2766db28359d@samsung.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <6a151d0d-4d78-5310-265d-93eca2143e3e@linux.intel.com>
Date:   Thu, 27 Aug 2020 16:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b0e5e2e7-0ac6-4b0b-6d56-2766db28359d@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/8/2020 4:11 pm, Chanwoo Choi wrote:
> On 8/27/20 4:53 PM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>> On 27/8/2020 3:56 pm, Chanwoo Choi wrote:
>>> On 8/27/20 3:51 PM, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan<vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> Set the capability value of property for VBUS and POLARITY.
>>>>
>>>> Signed-off-by: Ramuthevar Vadivel Murugan<vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> ---
>>>>    drivers/extcon/extcon-ptn5150.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>>>> index 841c9fe211f1..20d49a54c36e 100644
>>>> --- a/drivers/extcon/extcon-ptn5150.c
>>>> +++ b/drivers/extcon/extcon-ptn5150.c
>>>> @@ -275,6 +275,13 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>>>            return ret;
>>>>        }
>>>>    +    extcon_set_property_capability(info->edev, EXTCON_USB,
>>>> +                       EXTCON_PROP_USB_VBUS);
>>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>>> +                       EXTCON_PROP_USB_VBUS);
>>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>>> +                       EXTCON_PROP_USB_TYPEC_POLARITY);
>>> Above codes used the space for the indentation to keep the vertical line.
>>> I think that we better to use tab for the indentation.
>>>
>>> If there are no objection, I'll fix and then apply it.
>> Thank you!, no objection , please fix it.
> Applied it. Thanks.
Thank you so much for applying.

Regards
Vadivel
> 

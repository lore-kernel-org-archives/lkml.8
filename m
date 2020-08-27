Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F8C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgH0GLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:11:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:40504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgH0GLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:11:32 -0400
IronPort-SDR: kQuZQJrbRqv70Kd/8W5YT9++n2pjAFTuY9DjsqO/Zi10BZKD8fye6yRdm3rzlY/ooM1R9TF5Js
 4vw08eXt0eYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="156432603"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="156432603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:11:31 -0700
IronPort-SDR: dF3te/9eMlBqrdSNu7nKwtGsgVljxjumlayN34tLdJUojd01NVusT20U0Y851NJkBfQ0UfRoTM
 iBA+LI3VK/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="500515776"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2020 23:11:30 -0700
Received: from [10.249.76.175] (vramuthx-MOBL1.gar.corp.intel.com [10.249.76.175])
        by linux.intel.com (Postfix) with ESMTP id 5338B58069F;
        Wed, 26 Aug 2020 23:11:28 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 2/2] extcon: ptn5150: Set the VBUS and POLARITY
 property state
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CGME20200827035651epcas1p33a045925293860a361a3be0cf21a2e2a@epcas1p3.samsung.com>
 <20200827035633.37348-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <b44d90d2-e91d-afd4-22c0-f64400ba9e11@samsung.com>
 <1e9360ee-22f6-2135-26c7-a5b25fe7776d@linux.intel.com>
 <55514836-b9cf-e937-b5d5-eb0535d98334@samsung.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <87f86b88-6698-343c-bdbd-75972db593a7@linux.intel.com>
Date:   Thu, 27 Aug 2020 14:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <55514836-b9cf-e937-b5d5-eb0535d98334@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/8/2020 1:35 pm, Chanwoo Choi wrote:
> Hi,
> 
> On 8/27/20 2:17 PM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>> On 27/8/2020 12:51 pm, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> You better to change the 'state' word to 'capability'.
>>> Actually, this patch doesn't change the value of property.
>>> It set the capability value of property.
>>>
>>> "Set the VBUS and POLARITY property capability"
>> Thank you for the review comments, sure will update.
>>>
>>> On 8/27/20 12:56 PM, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> Set the VBUS and POLARITY property state.
>>>
>>> ditto. Need to change the work from 'state' and 'capability'.
>> Noted.
>>>
>>>>
>>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> ---
>>>>    drivers/extcon/extcon-ptn5150.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>>>> index 8b930050a3f1..b5217a61615c 100644
>>>> --- a/drivers/extcon/extcon-ptn5150.c
>>>> +++ b/drivers/extcon/extcon-ptn5150.c
>>>> @@ -279,6 +279,12 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>>>            return ret;
>>>>        }
>>>>    +    extcon_set_property_capability(info->edev, EXTCON_USB,
>>>> +                       EXTCON_PROP_USB_VBUS);
>>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>>> +                       EXTCON_PROP_USB_VBUS);
>>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>>> +                       EXTCON_PROP_USB_TYPEC_POLARITY);
>>>
>>> Need to add blank line.
>> Noted.
>>>
>>> I understood that you set the property capability
>>> because of get_flipped() function of your patch[1].
>>>
>>> But, I think that you need to change the value of EXTCON_PROP_USB_TYPEC_POLARITY
>>> when changing the state of EXTCON_USB_HOST. The polarity property value is always
>>> zero regardless of EXTCON_USB_HOST state as following: The get_flipped()[1] returns
>>> always the same *flipped value.
>>>
>>>      EXTCON_USB_HOST is 1, EXTCON_PROP_USB_TYPEC_POLARITY is 0
>>>      EXTCON_USB_HOST is 0, EXTCON_PROP_USB_TYPEC_POLARITY is 0
>> by default EXTCON_PROP_USB_TYPEC_POLARITY is 1
> 
> If you don't touch the value of EXTCON_PROP_USB_TYPEC_POLARITY property,
> EXTCON_PROP_USB_TYPEC_POLARITY has default value (0).
Ok, thanks!
will update the patch, send it.

Regards
Vadivel
> 
>>>
>>> If EXTCON_PROP_USB_TYPEC_POLARITY value is not related to any behavior,
>>> you don't need to get the property value from extcon consumer driver
>>> like drivers/phy/phy-lgm-usb.c.
>>>
>>> Actually, I don't understand why you don't handle the value
>>> of EXTCON_PROP_USB_TYPEC_POLARITY.
>>>
>>> Or, are there any case of what drivers/phy/phy-lgm-usb.c
>>> uses the different extcon device with EXTCON_PROP_USB_TYPEC_POLARITY property
>>> in the future?
>> Yes, you're right, user connect the different USB cable then we check polarity, accordingly driver proceeds, thanks!
> 
> OK.
> 
>>>
>>> So, do you set the EXTCON_PROP_USB_TYPEC_POLARITY capability
>>> for the extensibility in order to use other extcon device on later?
>> yes, that might be the case as well.
> 
> OK.
> 
>>>
>>>
>>> [1] https://protect2.fireeye.com/v1/url?k=1fb29698-422c0d72-1fb31dd7-0cc47a6cba04-3009aa7184024984&q=1&e=566e4565-e7db-4a90-b036-fc28dbdb742f&u=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdevicetree%2Fmsg371828.html
>>> +static int get_flipped(struct tca_apb *ta, bool *flipped)
>>> +{
>>> +    union extcon_property_value property;
>>> +    int ret;
>>> +
>>> +    ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
>>> +                  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
>>> +    if (ret) {
>>> +        dev_err(ta->phy.dev, "no polarity property from extcon\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    *flipped = property.intval;
>>> +
>>> +    return ret;
>>> +}
>> Thank you for the gone through my usb-phy patch as well
>>
>> Regards
>> Vadivel
>>>
>>>
>>>>        /* Initialize PTN5150 device and print vendor id and version id */
>>>>        ret = ptn5150_init_dev_type(info);
>>>>        if (ret)
>>>>
>>>
>>>
>>
>>
> 
> 

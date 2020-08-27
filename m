Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5569F20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uD+4efF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0FXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:23:06 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54230 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgH0FXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:23:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200827052258epoutp01054ac7727bb2404cbff9ba947897c054~vCIlgzgls2563125631epoutp01U
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200827052258epoutp01054ac7727bb2404cbff9ba947897c054~vCIlgzgls2563125631epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598505778;
        bh=wW91TW50iLW8IcWcwKwnAsRn7VzFUazAP9nnNaurKJU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uD+4efF6H8BjPf1iLXG+7TPovhDvvcH3c7vg3117VLMI3uDNu6yBWaeLiHnQMVJ6h
         MZUZmtCiEcRuIPk8QJM+NmgDp2xAEd5CpFmeqsui69EfDBJf31Cn6GZ6rUIBf3kJ96
         +HG5KuKXYDKd7Qgi2CpxoLCIORaHD/9QjgeLwROE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200827052258epcas1p3babea90cc670d94f502faa4443f3fa6b~vCIlBQf0A1562415624epcas1p3M;
        Thu, 27 Aug 2020 05:22:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BcWMg51LyzMqYm1; Thu, 27 Aug
        2020 05:22:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.A2.28581.F23474F5; Thu, 27 Aug 2020 14:22:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200827052255epcas1p4329493a9e626c8b1f5a660694c344bfc~vCIiNtrnS1965019650epcas1p4F;
        Thu, 27 Aug 2020 05:22:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200827052255epsmtrp206194b2387efecc05a9ad4af771b8496~vCIiMlbhQ1674616746epsmtrp2y;
        Thu, 27 Aug 2020 05:22:55 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-2a-5f47432fae49
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.84.08303.F23474F5; Thu, 27 Aug 2020 14:22:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200827052254epsmtip21cd16d4ecbb1e70677087bdcea2cfca8~vCIhJdH_v1765817658epsmtip2r;
        Thu, 27 Aug 2020 05:22:53 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] extcon: ptn5150: Set the VBUS and POLARITY
 property state
To:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <55514836-b9cf-e937-b5d5-eb0535d98334@samsung.com>
Date:   Thu, 27 Aug 2020 14:35:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1e9360ee-22f6-2135-26c7-a5b25fe7776d@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmnq6+s3u8wdPF6hbX30ZYdK3eyWJx
        /vwGdovLu+awWdxuXMFm8aVjPZvFhmP32Sxe7p/OatHUdJzNgdNj56y77B6L97xk8ti0qpPN
        Y97JQI++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1ya
        l66XnJ9rZWhgYGQKVJiQnbHi5FWWgt+KFa9/PmFsYLwn08XIySEhYCJx5vtppi5GLg4hgR2M
        Ere3r2GEcD4xSjTcnMcCUiUk8JlR4t5iI5iOP/f2s0AU7WKUODLxCVTHe0aJrv6PYB3CAuES
        E1ZsYQOxRQT8JR6+vsYIYjMLbGeUeLS6HsRmE9CS2P/iBlgNv4CixNUfj8FqeAXsJO717weL
        swioSpyeepkVxBYVCJM4ua0FqkZQ4uTMJ2C7OAWcJV4d62KFmC8ucevJfCYIW16ieetsZpDj
        JATWckhc3dfBCvGCi8SB66eYIWxhiVfHt7BD2FISn9/tZYOwqyVWnjzCBtHcwSixZf8FqGZj
        if1LJwNt4ADaoCmxfpc+RFhRYufvuVBP8km8+9rDClIiIcAr0dEmBFGiLHH5wV0mCFtSYnF7
        J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAhPk2N7ECE6vWhY7GOe+/aB3iJGJ
        g/EQowQHs5IIr+BF53gh3pTEyqrUovz4otKc1OJDjKbAAJ7ILCWanA9M8Hkl8YamRsbGxhYm
        hmamhoZK4rwPbynECwmkJ5akZqemFqQWwfQxcXBKNTCFs955fdP6gZCjiOjDVTOtWBzvfW90
        SuIyb9MQPl/kvXbHnyWWDwRObNi8eLeF1PQ1E+Y4z/ped8iCj7nV8XPuhDObT214JnzAMPi0
        Qu+/r1b/tkms2HTiwqT3m9TqN66pLY2acKRh77SsM5c9zszdVXA8eoqlR0t4TEdHwfIjD+98
        lhAU3hB9I/3v9r+GHg5T7M7oWUsWd5yZM3Vi6aUXmQwhmy8kXfe6ccP7lDsX28zsIAZ35eTP
        AqG9ipErj798XPLA7v5V08LZGy6sDzz8+Xj6/W5F9pXr1K70Kx3/PXV1+vLPQteDoqw8TWW8
        n/TPqFDd8Yn31oKMZMEla2fWHZ0l7Pah5qjm/PciCvKy/kosxRmJhlrMRcWJAEkwlvc4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvK6+s3u8wYMHfBbX30ZYdK3eyWJx
        /vwGdovLu+awWdxuXMFm8aVjPZvFhmP32Sxe7p/OatHUdJzNgdNj56y77B6L97xk8ti0qpPN
        Y97JQI++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKWHHyKkvBb8WK1z+fMDYw3pPpYuTkkBAw
        kfhzbz9LFyMXh5DADkaJ2y9uskMkJCWmXTzK3MXIAWQLSxw+XAxR85ZR4v6Ov0wgNcIC4RIT
        VmxhA7FFBHwl1j+ezgxSxCywnVHi+PlrUFNvMkls2bQWbCqbgJbE/hc3wDr4BRQlrv54zAhi
        8wrYSdzr3w8WZxFQlTg99TIriC0qECaxc8ljJogaQYmTM5+wgNicAs4Sr451gdUwC6hL/Jl3
        iRnCFpe49WQ+E4QtL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1
        ihNzi0vz0vWS83M3MYJjTUtrB+OeVR/0DjEycTAeYpTgYFYS4RW86BwvxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPfrrIVxQgLpiSWp2ampBalFMFkmDk6pBqZNP1qTfHezZs73CdXOEfjsX3Co
        c+I/pu3+81dPPfe6dZaQtvBUl23eyQdeV0cd/HZ/r6/MCYM+W8aALyKWkZe7rmxVuaLxa8HJ
        Cz/2dLOvd9CLUxc16H+24qkTn3kzq3iTLsu/nZ1XZwZaxzpeUl57ZYkw28vsitxl5p/DfgWF
        LVedGL5++ye3SxpLQmcksTxJiu8Nrbw2pUujKLo6JmdP3fp/V2tOsNzm7lFas8NE/kHMAg2e
        s1ed1p0/mncq7RbDq7DMaw27w9uMFq2PUdhXsuScyVuDX9ZAzwY5sewIO9ZWH1AcERz6m3Gr
        xYLNt5lZXvz3imVpuv9lpiIX7763oU3WlieiEj24eIM+KbEUZyQaajEXFScCAMpNkp4kAwAA
X-CMS-MailID: 20200827052255epcas1p4329493a9e626c8b1f5a660694c344bfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200827035651epcas1p33a045925293860a361a3be0cf21a2e2a
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200827035651epcas1p33a045925293860a361a3be0cf21a2e2a@epcas1p3.samsung.com>
        <20200827035633.37348-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <b44d90d2-e91d-afd4-22c0-f64400ba9e11@samsung.com>
        <1e9360ee-22f6-2135-26c7-a5b25fe7776d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/27/20 2:17 PM, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 27/8/2020 12:51 pm, Chanwoo Choi wrote:
>> Hi,
>>
>> You better to change the 'state' word to 'capability'.
>> Actually, this patch doesn't change the value of property.
>> It set the capability value of property.
>>
>> "Set the VBUS and POLARITY property capability"
> Thank you for the review comments, sure will update.
>>
>> On 8/27/20 12:56 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>
>>> Set the VBUS and POLARITY property state.
>>
>> ditto. Need to change the work from 'state' and 'capability'.
> Noted.
>>
>>>
>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>> ---
>>>   drivers/extcon/extcon-ptn5150.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>>> index 8b930050a3f1..b5217a61615c 100644
>>> --- a/drivers/extcon/extcon-ptn5150.c
>>> +++ b/drivers/extcon/extcon-ptn5150.c
>>> @@ -279,6 +279,12 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>>           return ret;
>>>       }
>>>   +    extcon_set_property_capability(info->edev, EXTCON_USB,
>>> +                       EXTCON_PROP_USB_VBUS);
>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>> +                       EXTCON_PROP_USB_VBUS);
>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>> +                       EXTCON_PROP_USB_TYPEC_POLARITY);
>>
>> Need to add blank line.
> Noted.
>>
>> I understood that you set the property capability
>> because of get_flipped() function of your patch[1].
>>
>> But, I think that you need to change the value of EXTCON_PROP_USB_TYPEC_POLARITY
>> when changing the state of EXTCON_USB_HOST. The polarity property value is always
>> zero regardless of EXTCON_USB_HOST state as following: The get_flipped()[1] returns
>> always the same *flipped value.
>>
>>     EXTCON_USB_HOST is 1, EXTCON_PROP_USB_TYPEC_POLARITY is 0
>>     EXTCON_USB_HOST is 0, EXTCON_PROP_USB_TYPEC_POLARITY is 0
> by default EXTCON_PROP_USB_TYPEC_POLARITY is 1

If you don't touch the value of EXTCON_PROP_USB_TYPEC_POLARITY property,
EXTCON_PROP_USB_TYPEC_POLARITY has default value (0).

>>
>> If EXTCON_PROP_USB_TYPEC_POLARITY value is not related to any behavior,
>> you don't need to get the property value from extcon consumer driver
>> like drivers/phy/phy-lgm-usb.c.
>>
>> Actually, I don't understand why you don't handle the value
>> of EXTCON_PROP_USB_TYPEC_POLARITY.
>>
>> Or, are there any case of what drivers/phy/phy-lgm-usb.c
>> uses the different extcon device with EXTCON_PROP_USB_TYPEC_POLARITY property
>> in the future?
> Yes, you're right, user connect the different USB cable then we check polarity, accordingly driver proceeds, thanks!

OK.

>>
>> So, do you set the EXTCON_PROP_USB_TYPEC_POLARITY capability
>> for the extensibility in order to use other extcon device on later?
> yes, that might be the case as well.

OK.

>>
>>
>> [1] https://protect2.fireeye.com/v1/url?k=1fb29698-422c0d72-1fb31dd7-0cc47a6cba04-3009aa7184024984&q=1&e=566e4565-e7db-4a90-b036-fc28dbdb742f&u=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdevicetree%2Fmsg371828.html
>> +static int get_flipped(struct tca_apb *ta, bool *flipped)
>> +{
>> +    union extcon_property_value property;
>> +    int ret;
>> +
>> +    ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
>> +                  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
>> +    if (ret) {
>> +        dev_err(ta->phy.dev, "no polarity property from extcon\n");
>> +        return ret;
>> +    }
>> +
>> +    *flipped = property.intval;
>> +
>> +    return ret;
>> +}
> Thank you for the gone through my usb-phy patch as well
> 
> Regards
> Vadivel
>>
>>
>>>       /* Initialize PTN5150 device and print vendor id and version id */
>>>       ret = ptn5150_init_dev_type(info);
>>>       if (ret)
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

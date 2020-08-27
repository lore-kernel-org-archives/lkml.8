Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40626C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D1120825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lm1ITC9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgH0H7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:24 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43349 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgH0H7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:59:19 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200827075917epoutp0126dab66655722678bbc923295328c8a9~vERDwsof50467504675epoutp01Z
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:59:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200827075917epoutp0126dab66655722678bbc923295328c8a9~vERDwsof50467504675epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598515157;
        bh=XmQobl0I9SrP7Lo7crSQbDWM11M4lwMtuavjrwnEwx8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lm1ITC9JWIseXbxcrHAXPXgF0VoaKfTwrXMhkRXLkcsHfdj21UKPBvS0g4rwl258b
         aj/eEVREAVqP+tAAF61Sj8pUbrAvyrW9/ZbbZD+YJ8p6VYMFZEuUbKgIaYjYByZOJL
         WBgLmfyBwxs/9dneRkHdVC9xxv0PTC1UHeDFcLTE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200827075916epcas1p3142fe9029a8547e408324f1df60f8161~vERDEt0pg3045030450epcas1p3y;
        Thu, 27 Aug 2020 07:59:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BcZr10WVTzMqYm9; Thu, 27 Aug
        2020 07:59:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.F3.29173.AC7674F5; Thu, 27 Aug 2020 16:59:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200827075905epcas1p1d289cac765600d22fd1c328231b038c1~vEQ5GN3hm0863608636epcas1p1U;
        Thu, 27 Aug 2020 07:59:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200827075905epsmtrp13e94d11ddb2679a6dac5c61eed77c774~vEQ5FU0Ft0369603696epsmtrp10;
        Thu, 27 Aug 2020 07:59:05 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-1b-5f4767caabaf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.A9.08382.9C7674F5; Thu, 27 Aug 2020 16:59:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200827075905epsmtip15162cdec85194f81cae322912822ac78~vEQ40zql82713327133epsmtip14;
        Thu, 27 Aug 2020 07:59:05 +0000 (GMT)
Subject: Re: [PATCH v3 1/1] extcon: ptn5150: Set the VBUS and POLARITY
 property capability
To:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b0e5e2e7-0ac6-4b0b-6d56-2766db28359d@samsung.com>
Date:   Thu, 27 Aug 2020 17:11:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <47fef2ec-012c-03c7-13ef-0882b4f7146b@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmvu6pdPd4g7fPlSyuv42w6Fq9k8Xi
        /PkN7BaXd81hs7jduILN4kvHejaLDcfus1m83D+d1aKp6TibA6fHzll32T0W73nJ5LFpVSeb
        x7yTgR59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQN0k5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0
        L10vOT/XytDAwMgUqDAhO+P4yn72gjt8FccbXzA3MO7n6WLk5JAQMJHobmli6mLk4hAS2MEo
        0bBqEzuE84lR4u6GBcwQzjdGidnPFzPDtKz8vI4RxBYS2MsosWddDETRe0aJzc3XgGZxcAgL
        xEh8XCAHUiMi4C/x8PU1sHpmge2MEo9W14PYbAJaEvtf3GADsfkFFCWu/njMCNLKK2An8eZd
        BUiYRUBVYuOiD+wgtqhAmMTJbS1gY3gFBCVOznzCAmJzCjhL/Dr8jh1ivLjErSfzmSBseYnm
        rbPB7pcQ2MIhMXHnR1aI+10k+m/cYoGwhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHcwSixZf8F
        qGZjif1LJ4P9yCygKbF+lz5EWFFi5++5UD/ySbz72sMKUiIhwCvR0SYEUaIscfnBXSYIW1Ji
        cXsn2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCY+S43sQITq1a5jsYp739oHeI
        kYmD8RCjBAezkgiv4EXneCHelMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD0zueSXxhqZGxsbG
        FiaGZqaGhkrivA9vKcQLCaQnlqRmp6YWpBbB9DFxcEo1MO19ZLdRqfKc4BaXTI2nhmc2rTzy
        uEqk6vZvpRWP7ja6vz43x2kPu8K/xAaZEhkXgTbh8M71z8Q8jicW95Ud/zJz+Y49/5ZpHOTq
        SU3vCnfMVjrQo5izIvej7AWRoOf+b65VSuyT+zpXYONLmeWlL1IaJqz2a/X12B+16MeDzt+h
        5asbr5+7FBh9RsR92v3ZqZulCvzny+RMzggW4Jli3/Nv17EIXY5H4cL8lXM3nGPv/R7r+c5M
        +FXgou7ko2bCQUzv//ytm/3t5wvBBodbv87YPxDrXvVfj+EWm9bV5/yrtrvGnJt9hUv9zpK5
        eqys+c3bsx2vx79L+/6cl627z4rZsnKmX31pZJ3i0WvfypVYijMSDbWYi4oTAf9u78M2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvdkunu8wc31KhbX30ZYdK3eyWJx
        /vwGdovLu+awWdxuXMFm8aVjPZvFhmP32Sxe7p/OatHUdJzNgdNj56y77B6L97xk8ti0qpPN
        Y97JQI++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKOL6yn73gDl/F8cYXzA2M+3m6GDk5JARM
        JFZ+XsfYxcjFISSwm1Hi/c6LLBAJSYlpF48ydzFyANnCEocPF0PUvGWUuNJ1lx0kLiwQI/Fx
        gRxIuYiAr8T6x9OZQWqYBbYzShw/f40FouEmk8SNjzPBhrIJaEnsf3GDDcTmF1CUuPrjMSPI
        IF4BO4k37ypAwiwCqhIbF31gB7FFBcIkdi55zARi8woISpyc+QRsDKeAs8Svw+/AapgF1CX+
        zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp
        5XrFibnFpXnpesn5uZsYwXGmpbmDcfuqD3qHGJk4GA8xSnAwK4nwCl50jhfiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomDU6qB6ShX+orz+mmrjCzzl88/+VUv
        1kj8Cs9psSXOCW01aacW7a32SFj6zO2rvO/M5HDj2ttzDE7PaNzJF7Yp4uVDpW1bf6RLbnC/
        cY9lnkcuw41NeXeFWhe7aWuIRZ20Ff1y/Y1mz8Hi3LtViocPb78l3CjwbDUPp8LPy1Lch18k
        WPiI5ZgpVtwSPfLE/wDzc8/Z28pjtbfvq7fOvsiXEfT96AvxvyyeFgZ1x3UmVFs80F9+UilF
        hJdbNSHlbdZ0u9Xvu15/CH/nmb/oafiaTZFTdXb/yU6S2qXQ6H66b82m9OqYMK7tD7+Vyk+e
        /Wnl9u37ouTZV/dz5l2+3lnwcu39iZ+mvH7y1dSLO74i/m6jpBJLcUaioRZzUXEiALFc/esi
        AwAA
X-CMS-MailID: 20200827075905epcas1p1d289cac765600d22fd1c328231b038c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb
References: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb@epcas1p3.samsung.com>
        <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
        <e0ac8482-d607-6095-0d9b-2918f0e7a0f2@samsung.com>
        <47fef2ec-012c-03c7-13ef-0882b4f7146b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/27/20 4:53 PM, Ramuthevar, Vadivel MuruganX wrote:
> Hi,
> 
> On 27/8/2020 3:56 pm, Chanwoo Choi wrote:
>> On 8/27/20 3:51 PM, Ramuthevar,Vadivel MuruganX wrote:
>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>
>>> Set the capability value of property for VBUS and POLARITY.
>>>
>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>> ---
>>>   drivers/extcon/extcon-ptn5150.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>>> index 841c9fe211f1..20d49a54c36e 100644
>>> --- a/drivers/extcon/extcon-ptn5150.c
>>> +++ b/drivers/extcon/extcon-ptn5150.c
>>> @@ -275,6 +275,13 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>>>           return ret;
>>>       }
>>>   +    extcon_set_property_capability(info->edev, EXTCON_USB,
>>> +                       EXTCON_PROP_USB_VBUS);
>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>> +                       EXTCON_PROP_USB_VBUS);
>>> +    extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
>>> +                       EXTCON_PROP_USB_TYPEC_POLARITY);
>>
>> Above codes used the space for the indentation to keep the vertical line.
>> I think that we better to use tab for the indentation.
>>
>> If there are no objection, I'll fix and then apply it.
> Thank you!, no objection , please fix it.

Applied it. Thanks.

> 
> Regards
> Vadivel
>>
>>> +
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

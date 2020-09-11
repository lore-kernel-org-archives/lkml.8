Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A7EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7AE21D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rrjye7Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgIKHvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:51:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10247 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgIKHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:50:59 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200911075055epoutp049683f62ef616b916832a50544794ebd2~zq1C33gTD0353203532epoutp04_
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:50:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200911075055epoutp049683f62ef616b916832a50544794ebd2~zq1C33gTD0353203532epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599810655;
        bh=WUsdxYtCe0WXkND3wDSkH/X/sNvA8pPyFV9pZO+Sfoo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rrjye7LnflyGZA8LXl3X7tHnsnJXPR49wy39G0XOTAbUlmUx0eFvb+hzksccttdZF
         ME1lMcq9ZDC/Hwpasugpf9djuvng+9D3XwJrjALst6l7UVYLy8mS6Mr0vOvrEtIG4C
         Wzu9Tv1bU9dxH1uEveWS5veEOI2s54fsQDhj2JQA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200911075055epcas1p449b0ad57c968b1bd411109e8826cfcc0~zq1CnHcRY1487614876epcas1p4C;
        Fri, 11 Sep 2020 07:50:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BnnxT5fwZzMqYks; Fri, 11 Sep
        2020 07:50:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.9B.28581.85C2B5F5; Fri, 11 Sep 2020 16:50:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200911075047epcas1p1e529af0730dcb50520e568450a2718a5~zq062uGys0890708907epcas1p12;
        Fri, 11 Sep 2020 07:50:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200911075047epsmtrp1f9e0df52c936ef9f679a3cfebb2213ed~zq062Khmi2034320343epsmtrp1Q;
        Fri, 11 Sep 2020 07:50:47 +0000 (GMT)
X-AuditID: b6c32a38-2e3ff70000006fa5-cd-5f5b2c5893ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.22.08382.75C2B5F5; Fri, 11 Sep 2020 16:50:47 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200911075046epsmtip11b721a92573176a482b8f0ecc6b0752e~zq06pr88x1626816268epsmtip1_;
        Fri, 11 Sep 2020 07:50:46 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: ptn5150: Use defines for registers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6e621023-530a-727c-fff7-e8435ca4a4d2@samsung.com>
Date:   Fri, 11 Sep 2020 17:03:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200911053805.GA2954@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTXzdCJzreoPGhgMX58xvYLS7vmsNm
        cbtxBZvFy/3TWR1YPHbOusvusWlVJ5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2Tmpdsq
        eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhkaGBiZAhUmZGcs2tHOVtAiWLFxVhdjA+M8vi5G
        Tg4JAROJ99P/MXYxcnEICexglDhy8DYzhPOJUeJm/zZ2COcbo8Sqc/PZYVqmrJ4HldjLKLHx
        5TKolvdALScOMoNUCQs4S1xpn8YEYosIaEpc//udFcRmFqiVOHKsESzOJqAlsf/FDTYQm19A
        UeLqj8eMIDavgJ3El873LCA2i4CqxKv/c8DqRQXCJE5ua4GqEZQ4OfMJWA2ngJ7EwZWb2SDm
        i0vcejKfCcKWl9j+dg7YcRICf9klun7PBDqbA8hxkVg+XxDiG2GJV8e3QH0mJfGyvw3KrpZY
        efIIG0RvB6PElv0XWCESxhL7l05mApnDDPTY+l36EGFFiZ2/5zJC7OWTePe1hxViFa9ER5sQ
        RImyxOUHd5kgbEmJxe2dbBMYlWYh+WYWkg9mIflgFsKyBYwsqxjFUguKc9NTiw0LTJBjexMj
        ODlqWexgnPv2g94hRiYOxkOMEhzMSiK8SfmR8UK8KYmVValF+fFFpTmpxYcYTYHhO5FZSjQ5
        H5ie80riDU2NjI2NLUwMzUwNDZXEeR/eUogXEkhPLEnNTk0tSC2C6WPi4JRqYDJSnLz03TqN
        MsPKcs4/Cu+tc6Yacd91jXnxPPbqggLWJrM/L+f/aMty0Xo3R+CX6F+2qi0TKr/OS3NQ7+v7
        n8ea9nj3jTWyTGFCvxdYWNe9y5jwtGKmUMf5iRu+G5fptcTNbVl5+GvY17DElS1Fli98r7qI
        26fWGSx+fnnSkTNamuHNs57M2+DU4fdQMzv65M1qwQUe67q/X13f1t94/ZDiHOZdH/kWvF3E
        x3Hp7fmDpzVF5rhwaOX0a/97H9jCpL1UfEffVv3Xv7X72Xw3GvBKLc76/nzXJZPZQrMd5RxX
        Bc3aN688lPvg+k/zrjxfsWOLw/ztHTozN/rKvhVvKZP7l6RfG3Ky73GO5IHoqsdKLMUZiYZa
        zEXFiQCOqEmzFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG64TnS8Qcdfdovz5zewW1zeNYfN
        4nbjCjaLl/unszqweOycdZfdY9OqTjaPvi2rGD0+b5ILYInisklJzcksSy3St0vgyli0o52t
        oEWwYuOsLsYGxnl8XYycHBICJhJTVs9j72Lk4hAS2M0oMWnzBiaIhKTEtItHmbsYOYBsYYnD
        h4shat4ySmw+9IcdpEZYwFniSvs0sHoRAU2J63+/s4LYzAL1Ei1fX0INfcgo8ezPXrAGNgEt
        if0vbrCB2PwCihJXfzxmBLF5BewkvnS+ZwGxWQRUJV79nwM2VFQgTGLnksdMEDWCEidnPgGr
        4RTQkzi4cjMbxDJ1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sq
        RsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgONHS3MG4fdUHvUOMTByMhxglOJiVRHiT
        8iPjhXhTEiurUovy44tKc1KLDzFKc7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCUamBSPT69
        JFvru6HZzGyrdW39wksa9jVNfmpwcHpDtggfxz9vm9UTP6W1FGy+mlKiG6YiHbAkxfXHkadf
        tyT13IsXWDSzt275arGt/dtlgtJSDP/WBFd1T+Q9XHH6f3mq7mqrCzO2T7td3HPw7OvJAb3P
        LE/aNC1sXCA5e+eh6Ze0LeefqLo4z55vLutPfwHRfUfOp0uc3rJg3b49a9foWSxKbH49XSM5
        eh7367cXWHuvepmZ/xHcdO5rUMeBqUvW/44/Lnbd5O4540u7xDYmsnH58rywFV8d9VVlq1pS
        qpPg6rp7DtONz2SdKv1TYNlgynvpE0+UYAWn3Sal95OYmYSnJcx0F4k027jV9v6ug3sjlViK
        MxINtZiLihMBCTLEwAIDAAA=
X-CMS-MailID: 20200911075047epcas1p1e529af0730dcb50520e568450a2718a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9
References: <CGME20200909172007epcas1p2fe01380c62ca112a19283f2dc63e75f9@epcas1p2.samsung.com>
        <20200909150129.12476-1-krzk@kernel.org>
        <7571e535-f0ff-2371-1669-734c3996aacf@samsung.com>
        <20200911053805.GA2954@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 2:38 PM, Krzysztof Kozlowski wrote:
> On Fri, Sep 11, 2020 at 12:14:19PM +0900, Chanwoo Choi wrote:
>> On 9/10/20 12:01 AM, Krzysztof Kozlowski wrote:
>>> The register addresses are not continuous, so use simple defines for
>>> them.  This also makes it easier to find the address for register.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>  drivers/extcon/extcon-ptn5150.c | 22 ++++++++++------------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
>>> index dda5b3a3a908..1b68f56d8372 100644
>>> --- a/drivers/extcon/extcon-ptn5150.c
>>> +++ b/drivers/extcon/extcon-ptn5150.c
>>> @@ -19,18 +19,16 @@
>>>  #include <linux/gpio/consumer.h>
>>>  
>>>  /* PTN5150 registers */
>>> -enum ptn5150_reg {
>>> -	PTN5150_REG_DEVICE_ID = 0x01,
>>> -	PTN5150_REG_CONTROL,
>>> -	PTN5150_REG_INT_STATUS,
>>> -	PTN5150_REG_CC_STATUS,
>>> -	PTN5150_REG_CON_DET = 0x09,
>>> -	PTN5150_REG_VCONN_STATUS,
>>> -	PTN5150_REG_RESET,
>>> -	PTN5150_REG_INT_MASK = 0x18,
>>> -	PTN5150_REG_INT_REG_STATUS,
>>> -	PTN5150_REG_END,
>>> -};
>>> +#define PTN5150_REG_DEVICE_ID			0x01
>>> +#define PTN5150_REG_CONTROL			0x02
>>> +#define PTN5150_REG_INT_STATUS			0x03
>>> +#define PTN5150_REG_CC_STATUS			0x04
>>> +#define PTN5150_REG_CON_DET			0x09
>>> +#define PTN5150_REG_VCONN_STATUS		0x0a
>>> +#define PTN5150_REG_RESET			0x0b
>>> +#define PTN5150_REG_INT_MASK			0x18
>>> +#define PTN5150_REG_INT_REG_STATUS		0x19
>>> +#define PTN5150_REG_END				PTN5150_REG_INT_REG_STATUS
>>
>> PTN5150_REG_END should be (PTN5150_REG_INT_REG_STATUS + 1)
>> for regmap operation of PTN5150_REG_INT_REG_STATUS.
> 
> Why? This goes to regmap's max_register which is the last register
> allowed to read:
> 
>   drivers/base/regmap/regmap-debugfs.c:   for (i = 0; i <= map->max_register; i += map->reg_stride) {
>   drivers/base/regmap/regmap.c:   if (map->max_register && reg > map->max_register)

It is my mismake. You're right.
Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

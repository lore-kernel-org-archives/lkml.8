Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F76BC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADB120838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XeObzXx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGDdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:33:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63561 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgEGDd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:33:28 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200507033324epoutp04599b35b0aaaf1b19c2da385a3bf59fae~MoY8Qzdxf1505115051epoutp04h
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 03:33:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200507033324epoutp04599b35b0aaaf1b19c2da385a3bf59fae~MoY8Qzdxf1505115051epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588822404;
        bh=NtEhd+1dje5QiiDef26OgK5fEvWiYEZBE2ExI1aWxPU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XeObzXx7gmiro21+Z2+S1nf0VK1kOELlfJSZyxHWclwF5ABQQYLg9C7BjmzwvpoUm
         3BYCTq4ljX3BEVs89jg3RmvXxNpf3RXMYmPnZgD0NKEgsYngyonKZ2uyR7dcUG628z
         yjUDEYlV1wFcWKr2ogrXddsda5mOU1q+zWfvF2h0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200507033323epcas1p1f4fdf33a585f7169c4bc6d5ac36db351~MoY717QTV3096730967epcas1p1n;
        Thu,  7 May 2020 03:33:23 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49HfDw6KBVzMqYkr; Thu,  7 May
        2020 03:33:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.5D.04658.08183BE5; Thu,  7 May 2020 12:33:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200507033320epcas1p2b520b5a5547110ad5877d011d47136cf~MoY4fc2gN2074520745epcas1p2m;
        Thu,  7 May 2020 03:33:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200507033320epsmtrp18522351d5a6129f034ba30a001132a9a~MoY4efl0T1638016380epsmtrp1x;
        Thu,  7 May 2020 03:33:20 +0000 (GMT)
X-AuditID: b6c32a39-a99ff70000001232-e7-5eb38180819a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.33.18461.08183BE5; Thu,  7 May 2020 12:33:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200507033320epsmtip1489171e2f59805d8d87024e5f1510c1c~MoY4PC97g1701617016epsmtip1K;
        Thu,  7 May 2020 03:33:20 +0000 (GMT)
Subject: Re: [PATCH v2 2/7] extcon: arizona: Move binding over to dtschema
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc:     myungjoo.ham@samsung.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4ee56044-22f2-04f8-445b-b431b7053bc7@samsung.com>
Date:   Thu, 7 May 2020 12:43:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200506155758.14643-2-ckeepax@opensource.cirrus.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUgTYRzHeXbb7ZRW10z9tcL0WkSWulNnZ2gUSq0XQujljwLtcNcU99Zu
        hhXkRvkWNouycBja62oF5TTTyKxliX8UkTVFszelMtBeRCuKatst8r/v77nP977P957nCEx+
        G1cQhUYrZzGyegoPF7feX5KYYLM356rO2FOZ2jcjOPOszIOYhq7HEubV5APETD2rFDEnfrlE
        TO+tepwZtF/CmYlPnRKmrKNLuipc0+4ckmo87ipc88J3G9ecqv+DNI4WN9JMeGJy8O1FGQUc
        q+UssZwx36QtNOoyqQ2b87Ly1GkqOoFOZ5ZTsUbWwGVS2RtzEtYU6v1bo2L3sPpi/1IOy/NU
        0soMi6nYysUWmHhrJsWZtXpzujmRZw18sVGXmG8yrKBVqmS1H9xZVDB84yFmrllb4nJcwW2o
        bvlhFEYAmQo9Ryqkh1E4ISfbEFw/WS0Shq8Ihu99xoVhCoHb1or/szyfuoiEBx0IvCeuhiyf
        ENwYa0QBKoJcDz/6fEH7HLIawccvjySBASMdCMYbD4oCFE7GQ+eH/uB7Z5Fx8Pz7cNAtI1fC
        uS9eLKDFpBLeTbYH+UhyG/S0Hgoxs6GnbkQc0GFkFgx+exPkMTIaBkYaRIJeADfH6rFAMJB3
        CRhzvZcIJbKho7wtVCgCPna3SAWtgNGa8pDeD5d7unDBXImgpfNJyJwCnReO+xMIf8ISuHYr
        SViOg/afp5EQPBPGJ6slAQRIGVSWywVkIfS+HhIJei6cq6jCjyLKOa2Oc1oF57QKzv9hjUjs
        RlGcmTfoOJ42q6cfuAcFb258eht6+HijF5EEombI7l705Mol7B5+r8GLgMCoObIZ35ty5TIt
        u3cfZzHlWYr1HO9Fav/XPoYpIvNN/v/AaM2j1ckpKSlMKp2mpmkqWlbbp8+VkzrWyhVxnJmz
        /POJiDCFDc0vWRa1qbnUoTzwIyqpP7p0dOqOtm53c8nrdu0u4pfywZaDtdLPTFpHVrLqQu9L
        96KSshjDOl3Fjgz5vH2TozbfU1/34vihqK2Yy3d94uTxbw2r7a51dOvAuL3Jh4t2mZ3ns1EN
        NV56xbp2qUJZml1uUDrilIm/z8akdr2t2vGVEvMFLB2PWXj2L/c4wi7PAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG5D4+Y4gxf3eS2mPnzCZnGldROj
        xfwj51gt7n89ymjx7UoHk8WUP8uZLC7vmsNmcbtxBZvF5/f7WS1a9x5hd+Dy2DnrLrvHplWd
        bB53ru1h85g+5z+jR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGU83nqMuaDfvWJ532q2BsaZ
        5l2MnBwSAiYSV78tY+xi5OIQEtjNKHF/53R2iISkxLSLR5m7GDmAbGGJw4eLIWreMkpcOnGP
        FaRGWMBL4uf1a2wgCRGBHkaJj4+/MoE4zAJ9jBInj01kBKkSEjjPKPF7TQaIzSagJbH/xQ02
        EJtfQFHi6o/HYDW8AnYSiz8eYgaxWQRUJJ593ckEYosKhEnsXPKYCaJGUOLkzCcsIDangLPE
        7e8PweqZBdQl/sy7BGWLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNPS3MH4/ZVH/QOMTJxMB5ilOBgVhLh5fmxMU6I
        NyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUwWSYOTqkGJoGkE6lPc+LC
        6nrcwuIr5bPaC6ZLLdx1V63gF8eR9wdPm0x36hEVO/vnTLFo2Oy0s41/1Cz671y6kXmr89ZO
        39d1a75Gh7NcnbfewkMsQivzaWqVeue9FwsfOz9n+Gm+eZKHGKfRNt4yxS+/73hZLMwSPbut
        z1+g+rXo1aTXkm57v756mrO6+NabsPLvTcGbD3gJTzzf0543N1ch4npFp11QvmZt84LL3IES
        qzaov535WaJ13w+uJhXBhCsT9co1I3RzXWo05qi8X3enJLb+6MYpFZOf3TlvrlgesqGE/xpT
        db+E9q9HW1bVvrng8dw9TuoR59ar/D/Y2Y/WpE9Y9mKl2PILB09MnP6oP1ctVImlOCPRUIu5
        qDgRAMxwH28rAwAA
X-CMS-MailID: 20200507033320epcas1p2b520b5a5547110ad5877d011d47136cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506155807epcas1p4a0b11d00d258c5daa7ef05372811347a
References: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
        <CGME20200506155807epcas1p4a0b11d00d258c5daa7ef05372811347a@epcas1p4.samsung.com>
        <20200506155758.14643-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 5/7/20 12:57 AM, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Removed some description that duplicates constraints
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 -------------
>  .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 +++++++++++++++++++++
>  2 files changed, 125 insertions(+), 76 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> deleted file mode 100644
> index 208daaff0be4f..0000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> +++ /dev/null
> @@ -1,76 +0,0 @@
> -Cirrus Logic Arizona class audio SoCs
> -
> -These devices are audio SoCs with extensive digital capabilities and a range
> -of analogue I/O.
> -
> -This document lists Extcon specific bindings, see the primary binding document:
> -  ../mfd/arizona.txt
> -
> -Optional properties:
> -
> -  - wlf,hpdet-channel : Headphone detection channel.
> -    ARIZONA_ACCDET_MODE_HPL or 1 - Headphone detect mode is set to HPDETL
> -    ARIZONA_ACCDET_MODE_HPR or 2 - Headphone detect mode is set to HPDETR
> -    If this node is not mentioned or if the value is unknown, then
> -    headphone detection mode is set to HPDETL.
> -
> -  - wlf,use-jd2 : Use the additional JD input along with JD1 for dual pin jack
> -    detection.
> -  - wlf,use-jd2-nopull : Internal pull on JD2 is disabled when used for
> -    jack detection.
> -  - wlf,jd-invert : Invert the polarity of the jack detection switch
> -
> -  - wlf,micd-software-compare : Use a software comparison to determine mic
> -    presence
> -  - wlf,micd-detect-debounce : Additional software microphone detection
> -    debounce specified in milliseconds.
> -  - wlf,micd-pol-gpio : GPIO specifier for the GPIO controlling the headset
> -    polarity if one exists.
> -  - wlf,micd-bias-start-time : Time allowed for MICBIAS to startup prior to
> -    performing microphone detection, specified as per the ARIZONA_MICD_TIME_XXX
> -    defines.
> -  - wlf,micd-rate : Delay between successive microphone detection measurements,
> -    specified as per the ARIZONA_MICD_TIME_XXX defines.
> -  - wlf,micd-dbtime : Microphone detection hardware debounces specified as the
> -    number of measurements to take, valid values being 2 and 4.
> -  - wlf,micd-timeout-ms : Timeout for microphone detection, specified in
> -    milliseconds.
> -  - wlf,micd-force-micbias : Force MICBIAS continuously on during microphone
> -    detection.
> -  - wlf,micd-configs : Headset polarity configurations (generally used for
> -    detection of CTIA / OMTP headsets), the field can be of variable length
> -    but should always be a multiple of 3 cells long, each three cell group
> -    represents one polarity configuration.
> -    The first cell defines the accessory detection pin, zero will use MICDET1
> -    and all other values will use MICDET2.
> -    The second cell represents the MICBIAS to be used.
> -    The third cell represents the value of the micd-pol-gpio pin.
> -
> -  - wlf,gpsw : Settings for the general purpose switch, set as one of the
> -    ARIZONA_GPSW_XXX defines.
> -
> -Example:
> -
> -codec: wm8280@0 {
> -	compatible = "wlf,wm8280";
> -	reg = <0>;
> -	...
> -
> -	wlf,use-jd2;
> -	wlf,use-jd2-nopull;
> -	wlf,jd-invert;
> -
> -	wlf,micd-software-compare;
> -	wlf,micd-detect-debounce = <0>;
> -	wlf,micd-pol-gpio = <&codec 2 0>;
> -	wlf,micd-rate = <ARIZONA_MICD_TIME_8MS>;
> -	wlf,micd-dbtime = <4>;
> -	wlf,micd-timeout-ms = <100>;
> -	wlf,micd-force-micbias;
> -	wlf,micd-configs = <
> -		0 1 0 /* MICDET1 MICBIAS1 GPIO=low */
> -		1 2 1 /* MICDET2 MICBIAS2 GPIO=high */
> -	>;
> -
> -	wlf,gpsw = <ARIZONA_GPSW_OPEN>;
> -};
> diff --git a/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> new file mode 100644
> index 0000000000000..f9845dc2f5ae5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/url?k=696fcddc-34bc96c8-696e4693-0cc47a31ce4e-2a3e86cfac9f17c2&q=1&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fextcon%2Fwlf%2Carizona.yaml%23
> +$schema: https://protect2.fireeye.com/url?k=afda1ee7-f20945f3-afdb95a8-0cc47a31ce4e-9f3472c530744134&q=1&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  These devices are audio SoCs with extensive digital capabilities and a
> +  range of analogue I/O.
> +
> +  This document lists Extcon specific bindings, see the primary binding
> +  document ../mfd/arizona.yaml
> +
> +properties:
> +  wlf,hpdet-channel:
> +    description:
> +      Headphone detection channel.  ARIZONA_ACCDET_MODE_HPL/1 sets the
> +      headphone detect mode to HPDETL, ARIZONA_ACCDET_MODE_HPR/2 sets it
> +      to HPDETR.  If this node is not included or if the value is unknown,
> +      then headphone detection mode is set to HPDETL.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 2
> +
> +  wlf,use-jd2:
> +    description:
> +      Use the additional JD input along with JD1 for dual pin jack detection.
> +    type: boolean
> +
> +  wlf,use-jd2-nopull:
> +    description:
> +      Internal pull on JD2 is disabled when used for jack detection.
> +    type: boolean
> +
> +  wlf,jd-invert:
> +    description:
> +      Invert the polarity of the jack detection switch.
> +    type: boolean
> +
> +  wlf,micd-software-compare:
> +    description:
> +      Use a software comparison to determine mic presence.
> +    type: boolean
> +
> +  wlf,micd-detect-debounce:
> +    description:
> +      Additional software microphone detection debounce specified in
> +      milliseconds.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  wlf,micd-pol-gpio:
> +    description:
> +      GPIO specifier for the GPIO controlling the headset polarity if one
> +      exists.
> +    maxItems: 1
> +
> +  wlf,micd-bias-start-time:
> +    description:
> +      Time allowed for MICBIAS to startup prior to performing microphone
> +      detection, specified as per the ARIZONA_MICD_TIME_XXX defines.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 12
> +
> +  wlf,micd-rate:
> +    description:
> +      Delay between successive microphone detection measurements, specified
> +      as per the ARIZONA_MICD_TIME_XXX defines.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 12
> +
> +  wlf,micd-dbtime:
> +    description:
> +      Microphone detection hardware debounces specified as the number of
> +      measurements to take.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    enum: [2, 4]
> +
> +  wlf,micd-timeout-ms:
> +    description:
> +      Timeout for microphone detection, specified in milliseconds.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  wlf,micd-force-micbias:
> +    description:
> +      Force MICBIAS continuously on during microphone detection.
> +    type: boolean
> +
> +  wlf,micd-configs:
> +    description:
> +      Headset polarity configurations (generally used for detection of
> +      CTIA / OMTP headsets), the field can be of variable length but
> +      should always be a multiple of 3 cells long, each three cell group
> +      represents one polarity configuration.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> +    items:
> +      items:
> +        - description:
> +            The first cell defines the accessory detection pin, zero
> +            will use MICDET1 and 0x2000 will use MICDET2.
> +          enum: [ 0, 0x2000 ]
> +        - description:
> +            The second cell represents the MICBIAS to be used. Zero
> +            will use MICVDD, 1-3 will use MICBIASx.
> +          minimum: 0
> +          maximum: 3
> +        - description:
> +            The third cell represents the value of the micd-pol-gpio
> +            pin.
> +          minimum: 0
> +          maximum: 1
> +
> +  wlf,gpsw:
> +    description:
> +      Settings for the general purpose switch, set as one of the
> +      ARIZONA_GPSW_XXX defines.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 0
> +    maximum: 3
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

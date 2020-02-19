Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DBAC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1712D24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ku9wJU1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSEM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:12:28 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26922 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgBSEM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:12:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200219041226epoutp032f286aece9ccbd23c3039e68be9007d7~0smwIO1tR2283722837epoutp03-
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 04:12:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200219041226epoutp032f286aece9ccbd23c3039e68be9007d7~0smwIO1tR2283722837epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582085546;
        bh=U7n0nDovjPinNAeOyhnhsgkmcdAERmhQLFW+c5IPtKw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ku9wJU1vUT1UB41DWH3aEoMIaVuww1b5NdZqywl0Khp/NIyfmqdmlwwGx7pZTKlI0
         ThuLDOt89R9WfFTo/7Uh1Fsx+YqXlnrsc7+990pJTdtmhagul8BGSLUwUA1A5/GHHu
         Iqu74V39WG1kIBm67LtyyTVgUScvxbt9JdmoayZA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200219041225epcas1p1a019ed5ae1d0702fc382cc0b6678f96c~0smvr6Q2q1974819748epcas1p1p;
        Wed, 19 Feb 2020 04:12:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48Mkny0c8CzMqYkg; Wed, 19 Feb
        2020 04:12:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.52.52419.5A5BC4E5; Wed, 19 Feb 2020 13:12:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200219041221epcas1p3f6cd8e4cb03a8e657ff2794f7aa74b05~0smrlMlXT1364313643epcas1p3E;
        Wed, 19 Feb 2020 04:12:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200219041221epsmtrp242cfbccb464c6585ead7c9388bb0984f~0smrkYMct2045520455epsmtrp2U;
        Wed, 19 Feb 2020 04:12:21 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-3b-5e4cb5a59d1c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.BC.06569.5A5BC4E5; Wed, 19 Feb 2020 13:12:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200219041220epsmtip29266020989df658f8b38ee2a0630480b~0smrP29Wu1146511465epsmtip2i;
        Wed, 19 Feb 2020 04:12:20 +0000 (GMT)
Subject: Re: [PATCH v4] dt-bindings: extcon: usbc-cros-ec: convert
 extcon-usbc-cros-ec.txt to yaml format
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <20e80940-ee5e-0593-a231-ee64c85c3212@samsung.com>
Date:   Wed, 19 Feb 2020 13:20:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJvCmwfA7tnyv05McZi+Gh=u8G9Kc2mb-VKbON9TPhKgQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVAMcRjH/W73dq/Gsc5LjwxqZUyN6vbOaRkZRHOj/shEM94uO91OpXtz
        exkvfzgz6UUhw3i5kCGpJM2plJmcEko0mpBKhnFD3jJDDCMvt21G/32e5/k+b78XBaZqJwIV
        6RYHb7dwJprwx+tuhUaEl9bGG9Rv3Yg97u3C2baqDzj7sOwpxha3dMjZyr5mxDZUD5HsvXel
        GHsvf5Bkr3YUyNmu66cI9kJ3p4zt21tGsPsaW8hlSn3lmUqkL3J24vr6/hKkb3D1k3p3RR6h
        P1hTgfRf3LMSyA0ZS9J4zsjbg3hLitWYbkmNpuMSk2OSdQvVTDiziI2igyycmY+mV8YnhMem
        m3zj0kHbOVOmz5XACQIduXSJ3Zrp4IPSrIIjmuZtRpNtkS1C4MxCpiU1IsVqXsyo1RqdT7gl
        I+3569W2FvWO9yXznShr3n7kpwBqAXh63ITIKqoegbd07X7k7+PPCPqeDBCS8Q3Bq8JW2b+M
        nOH7MinQiODOn0pcMj4hKHl5aKTWZCoDDrQ+HuEpVAhUv+nFRMaoXxg0/QkRmaDCwDPwdEQz
        kQqGx99fIZGV1FK43d0vFxmn5oK3uJ0UeSqVBG11WaOaSdB20ouL7EetgYt9Q7hUPwB6vcUy
        iWfDtY+nMHE4oKpIGMp5MrrCSvBcKkIST4Z3d2tIiQPhy2AjIfFuKG9rIaTkXAQ1nodyKaAF
        z4UjvkIKX4dQuHI9UnIHQ8PP00hqPAEGvxbIRQlQSsjNVkmSOdD1on90hOlwPiePKES0a8w6
        rjEruMas4Prf7CzCK9A03iaYU3mBsWnH3rUbjTzksKh6VN0R34woBaLHK292xhlUcm67sNPc
        jECB0VOUcQGrDSqlkdu5i7dbk+2ZJl5oRjrfaR/GAqemWH3fwuJIZnQarVbLLmAW6hiGDlC+
        XB9qUFGpnIPP4Hkbb/+XJ1P4BToRjYItMfF1vaeb9pRXFZQdzl7hvDnu7OtHtTOZpHqdPVEz
        29VKt2/EN2evOBYddXTDcNaEzcfzi9XbNN7fsUnrXHX7mg4W9ByLgxin/+UbhvUnn3V7TvRU
        vclBRcbdw1dWdb5ot+XGbt1U63d04G75jPxzWZrlpsIZD37kPXdFLjORNC6kcUwYZhe4v/8M
        WbneAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSvO7SrT5xBm+buC2mP7nMYnFy3RsW
        iwsrbjBbzD9yjtVize1DjBY7N3xhtzj1ahmzxanud+wWm8/1sFpc3jWHzWLp9YtMFrcbV7BZ
        tO49wu7A67Fm3hpGj9kNF1k8dtxdwuixc9Zddo9NqzrZPPq2rGL0+LxJLoA9issmJTUnsyy1
        SN8ugSvj3jOvgiMGFa+X6DQwtqh3MXJySAiYSLT/OcPUxcjFISSwm1FiwaVf7BAJSYlpF48y
        dzFyANnCEocPF0PUvGWUWP3tATNIjbBAtkTviatsILaIgIrEhue3mEGKmAX+M0vcffCfFaJj
        MpPE9gXdYFPZBLQk9r+4AdbBL6AocfXHY0YQm1fATuLo9busIDaLgKrEk/mnwepFBcIkdi55
        zARRIyhxcuYTFhCbUyBQYvntL2A2s4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoPAtJ+ywk
        LbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwdGpp7WA8cSL+EKMA
        B6MSD++Bi95xQqyJZcWVuYcYJTiYlUR4vcW94oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucf
        ixQSSE8sSc1OTS1ILYLJMnFwSjUwlkzd9kLX/lSpwAOfOZeE/Ptd3xkY5O+99vbp5VX6JTcq
        zbjYFUIvGs6x3NKUK/eOse/grMwEpxrtBQuj/j84GrB/loJD09PiKr9Pbqtdz95Wb8/6c9Iw
        +b3dS5Obb3LneXDe42iW8N2sYx025fzUEI7pK/89nM/jGtl8rOX2z8jAbUtvTbD7qcRSnJFo
        qMVcVJwIABz+LmvKAgAA
X-CMS-MailID: 20200219041221epcas1p3f6cd8e4cb03a8e657ff2794f7aa74b05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200213123953epcas1p45c39830a9ec6bd535f5370702f603806
References: <CGME20200213123953epcas1p45c39830a9ec6bd535f5370702f603806@epcas1p4.samsung.com>
        <20200213123934.10841-1-dafna.hirschfeld@collabora.com>
        <a1bc262f-d8af-9590-105b-1db0b16f2861@samsung.com>
        <CAL_JsqJvCmwfA7tnyv05McZi+Gh=u8G9Kc2mb-VKbON9TPhKgQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 11:20 AM, Rob Herring wrote:
> On Mon, Feb 17, 2020 at 4:30 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> On 2/13/20 9:39 PM, Dafna Hirschfeld wrote:
>>> convert the binding file extcon-usbc-cros-ec.txt to
>>> yaml format extcon-usbc-cros-ec.yaml
>>>
>>> This was tested and verified on ARM with:
>>> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>>
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>> Changes since v1:
>>> 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
>>> 2 - changing the maintainers
>>> 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
>>>
>>> Changes since v2:
>>> 1 - Changing the patch subject to start with "dt-bindings: extcon: usbc-cros-ec:"
>>> 2 - In the example, adding a parent isp node, a reg field to cros-ec@0
>>> and adding nodes 'extcon0/1' instead of one node 'extcon'.
>>>
>>> Changes since v3:
>>> in the example, changing the node isp1 to spi0
>>>
>>>  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 --------
>>>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 56 +++++++++++++++++++
>>>  2 files changed, 56 insertions(+), 24 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>> deleted file mode 100644
>>> index 8e8625c00dfa..000000000000
>>> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>> +++ /dev/null
>>> @@ -1,24 +0,0 @@
>>> -ChromeOS EC USB Type-C cable and accessories detection
>>> -
>>> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>>> -able to detect the state of external accessories such as display adapters
>>> -or USB devices when said accessories are attached or detached.
>>> -
>>> -The node for this device must be under a cros-ec node like google,cros-ec-spi
>>> -or google,cros-ec-i2c.
>>> -
>>> -Required properties:
>>> -- compatible:                Should be "google,extcon-usbc-cros-ec".
>>> -- google,usb-port-id:        Specifies the USB port ID to use.
>>> -
>>> -Example:
>>> -     cros-ec@0 {
>>> -             compatible = "google,cros-ec-i2c";
>>> -
>>> -             ...
>>> -
>>> -             extcon {
>>> -                     compatible = "google,extcon-usbc-cros-ec";
>>> -                     google,usb-port-id = <0>;
>>> -             };
>>> -     }
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>> new file mode 100644
>>> index 000000000000..9c5849b341ea
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>> @@ -0,0 +1,56 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: https://protect2.fireeye.com/url?k=d3c63a24-8e5dc647-d3c7b16b-0cc47a31cdbc-e8d8e2b7806aed8e&u=http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
>>> +$schema: https://protect2.fireeye.com/url?k=04f78247-596c7e24-04f60908-0cc47a31cdbc-1b9a3937c161a4b6&u=http://devicetree.org/meta-schemas/core.yaml#
> 
> ^^^
> 
>>> +
>>> +title: ChromeOS EC USB Type-C cable and accessories detection
>>> +
>>> +maintainers:
>>> +  - Benson Leung <bleung@chromium.org>
>>> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> +
>>> +description: |
>>> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>>> +  able to detect the state of external accessories such as display adapters
>>> +  or USB devices when said accessories are attached or detached.
>>> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
>>> +  or google,cros-ec-i2c.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: google,extcon-usbc-cros-ec
>>> +
>>> +  google,usb-port-id:
>>> +    allOf:
>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: the port id
>>> +    minimum: 0
>>> +    maximum: 255
>>> +
>>> +required:
>>> +  - compatible
>>> +  - google,usb-port-id
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    spi0 {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        cros-ec@0 {
>>> +            compatible = "google,cros-ec-spi";
>>> +            reg = <0>;
>>> +
>>> +            usbc_extcon0: extcon0 {
>>> +                compatible = "google,extcon-usbc-cros-ec";
>>> +                google,usb-port-id = <0>;
>>> +            };
>>> +
>>> +            usbc_extcon1: extcon1 {
>>> +                compatible = "google,extcon-usbc-cros-ec";
>>> +                google,usb-port-id = <1>;
>>> +            };
>>> +        };
>>> +    };
>>>
>>
>> Applied it. Thanks.
> 
> And once again corrupted it when applying it:
> 
> Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dts'
> failed
> Traceback (most recent call last):
>   File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py",
> line 774, in resolve_from_url
>   document = self.store[url]
>   File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py",
> line 22, in __getitem__
>   return self.store[self.normalize(uri)]
> KeyError: 'https://protect2.fireeye.com/url?k=04f78247-596c7e24-04f60908-0cc47a31cdbc-1b9a3937c161a4b6&u=http://devicetree.org/meta-schemas/core.yaml'
> 
> 

I'm sorry for that. It was added by company
firewall system automatically when I applied it to git.
It was my mistake. I'll edit them and pushed again.

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

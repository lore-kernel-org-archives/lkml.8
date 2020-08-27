Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB24C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DAC20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PgBJtOkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH0C2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:28:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52755 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgH0C2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:28:35 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200827022831epoutp03185452077e12a4975e403bb86311e945~u-wQyyIM_0368703687epoutp03b
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:28:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200827022831epoutp03185452077e12a4975e403bb86311e945~u-wQyyIM_0368703687epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598495311;
        bh=tF5CHx4B3XirKe14xx1d/NKmRq9HTyCy5EuCdxYmztU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PgBJtOkngu71/VlAuegKpHiROddnZfvzhpdtLdMVwWFupCX5IPp+qb8Lh5xPLjw8d
         NwsQkIuMP0F6/WnsPq8sSG8Gc8I8XRF+KAiK2vZhGiTlM0V+0ABKreAho+wN7W81Om
         Sm8rTmmphMQZxqlW3Yy7joUb/zNhOR73AjNpdA18=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200827022830epcas1p26edc344bdfff041ff932de4cf4ca95c4~u-wQVOTg81469714697epcas1p2Q;
        Thu, 27 Aug 2020 02:28:30 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BcRVM3lyhzMqYkk; Thu, 27 Aug
        2020 02:28:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.9C.28578.94A174F5; Thu, 27 Aug 2020 11:28:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200827022824epcas1p4a9b5ea07d560df2f9e730e3c495d1ec4~u-wKktrX11181411814epcas1p4V;
        Thu, 27 Aug 2020 02:28:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200827022824epsmtrp17f8436540301cf05b786b88afad59c6d~u-wKj-9l72541725417epsmtrp1p;
        Thu, 27 Aug 2020 02:28:24 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-59-5f471a492839
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.03.08382.84A174F5; Thu, 27 Aug 2020 11:28:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200827022824epsmtip2f3dac4c44625021afb3c6100e1eb934d~u-wKVYtZc1050810508epsmtip2e;
        Thu, 27 Aug 2020 02:28:24 +0000 (GMT)
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Suman Anna <s-anna@ti.com>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     "Menon, Nishanth" <nm@ti.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4eb235ff-2b1a-2ff3-9da0-e650e24e65b1@samsung.com>
Date:   Thu, 27 Aug 2020 11:40:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <065f3979-f8c3-9233-4411-6f34f605a05a@ti.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmnq6nlHu8wYodyhbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLN48+Msk0Xr3iPsFnt/7WO12HDsPpvFy/3TWR04PXbOusvusWlVJ5vHvJOB
        Hn1bVjF6HL+xncnj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZCy+cYiyYolgx//pq1gbGS9JdjJwcEgImEns397B3MXJxCAns
        YJTYNP0sC4TziVHiRHMPG4TzjVFif99KNpiWA8uWs0Ik9jJK3DrQD9X/nlHi3IlWdpAqYQFX
        iWPf/oElRAQ2Mkksv/OVBSTBLKAoMfv+fzCbTUBLYv+LG2Bj+YHiV388ZgSxeQXsJPrO/GIC
        sVkEVCXu9L4Bi4sKhEmc3NYCVSMocXLmE7A5nAJWEhOfLmKHmC8ucevJfCYIW16ieetsZpAj
        JAS2cEgsvLCXHeIHF4lLd++zQtjCEq+Ob4GKS0m87G+DsqslVp48wgbR3MEosWX/BagGY4n9
        SycDbeAA2qApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2T
        bQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJ8b2IEJ1ktyx2M099+0DvEyMTB
        eIhRgoNZSYRX8KJzvBBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OB6b5vJJ4Q1MjY2NjCxND
        M1NDQyVx3oe3FOKFBNITS1KzU1MLUotg+pg4OKUamPpTHG72aVstfCjx2b+Ud6qZxmFOlgrR
        y94J2/4brA4Rbn1x50mIRnbi0Wef+5hZxdf6VrsquNU9ZWN1mmhvd6jhweG+hjQdpy9MgQWt
        Z48uVeB/yPJMNUrSleOKy0Hup5kVWXOY7ZUuGxi8O3f8lcC5zQJLpi1axndzwwmDs387BS0f
        ulxkrz/xwot7/84Nb78+Zd/TrKShdbF8w8FGMb50sSk+3wRVO2+//sa57XiMusu3Xedsvr/e
        dsY/0/p50L5tOzOc7PtVFqx+1eA8VU70ebFa19wZ7/0aDs2KfNvuc8s3yf+RxMQrcUrSRyKl
        pC7p+HZU3Huw91BrlqLhgxRmu5TkxOdN/7e32PguVGIpzkg01GIuKk4EABegULw7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvK6HlHu8wdNZMhbzj5xjtTh/fgO7
        xeVdc9gsbjeuYLN48+Msk0Xr3iPsFnt/7WO12HDsPpvFy/3TWR04PXbOusvusWlVJ5vHvJOB
        Hn1bVjF6HL+xncnj8ya5ALYoLpuU1JzMstQifbsEroyFF04xFkxRrJh/fTVrA+Ml6S5GTg4J
        AROJA8uWs4LYQgK7GSVOLUmBiEtKTLt4lLmLkQPIFpY4fLgYouQto8TTM0UgtrCAq8Sxb//Y
        uxi5OEQENjJJ7Dz7mBkkwSygKDH7/n8WkISQwFImiZ4zD9hBEmwCWhL7X9xgA7H5gYqu/njM
        CGLzCthJ9J35xQRiswioStzpfQMWFxUIk9i55DETRI2gxMmZT1hAbE4BK4mJTxexQyxTl/gz
        7xLUYnGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vc
        rzgxt7g0L10vOT93EyM40rQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7Bi87xQrwpiZVVqUX58UWl
        OanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTC1/mvxnxPWKcm8otNPvPd/PIv2
        zGnuGjdesS9YfSr1/C+DPc9PiG1pOF/0ukJvX/ebL3MWv9JnDuU0PyoQOmOx4XuG6ElT2nft
        3BSxi+edyZ6uRTIZpuXzZV+zBfY52yb9brh8T9InNWej+zTVt1Vf+NMe/wrdXvBozrn8PTtE
        JhxjzlZdPbVQvt1iW0Fc14+bOvv+LIk/tkLlbQn3irI3W5dx3vjYmK+9dTZHhMHsSwVBWY17
        sxwy/hVeWjbb4tRzVX9u46slt28u5l6p0fds/fad9dfb7/2U1Zso+vZty4tk/rf8lZdDDwl1
        681Rqdz0qs7xwfJz12YFVbmfOSYVEPUwvVe7ct7i9QHP7juvUWIpzkg01GIuKk4EAGgyeB0j
        AwAA
X-CMS-MailID: 20200827022824epcas1p4a9b5ea07d560df2f9e730e3c495d1ec4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200824103713epcas1p4ae0d5d821fd468163ec5948dd59d0d15
References: <20200817070009.4631-1-krzk@kernel.org>
        <CGME20200824103713epcas1p4ae0d5d821fd468163ec5948dd59d0d15@epcas1p4.samsung.com>
        <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
        <b6ec12af-5573-ce86-9f6b-16fcbc36b1a3@samsung.com>
        <065f3979-f8c3-9233-4411-6f34f605a05a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On 8/27/20 6:56 AM, Suman Anna wrote:
> Hi Chanwoo,
> 
> On 8/24/20 6:28 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 8/24/20 7:36 PM, Ramuthevar, Vadivel MuruganX wrote:
>>> Hi,
>>>
>>>  Thank you for the patches and optimized the code as well.
>>>  I have applied your patches and tested, it's working fine
>>>  with few minor changes as per Intel's LGM board.
>>
>> Thanks for the test.
>>
>>>
>>>  can I send the patches along with patches or we need to wait until
>>>  your patch get merge?
>>>
>>>  Please suggest to me go further, Thanks!
>>
>> I applied these patches. You better to send your patches
>> based on extcon-next. Thanks.
> 
> I am not sure what happened, but the $id and $schema got morphed in the patch
> on linux-next, 000ce2ad3c96 ("dt-bindings: extcon: ptn5150: Convert binding to
> DT schema"), when compared to Krzysztof's original patch.

It is my fault because of the company's firewall.
I updated and pushed it. Thanks.

> 
> This is causing dtbs_check to fail in general on linux-next,
>   UPD     include/config/kernel.release
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> Traceback (most recent call last):
>   File
> "/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
> 774, in resolve_from_url
>     document = self.store[url]
>   File "/home/suman/.local/lib/python3.6/site-packages/jsonschema/_utils.py",
> line 22, in __getitem__
>     return self.store[self.normalize(uri)]
> KeyError:
> 'https://protect2.fireeye.com/url?k=59835ffc-05905d01-59822c67-0cc47a336902-306bd2691e458c36&q=1&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23'
> 
> During handling of the above exception, another exception occurred:
> 
> Traceback (most recent call last):
>   File
> "/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
> 777, in resolve_from_url
>     document = self.resolve_remote(url)
>   File
> "/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
> 860, in resolve_remote
>     result = requests.get(uri).json()
>   File "/usr/lib/python3/dist-packages/requests/models.py", line 892, in json
>     return complexjson.loads(self.text, **kwargs)
>   File "/usr/lib/python3/dist-packages/simplejson/__init__.py", line 518, in loads
>     return _default_decoder.decode(s)
>   File "/usr/lib/python3/dist-packages/simplejson/decoder.py", line 370, in decode
>     obj, end = self.raw_decode(s)
>   File "/usr/lib/python3/dist-packages/simplejson/decoder.py", line 400, in
> raw_decode
>     return self.scan_once(s, idx=_w(s, idx).end())
> simplejson.errors.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
> 
> During handling of the above exception, another exception occurred:
> 
> Traceback (most recent call last):
>   File "/home/suman/.local/bin/dt-doc-validate", line 67, in <module>
>     ret = check_doc(f)
>   File "/home/suman/.local/bin/dt-doc-validate", line 33, in check_doc
>     for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree),
> key=lambda e: e.linecol):
>   File "/home/suman/.local/lib/python3.6/site-packages/dtschema/lib.py", line
> 663, in iter_schema_errors
>     meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
>   File
> "/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
> 779, in resolve_from_url
>     raise exceptions.RefResolutionError(exc)
> jsonschema.exceptions.RefResolutionError: Expecting value: line 1 column 1 (char 0)
> Documentation/devicetree/bindings/Makefile:52: recipe for target
> 'Documentation/devicetree/bindings/processed-schema-examples.json' failed
> make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.json]
> Error 123
> Makefile:1366: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> regards
> Suman
> 
>>
>>>
>>> On 17/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
>>>> Hi,
>>>>
>>>> Changes since v1:
>>>> 1. Mutex unlock fix in patch 8/13.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>>
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

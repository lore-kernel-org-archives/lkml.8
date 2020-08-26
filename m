Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D57C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C251207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y1O0o25r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZV4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:56:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52204 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:56:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07QLu8uo042177;
        Wed, 26 Aug 2020 16:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598478968;
        bh=dQZ0Q9XvUZXYwld+PELH7Qf4PN7CZlITbMVyyKwxzbU=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Y1O0o25rMSxs3MC9UHRZc6aNRYBYb8johsSyqxN6O5Zej9Ot9XFzSl4W2PKKZeaJB
         GTRBQofnFFdejVqmQPNSf6bxuKqlCLLzEJnyAnP+OlTSoe3unt/+E+SavkZ4SPUGIX
         TPpgabyvpxC35ayYehxOKcaZqewv89SjMjVvksbo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07QLu85b005105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 16:56:08 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 26
 Aug 2020 16:56:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 26 Aug 2020 16:56:08 -0500
Received: from [10.250.32.245] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07QLu7Pj129319;
        Wed, 26 Aug 2020 16:56:07 -0500
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
 <CGME20200824103713epcas1p4ae0d5d821fd468163ec5948dd59d0d15@epcas1p4.samsung.com>
 <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
 <b6ec12af-5573-ce86-9f6b-16fcbc36b1a3@samsung.com>
CC:     "Menon, Nishanth" <nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <065f3979-f8c3-9233-4411-6f34f605a05a@ti.com>
Date:   Wed, 26 Aug 2020 16:56:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b6ec12af-5573-ce86-9f6b-16fcbc36b1a3@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 8/24/20 6:28 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 8/24/20 7:36 PM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi,
>>
>>  Thank you for the patches and optimized the code as well.
>>  I have applied your patches and tested, it's working fine
>>  with few minor changes as per Intel's LGM board.
> 
> Thanks for the test.
> 
>>
>>  can I send the patches along with patches or we need to wait until
>>  your patch get merge?
>>
>>  Please suggest to me go further, Thanks!
> 
> I applied these patches. You better to send your patches
> based on extcon-next. Thanks.

I am not sure what happened, but the $id and $schema got morphed in the patch
on linux-next, 000ce2ad3c96 ("dt-bindings: extcon: ptn5150: Convert binding to
DT schema"), when compared to Krzysztof's original patch.

This is causing dtbs_check to fail in general on linux-next,
  UPD     include/config/kernel.release
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
Traceback (most recent call last):
  File
"/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
774, in resolve_from_url
    document = self.store[url]
  File "/home/suman/.local/lib/python3.6/site-packages/jsonschema/_utils.py",
line 22, in __getitem__
    return self.store[self.normalize(uri)]
KeyError:
'https://protect2.fireeye.com/url?k=59835ffc-05905d01-59822c67-0cc47a336902-306bd2691e458c36&q=1&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File
"/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
777, in resolve_from_url
    document = self.resolve_remote(url)
  File
"/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
860, in resolve_remote
    result = requests.get(uri).json()
  File "/usr/lib/python3/dist-packages/requests/models.py", line 892, in json
    return complexjson.loads(self.text, **kwargs)
  File "/usr/lib/python3/dist-packages/simplejson/__init__.py", line 518, in loads
    return _default_decoder.decode(s)
  File "/usr/lib/python3/dist-packages/simplejson/decoder.py", line 370, in decode
    obj, end = self.raw_decode(s)
  File "/usr/lib/python3/dist-packages/simplejson/decoder.py", line 400, in
raw_decode
    return self.scan_once(s, idx=_w(s, idx).end())
simplejson.errors.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/suman/.local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/home/suman/.local/bin/dt-doc-validate", line 33, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree),
key=lambda e: e.linecol):
  File "/home/suman/.local/lib/python3.6/site-packages/dtschema/lib.py", line
663, in iter_schema_errors
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
  File
"/home/suman/.local/lib/python3.6/site-packages/jsonschema/validators.py", line
779, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: Expecting value: line 1 column 1 (char 0)
Documentation/devicetree/bindings/Makefile:52: recipe for target
'Documentation/devicetree/bindings/processed-schema-examples.json' failed
make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.json]
Error 123
Makefile:1366: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

regards
Suman

> 
>>
>> On 17/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changes since v1:
>>> 1. Mutex unlock fix in patch 8/13.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>>
> 
> 


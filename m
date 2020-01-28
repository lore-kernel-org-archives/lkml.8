Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF43C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E2C24687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BJ150Xf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA1QuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:50:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21360 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgA1Qt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:49:59 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SGlDtY023385;
        Tue, 28 Jan 2020 17:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=CIHFy0mpXNHWYOHODkLgaAdMxCyVoBTuoV1E4uG8N4s=;
 b=BJ150Xf73hbnN0bLEEf+2Tp+7lOBzGmIVeJRu4sx9uRKodntTP0B8dXoWCQ09pGsRtXX
 aPCLIE7SIeIlQMTPryODHZrE5AN8GdshrcWtZ7J6cm4dDRYsNKYo24gQ4blIPAhbxMPC
 KNjN8nDWfUjxXKXffDzHNlDp767Ex6s0X7dDsdjyjwcC7Be77Yx/SIHITl/IGZtzehtz
 HkXBc9drImE8Ex0wpMgoROWJRhKXKHkucx1xPCJXmdphrbG4d2P2fJeG5iy5bgWlK9Yg
 vD01uh4AAlkPjCAjm8NXstDxHqU5rAXhdmPqkE7X+/q3DNQ1/0Cz4+ORrWR4hTU4GvlD wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxxwuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 17:49:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6916100038;
        Tue, 28 Jan 2020 17:49:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9FF0721CA94;
        Tue, 28 Jan 2020 17:49:35 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jan
 2020 17:49:35 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Tue, 28 Jan 2020 17:49:35 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Maxime Ripard <maxime@cerno.tech>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Thread-Topic: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Thread-Index: AQHV1bPFvwodev/kWkOXWkWfzChdiaf/6nAAgAAHB4CAAEgqAA==
Date:   Tue, 28 Jan 2020 16:49:35 +0000
Message-ID: <7acf71bb-092d-14f4-8208-6d906a993211@st.com>
References: <20200128082013.15951-1-benjamin.gaignard@st.com>
 <20200128120600.oagnindklixjyieo@gilmour.lan>
 <a7fa1b43-a188-9d06-73ec-16bcd4012207@st.com>
In-Reply-To: <a7fa1b43-a188-9d06-73ec-16bcd4012207@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <85CDDBF742537543A477C23D8CA2A1C8@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_05:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,


On 1/28/20 1:31 PM, Benjamin GAIGNARD wrote:
>=20
> On 1/28/20 1:06 PM, Maxime Ripard wrote:
>> Hi Benjamin,
>>
>> On Tue, Jan 28, 2020 at 09:20:13AM +0100, Benjamin Gaignard wrote:
>>> Convert etnaviv bindings to yaml format.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> ---
>>>    .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
>>>    .../devicetree/bindings/gpu/vivante,gc.yaml        | 72 ++++++++++++=
++++++++++
>>>    2 files changed, 72 insertions(+), 36 deletions(-)
>>>    delete mode 100644 Documentation/devicetree/bindings/display/etnaviv=
/etnaviv-drm.txt
>>>    create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.=
yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-=
drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
>>> deleted file mode 100644
>>> index 8def11b16a24..000000000000
>>> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
>>> +++ /dev/null
>>> @@ -1,36 +0,0 @@
>>> -Vivante GPU core devices
>>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> -
>>> -Required properties:
>>> -- compatible: Should be "vivante,gc"
>>> -  A more specific compatible is not needed, as the cores contain chip
>>> -  identification registers at fixed locations, which provide all the
>>> -  necessary information to the driver.
>>> -- reg: should be register base and length as documented in the
>>> -  datasheet
>>> -- interrupts: Should contain the cores interrupt line
>>> -- clocks: should contain one clock for entry in clock-names
>>> -  see Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> -- clock-names:
>>> -   - "bus":    AXI/master interface clock
>>> -   - "reg":    AHB/slave interface clock
>>> -               (only required if GPU can gate slave interface independ=
ently)
>>> -   - "core":   GPU core clock
>>> -   - "shader": Shader clock (only required if GPU has feature PIPE_3D)
>>> -
>>> -Optional properties:
>>> -- power-domains: a power domain consumer specifier according to
>>> -  Documentation/devicetree/bindings/power/power_domain.txt
>>> -
>>> -example:
>>> -
>>> -gpu_3d: gpu@130000 {
>>> -	compatible =3D "vivante,gc";
>>> -	reg =3D <0x00130000 0x4000>;
>>> -	interrupts =3D <0 9 IRQ_TYPE_LEVEL_HIGH>;
>>> -	clocks =3D <&clks IMX6QDL_CLK_GPU3D_AXI>,
>>> -	         <&clks IMX6QDL_CLK_GPU3D_CORE>,
>>> -	         <&clks IMX6QDL_CLK_GPU3D_SHADER>;
>>> -	clock-names =3D "bus", "core", "shader";
>>> -	power-domains =3D <&gpc 1>;
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Do=
cumentation/devicetree/bindings/gpu/vivante,gc.yaml
>>> new file mode 100644
>>> index 000000000000..c4f549c0d750
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
>>> @@ -0,0 +1,72 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/gpu/vivante,gc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Vivante GPU Bindings
>>> +
>>> +description: Vivante GPU core devices
>>> +
>>> +maintainers:
>>> +  -  Lucas Stach <l.stach@pengutronix.de>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: vivante,gc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: AXI/master interface clock
>>> +      - description: GPU core clock
>>> +      - description: Shader clock (only required if GPU has feature PI=
PE_3D)
>>> +      - description: AHB/slave interface clock (only required if GPU c=
an gate slave interface independently)
>> Can you have an AHB slave interface clock without a shader clock?
>=20
> No because the items in the list are ordered so you need to have, in
> order: "bus", "core", "shader", "reg"
>=20
> If it is needed to allow any number of clock in any order I could write
> it like this:
>=20
> clocks:
>=20
>   =A0 minItems: 1
>=20
>   =A0 maxItems: 4
>=20
> clock-names:
>=20
>   =A0 items:
>=20
>   =A0=A0=A0 enum: [ bus, core, shader, reg]
>=20
>   =A0 minItems: 1
>=20
>   =A0 maxItems: 4
>=20
> Benjamin


Thank you for your patch,

I confirm that your last proposal with enum would be better.

With that,
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>

Philippe :-)


>=20
>>
>>> +    minItems: 2
>>> +    maxItems: 4
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: bus
>>> +      - const: core
>>> +      - const: shader
>>> +      - const: reg
>>> +    minItems: 2
>>> +    maxItems: 4
>> If so, that check will fail, since it would expect a clock named
>> shader on the 3rd item.
>>
>> It looks good otherwise, thanks!
>> Maxime=

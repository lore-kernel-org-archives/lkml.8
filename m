Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C6C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62B520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=osportal.onmicrosoft.com header.i=@osportal.onmicrosoft.com header.b="O6fqdNXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgH1Qts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:48 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:17230
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgH1Qt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf+/WAP8m3gvpsGLTNFbFRNOlR+mqCGkV+TBEP/ra6MPE9zy1+5+q1v7h7KoOgN2R21tSNzg8wtVq59AU/W3yALrOHJHE8tmHMTz5jDuiPXVNWf9xNKX1dZIAEhHvjI02EQstAFSEtlLQdoRy0ETe9l6En33OxjN0NqEfYd5FwuDoY71Opx2Zbw2AUBAE/fD48ZaymJm3Q2Op53De3xv9u6YK6IXX0+uyCZR8Jv+pg3BNvgeH5kELtI7NILipC3e45WvtaGVn3eJRGqDtt7gyOKswGbppssuNMVTm7LnJALMZJVc57aFWbKiwkVFyT7OEfL5suwdhQoGa++IcJmJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cMkUw8N+RNIkoVrqMzUzP/v3ev/vNZgJ50XLYLvlaw=;
 b=VYu/LPZ2NGt0AY/lvQ3GkQ0nALLBynrZMYq2pj0TgZynA0HKWxxfL8u7Kcp4STRFnuJgUuv2XX48oq/d8K/E2nt5tndEWqW8lgn4BL9b9/vR7n+nfCBUit96ejFsDoQP7tSi7jmlQqa0cv/Ud2cCP/hHrERG7bW7VjTAdhMyTNPUagbrlyQyv8It/4DvfebeeUaaU12lOfHdEEeNiVt1BpVnnwOa52AbE6cdXdtmxIaIcw51kgm5uDM6XA/8Fm/mWCh7+VqWANxjGHb3rVgTQhU4gmV3l2oh640RR+C04XumMC4sh7iWYI3enWpjfi+JC2E2oTYo4NrfTctmowXb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cMkUw8N+RNIkoVrqMzUzP/v3ev/vNZgJ50XLYLvlaw=;
 b=O6fqdNXs9S3hYkSWBm3p8GbIrLKZafQ1EVChA9JbwaL0imp7jH0/xTutbnNiEZTTVIkOGY+YMPhbLMPzOQUHv/6kFAI/g0Ap7ocIXFKYggNVgjeHn5DKeCNVzRf70JzSbuOs308ugR+hDDbuDtVe2W3Cp2PR3m7uW2c9xJkbBqQ=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4033.namprd13.prod.outlook.com (2603:10b6:5:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7; Fri, 28 Aug
 2020 16:49:23 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::f570:90c6:f6d5:c078%7]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 16:49:23 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Subject: RE: [PATCH v2] dt-bindings: riscv: sifive-l2-cache: convert bindings
 to json-schema
Thread-Topic: [PATCH v2] dt-bindings: riscv: sifive-l2-cache: convert bindings
 to json-schema
Thread-Index: AQHWfVR4lz9JlE/ec0CZDYHYyLyKialNu0ZQ
Date:   Fri, 28 Aug 2020 16:49:23 +0000
Message-ID: <DM6PR13MB345171F14B41C30688B51D4D97520@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1598630453-31125-1-git-send-email-sagar.kadam@sifive.com>
 <1598630453-31125-2-git-send-email-sagar.kadam@sifive.com>
In-Reply-To: <1598630453-31125-2-git-send-email-sagar.kadam@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=openfive.com;
x-originating-ip: [116.74.148.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c53ed6ba-b13c-4ca0-68a0-08d84b72514f
x-ms-traffictypediagnostic: DM6PR13MB4033:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR13MB403397BC4814638FB4B0218D97520@DM6PR13MB4033.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgQ6So46m+Rh95Uznr4+9pZV4MXi7Ija5CzzMNc4jcrIY9MbWQzN4MUNhcMFsRLXMsMf/M4u8ePttdJcFbd36a4JMCLmCaXRt4AozSY40RK9t3oS2/s3vcdEdKwUhKaG3DgzeupB9BrGiLtSir15akCu96BRBXy40mLG3hb8k/K76B4WLktyUUlaxcYEsxbpZj/AxVYmQGgwt3V07E4/3U6/jXuiRFU5kEN39pOTsUhWc/2vllFK5juQaw9SK92HmWLa9iBDtmqk//T8VHB9MF39vNg7J6Zsd6uP/mEINQwrET/doefs7po7CWaW1wU4io6UDGtlu8GljXKfZLEij3SbjYXWY7fFvnoGJVlWtBCRpXvkjbuCiL64zwGge7qKK9/+UByp7W9Z4NUuf6+gUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(136003)(376002)(366004)(346002)(7696005)(8676002)(6506007)(186003)(6916009)(5660300002)(26005)(8936002)(55236004)(966005)(107886003)(54906003)(53546011)(83380400001)(316002)(52536014)(71200400001)(86362001)(55016002)(4326008)(9686003)(478600001)(33656002)(2906002)(66946007)(76116006)(44832011)(66446008)(66556008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fX8LRxfKpH8OvOO/Y+fHppj5lq85dG/28c7B6GdvGM254++zg60nV0cSclnakU/nwgJKsNoIePjdBgnCeuTOqmERZVFrpt/j8ubNj1VfOhKpPmThDyo1DaRJ0OfwZrOkGKWfXu1DNf4UuNxkh75h3D7J096oR1ZAHs0soISJCqEUL5/YCTd3AtRFOm5Eurr4dxlDFEsCwc04EMJL1RB90NtSgpvCwjr864d0zFI6U4Bj+ynFxHk3MTBFaC/g2ZDH+AkdQxbYrmvNdSHWJIQXmmp9cqkTpn4cps4fCQgt/V1VkANJprAA6MIzmiHS/VCsbSKUQXcpSfZct1WfCR8xQqMNYhC2HVJA2C8IYlmZqXcO7plB6eCoO9F8t3PKE8CJCwli/JZu3Tp/syG9sZK7XhQ0zfwAYzsw7Pm8d1iek376ECHyDM6/Gd5kVXXskIl7FkNIFsuPRkKU/INVg1ibrlpjY14xUjL/QzB8jtjghpqc9UyJkuKhROkiA9LnsRfBTXXY8MIMhWLb/eNIaEViNXjCKNQkZu02h81kH6ub7sbP2gropLKWiCL0J1dpFvm2fEtRGdQ+qN3v2XL9hawB66PZNR2t1JdX+vm6Eh0+tEgkwqhs7HkzJlWGK5yKZtNfudYQGJGb2TGyjM65m66X6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53ed6ba-b13c-4ca0-68a0-08d84b72514f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 16:49:23.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyx9POIYwIHdUyOh0CjbsieCArOBUarLdXtTIh2ZSX8zQ+r3dKLUz3wj6G7npDq/DZv4UO/Xltfb/7E4VqCV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this v2, since the subject line missed the patch sequences 0/=
1 and 1/1.
Will resubmit it.

Thanks & BR,
Sagar

> -----Original Message-----
> From: Sagar Kadam <sagar.kadam@openfive.com>
> Sent: Friday, August 28, 2020 9:31 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; Yash Shah
> <yash.shah@openfive.com>; Sagar Kadam <sagar.kadam@openfive.com>
> Subject: [PATCH v2] dt-bindings: riscv: sifive-l2-cache: convert bindings=
 to
> json-schema
>=20
> Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cac=
he
> controller to YAML format.
>=20
> Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
> .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92
> ++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 51 deletions(-)  delete mode 100644
> Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-
> cache.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> deleted file mode 100644
> index 73d8f19..0000000
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -SiFive L2 Cache Controller
> ---------------------------
> -The SiFive Level 2 Cache Controller is used to provide access to fast co=
pies -
> of memory for masters in a Core Complex. The Level 2 Cache Controller als=
o
> -acts as directory-based coherency manager.
> -All the properties in ePAPR/DeviceTree specification applies for this
> platform
> -
> -Required Properties:
> ---------------------
> -- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
> -
> -- cache-block-size: Specifies the block size in bytes of the cache.
> -  Should be 64
> -
> -- cache-level: Should be set to 2 for a level 2 cache
> -
> -- cache-sets: Specifies the number of associativity sets of the cache.
> -  Should be 1024
> -
> -- cache-size: Specifies the size in bytes of the cache. Should be 209715=
2
> -
> -- cache-unified: Specifies the cache is a unified cache
> -
> -- interrupts: Must contain 3 entries (DirError, DataError and DataFail
> signals)
> -
> -- reg: Physical base address and size of L2 cache controller registers m=
ap
> -
> -Optional Properties:
> ---------------------
> -- next-level-cache: phandle to the next level cache if present.
> -
> -- memory-region: reference to the reserved-memory for the L2 Loosely
> Integrated
> -  Memory region. The reserved memory node should be defined as per the
> bindings
> -  in reserved-memory.txt
> -
> -
> -Example:
> -
> -	cache-controller@2010000 {
> -		compatible =3D "sifive,fu540-c000-ccache", "cache";
> -		cache-block-size =3D <64>;
> -		cache-level =3D <2>;
> -		cache-sets =3D <1024>;
> -		cache-size =3D <2097152>;
> -		cache-unified;
> -		interrupt-parent =3D <&plic0>;
> -		interrupts =3D <1 2 3>;
> -		reg =3D <0x0 0x2010000 0x0 0x1000>;
> -		next-level-cache =3D <&L25 &L40 &L36>;
> -		memory-region =3D <&l2_lim>;
> -	};
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> new file mode 100644
> index 0000000..e14c8c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright (C)
> +2020 SiFive, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive L2 Cache Controller
> +
> +maintainers:
> +  - Sagar Kadam <sagar.kadam@sifive.com>
> +  - Yash Shah <yash.shah@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +
> +description:
> +  The SiFive Level 2 Cache Controller is used to provide access to fast
> +copies
> +  of memory for masters in a Core Complex. The Level 2 Cache Controller
> +also
> +  acts as directory-based coherency manager.
> +  All the properties in ePAPR/DeviceTree specification applies for this
> platform.
> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +     - enum:
> +        - sifive,fu540-c000-ccache
> +    description: |
> +      Should have "sifive,<soc>-cache" and "cache".
> +
> +  cache-block-size:
> +    const: 64
> +
> +  cache-level:
> +    const: 2
> +
> +  cache-sets:
> +    const: 1024
> +
> +  cache-size:
> +    const: 2097152
> +
> +  cache-unified: true
> +
> +  interrupts:
> +    description: |
> +      Must contain entries for DirError, DataError and DataFail signals.
> +    minItems: 1
> +    maxItems: 3
> +
> +  reg:
> +    maxItems: 1
> +    description: address of cache controller's registers.
> +
> +
> +  next-level-cache:
> +    description: |
> +      Phandle to the next level cache if present.
> +
> +  memory-region:
> +    description: |
> +      The reference to the reserved-memory for the L2 Loosely Integrated
> memory region.
> +      The reserved memory node should be defined as per the bindings in
> reserved-memory.txt.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cache-block-size
> +  - cache-level
> +  - cache-sets
> +  - cache-size
> +  - cache-unified
> +  - interrupts
> +  - reg
> +
> +examples:
> +  - |
> +    cache-controller@2010000 {
> +        compatible =3D "sifive,fu540-c000-ccache";
> +        cache-block-size =3D <64>;
> +        cache-level =3D <2>;
> +        cache-sets =3D <1024>;
> +        cache-size =3D <2097152>;
> +        cache-unified;
> +        reg =3D <0x2010000 0x1000>;
> +        interrupt-parent =3D <&plic0>;
> +        interrupts =3D <1 2 3>;
> +        next-level-cache =3D <&L25>;
> +        memory-region =3D <&l2_lim>;
> +    };
> --
> 2.7.4


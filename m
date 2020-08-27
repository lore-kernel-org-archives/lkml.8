Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECB922CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S+GpaOsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgH0LZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:25:58 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:34894
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgH0LQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8PcMpkkny/zChFtgZNULtVOyUYOASMjrIaD4TE4K+dYnPYQciA3BaL1uJmV5tsEG/1GmXvd7FAvBuV9thObiKj6QWeyQx9VCm+9kXMxgv5febF7Jo1Gf5gwZyq2KB2pFqzNJ5pBYiOCqwnxO5H7ikHuKmhN+P4aw1ejZh3PxMbOgwI41/CodMggLZHRxyGAsBOaMXGs+HjpMS91mm23DwOikVaobVxoWse5o3/tXbdBwOGCKlLYaiT3IIy5OIXAcbbKyETZQpBEm/oFrBfMqz3Q+WN/EFidq73FiSQvssMB/bkbU8AvJdO71lhBFAtc951pr32avqiorXSV438yMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL09PsZity/orIstjfA5XVgVAXcyxlhY3rX0Arc+18U=;
 b=DMPJ6ey+P3gTJEc3G5pPpH78zLM6eFB/tIIbRJxymKlNbIiUYw5mj2yuM3Nzcy/gP44Id+VuER712FYAZ4IaqP1Z15Go1RgqAqgjTE5SOyjgRsEvPsdqB1Ap7IPvmaxZo8yufP9QkZuLAPZf/Ky1HP7Hfp/H/FUjZ9QI2BBDFyVpnE+gEgCYK4wJP3uJ885TfI6ImNCcVx20ab+RvqTaU6Igje6PsAoC3mnF67eHzgKLJyKAWTonYV0DPLx54HpSxkyhPbnGbJ6qgPhvQ5oQNnfleTBUUILik4azp5qk0wPoIac1Gy5jCQNozIGS7aSnvn9sLUckT93CDG9cZpr3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL09PsZity/orIstjfA5XVgVAXcyxlhY3rX0Arc+18U=;
 b=S+GpaOsODAmLr2AM8L6EumCNd7ruGnxtoUc6QdRQ9/xBxztgu8L5KdUyASrXp/83K1gTAdUyFgoaXtId/CGi9/eAMz8q+I6yQiVQaQTizGCV3QSRuADMptmkD5H4iOVhy0mmSviJ+hwvI7T5RqXntoxE3UCCsaiO2AGlvHzAL1U=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4421.eurprd04.prod.outlook.com (2603:10a6:20b:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 11:14:59 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:14:59 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable
 property
Thread-Topic: [PATCH 2/3] dt-bindings: usb: cdns,usb3: Add
 cdns,phyrst-a-enable property
Thread-Index: AQHWetjF2mYsQKwgvU+3PPFGyTZfuKlL0I2A
Date:   Thu, 27 Aug 2020 11:14:59 +0000
Message-ID: <20200827111343.GB5983@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-3-rogerq@ti.com>
In-Reply-To: <20200825120059.12436-3-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d5b8407-6b4f-4b5b-1aa9-08d84a7a6fe1
x-ms-traffictypediagnostic: AM6PR04MB4421:
x-microsoft-antispam-prvs: <AM6PR04MB442168F3D1B663C2B71114098B550@AM6PR04MB4421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCoDbWN4ta6zMkCrAcNHNOUg1gRPFSQPqFWLHUXTo4gIUsmch2794OGlbncgN3fJsNF7juIwBA5NIeoghQEXzdnpQkGRJPteNBE30Dc+W/nVE8hhw+NMyvB9UbmjNjvANJiu2jXHaik3ACL+Bkt/2Vo07W54q1q+LM94HK1aNN6X/X07wlNH1S3c16atLycPnd39hY5kG4vJInAMADLJ3WnTpHgo+P1YH3MEmCw3TguE4EEaF3PLFau0L+gzKsgW5A59DI7oIdBf4//W4ZRnbDEsi5s6voV/bNN54tr4xtj2vey+vd/507F2njczK+8ejC8oEYHzgcPiKD4xSFiZrTL+I7JO4OdrxFrvNa2TXlgkFyAHnNONX9/sGfN9iDT7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(7416002)(44832011)(76116006)(66556008)(33656002)(64756008)(66476007)(66946007)(66446008)(26005)(8676002)(33716001)(91956017)(4326008)(186003)(5660300002)(6506007)(8936002)(316002)(2906002)(83380400001)(6486002)(54906003)(53546011)(71200400001)(86362001)(6916009)(6512007)(1076003)(478600001)(9686003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: n1+d+v1Dr0MhRWI0Sn+UeV4bZYppU+6rAitdAyS0naRyRywc6Crs27ywZ7MEvdLwrzljQdVjQ1AqmtbheTOwhVeb1LZkMAozQfhoTXsAlnq1VpPt0qgZ1ne/8o+tjaX8TA0xnMQCZqzVTgyRYVqvuqE2xUWFKpkoV9gC/UgKJeokqikNJEHsOBxUyDDKaVgu4Y8LDoWXpwL1NLIslV1H8W2k9C8fIp2SF64+53G88yIG+u7fvnSxI7TenjUz189Yn8qApG+/2cl+/noaAlqWMy2ILPXpZwIF8nyy3b7lRoYOXt56KK3p/DZyXdsaxjIuZhBm5RHLnGcrnW53/2jNg/N/Nq7c884eOp9KNp8CAmLfmYvemNabzDUd7kJEc+TIz+JF2BIF4eIoFvmda925Ws6h69N5Jz4mf6SRq4VhW33Jrp5ag2ejlBViMZtJNhZGDpvppNvMUehm8mHFgOId20O9AxHDN2qmpnKiTDe++xz73Y4D9F7VXaAkhxU89eGEWFlpg/L/NBOo8Jx/DNpQyDjRl3dTLG3Wn9Voe7tyP2gKe1/bEuFmxJCL5RtjuaKhSpt49OVIuTgl1IGpo70IqLp1kTvSBbe30h5DJ1br3g9XOulIcQ3xAGQCRee9gc5fh5xpKXx7/wF1WGj46Fzr+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB83B0331D587845BA644C178C701995@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5b8407-6b4f-4b5b-1aa9-08d84a7a6fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 11:14:59.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxPOuhysHASS+d7PRrefyGFvgG0vArJrepg28/QCjuNBKN1CeHvxWXC4E2qwsaG1p+J0qIwsixoVZyKcgwqEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-25 15:00:58, Roger Quadros wrote:
> Controller version 0x0002450D has USB2 PHY RX sensitivity issues
> that needs to be worked around by enabling phyrst-a-enable bit
> in PHYRST_CFG register.
>=20
> There is no way to distinguish between the controller version
> before the device controller is started so we need to add this
> DT property.

Maybe you should say "There is no way to know controller version
at host mode, but this workaround needs for both host and device
mode, so we have to add this DT property", the same for the comments
of your driver code patch.

Peter
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Docum=
entation/devicetree/bindings/usb/cdns,usb3.yaml
> index 7bc0263accee..e670adc955e1 100644
> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> @@ -58,6 +58,10 @@ properties:
>        buffers expressed in KB
>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
> +  cdns,phyrst-a-enable:
> +    description: Enable resetting of PHY if Rx fail is detected
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

--=20

Thanks,
Peter Chen=

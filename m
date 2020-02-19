Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3FC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF424680
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="blZr4D+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBSOej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:34:39 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:36455
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727720AbgBSOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:34:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB5XzE1SbseyvB45bjALNp6F2Dy1X5NdyU1pRH+cCxg2cmZpu2koe93Zny0znB80F7T+8IeLk73VOsPOlm1hgeODcVUXuyEJCC/QDSKNSOCUCrPtXVYA0OjBGG5ABQuHaYdTqVpCz9/Cfs/d3ADqz97KSd5aRLOuHhFF/+ityR3o3e1yBSWrbL8KT3tnU4oViVx9bQJ8ivyo9z5ockBRELpbBSfndnrD9rtUC8N1LLgFOj7I+PW63pCRMUaHVYXTCfOCTFQBUqeFAikwAfgZr6vHdrpnoiNReGg2N8dtAacuKNegM8rRp4i9uaycZjNyzjuPaAAYLcCSKVOKydyYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dCN5LQEx4h/uxxp39Cw1akoKKywbQL1tX6ulA8JmO0=;
 b=a5FvQ2OIN9AovOgdmaZjZWBANQsPJTiPT3HfAxk6mOvLOrwtYBpOIqKkXL2kAMUaql9/QOF2cGCnxA3kiuQXd8Q++lrV/Gwahnu515kY0dxB4rxidB1LjYhkUqQ8iNcZsKdW4grKriHqkj3RYgR18rRkAhBH24C13r7cZeeXVBvizSgAxC6vwZWIflg/Ajb4hWYjFxOdzieMcHIW510KNiQ1SoCzwPwgks8yfcaczzJ4YcBuS70HJwGeIN5sxcsSV4Lm9NerCOIK6ZXPX7oqcKVfHyOO136EFyK4dIVgRTBL14KrT/e78S42+pE5xGR2BWYUh7Z0ggN77iymzCOsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dCN5LQEx4h/uxxp39Cw1akoKKywbQL1tX6ulA8JmO0=;
 b=blZr4D+9KlX0HpBZvqurJgXSo7b6eP0o5zyuI70P5LO0xIOs/ZAEkleKpocX35gxF7n06VLWyds9TUqISnbf4bdDE8619OKMXNI1HjMAFP3a4YdLMBpVu7ObRwKLF4AkRkIXlfmLuM/tZCMBg+sYUw53zujnwiMipmVswL6NhaU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6322.eurprd04.prod.outlook.com (20.179.35.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 14:34:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:34:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to
 json-schema
Thread-Topic: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to
 json-schema
Thread-Index: AQHV5vbonmiG8tzofUyTMtjSu9BVs6gijm6AgAAGNCA=
Date:   Wed, 19 Feb 2020 14:34:32 +0000
Message-ID: <AM0PR04MB44814713955807D7BB3E2CD088100@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-2-git-send-email-peng.fan@nxp.com>
 <20200219140921.GA7031@bogus>
In-Reply-To: <20200219140921.GA7031@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e68f2695-4a4c-4f16-3b9c-08d7b548d5f0
x-ms-traffictypediagnostic: AM0PR04MB6322:|AM0PR04MB6322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6322ADB1B9576FD04B104F1188100@AM0PR04MB6322.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(7696005)(66476007)(66446008)(64756008)(66556008)(76116006)(26005)(316002)(45080400002)(33656002)(6916009)(54906003)(966005)(4326008)(86362001)(55016002)(7416002)(81166006)(9686003)(44832011)(5660300002)(478600001)(6506007)(81156014)(71200400001)(8936002)(8676002)(66946007)(186003)(52536014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6322;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjxLEs/B6syH+EZZGuKAMDHGoUoQr0HYMHBfg1FsNKGA7kzv2XQgoUKTNP0WkgQcyn92hNpg91Vikz4yPBfvbmxlt8HQ7Dp4qAqZqFcztuau0Wg5wcvRt4fqU77mD/7womp2lNl/OrZzxTnT4MBuTOhULCRNKaVZ6WrERXtlmtTUxGz2lR7WyQcX/3qEpB8CuBrXlECNBfImWKiGfrOHJRmdoQHrn11Delwv6njVg1E8SohoWsf/6A2nx8dJpbzs5oeLanJf7XZtkH9mhmY3jRek9ka8xO1i2Mgd02TJsAccjPn2nFSU6IrRTvxelucEzYzCMdx3drZbqgOBkjEqPSqjFZUtTThM5osnlQyedXoAw39x4AOOUGfDbJZ/1cNyK3DvZi82RpTUUH1G7HMXblV3o3UyWKEo7Ts3rcbz1rQeN0Px7ouEbaXbSToHl/ZLikd8sE6RuS/ldj9GFF1EDpcUkbEqKX0iJmZaDIjHiiEmyz8T6Uz/mR/rAUjZxTALDSzM6EP6j5H45MSBTc4L7OcW0MveQBbuozIqeNe5R8LbrCJ+qo1+WKCkHQuyJKpNzpQhNXkDED2iuZpaXM8/7nMd/p/jrdaKhzi5GUaIxFTIlObxBbY2O9fyJaPqYQrT
x-ms-exchange-antispam-messagedata: +P9Jjo/cZIRFqbLJRLTqG4hbJdY+KZcusJLnrosxf3vM4qT2/cAY3i6rMQZhp5tQgVs+8tK/LiS43ePYSdnst7SkX5Z4qjnnkiEriC5sGitRGskfs+hA8PuGQuw02pnnuKvKjqY+XKzjbqFrSWEFmg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68f2695-4a4c-4f16-3b9c-08d7b548d5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 14:34:32.7028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zhs0zi/AqxjfozAAghbFaSCupEM67q4EBEcVTDf+fsl3FKt1j92tNHJjrkt1pufKGcAnE99gXgKiAEgrA0dq4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to
> json-schema
>=20
> On Wed, 19 Feb 2020 15:27:37 +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Convert the i.MX remoteproc binding to DT schema format using
> > json-schema
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/remoteproc/imx-rproc.txt   | 33 ------------
> >  .../devicetree/bindings/remoteproc/imx-rproc.yaml  | 61
> > ++++++++++++++++++++++
> >  2 files changed, 61 insertions(+), 33 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

My command:
make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/r=
emoteproc/imx-rproc.yaml

and output:

  CHKDT   Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  DTC     Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dt=
.yaml
  CHECK   Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dt=
.yaml

>=20
> warning: no schema found in file:
> Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rem
> oteproc/imx-rproc.yaml: ignoring, error in schema: properties: clocks: it=
ems
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:
> 21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen
> node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rem
> oteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-processor
> (See': '../clock/clock-bindings.txt)'} is not valid under any of the give=
n
> schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/
> remoteproc/imx-rproc.yaml: properties:clocks:items: Additional properties
> are not allowed ('Clock for co-processor (See' was unexpected)
>=20
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rem
> oteproc/imx-rproc.yaml: properties:clocks: {'items': {'Clock for co-proce=
ssor
> (See': '../clock/clock-bindings.txt)'}} is not valid under any of the giv=
en
> schemas (Possible causes of the failure):
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/
> remoteproc/imx-rproc.yaml: properties:clocks: 'maxItems' is a required
> property
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/
> remoteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-proces=
sor
> (See': '../clock/clock-bindings.txt)'} is not valid under any of the give=
n
> schemas (Possible causes of the failure):
>=20
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/
> remoteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-proces=
sor
> (See': '../clock/clock-bindings.txt)'} is not of type 'array'
>=20
>=20
> Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dts'
> failed
> make[1]: ***
> [Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dts]
> Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2

I'll check, and after get comments for other patches will send out v2.

Thanks,
Peng.

>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.ozlabs.org%2Fpatch%2F1240544&amp;data=3D02%7C01%7Cpeng.fan%40
> nxp.com%7C28b6280f1e8d4cd48fff08d7b5455348%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C637177181663776763&amp;sdata=3DXfOrYdrVi
> qB4jwZRjPFLM82Zz5BjTZQF7gNohDOcOCw%3D&amp;reserved=3D0
> Please check and re-submit.

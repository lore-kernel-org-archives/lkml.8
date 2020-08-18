Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B2C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAAB20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BoMPWGla";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="20VBGG5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHRHIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:08:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54844 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgHRHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:08:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I7158a021659;
        Tue, 18 Aug 2020 00:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=FNNkwDP1cKMAtBMVgH9/UO0+gIrZJ9d/Np/XwENeb68=;
 b=BoMPWGlaKeXA3hMRCUUUxp13eYgVVL+o7z2q0+JqQ2zfescvVtnc6q9VZmwdPtV+4G6W
 mj/HVlKM0WIK8Oxb/Xty9YEufdYu5NW7ZxGxfQdCD0mD6bC0ukkAk1aBR9bF+Iy4ZWbH
 JIyz3Krw6Q/DCEo7K/kBBEBKQx/G4IuTttrgLYuaT4yJVYwjIzyVrOSQAcvWVHVfM2B8
 /iSKXUgL/f2Tpm411otZ2kTEZGkvY25tnaAZiJB+OnUWIZqXZ+ZWsiepLBuvL8qJqj7y
 9JsmEz15T9vB41H+s0ep4AixJMefOUOtOA2b12tKA5FzD1l5FSiq8CiBut0bNrKSfDt4 XA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3306jngupw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 00:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHVjpkj9KJ/ZGi/jG6PqVp/zAtiBK3JnxmMzZE/wZh4Owb4kQ4nWrZZbnvdX9CCriaQ3CIaPaXdx93QxuEE3NEx1PN6Fq/AteG6UeFCwzTBb9CruqkJLbEls7Tl9X7JUYJRW050SI+DYwTUwNt2sss/dW4lL6Ab425ju2Gv51vBgJYOLHRa7MzHtbe8HLrYjCInQyORm29meh0I3RT6brCBXxxW6I+exhYHPC5qv1VEwIzpCzelU+xf4fe+Vha8TLThZjgDR/tR/F48NJVpKdtscDRufo5SiPRl7XeziR5sB3Nx9Bebk7JfPQ74RE3y69HpKqoscE6JoYar0Fndwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNNkwDP1cKMAtBMVgH9/UO0+gIrZJ9d/Np/XwENeb68=;
 b=f8aUa6EX5gNEgqBqfwZzgjrME4wGgx8aw0Uqn6l0rPmV2NGQXzSEb4CDU0f3cR/GKWhTz0iICpjw5d/3BZlH707UFp00wXEPA5Et99RlLYE7PlamXasiaBkwgPp2KNa/LTVKRHOmSEiSMejlyRqfdkNB4oYiywVa3oW4Uu7D8TbT7rB+tFVYaZXL/mGb0fo1F8qcdlfLUwzatzn9Zp3tdGPswWQ9x9eYrT5xK2GTkOscxkppYldfEnF7ClF492WVHE8OBdAzHh/a7wn3Mr1lWVXgOldAa5DQWXYtmDHJeP8yUrxEFlEsl287EqdwD1MMntUOerlXQ+QNcI0uBuDBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNNkwDP1cKMAtBMVgH9/UO0+gIrZJ9d/Np/XwENeb68=;
 b=20VBGG5CmtglcF6Yo4g2ZtENawMmDEECzSbmRQIiqsuiI/8KoCorqos0AnX/QO9kREufqJWxijt2ENpxnjoyglo3GMweeo9xgax2NXSjj5yNpDrd3N8ct6RGTPgF18bdLWD0KaDapfhzgrtoeWParzGrPTR+WjlRRwVN9xrzOSw=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM5PR07MB3161.namprd07.prod.outlook.com (2603:10b6:3:e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 07:08:27 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 07:08:27 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>, "jsarha@ti.com" <jsarha@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Thread-Topic: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Thread-Index: AQHWbKNgb4eLlJb0pE6AuVCE/4rv2ak0sXOAgAjQckA=
Date:   Tue, 18 Aug 2020 07:08:27 +0000
Message-ID: <DM6PR07MB61546EAD17F3221DEF393780C55C0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
 <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
 <20200812162643.GA2320575@bogus>
In-Reply-To: <20200812162643.GA2320575@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05OTJiMWI3Mi1lMTIxLTExZWEtODUyNi1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcOTkyYjFiNzQtZTEyMS0xMWVhLTg1MjYtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIyNTUyIiB0PSIxMzI0MjIwODEwMTgyODAxOTkiIGg9ImxBN0R2QzIyMk00Y3dOWGxOdGFjSzlTYU5URT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f73b6ee-0dad-4f54-a131-08d843458156
x-ms-traffictypediagnostic: DM5PR07MB3161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB31611EC5F910662965FCDD36C55C0@DM5PR07MB3161.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YBWfo0egCF6lCqTDzu+S5GcM55g6J+zxcebKl9ZNTy1AswN6PwlDjzwG2lIZeBnq8cOl7FU/75MrsA4Bs/0WNaMsFX0KBU/hPBBpu2uRMrzzM6Q38HEmFg4spB7ivOSKhQqGXIruX4/xwLeylBFuTRzuclY4lmfdtF4etAEjmAEzDBvGTvCazuLd/4dVqiY/FasV8+Apki06HPQ8so9Xvua1GTYiiduSn8g8wFJz6WpLCP4jBF8ZY5SmS9+8Rj7JOVIy7g5e/n8CF52HGLrX1HasMMh7JbhtV4f4/XRSPK4LdvhkLXwQlGrfEoDem15Ee2O87K5tnIXWvNddZqJtRDEzXX68HjdfkIsfbV3Ezj7wD3eepk2bFifJEVC2fm+yjIJlGsGvKmQcgpVKKVVfhafL8bCNqm4k5HrwVzhb01cvuVFTQsgEP3GSzNHrMp/sanKUjzJP6iSOA4I0g71ctkE6ha+Nc8S/vncqgspfTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(36092001)(7696005)(52536014)(9686003)(6506007)(26005)(53546011)(55016002)(478600001)(86362001)(83380400001)(66556008)(66446008)(66946007)(2906002)(76116006)(64756008)(8936002)(71200400001)(5660300002)(316002)(33656002)(15650500001)(6916009)(8676002)(966005)(54906003)(66476007)(4326008)(186003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BuPA6Y26fG5q8a2MXY8GNpnbs0SzC56RMdP19DgOzyVjpJp6cLRZtWhN73Ro/MYhbmNW3GhqhtfBx+MeXhuWHg1p9okogMmTpvIW4NwIG0jmxBwJk1QMiXUOEdP9qvNP2QnGRpTAg9IfufdxzplhCBd2yLa0KyCDsLcDVVU+CYYEWoGMWhx6BOlFcjudyPxlnGgi7JV6CM8dvFX6RzVYQplgHqdslEXRW9KosXVgaBvyYbyjUtxoZgr3U8mnsEAsEQUIutf0neq2ynwpRM4KlGB4s/ymX8FxPbX7t0l5Ryh38QNmHs5YSMQUShv7DTMvlTKa4f8/K8bo7n1/0uhEYqJdNB36T6bpnPqO+xRk1GaWEp4aQpAsmJNQUOFeKQBwzxOITW37yhDp+K53gMaewtRDU2DUi49qpxVs24cWwanRSSyxUmTjwOfYMDhFb2m+vve2OklMcYBvTLVNms1zoHgVUKKWDLj6+VLObr8y0KHrktOaqPh+qn9awz1U3thA75VL864QSl4t0pWwB8Rw0KfFaWMDGeejEtdTagjR2cFdCnImjipDX9WwMSk4lD/gdLHyy9bgKQ/cb3BzZN14KPMrr2aIKlt+alCEhItMznMCaYyGuTgVtDXwzn/AunCm/psUG+Fel4eSg8/R1Fjv9A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f73b6ee-0dad-4f54-a131-08d843458156
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 07:08:27.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2tY94BSxcZfK3Zaz9Rl+lTgCdRW572OkB1qQgyt0gR2hDnGAcR8P5vo0jFrwVzFj/R/f6Dh0yarJCxuuv2UK34o7j7NutLZNlV5sE8iMQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_04:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=757 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008180049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, August 12, 2020 9:57 PM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; jsarha@ti.com; vkoul@kernel.org;
> tomi.valkeinen@ti.com; Yuti Suresh Amonkar <yamonkar@cadence.com>;
> Milind Parab <mparab@cadence.com>; robh+dt@kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; nsekhar@ti.com
> Subject: Re: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update
> Torrent PHY bindings for generic use
>=20
> EXTERNAL MAIL
>=20
>=20
> On Fri, 07 Aug 2020 12:12:45 +0200, Swapnil Jakhade wrote:
> > Torrent PHY can be used in different multi-link multi-protocol
> > configurations including protocols other than DisplayPort also, such
> > as PCIe, USB, SGMII, QSGMII etc. Update the bindings to have support
> > for these configurations.
> >
> > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> > ---
> >  .../bindings/phy/phy-cadence-torrent.yaml     | 76 ++++++++++++++-----
> >  1 file changed, 58 insertions(+), 18 deletions(-)
> >
>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> Error: Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.example.dts:93.38-39 syntax error FATAL ERROR: Unable to parse
> input tree
> make[1]: *** [scripts/Makefile.lib:330:
> Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1334: dt_binding_check] Error 2
>=20
>=20
> See
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1342193_
> _;!!EHscmS1ygiU1lA!SVJ6n249DhrJY-
> i_QSvywciTmAiJRcn9zUnmEeSR5UI4tt9jxEzzj9r5Rz1ZiOY$
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure dt-schema is up to date:
>=20
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master -=
-
> upgrade
>=20
> Please check and re-submit.

This patch and the series requires the macro definition for PHY_TYPE_SGMII =
in
file include/dt-bindings/phy/phy.h
This error is because of missing this macro definition. It has been newly a=
dded
and present in kernel v5.9-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/inc=
lude/dt-bindings/phy/phy.h?id=3Dv5.9-rc1&id2=3Dv5.8
So latest version should not get this error.

Thanks,
Swapnil

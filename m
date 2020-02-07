Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959EC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C5D21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JiHB+UN9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Dcghl5V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGMGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:06:03 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:2538 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgBGMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:06:02 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017C3XOJ012685;
        Fri, 7 Feb 2020 04:05:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=O9whW5pRtLEzcX2nQnW1vfWdhih0XAVolfu1EHci9DY=;
 b=JiHB+UN98jozBqYF7JoLrYdPKG4DqBLMx3Ct+xcaPVn7fBEa2/zyxvuCNpSkgcWPCvrB
 mU+oLP6Jgy3aNPQoc8eBW+VzBhiwnvNU5iCgZnSgw3i+3H14W7NQabTY4Sm50KpzgMwu
 hZnk3NetW0eRvCxMd9mSIgov18WZDe1dLR06ugzz/mZ3R8LbKXdAvZCXzZgk0knaDwEZ
 J8p0ZUFxPOvQWQkv7YHIXKTaJXS/AunvvhBe5dUD5cNesQbsuL95jbDQmVo2u1DD0bIE
 RDFkH4+bX2mLralFVPyS9bzWF8nvfuxJusPh8589Wn3ExO0KwztPCl4vlQqWj4kedJSV MQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkvax5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 04:05:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUXaiuSPYNbXeFZgCPnYHFAbU4bIwEiPbKqQYzcPh0+mS7UQh60KTm+PGKGIGcncchRFSS2c2u3/xS4UI9ZkHM0aOAn6tmKn9FfUQu3wgPF+x/hb6t6ZqmNiG6PFPxNhz3y/FdZRCIgG+hvd6tnk37nA4JMRdqknZivELdFUki6QvqLRBxHP/4NXXmUx1+s9qnHopH3s4c8pkWt6Xnpis5XDwZayjWCTIWXSkQ14Gf3rKgTlU2CJ5zOgTlMzw2uGyU6GmMGiDsSPKt8gHfIyJete9UrjY1oGjbn0CLI2sNdJLjkqQjzjp+/QGAC8Stl7P1W1Du0FAhfUKo5GzyzLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9whW5pRtLEzcX2nQnW1vfWdhih0XAVolfu1EHci9DY=;
 b=TZVcJf9QQCcba9MfmTCI4GykPmBFlg4iHBq272eZQ9JUvAoCKThAnpVEn5RsheymCIkE4ihqkVQD/IOGBEA1wcu1fx2FbULge/A7YIqH+g0l1qwKNGYHzNtcX+rcRG7M+bk5US4k3S3kK4LugH06cfZzuc2cN4H6Ht9NBTjGxtZJsJtG6WoFVo2HBwSVoMjrmMHcWBSpu3dzbt1Q57aJjglmReC0bPjwilYMPCo9oBBlwQSNdsw5ohLifSovyuhap0zH+/nJIT+arL4kKLSjDZ2pffANcZehwp+LxMWpr5pmSvjF3j20QNUTtHZoLjbItcClykEJnJP46vgzluQL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9whW5pRtLEzcX2nQnW1vfWdhih0XAVolfu1EHci9DY=;
 b=Dcghl5V3Ofmjb02G8kVHNpddfb+zOezFSGM07+x4hZEcjTvynJN2/T7IX+Wb5SSAp37emHmNcsYXn5U1dMVFMYJcanNptRoumLKETXZyseUCG2RT0aSIkN35esj2yAY1L1WlTSK6eQvPJmXwL7EpHUj4/mZiWKxOD/jwX1lKJAs=
Received: from BYAPR07MB5110.namprd07.prod.outlook.com (20.176.255.14) by
 BYAPR07MB4678.namprd07.prod.outlook.com (52.135.204.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 12:05:46 +0000
Received: from BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::cc36:479a:7b72:b1c9]) by BYAPR07MB5110.namprd07.prod.outlook.com
 ([fe80::cc36:479a:7b72:b1c9%5]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 12:05:46 +0000
From:   Yuti Suresh Amonkar <yamonkar@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Subject: RE: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY bindings
 in YAML format.
Thread-Topic: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY bindings
 in YAML format.
Thread-Index: AQHV3LRLSlhV6s2u3EiDn6CGqL1+xagOpgSAgAD6LwA=
Date:   Fri, 7 Feb 2020 12:05:46 +0000
Message-ID: <BYAPR07MB5110DC5D61AD92C0DF2CBE50D21C0@BYAPR07MB5110.namprd07.prod.outlook.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
 <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
 <20200206205507.GA13685@bogus>
In-Reply-To: <20200206205507.GA13685@bogus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNceWFtb25rYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yOWY0OTRhNy00OWEyLTExZWEtYWU3NS0xNGFiYzUzOWE4NjNcYW1lLXRlc3RcMjlmNDk0YTktNDlhMi0xMWVhLWFlNzUtMTRhYmM1MzlhODYzYm9keS50eHQiIHN6PSIzMTc2IiB0PSIxMzIyNTU1MDc0MzU4OTU2NTUiIGg9IktBQjArOFJwUWRnR25ReHc3aVdlWHBieU00bz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f19f887-a671-4181-3e46-08d7abc610a6
x-ms-traffictypediagnostic: BYAPR07MB4678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB46788C44C93A3B71E8E999AFD21C0@BYAPR07MB4678.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(36092001)(189003)(199004)(186003)(7416002)(81156014)(2906002)(71200400001)(6506007)(478600001)(26005)(9686003)(8676002)(81166006)(19627235002)(7696005)(6916009)(8936002)(53546011)(55016002)(33656002)(5660300002)(316002)(107886003)(4326008)(76116006)(66946007)(54906003)(86362001)(66446008)(66556008)(66476007)(52536014)(64756008)(966005)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4678;H:BYAPR07MB5110.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmkem5hfKsZt5AgEDRhAnHN7w6wl3Jg+MKsRx0Qta4QUXmfZTVxCVJPyntCHk97ORlb8FXT8LOP7j9v6T8VNMOvonmHUKvAlZEOD08Lp0KQbESBKffFBsyAsz72FrRM27GEUvwz7xP5AKhyyZvQk2HjIqENYYuTDjQyxzlTkf6fTUt61EcLJDvJ2cejwOCRBdpwhpb5GK6MH0lMANj+1E71+Prjnj1qjJ80UI+WG8YRj1pQStloz/7z6Q06Nifjfo0hE7OBVla/4qaaRmqhpfys8A6+qZ4fZQ4nmKXErvCpfIs+wmCR9kLKIBXvT7b/eaqIC0tuIdoc+li1OMitVeeA8rk5Ca3eIzj9+8KTx6VB05Y1ugku0J55bXujwAKABLvsh3P1lv19TsebJTd+89ELdWhKr4uTSFdVEvvE8NTPtJVxuADnMiDf/VjVwkyB+b6j3mHJTiDcJvYuzG9iOkZLo1clONqN709819AhlRx32rsDegVSqipcqi2nLNDVclWBSVOXVy0rDNVTZUo6AJdusySeVyUR4A3CLC4FD1zP+l4RjMTn76QPWlK5HiWNjgKaQ0gkheSBctxfDPRkaFg==
x-ms-exchange-antispam-messagedata: GujirQiW2vVC4aQPUc2EpKf2fjAMVva4/QOpSOBOMEtkJjMbh/3qxnLSU2zhLDWDegpUXouic+Q6JA2q0ir+qbYiuqdOCAIueBfOFvTASo9L3sXbSwveCeLh5GX2pa/4bDgxAb+E1XsaKOpKY8Q4DQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f19f887-a671-4181-3e46-08d7abc610a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 12:05:46.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLDddEnK3m44jXuF5E7xiQtqF1olHFdmLgzf+qDdrfq0YpHEyUIHXy84WrxACRXTGh8EY3zvQtorsFNq73kZXTLA5dWrTfcIPlZPd3K7VHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4678
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, February 7, 2020 2:25
> To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> kishon@ti.com; robh+dt@kernel.org; mark.rutland@arm.com;
> maxime@cerno.tech; jsarha@ti.com; tomi.valkeinen@ti.com;
> praneeth@ti.com; Milind Parab <mparab@cadence.com>; Swapnil Kashinath
> Jakhade <sjakhade@cadence.com>; Yuti Suresh Amonkar
> <yamonkar@cadence.com>
> Subject: Re: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY
> bindings in YAML format.
>=20
> EXTERNAL MAIL
>=20
>=20
> On Thu, 6 Feb 2020 07:10:50 +0100, Yuti Amonkar wrote:
> > - Add Cadence MHDP PHY bindings in YAML format.
> > - Add Torrent PHY reference clock bindings.
> > - Add sub-node bindings for each group of PHY lanes based on PHY type.
> >   Each sub-node includes properties such as master lane number, link re=
set,
> >   phy type, number of lanes etc.
> > - Add reset support including PHY reset and individual lane reset.
> > - Add a new compatible string used for TI SoCs using Torrent PHY.
> > This will not affect ABI as the driver has never been functional, and
> > therefore do not exist in any active use case.
> >
> > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> > ---
> >  .../bindings/phy/phy-cadence-torrent.yaml     | 143 ++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> Documentation/devicetree/bindings/display/simple-
> framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root):
> /example-0/chosen: chosen node must be at root node
> Error: Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.example.dts:33.42-43 syntax error FATAL ERROR: Unable to parse
> input tree
> scripts/Makefile.lib:300: recipe for target
> 'Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/phy/phy-cadence-
> torrent.example.dt.yaml] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>=20

I think this error is due to missing PHY_TYPE_DP macro in the include/dt-bi=
ndings/phy/phy.h file. This macro is defined in the patch [1] which is avai=
lable in phy-next. I forgot to mention dependency of this patch series on [=
1]. Should I send the series again by mentioning the dependency in the cove=
r letter?

[1]
https://lkml.org/lkml/2019/12/9/586

> See https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__patchwork.ozlabs.org_patch_1234141&d=3DDwIBAg&c=3DaUq983L2pue2Fq
> KFoP6PGHMJQyoJ7kl3s3GZ-
> _haXqY&r=3DxythEVTj32hrXbonw_U5uD9n5Dh9J7TTTznvmGAGKo4&m=3D4HxnP
> HG3MyXrwx28RZFwK7SF4T0LlYYpDjAaJcJ0lXI&s=3Dzp6pUcrsuA4OAIRcws8y1rxY
> xC4OrNk7GCrLcWqE0z8&e=3D
> Please check and re-submit.

Thanks & Regards,
Yuti Amonkar

Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4E92065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="F6JtPPCb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cHPPMpNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGIHCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:02:53 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62826 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgGIHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:02:52 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06972Eso029737;
        Thu, 9 Jul 2020 00:02:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zUcU0fuqWQW2Og99sVvpJAvhULvftKGP8+rdpbIApWQ=;
 b=F6JtPPCbWXoaEv2jTtFYEFQuuTwO2VWq7jepK4RG/wuIUFMAyxGAWrpFCgBGbliDQguk
 62ao0bTbghr3ziSBex5V8seFxgKEX1BYXWUJOFDQTKYmhpZy60xi+Nm4LLxIgtktVWkk
 EpGC4sNshPFszAvUzm+XSQGMXLI6xneAyryK2oYb4yTJ4hsy8mdJ83r0xeE98VuIM5xJ
 ag6ltP5KESpADVmqOUuO+OAcAjgTvfdMxri63kAlAZh+V2R22VQmEzUQex82hNzAMnJq
 TfeIvuTNWe93cyllT6DbTq8ytYctLhJwMtqxN+6TneFRmQ+qvVEnjQDP/+YQBPH94Zmb zg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 325k13t7g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 00:02:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOgm5IuB0BztQ7TmiIvLZNjPFvdcjbQOTRYTQavJJ9lT6x2FLVmbja3bMl+yRh2OVADdjb2sHrOrm90mu9T3gzBvvyYTk3z9pQAju5XjZLmLBRYhsBREhZC6+svA0ul6bWW4Ap7dy6/sF3RjE/0Ovw4X9cGBM+LTCTfIZIWkHrZod2WJTVOtBGjyTCFumUdL+2QxbutKxck0MgPv0l/1xUb0O9hQBdIfO6oMO1ZJUXYXkWD06m/vQX9aC4JxRMoO4WIjyuBhvrUq15MXckqvlBUApcs3xkc9+cS2EcN4Nux2fTukTnpKIWFBK3qUvNlY+Kfm0lK+HvWqa50Trrdg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUcU0fuqWQW2Og99sVvpJAvhULvftKGP8+rdpbIApWQ=;
 b=Fzw/uRIV3VUx/Sf3sJHqOd7SsSCH/YQeUV2cYeMcYDyGDgOY5wKDSo29xoK1ejvhlSvoTj4k7qwUge7zuu3obuaEDKHIDHNc84GzHWscVCEK3TfzGBWonzAi/3HNDchuqLJvBZJW36xeKVbsIqdX/CwjlKJCvE74a8XdkMbXfeF1q3nuDDkaZX5df+WgjWO43VunbnKuetmLrdy4dw5ihSGykq3ZzGb2Ymvz2UCqD9R9znB/8VSvVXZ51+rXJuW+L9XI47xwhTApyOdzhLA3kYzYS7Til5ArGryo5C8mbmX9uVd/8oMV2TwA8kSAqjm2FAdNe7X9/QPdNc+v8wK3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUcU0fuqWQW2Og99sVvpJAvhULvftKGP8+rdpbIApWQ=;
 b=cHPPMpNbu+pG3Qw2UmDJ+VlUmUw5P9tJXrrgf4aYt4e9QeT7XwrTazOF7DFq6pS+H2IHqgGiBwi84LV1YwtHsrRYYJTuTRtqnYJB+0Gl8gfyy0UwV/firlx0YifTPc0oK8HQXMsWg/iKPTc/8x7EgQW71745A/3l7RNxXApUMtc=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB6252.namprd07.prod.outlook.com (2603:10b6:5:179::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 07:02:37 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::88e7:2025:120f:97f]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::88e7:2025:120f:97f%7]) with mapi id 15.20.3153.032; Thu, 9 Jul 2020
 07:02:37 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Vinod Koul <vkoul@kernel.org>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>, "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>
Subject: RE: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY
 framework
Thread-Topic: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY
 framework
Thread-Index: AQHWM2rir14dmyS0cUqBu7jvGTV3zKj/FTIQ
Date:   Thu, 9 Jul 2020 07:02:37 +0000
Message-ID: <DM6PR07MB615442045742A117202DA5ABC5640@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
In-Reply-To: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yOTEwYmUyOS1jMWIyLTExZWEtODUyMy1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcMjkxMGJlMmEtYzFiMi0xMWVhLTg1MjMtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIyMzYyIiB0PSIxMzIzODc1MTc1MzY0MjEzNTUiIGg9Im9aRWZ0NEFPdmYrM0Z1TkNqVDlOUmF2UDNEbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dab29f1-a552-4352-f379-08d823d6102a
x-ms-traffictypediagnostic: DM6PR07MB6252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB625250D71346776954EC1B15C5640@DM6PR07MB6252.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYQ5ElGtlY44teelfgkW0s0B0JMc+V+P9KyrB/a+ohMbEdtA/xVyFcUBJ6TqR9CRvOU6/DHMrL4G3SjkELnO/d+7XmDs9i9pkDSxxLmSUtUeErkrxtsqcnjVo/UDFtvRffs68LOMdNF+7IUivlonP9c7cIYXsd6aJqc5TeKksaYF6CBrTtwukb2K3CDlonwULaMX94+LpdR38lXANPTuipt2iqkQnfu95RwmFf8fXgw7HCBGje5OpK4B7aIRyeNmdmlpTrfKRFniObYoNNSESzetHcp5KBp7i1segwTJq2/amfKfv6vscaR8pa2rgWc/7u0HY4aGAVVES1uHQ0uRhR8c9bOy4BS9f+a5CHS0XRlPfLKkMliWb6Uwz/ccUISqqVWhLiLOUNmCmMJYEi/IgZHYITQo+mdcZ/Y8LtbeclTqQNngyNLaJraLbyK94FY5ubdsSoPOTyOJLfOjxHYrdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(36092001)(54906003)(186003)(33656002)(9686003)(66556008)(66446008)(7696005)(64756008)(66476007)(66946007)(55016002)(4326008)(8676002)(76116006)(8936002)(52536014)(7416002)(5660300002)(2906002)(6506007)(316002)(53546011)(86362001)(71200400001)(110136005)(107886003)(478600001)(26005)(83380400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ef5rqBAYFR8J7/TtOi2Uh5NyUmigIpt5owqtwmGp9GE++PaNQ+UwbXiRopZ5VyYQlD0aiSONDRA/X/a/670/nPEIPao/p3GPjkZLwFqyrVZ49+sj6/WilJNFuCs4OEigsC6Sz/k4oFM/+w64+To36wrRX9x2/GyqcsJZ03iYN6Ux7UwNfrh2YqqsPrA4deJGv1zS1bQ3Si8CktRka8qNeV5ZcOkLq17xaMfDwGWHE9Jy47N7R4dwQVOi6vyu0gJRqiUfsBhq6gBbICeaHLjZBJkB/9ht+lWAZQIfB1NunzDTILofXmXZzzXywPTWD86NtyjmK99OhA53MJ1glZDt7K6zJ6SoqAnbH4aksMNUxDjZCUKWXJbgD41swOW3eMJzQdzN3SWj79urTZTmIwGiJB9yo5R6gP6pJwCKOZO1e05UGj4zGQOhEJwjEoGjMMtcSkEtUo1P91oEs4EqzNeI4zrSWVcU4CWU524U109NnvQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dab29f1-a552-4352-f379-08d823d6102a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 07:02:37.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaqQ7N24BvWvaxoPtg2FDxW/flzHs2NWxVybApWygAB5ybFscFtETqGB6qHYy1aW6Vw4bjfdFzCSCYbcDhberm4oA3TGxd0PM0GSF7siSEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6252
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_04:2020-07-08,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=765 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007090055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping requesting review comments.
https://lkml.org/lkml/2020/5/26/507

Thanks & regards,
Swapnil

> -----Original Message-----
> From: Yuti Amonkar <yamonkar@cadence.com>
> Sent: Tuesday, May 26, 2020 8:05 PM
> To: linux-kernel@vger.kernel.org; kishon@ti.com; robh+dt@kernel.org;
> mark.rutland@arm.com; maxime@cerno.tech
> Cc: nsekhar@ti.com; jsarha@ti.com; tomi.valkeinen@ti.com;
> praneeth@ti.com; Milind Parab <mparab@cadence.com>; Swapnil Kashinath
> Jakhade <sjakhade@cadence.com>; Yuti Suresh Amonkar
> <yamonkar@cadence.com>
> Subject: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY
> framework
>=20
> This patch series adds support to use kernel PHY subsystem APIs to get/se=
t
> PHY attributes like number of lanes and maximum link rate.
>=20
> It includes following patches:
>=20
> 1. v2-0001-phy-Add-max_link_rate-as-a-PHY-attribute-and-APIs.patch
> This patch adds max_link_rate as a PHY attribute along with a pair of API=
s
> that allow the generic PHY subsystem to get/set PHY attributes supported =
by
> the PHY.
> The PHY provider driver may use phy_set_attrs() API to set the values tha=
t
> PHY supports.
> The controller driver may then use phy_get_attrs() API to fetch the PHY
> attributes in order to properly configure the controller.
>=20
> 2. v2-0002-phy-phy-cadence-torrent-Use-kernel-PHY-API-to-set.patch
> This patch uses kernel PHY API phy_set_attrs to set corresponding PHY
> properties in Cadence Torrent PHY driver. This will enable drivers using =
this
> PHY to read these properties using PHY framework.
>=20
> The phy_get_attrs() API will be used in the DRM bridge driver [1] which i=
s in
> process of upstreaming.
>=20
> [1]
>=20
> https://lkml.org/lkml/2020/2/26/263
>=20
> Version History:
>=20
> v2:
>     - Implemented single pair of functions to get/set all PHY attributes
>=20
> Swapnil Jakhade (1):
>   phy: phy-cadence-torrent: Use kernel PHY API to set PHY attributes
>=20
> Yuti Amonkar (1):
>   phy: Add max_link_rate as a PHY attribute and APIs to get/set
>     phy_attrs
>=20
>  drivers/phy/cadence/phy-cadence-torrent.c |  7 +++++++
>  include/linux/phy/phy.h                   | 25 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> --
> 2.17.1


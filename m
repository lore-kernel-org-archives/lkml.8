Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB95C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64883206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sNdAiMY8";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SGCNdQoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgD3OGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:06:39 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48689 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD3OGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:06:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UE3QPH006223;
        Thu, 30 Apr 2020 07:06:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=/Aap5ApsY2nOR8APcT/0d2YS+nIX/4NCR/jIeoMHNk0=;
 b=sNdAiMY89yxdD/55KceclDbhFOSQVUOI2vkFIV1lbXN06crPxkDfcSdGCul107Y27NKb
 W/Ur16V1vUkWAN2KOZ0r0QEOkbAZDE1P2sIOi7/Ugqx2K4TD5KGuMaQ2x0OsdCKN5c59
 AlJ+iXVvsV2+elotI3w3VNE5n8XdAVP0KIJ7Mu2TVpWHYvxTJb2BawPpepV6dMFscylj
 hIUNPagToGQ7UTvlwzq48Jxh7avjy4jPpHduAWhS5fz0N0IkF+TvpFpmH/oGtlDLROXI
 Oxcbfue/v/F7b0j3KUVfm+/BFY0+HzR9+1jaSR34zfCK7RnlTGT2zcVW8Xi/vP3XT5OF uw== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30mhywx1nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQS7onQmqhLrQQIbtgkgTGn72bw9E8nO0YqUMGyxUr1uwrZSgc9/L60vzpCWZ+5uhWotlk459ZIEl0akOCyGn7UdfQjtDbUf15R0D98qfZcB7dThrEv4DZ/FeoX8HA2hYo9v2JWqmnQkefXWGKwunRTYZNNC40TqMAnmVwcugOrN3CbJceGKaB1S6+63zzJoeyFIRBJcssXycQTTb+IznDuvZmlB2p5/ndebFgOQovyn6QxkO0cWeNdv3UfZJ4XLORGlY4th3gbQgAzR9NyCpsX2A9YNB24GW9cO3vA9lK76FQzh9CKdPuYKZFgcE7aNy+QkE0u3RF98DLygnSBNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Aap5ApsY2nOR8APcT/0d2YS+nIX/4NCR/jIeoMHNk0=;
 b=aUZz6i2LXaci0pLb9zSeFa/89OcPIgKQKXaNhhDt2ARkg5xNVu2w2O/bcmv+CO1x8wZuj2FbiVobIB79qCC8f8wIj9SOjbLJT/H272PD5LvXL1XmOqZ1EqUg5oiFEB8VGTrpGqh+tRS41uTFuk0uLu8twCZ4mQoDeY97OsbADi+4z/MLmmgzTtqPud+kJsWPg+/jZfbB90bwxs0fIfEOj0c0xOQ1Tn+Ja7NSSmcd1AsIOgk6Sxvp0JmYEC4h/A99dPf15O3WlF9ubzcObhTE4ASfviA17bflHrPwz8WLcQ7LpMsMvku3DXes51H8n7IMHdTci/H+3xNBzwh32iig0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Aap5ApsY2nOR8APcT/0d2YS+nIX/4NCR/jIeoMHNk0=;
 b=SGCNdQoUlVo0s/1Exh94SC1TUxlEyM+munRkmlXnp6V/dPpai6w7VPsnjfdYFITIO80Ya5gYA2OzC2QYj95H19Ks+p8YMNW9l++w6E67f8lKOLVzZmalcHAWrFx6WrdjX6Wpt0Lcb0e+eBCjPbyWumNPO7vGzX0fK35KDs21Mo8=
Received: from BY5PR07MB6982.namprd07.prod.outlook.com (2603:10b6:a03:1ec::13)
 by BY5PR07MB7045.namprd07.prod.outlook.com (2603:10b6:a03:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 14:06:21 +0000
Received: from BY5PR07MB6982.namprd07.prod.outlook.com
 ([fe80::30bd:728e:27db:1c5d]) by BY5PR07MB6982.namprd07.prod.outlook.com
 ([fe80::30bd:728e:27db:1c5d%4]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 14:06:20 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Thread-Topic: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Thread-Index: AQHWHSwc1RgU1BkduE6GLxxNwyDKs6iQCNkAgAGpv0A=
Date:   Thu, 30 Apr 2020 14:06:20 +0000
Message-ID: <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
 <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
In-Reply-To: <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMmFmNDBlZC04YWViLTExZWEtODUxNi1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcYzJhZjQwZWUtOGFlYi0xMWVhLTg1MTYtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzNjI2IiB0PSIxMzIzMjcyOTE3ODcxMTAyNDEiIGg9IlVtVHNIa09sUzBSNHpWSWtSbVA1UWJ5WS9Qcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: cerno.tech; dkim=none (message not signed)
 header.d=none;cerno.tech; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 098c5dea-22b2-41d1-c7a3-08d7ed0fa8e0
x-ms-traffictypediagnostic: BY5PR07MB7045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB70452FC73EBECE7759220E1CC5AA0@BY5PR07MB7045.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB6982.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(36092001)(8676002)(55016002)(316002)(5660300002)(110136005)(26005)(71200400001)(9686003)(54906003)(186003)(86362001)(8936002)(33656002)(2906002)(4326008)(66476007)(76116006)(66446008)(66946007)(478600001)(66556008)(107886003)(64756008)(6506007)(7696005)(966005)(52536014)(53546011)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6lxKsWLf8nZyfwZx2yyPefqPejy4sI7QFcf2ni5pBLzbcBxv1UatvJJImWstf6Hbjz+YtfHoozTyCmUSD5/+tvRBGTd4rAbcAhHsECmVzj6hf5/L/Nhd8q3Mb8lN05ixjVTmaFaUMq2yfJ1ZOaoO/0B4BsQv8suQx7rlifogGVkNU+gwOzQuIm1RcOk91DWQEi3J8OViK//KmsRjD3rq/A8KS4OMdypn9sih+9J0FjjXC9pX1D9GxneAhOSFTB/TJmVWNuItvtwCsaWlWesdr6OPvsVlhqT2k1kbJw73s2iMSJYUTaZZmVUIAF7jtyZDSBukG48vIMlj4Myiw09uKufh45GOIlgwA9eMsbg84wvBF5T6yq9aGYhVeI410tQpiVrKsv1+arFPvJWYWc+9IeKhFrPRsqj29PKf3w7fTYz/GJVLHdtCAw/5Ml1ZVVtzxpbwYhUPh6R9qA1+64XA0qv+LW0Qqso7X7dWN9DVLrU6bUX4lQn8OCIumJWj9uitxS3R7Nl7KF6hyfLslvHymOM4MyON92BSy2ayrhlpYjvieJzoiBPpig30kAKzdYl2Bv41lK628oXjS8wBIpGPA==
x-ms-exchange-antispam-messagedata: OwOGsrQFoJKcgl46VuR5RZJNTl/iepsV9PxA+F7wmLlrzKmkHbftMK3M3Or4Lc5tBh1in72640TjvAkmh84mvvZHdeblTPZU1kpAhkBlQQNZWo6j+hWK3ATpc0h4VtvVg7gUWB179ZYqXJzTjWZyE64twVJtRv7o8wFDf02gBPvV0z0gJHeEZbAl+rJKBA04IdHZYaHA7EdUX/pbd+MUVXM2e9h47l4bJyIlpBbUOz6DF2j3iKtrlrUpBviW2WL66r8IeQtXYEzlVzCfHVbbXntXY8/tTSfofTXrZ1Dpw7bFRLFx6ORGNsfIvSFMI00CmAjgxx249oRqqSOyGX8+bpdGSwI0S4qjpSoNuY1FTkAgCUdzBZEkcMAo8sKpyc5SxMoV/h+EkPv5JfmyiZ+hoxw9/E8BGdYdhcB1WNxv2Aww1VGuUmEAoS3kujD02EFPYxgVBVPg0yeFRRD8ysSUil8EkIx7Clbo5JNHTF8MKe9OBszKRUADqY5K9IRxjxIXX8p3GPowRE1MNeQbhy+VMAI4iqm9KDYzGmUkJaFEIPq5meEBw0tfpIvxs0GrMu12o6O8OycOKNNUzSVbgqYfUQUWHozyt5ocIigTWBaQN97dPafaq8WJEmoEiO1gukWAMinlepBX96YoaKUMpl0tpbvYWdLZYzzQhyko7MaagPqUlPRxktUVMoczpRNb+jH6GRqanOWRx+GI6kAt9vLcotFlSR0wKO+4RH170dXkq8aYcUTn4LS+/0SRtp61kt9begVMmbL15G3aPfwU5KkOCyxaD3cTRx2YPqs9w0GJWS4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c5dea-22b2-41d1-c7a3-08d7ed0fa8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 14:06:20.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCAHWygr8O33NPReZHiaxGqSywR7mbIx09J9wuKOwaWI9CiEiRut+yGfSQo44WnFNajJqk5Zl9HAZtRJv8DqW92bGfBOZG5TyWKErRQoqW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7045
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_09:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you so much for reviewing the patch. Please see inline reply below.

> -----Original Message-----
> From: Maxime Ripard <maxime@cerno.tech>
> Sent: Wednesday, April 29, 2020 5:58 PM
> To: Yuti Suresh Amonkar <yamonkar@cadence.com>
> Cc: linux-kernel@vger.kernel.org; kishon@ti.com; mark.rutland@arm.com;
> jsarha@ti.com; tomi.valkeinen@ti.com; praneeth@ti.com; Milind Parab
> <mparab@cadence.com>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs=
 to
> set PHY attributes
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi,
>=20
> On Tue, Apr 28, 2020 at 09:10:04AM +0200, Yuti Amonkar wrote:
> > From: Swapnil Jakhade <sjakhade@cadence.com>
> >
> > Use generic PHY framework function phy_set_bus_width() to set number
> > of lanes and function phy_set_max_link_rate() to set maximum link rate
> > supported by PHY.
> >
> > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
>=20
> This should have your SoB.
>=20
> > ---
> >  drivers/phy/cadence/phy-cadence-torrent.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> > index 7116127358ee..b914e5ddf93c 100644
> > --- a/drivers/phy/cadence/phy-cadence-torrent.c
> > +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> > @@ -1852,6 +1852,9 @@ static int cdns_torrent_phy_probe(struct
> platform_device *pdev)
> >  				 cdns_phy->phys[node].num_lanes,
> >  				 cdns_phy->max_bit_rate / 1000,
> >  				 cdns_phy->max_bit_rate % 1000);
> > +
> > +			phy_set_bus_width(gphy, cdns_phy-
> >phys[node].num_lanes);
> > +			phy_set_max_link_rate(gphy, cdns_phy-
> >max_bit_rate);
>=20
> I think what Kishon meant in his previous mail is that it's not really cl=
ear (to
> me at least) how that function would be useful.
>=20
> In this particular case, what would the consumer make of that information=
?
> Does
> the phy needs to be reconfigured based on the max rate being changed?
>=20
> Some phy_configure_opts structures also have a somewhat similar field tha=
t
> can
> be negociated between the provider and the consumer using phy_validate,
> wouldn't
> that be redundant?
>=20
> Most of that discussion can only happen when you've provided a use-case
> for that
> series, so a consumer using it would help greatly there.

Actually, for this particular case, consumer driver will be the Cadence MHD=
P bridge driver
for DisplayPort which is also under review process for upstreaming [1]. So =
this DRM bridge
driver will make use of the PHY APIs phy_get_bus_width() and phy_get_max_li=
nk_rate()
during execution of probe function to get the number of lanes and maximum l=
ink rate
supported by Cadence Torrent PHY. This information is required to set the h=
ost capabilities
in the DRM bridge driver, based on which initial values for DisplayPort lin=
k training will be
determined.
The changes in this PHY patch series are based on suggestions in the review=
 comments in [1]
which asks to use kernel PHY APIs to read these properties instead of direc=
tly accessing PHY
device node. The complete driver and actual use of these APIs can be found =
in [2]. This is how
we are planning to use these APIs.

[1]
https://patchwork.freedesktop.org/patch/355362/?series=3D73996&rev=3D1

[2]
https://github.com/t-c-collab/linux/blob/cdns-mhdp-upstream/drivers/gpu/drm=
/bridge/cdns-mhdp-core.c#L1594

Thanks & regards,
Swapnil

>=20
> Maxime

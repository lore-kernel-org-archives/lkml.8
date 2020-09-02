Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF5DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92862087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rqqa7Rw5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MP8rwBcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBHJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:09:38 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25460 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgIBHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:09:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08278kYh011220;
        Wed, 2 Sep 2020 00:09:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=YPp8zxBqsaPsQeFeS+ITz1z33ZUox5SCypu7V4HFkSU=;
 b=rqqa7Rw5MhCzU8R0ENUWeAu9za1B3Tt6fAaPbpdGDMvA9rY03pzt9Wa0jC9V79J6ruS/
 HSO/NP93j3/cuc/cA0fzWUVqeh3Z82m1/uJ14oAjYNgNyE00Td3JAQzjkeXbxLv3FgTt
 nXzYJET24nXRv/IrY6e4nYGWr0p/aDUDs9EAnHAIVja8DPiSa/q9zXrC6APGvdeY08D5
 n/nIvrayOC+m29kHEuTJskt8WwcEr463+tRRcnMG6lNtIhd7rmWUCtXC5ye0VSuV8jIB
 cZA6N24xLIeyjkH4CrvjBks/bxqFe5AxRbG47T2wDownMDuRvOAOb8Vc0T2HKeGhVvTb xA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 337jkwf07u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR+sgD92XBaYsZxysOfw4zgHU6k5RUMRlTj/cO/8HxSyUn1k7gks7t4GrjC6MoMjfYhSYSE+FVunCcGtGTRByyDQNEV8SXCfvSuuvPnTxF6sC55L+2Wi/jdwcBvSbbQHavuSRTgWBZKGqKs5bFFrRE1aR8ErttEttv3MtTfk3iwLGL9muObTwQomG1JxgMyeTkqtiZDnzzZoS8U7Sqapu8q4h9UjHPFD7PLFSBa24brnhm5fSyseMlh/1JZIzyEjzvVTJsDveOP7C4QdcX6SljK8lY5rvnFEyeRMHi4uuZDX0I+qk+FYl4LWAFbvDbn1piBQOS9U5SXJVHv4s3yTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPp8zxBqsaPsQeFeS+ITz1z33ZUox5SCypu7V4HFkSU=;
 b=Nkx1V5jkPK2mNYmykGyK1fmnd+ZyfxMFL+CYCFwn6FKtfSTBZlRBbgwEiQNvtirRX0Hdx+Oj6iI6dntqGwydti8ZIKIBRajoNF39YeGYIP0hO2xrpMEsnie6Cf+mhQVvJ1D3fzma0r5+OkpCEE08IqqbxG9W1Dkww4a2IdR8WfStvFTqzyt82sewXo3LJI10bH4MxcDx8V106hhI2vq7GixoqyvgGTHGLy4qL4TRM0Mi3WdljCQDQTkPcWnOg5XROX83o5MqN+KTqueDHcZIQGEdV7xeQLrZbx6RtW57iZAZGx0U+TILwtQ/EQ7nKXEK6RRVGOAQALp8nY2wH0aSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPp8zxBqsaPsQeFeS+ITz1z33ZUox5SCypu7V4HFkSU=;
 b=MP8rwBcExHuSm6OJzZcS2GzfwmC/ZWemEEOUI38b6pRsH14L/3nxamd060FHUrf+th0L5gK279x6baFEX3jfxxlNwTzKcbR2AArn29f6NaMySBcYj9K/cJ1IMBQR5Z/lphFgn9IBSVl1syYH1/VIg3dzfzI4AlLCuHFCj1dkpZw=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM5PR07MB3002.namprd07.prod.outlook.com (2603:10b6:3:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:09:21 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 07:09:21 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Topic: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Index: AQHWekRjWakk5bsmRUWo+B0jwwHPTalUi9QAgABtITA=
Date:   Wed, 2 Sep 2020 07:09:21 +0000
Message-ID: <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
In-Reply-To: <20200902002956.GE14351@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zNjQ1ZjYxNi1lY2ViLTExZWEtODUyOS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcMzY0NWY2MTctZWNlYi0xMWVhLTg1MjktYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzNTE4IiB0PSIxMzI0MzUwNDE1NzA3MjY3NzYiIGg9InI1eWRvWDNDejZNcXZneElRWVhxQnF4ZnlBbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c3ba6ea-8a9f-41d2-8a77-08d84f0f1ddb
x-ms-traffictypediagnostic: DM5PR07MB3002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB30027316BF1E9409FB0F759CC52F0@DM5PR07MB3002.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjKhOPGs8AUqliYkLQJ4JZgTbTW6KoA8cNfAt1qAwPVPanHEnlmZo35BeyNWJGcgBnh04iEezPawKMMWjtPr9ol9GkxsxhEUe4ZUDW73TkQ4qlc2eCopQKjmlYPrGr9yTUm5YuT+qUYPYwKzHywq6EHX/3ohcBMQTj2ferAhHU3hFlCCeiXCIa1nB/jvEurUAEuebkCdqOGVqY5Xg1t6IeSXAjAvGbAAVYxcQiQ4u18CwoL8LIUMvAWwTwwc9EcFZyI/a+0S5aZ7SaK6v6RElDYwm/Peh3NGvobWP/2RoLHB8sa0CoUj8Aep0OFa7RdCqpzinGJBilXNMxDnct/1fyQwEqddbrmSVjr1xIEmuHgBz1BaNStZYrtclLle22C3X0IXAzWOgJuPQXFT54wQgt/tRh0iU3fvPQ6/zJtzScrRe1431Dz+Yq5PZfGE8zq5ByQtIKYBYuHfN+aQU0apiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(36092001)(7696005)(52536014)(6506007)(64756008)(316002)(9686003)(66556008)(76116006)(66476007)(5660300002)(4326008)(53546011)(33656002)(71200400001)(66946007)(966005)(66446008)(26005)(8936002)(83380400001)(8676002)(55016002)(186003)(2906002)(6916009)(54906003)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ReF60O22BiGLkAajzkX7wRRnwsNrcxw9orX2Ef5hGzQ8wKCOnOs6vCclB2VlvYQmId3nD8cku0O7LdMlvD2GgA0Ty01McKwZUg0vcQgK2ncdvIo4JTa81UYCN3AG+ePU0L+TORvWhWfS3xGr4MLpAY64kazY0aRnHHpcFvxZpjhScucJGXlLYlzj7LtkcJvdG1IxIsmcdEE0lxtuILPobTGvk17m+ixo7uiwvaJGXq/iwvd+g1pGUMXvE3Hom/0pe3nOsFs3b4xYA+BGdj+6dZjtoUuufpDsTowS40zm3/s9qq0xw4FO2g2u/nR4peMrwLnjHYzVYTVh4IbideibYGm79LCuhTaZTFki5o8ZZqrAnw5Rpld42xg1QqiMAMZLgK6Nnn/L93ZKV25l6fJ9nifq/20WTIss7P+YODBjZNB9MA61QAytSUIgADZ2H/7lAM5w9C+nyc0hATISlclOmwCFQhEu21IDUom97fmbYANqhoczpsVymP5EyQqXMVLcpfMInREN9BLVBpohbZXE7ZoEXwFWzSbyCpAVR2Dkds2EKzEypAUvreBJOvSCdSs/Zo2v66GQocVFWdpfxgNOfT5wqb242qVJuWR4/WGxXsEDVvBkVGX3IlwgtvuQRQS6nI7AsXFMksF7AWaCmAO71A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3ba6ea-8a9f-41d2-8a77-08d84f0f1ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:09:21.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvDGuhOHgzmkuIvzN5ZrUsYCTaV7SVkaKZZ+azTFeFh4XZf8G35kiVgEQbPG9FHb5jUjC2vUEUMIdGtSucXtxZWpopdh+iGP10CnmR4flFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVy
ZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDIsIDIwMjAgNjowMCBBTQ0KPiBUbzogU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZSA8c2ph
a2hhZGVAY2FkZW5jZS5jb20+DQo+IENjOiB2a291bEBrZXJuZWwub3JnOyBraXNob25AdGkuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtYXhpbWVAY2Vybm8udGVjaDsgTWls
aW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBZdXRpIFN1cmVzaA0KPiBBbW9ua2FyIDx5
YW1vbmthckBjYWRlbmNlLmNvbT47IG5zZWtoYXJAdGkuY29tOw0KPiB0b21pLnZhbGtlaW5lbkB0
aS5jb207IGpzYXJoYUB0aS5jb207IHByYW5lZXRoQHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDIvMl0gcGh5OiBjYWRlbmNlLXRvcnJlbnQ6IFVzZSBrZXJuZWwgUEhZIEFQSSB0byBz
ZXQNCj4gUEhZIGF0dHJpYnV0ZXMNCj4gDQo+IEVYVEVSTkFMIE1BSUwNCj4gDQo+IA0KPiBIaSBT
d2FwbmlsLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQo+IA0KPiBPbiBNb24sIEF1
ZyAyNCwgMjAyMCBhdCAwODoyODozMVBNICswMjAwLCBTd2FwbmlsIEpha2hhZGUgd3JvdGU6DQo+
ID4gVXNlIGdlbmVyaWMgUEhZIGZyYW1ld29yayBmdW5jdGlvbiBwaHlfc2V0X2F0dHJzKCkgdG8g
c2V0IG51bWJlciBvZg0KPiA+IGxhbmVzIGFuZCBtYXhpbXVtIGxpbmsgcmF0ZSBzdXBwb3J0ZWQg
YnkgUEhZLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3dhcG5pbCBKYWtoYWRlIDxzamFraGFk
ZUBjYWRlbmNlLmNvbT4NCj4gPiBBY2tlZC1ieTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lz
aG9uQHRpLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5j
ZS10b3JyZW50LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVu
Y2UtdG9ycmVudC5jDQo+ID4gYi9kcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNlLXRvcnJl
bnQuYw0KPiA+IGluZGV4IDcxMTYxMjczNThlZS4uZWNhNzE0NjdjNGE4IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVuY2UtdG9ycmVudC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5jZS10b3JyZW50LmMNCj4gPiBAQCAtMTcxMCw2
ICsxNzEwLDcgQEAgc3RhdGljIGludCBjZG5zX3RvcnJlbnRfcGh5X3Byb2JlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgY2Ruc190b3JyZW50X3BoeSAqY2Ru
c19waHk7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAJc3Ry
dWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3ZpZGVyOw0KPiA+ICsJc3RydWN0IHBoeV9hdHRycyB0
b3JyZW50X2F0dHI7DQo+ID4gIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCj4g
PiAgCXN0cnVjdCBjZG5zX3RvcnJlbnRfZGF0YSAqZGF0YTsNCj4gPiAgCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqY2hpbGQ7DQo+ID4gQEAgLTE4NTIsNiArMTg1MywxMiBAQCBzdGF0aWMgaW50IGNkbnNf
dG9ycmVudF9waHlfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAg
CQkJCSBjZG5zX3BoeS0+cGh5c1tub2RlXS5udW1fbGFuZXMsDQo+ID4gIAkJCQkgY2Ruc19waHkt
Pm1heF9iaXRfcmF0ZSAvIDEwMDAsDQo+ID4gIAkJCQkgY2Ruc19waHktPm1heF9iaXRfcmF0ZSAl
IDEwMDApOw0KPiA+ICsNCj4gPiArCQkJdG9ycmVudF9hdHRyLmJ1c193aWR0aCA9IGNkbnNfcGh5
LQ0KPiA+cGh5c1tub2RlXS5udW1fbGFuZXM7DQo+ID4gKwkJCXRvcnJlbnRfYXR0ci5tYXhfbGlu
a19yYXRlID0gY2Ruc19waHktDQo+ID5tYXhfYml0X3JhdGU7DQo+ID4gKwkJCXRvcnJlbnRfYXR0
ci5tb2RlID0gUEhZX01PREVfRFA7DQo+ID4gKw0KPiA+ICsJCQlwaHlfc2V0X2F0dHJzKGdwaHks
ICZ0b3JyZW50X2F0dHIpOw0KPiANCj4gV2h5IGlzIHRoaXMgYmV0dGVyIHRoYW4gYWNjZXNzaW5n
IHRoZSBhdHRyaWJ1dGVzIG1hbnVhbGx5IGFzIGZvbGxvd3MgPw0KPiANCj4gCQkJZ3BoeS0+YXR0
cnMuYnVzX3dpZHRoID0gY2Ruc19waHktDQo+ID5waHlzW25vZGVdLm51bV9sYW5lczsNCj4gCQkJ
Z3BoeS0+YXR0cnMubWF4X2xpbmtfcmF0ZSA9IGNkbnNfcGh5LQ0KPiA+bWF4X2JpdF9yYXRlOw0K
PiAJCQlncGh5LT5hdHRycy5tb2RlID0gUEhZX01PREVfRFA7DQo+IA0KPiBUaGlzIGlzIGNhbGxl
ZCBpbiBjZG5zX3RvcnJlbnRfcGh5X3Byb2JlKCksIGJlZm9yZSB0aGUgUEhZIHByb3ZpZGVyIGlz
DQo+IHJlZ2lzdGVyZWQsIHNvIG5vdGhpbmcgY2FuIGFjY2VzcyB0aGUgUEhZIHlldC4gV2hhdCBy
YWNlIGNvbmRpdGlvbiBhcmUgeW91DQo+IHRyeWluZyB0byBwcm90ZWN0IGFnYWluc3Qgd2l0aCB1
c2FnZSBvZiBwaHlfc2V0X2F0dHJzKCkgPw0KDQpJIGFncmVlIHRoYXQgZm9yIENhZGVuY2UgRFAg
YnJpZGdlIGRyaXZlciBhbmQgVG9ycmVudCBQSFkgZHJpdmVyIHVzZSBjYXNlLCBpdA0Kd291bGQg
bm90IG1hdHRlciBldmVuIGlmIHdlIHNldCB0aGUgYXR0cmlidXRlcyBpbiBUb3JyZW50IFBIWSBk
cml2ZXIgaW4gYSB3YXkNCnlvdSBzdWdnZXN0ZWQgYWJvdmUuDQpCdXQgYXMgcGVyIHRoZSBkaXNj
dXNzaW9uIGluIFsxXSwgcGh5X3NldF9hdHRycy9waHlfZ2V0X2F0dHJzIEFQSXMgaW4gZnV0dXJl
IGNvdWxkDQptYXliZSB1c2VkIGJ5IG90aGVyIGRyaXZlcnMgcmVwbGFjaW5nIGV4aXN0aW5nIGlu
ZGl2aWR1YWwgZnVuY3Rpb25zIGZvciBhdHRyaWJ1dGVzDQpidXNfd2lkdGggYW5kIG1vZGUgd2hp
Y2ggYXJlIHBoeV9zZXRfYnVzX3dpZHRoL3BoeV9nZXRfYnVzX3dpZHRoIGFuZA0KcGh5X3NldF9t
b2RlL3BoeV9nZXRfbW9kZS4gU28gdGhpcyB1c2FnZSBpbiBUb3JyZW50IFBIWSBkcml2ZXIgaXMg
YW4gZXhhbXBsZQ0KaW1wbGVtZW50YXRpb24gb2YgdGhlIEFQSS4NCg0KWzFdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDIwLzUvMTgvNDcyDQoNClRoYW5rcyAmIHJlZ2FyZHMsDQpTd2FwbmlsDQoN
Cj4gDQo+ID4gIAkJfSBlbHNlIHsNCj4gPiAgCQkJZGV2X2VycihkZXYsICJEcml2ZXIgc3VwcG9y
dHMgb25seQ0KPiBQSFlfVFlQRV9EUFxuIik7DQo+ID4gIAkJCXJldCA9IC1FTk9UU1VQUDsNCj4g
DQo+IC0tDQo+IFJlZ2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNoYXJ0DQo=

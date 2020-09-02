Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641D9C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9622075D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DmzhOSIN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zClgkA/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBGxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:53:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7466 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgIBGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:53:07 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0826oraL020147;
        Tue, 1 Sep 2020 23:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=G3S5WBbX5nq6Tv+G6m8JyMC4GcP9fUEWP43K1uR12Mg=;
 b=DmzhOSIN2afW7rYjqvOZImJd39EOCSm5GYDR+w+/g1yUzJF/8chfvuxj5NjFRFREkE+X
 3cZNzVcNuUaAKqrhjV+78Gs/J63LRRzgV0ImEI7bsQLLtxwkH0gDsZHwJUnDDG11QK82
 54rGKUGxmRzKAjLNs58hfuvHdVgU25mdGjAoC5gBDjTJW14lldMFrYaB4smnbsY39s6F
 JBq9Obfd8L2thDUeUiboRvWH+oZ1/n+RclDoQLtN8ZXwQ4hwp1bYKjKb1htbl2B21h6w
 7cP4Av18z+afniY5N1a4d2BRqbwMKD/BaihLI7avwepX5u54AOWuwHCSGZUB8k8mixDj 2g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-0014ca01.pphosted.com with ESMTP id 337jkwexx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 23:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1ALli4ouiQwLuwigrlwPvIxeW4uZpNyP1wI7si7fGKejunWeXbhCajwirvv9ST2a5vgsHo2JGQXzS68JoIXOgzolA65ysnJ7mrK1Oh+nCKKcmx0roES0rnuXzECevz51LUhosNcfgzhglkunZVQpVGbU1mLEYjCXsV3b2NnsyBfOWkjCfbvMUrb7FlOOAYLGgjf2oL7QGJYBq9LntzdS/5vYEA+x9ht1SDfvYMfrIlnfqZv2z6hkWtLgdPO4D9XRrZfBGaZRkNQ8bZpMKZqf1EppRx3p7qfxepviuDoEsRP8gMb12dD1ait5mWJsIUzW082uE82ZDol1d7zy9e3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3S5WBbX5nq6Tv+G6m8JyMC4GcP9fUEWP43K1uR12Mg=;
 b=PBWoU8chjdxupxndlu+k/PPawpOmwU0Jz+6970JmS/LKmNpS/Tzc8bvFVwAT9L5asU4/yw+mfNOnDDLJlMSUO6gQ7VaeP3ZAMNhlpIfZA+GlEMQy38las+urS0CdHOzj9VxL3FK0S0ASYjFL76WjJDRC1gij8OzrBYnC8aodRc4OhJeoKDxfpD/00AKkSHLQVxa1hFfNIvOBzz76y7dfUhp2SYUjf6HMglx9yLyMJYF3gCm2ayZYy7yz9nW2rHYTWg7yDOoJ4O3O1qMX9rlSY5II6ar3kFeWdtVB3QaBR67GZ1KAipm8fhgb2LGfrjXX35WsKooAE4zWBYdShR4Trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3S5WBbX5nq6Tv+G6m8JyMC4GcP9fUEWP43K1uR12Mg=;
 b=zClgkA/1iuhXBrlhG7SeY+jBtw0WI9XFxi+RR/B0xtE5wvOIvH7yF8PfJSiweoYZkMQSdHr+V7tQU3zFx6KsJyKwBAzhWQsBSuhd7Ue1t0kOLoYvE6/MAz9lcXkDTZHDDC/ACDEpB4goyMEbJ/yYSbVeJf3bVSETKssvD2f1Lt8=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB5769.namprd07.prod.outlook.com (2603:10b6:5:33::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 06:52:52 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 06:52:52 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v5 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Thread-Topic: [PATCH v5 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Thread-Index: AQHWekRitBr9NbwtYEWDtKhZwLvfcKlUisQAgABpBlA=
Date:   Wed, 2 Sep 2020 06:52:52 +0000
Message-ID: <DM6PR07MB6154F083F7F1CB1368BC0FCCC52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-2-git-send-email-sjakhade@cadence.com>
 <20200902002608.GD14351@pendragon.ideasonboard.com>
In-Reply-To: <20200902002608.GD14351@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lODMzMzVlMy1lY2U4LTExZWEtODUyOS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZTgzMzM1ZTQtZWNlOC0xMWVhLTg1MjktYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI0OTcyIiB0PSIxMzI0MzUwMzE2NzEyNzkxNzgiIGg9Ik5TRm50dnE4bjV4UWVVTDhrNkd5ZG10aW11MD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e4c8710-7dd0-43c4-99ff-08d84f0cd02e
x-ms-traffictypediagnostic: DM6PR07MB5769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB5769CA792AD8D14686EDECD4C52F0@DM6PR07MB5769.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bhf8GGslFermDoW96a7R4cTc9S/RKTa2OfORV+Rue9Y4PqaidzB+0eOdUiMAEXmvC47QPcUbXXIWeNF1r9oqSlDwmGSGVd3teiQAuN/n3W1KK23i/UsfoEGim3Giguxt9RAhdu1D6KQJxIh2nV+/3hDOwwRDAmAPq8eWN022OhHB98F6GcKgK55Q5dcmSnYxxmQcLu87xiIDRBENVJ3Gn0SecSBsi7zBO4h8IygRod7fF1qlxqbyKvDCtFg8CbQFWRLv8Rs+6xjXHKsFncWbvcPUVkB/+KJEgphfk197OddjOuV7cKE6HjXtoBqsb9lqikF1YIbPfRTUjefkpwAyF9za8kVrnX3JeVnAsmvNGtUtfz3kYa8/d5Avtz63nf1/bHXXNCT/ODMZAW89K4RR3lcPu3Vxka+2dVokaqLnK5KLBd1rQMn42/XvgVAvUDMafGysEaNq0q6TluCBZ0QBfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(36092001)(83380400001)(66556008)(4326008)(478600001)(33656002)(8936002)(86362001)(7696005)(64756008)(186003)(6506007)(26005)(53546011)(316002)(55016002)(66946007)(76116006)(66446008)(54906003)(8676002)(71200400001)(2906002)(52536014)(5660300002)(9686003)(966005)(110136005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rcQ73fn0r4qH+6e560t53QdyAI0ul2Uc3MoXhppmue5u7dUMJNKSQPBE1l1NVJJp54c6MqDWYHKJSDDcsy+vQBUrXnvOz7VyR5hCT5f0rPN3Mx3DQ0Cp3DZF9loWj7007fM9KPNKPyIMpru80QvmWCRAHjARTGl7X0Vcaex9hYe6NRp+eE8GmckbERRWYJtHWBdswrBKUzgtmD0NUAtEp42P5Slw7zPp4yJJeUlbbwuuLCBVgLILJaJYIpRZrwRLoagIQWkgvU2GIyW2YDZdx4pWNLjXL2fzyx60KBanxyo0tFz8AzJnP2RO0fzAu+Hubf58NAt2bnGE59z3gdwVWPxwtqJW+SB1p5k670utNEw6ZV0o9t3Io4iwA6Td02PEAjPLsr3M50bJGl3ot+XL61gcUxbOWlBdT8qmim36kCwmUbgWQKJWlzURnvAB9FvFnVwkNeI3ajt1DG5a7jE/88cqLLz520JLNwHMTlk6aEAP0ORpxpto6gvgJ4/wBrNcl06QCBVRNZgLJrrV6bjFAY3tTDQe5fEtyZzS+o3b8FblX6Us5pr0DvZf3yxhSP/Ics0NuFL3bAoeTutrBgP1lV1iVlBJfsrLMbgVbeWlw1H4xtZE9gyulyDosTeGhGifwMFXrqxz3+tqpis4gprqEQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4c8710-7dd0-43c4-99ff-08d84f0cd02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 06:52:52.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UsFGpY6uzFpmmKLtIjKlllJD1wjbvrX29yZRop0T281kU8OBb6aXe9zlyOzwo3WBSYQvVxiaBYpwOExwk/3CV1aLjEqolDac/rsZslL1VL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5769
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVy
ZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDIsIDIwMjAgNTo1NiBBTQ0KPiBUbzogU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZSA8c2ph
a2hhZGVAY2FkZW5jZS5jb20+DQo+IENjOiB2a291bEBrZXJuZWwub3JnOyBraXNob25AdGkuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBtYXhpbWVAY2Vybm8udGVjaDsgTWls
aW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBZdXRpIFN1cmVzaA0KPiBBbW9ua2FyIDx5
YW1vbmthckBjYWRlbmNlLmNvbT47IG5zZWtoYXJAdGkuY29tOw0KPiB0b21pLnZhbGtlaW5lbkB0
aS5jb207IGpzYXJoYUB0aS5jb207IHByYW5lZXRoQHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDEvMl0gcGh5OiBBZGQgbmV3IFBIWSBhdHRyaWJ1dGUgbWF4X2xpbmtfcmF0ZSBhbmQN
Cj4gQVBJcyB0byBnZXQvc2V0IFBIWSBhdHRyaWJ1dGVzDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+
IA0KPiANCj4gSGkgU3dhcG5pbCwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiAN
Cj4gT24gTW9uLCBBdWcgMjQsIDIwMjAgYXQgMDg6Mjg6MzBQTSArMDIwMCwgU3dhcG5pbCBKYWto
YWRlIHdyb3RlOg0KPiA+IEFkZCBuZXcgUEhZIGF0dHJpYnV0ZSBtYXhfbGlua19yYXRlIHRvIHN0
cnVjdCBwaHlfYXR0cnMuDQo+ID4gQWRkIGEgcGFpciBvZiBQSFkgQVBJcyB0byBnZXQvc2V0IGFs
bCB0aGUgUEhZIGF0dHJpYnV0ZXMuDQo+ID4gVXNlIHBoeV9nZXRfYXR0cnMoKSB0byBnZXQgYXR0
cmlidXRlIHZhbHVlcyBhbmQgcGh5X3NldF9hdHRycygpIHRvIHNldA0KPiA+IGF0dHJpYnV0ZSB2
YWx1ZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdXRpIEFtb25rYXIgPHlhbW9ua2FyQGNh
ZGVuY2UuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN3YXBuaWwgSmFraGFkZSA8c2pha2hhZGVA
Y2FkZW5jZS5jb20+DQo+ID4gQWNrZWQtYnk6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hv
bkB0aS5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oIHwgNDMNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvcGh5L3BoeS5oIGIvaW5jbHVkZS9saW51eC9waHkvcGh5LmggaW5kZXgNCj4gPiBiY2Vl
OGViYTYyYjMuLjkyNGNkMWEzZGVlYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Bo
eS9waHkuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4gQEAgLTExNSwx
MCArMTE1LDEyIEBAIHN0cnVjdCBwaHlfb3BzIHsNCj4gPiAgLyoqDQo+ID4gICAqIHN0cnVjdCBw
aHlfYXR0cnMgLSByZXByZXNlbnRzIHBoeSBhdHRyaWJ1dGVzDQo+ID4gICAqIEBidXNfd2lkdGg6
IERhdGEgcGF0aCB3aWR0aCBpbXBsZW1lbnRlZCBieSBQSFkNCj4gPiArICogQG1heF9saW5rX3Jh
dGU6IE1heGltdW0gbGluayByYXRlIHN1cHBvcnRlZCBieSBQSFkgKGluIE1icHMpDQo+ID4gICAq
IEBtb2RlOiBQSFkgbW9kZQ0KPiA+ICAgKi8NCj4gPiAgc3RydWN0IHBoeV9hdHRycyB7DQo+ID4g
IAl1MzIJCQlidXNfd2lkdGg7DQo+ID4gKwl1MzIJCQltYXhfbGlua19yYXRlOw0KPiA+ICAJZW51
bSBwaHlfbW9kZQkJbW9kZTsNCj4gPiAgfTsNCj4gPg0KPiA+IEBAIC0yMzEsNiArMjMzLDM3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBwaHlfc2V0X2J1c193aWR0aChzdHJ1Y3QgcGh5DQo+ID4gKnBo
eSwgaW50IGJ1c193aWR0aCkgIHsNCj4gPiAgCXBoeS0+YXR0cnMuYnVzX3dpZHRoID0gYnVzX3dp
ZHRoOw0KPiA+ICB9DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogcGh5X2dldF9hdHRycygpIC0g
Z2V0IHRoZSB2YWx1ZXMgZm9yIFBIWSBhdHRyaWJ1dGVzLg0KPiA+ICsgKiBAcGh5OiB0aGUgcGh5
IGZvciB3aGljaCB0byBnZXQgdGhlIGF0dHJpYnV0ZXMNCj4gPiArICogQGF0dHJzOiBjdXJyZW50
IFBIWSBhdHRyaWJ1dGVzIHRoYXQgd2lsbCBiZSByZXR1cm5lZA0KPiA+ICsgKg0KPiA+ICsgKiBJ
bnRlbmRlZCB0byBiZSB1c2VkIGJ5IHBoeSBjb25zdW1lcnMgdG8gZ2V0IHRoZSBjdXJyZW50IFBI
WQ0KPiA+ICthdHRyaWJ1dGVzDQo+ID4gKyAqIHN0b3JlZCBpbiBzdHJ1Y3QgcGh5X2F0dHJzLg0K
PiA+ICsgKi8NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIHBoeV9nZXRfYXR0cnMoc3RydWN0IHBo
eSAqcGh5LCBzdHJ1Y3QgcGh5X2F0dHJzDQo+ID4gKyphdHRycykgew0KPiA+ICsJbXV0ZXhfbG9j
aygmcGh5LT5tdXRleCk7DQo+ID4gKwltZW1jcHkoYXR0cnMsICZwaHktPmF0dHJzLCBzaXplb2Yo
c3RydWN0IHBoeV9hdHRycykpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZwaHktPm11dGV4KTsNCj4g
DQo+IFdoeSBpcyB0aGUgbXV0ZXggcmVxdWlyZWQsIHdoYXQgZG9lcyBpdCBndWFyZCBhZ2FpbnN0
ID8NCg0KTXV0ZXggcHJvdGVjdGlvbiBpcyBhZGRlZCBpbiBwaHlfZ2V0X2F0dHJzL3BoeV9zZXRf
YXR0cnMgQVBJcyBiYXNlZCBvbg0KcmV2aWV3IGNvbW1lbnRzIGZyb20gS2lzaG9uIGZvciB2MyBv
ZiB0aGlzIHBhdGNoIHNlcmllc1sxXS4NCkFsc28sIHBsZWFzZSBmaW5kIGJlbG93IHJlZmVyZW5j
ZXMgdG8gZWFybGllciB2ZXJzaW9ucyBvZiB0aGlzIHBhdGNoIHNlcmllcw0KYW5kIHRoZSBkaXNj
dXNzaW9ucyB3aGljaCBhcmUgdGhlIGJhc2lzIGZvciBpbXBsZW1lbnRhdGlvbiBpbiB2NSBvZiB0
aGlzDQpwYXRjaCBzZXJpZXMuDQoNCnYxIG9mIHRoZSBzZXJpZXMgY2FuIGJlIGZvdW5kIEAgWzJd
DQp2MiBvZiB0aGUgc2VyaWVzIGNhbiBiZSBmb3VuZCBAIFszXQ0KdjMgb2YgdGhlIHNlcmllcyBj
YW4gYmUgZm91bmQgQCBbNF0NCnY0IG9mIHRoZSBzZXJpZXMgY2FuIGJlIGZvdW5kIEAgWzVdDQoN
ClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzEzLzUyOQ0KDQpbMl0gaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMjAvNC8yOC8xNDANCg0KWzNdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDIwLzUvMjYvNTA3DQoNCls0XSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzEzLzM4MA0K
DQpbNV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8xNy8xNTgNCg0KPiANCj4gPiArfQ0K
PiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIHBoeV9zZXRfYXR0cnMoKSAtIHNldCBQSFkgYXR0cmli
dXRlcyB3aXRoIG5ldyB2YWx1ZXMuDQo+ID4gKyAqIEBwaHk6IHRoZSBwaHkgZm9yIHdoaWNoIHRv
IHNldCB0aGUgYXR0cmlidXRlcw0KPiA+ICsgKiBAYXR0cnM6IHRoZSAmc3RydWN0IHBoeV9hdHRy
cyBjb250YWluaW5nIG5ldyBQSFkgYXR0cmlidXRlcyB0byBiZQ0KPiA+ICtzZXQNCj4gPiArICoN
Cj4gPiArICogVGhpcyBjYW4gYmUgdXNlZCBieSBQSFkgcHJvdmlkZXJzIG9yIFBIWSBjb25zdW1l
cnMgdG8gc2V0IHRoZSBQSFkNCj4gPiArICogYXR0cmlidXRlcy4gVGhlIGxvY2tpbmcgaXMgdXNl
ZCB0byBwcm90ZWN0IHVwZGF0aW5nIGF0dHJpYnV0ZXMNCj4gPiArd2hlbg0KPiA+ICsgKiBQSFkg
Y29uc3VtZXIgaXMgZG9pbmcgc29tZSBQSFkgb3BzLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGlu
bGluZSB2b2lkIHBoeV9zZXRfYXR0cnMoc3RydWN0IHBoeSAqcGh5LCBjb25zdCBzdHJ1Y3QNCj4g
PiArcGh5X2F0dHJzICphdHRycykgew0KPiA+ICsJbXV0ZXhfbG9jaygmcGh5LT5tdXRleCk7DQo+
ID4gKwltZW1jcHkoJnBoeS0+YXR0cnMsIGF0dHJzLCBzaXplb2Yoc3RydWN0IHBoeV9hdHRycykp
Ow0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZwaHktPm11dGV4KTsNCj4gPiArfQ0KPiA+ICBzdHJ1Y3Qg
cGh5ICpwaHlfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqc3RyaW5nKTsgIHN0
cnVjdA0KPiA+IHBoeSAqcGh5X29wdGlvbmFsX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IGNoYXIgKnN0cmluZyk7ICBzdHJ1Y3QNCj4gPiBwaHkgKmRldm1fcGh5X2dldChzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IGNoYXIgKnN0cmluZyk7IEBAIC0zODksNg0KPiA+ICs0MjIsMTYgQEAg
c3RhdGljIGlubGluZSB2b2lkIHBoeV9zZXRfYnVzX3dpZHRoKHN0cnVjdCBwaHkgKnBoeSwgaW50
DQo+IGJ1c193aWR0aCkNCj4gPiAgCXJldHVybjsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBwaHlfZ2V0X2F0dHJzKHN0cnVjdCBwaHkgKnBoeSwgc3RydWN0IHBoeV9hdHRy
cw0KPiA+ICsqYXR0cnMpIHsNCj4gPiArCXJldHVybjsNCj4gDQo+IFlvdSBjYW4gZHJvcCB0aGUg
cmV0dXJuIHN0YXRlbWVudC4NCg0KT2theS4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIGlubGluZSB2b2lkIHBoeV9zZXRfYXR0cnMoc3RydWN0IHBoeSAqcGh5LCBjb25zdCBzdHJ1
Y3QNCj4gPiArcGh5X2F0dHJzICphdHRycykgew0KPiA+ICsJcmV0dXJuOw0KPiANCj4gSGVyZSB0
b28uDQoNCk9rYXkuDQoNClRoYW5rcyAmIHJlZ2FyZHMsDQpTd2FwbmlsDQoNCj4gDQo+ID4gK30N
Cj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IHBoeSAqcGh5X2dldChzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IGNoYXINCj4gPiAqc3RyaW5nKSAgew0KPiA+ICAJcmV0dXJuIEVSUl9Q
VFIoLUVOT1NZUyk7DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQaW5jaGFy
dA0K

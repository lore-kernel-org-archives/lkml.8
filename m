Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60200C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B883206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QajY32uw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="t8hMimx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHQKMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:12:00 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:2302 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgHQKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:11:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HA8hQC000456;
        Mon, 17 Aug 2020 03:11:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=4+PjhVGf5k1O8hK/zmokdV/jSPgL3SESrDR/KjkbqTI=;
 b=QajY32uwsf9G+f4IOpYDB1qZlVfndH5gfcdQRE2tnGk3qPRin7H8SvclWXhaoDOO8HGZ
 3o5DP17L1f1q9nbSkjllsEWs6RYg/o3F1ySKkNUHTOxoILM1FqR0BnkBABFzXZiD7q8s
 3T4mTdIZrOEqRjfnqU/wHJiXVzULkyWllT+LhEumBB+3tD8fTYO1C7sAi2C4W6EJ862a
 BjVtUP3zlXGq7mqID3OhFcn4I1O+7qmvi1j3ayTJHmieHAl9L2MhG6pxfSWA602i6CVI
 Nxsf1eXC5dh3FMexVr/slh4adxFtleaVPpssO3c+doh8bgK6V/Kl2XTZMhPnxdST1gfN Pg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32xba0dxgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 03:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezelrYhxn3cC+vWJls9pZOy6xt56iSACTTv1YoTO6Go15/FHl0o3F1iWjqBlhUBKgHGxshL5acxIn3XlP33jdA4bbpk/1IMgXp5FfvcvsKGzjqwNmsuvGBV/7OWwROmWI2CovRYlGzXwGMmE/XF08EadXTsdpmvHQdT5jteEwt7m7MPcdvnQDsUUpVlATAfyl2mCtrivblBZ03uyafS6VDRB00o5xnGo5Re12Q+ZzTIcB+CX8q5UKQO7kwHsbh1G/VkEzORLPwbzx21m6jJUtRlSPq9irSMVvVTnN23vkVPVaxYu+YA8o0HHrfPJa2sMVsbmP2FJXEUOsSreRG8OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+PjhVGf5k1O8hK/zmokdV/jSPgL3SESrDR/KjkbqTI=;
 b=WybigJpvXqgh/wKnn0Dbo4Xt3i+ATN3qGaRmlyNk8UEr4sB/C+HrtMdEYl5t70MFBq8Lbv50LTCqApEgUtrVxDMeemXygUvVKAoVBNd1Fj++rvDClSYCg6hpRI9yeMBNjmjvng1qKXSrVFVnmMyCOUf5u7FWz2vdIDoD/Qkn8mRYlR6Cha+sAxSylx70aEF5NzqUGfEfQx3qe7IGTg1AYxZilA6/bg7EKNOPyJaWHOHAm9W8QJ6OXl5AxT/DMHXRYtxICO4MEgP9ucPUPgjes5ndb4db5vrPx44wN1NYaxoTC7vjAjvsx25fbEQ/d6KYlQ3RvuA27OJlTVhoqtXNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+PjhVGf5k1O8hK/zmokdV/jSPgL3SESrDR/KjkbqTI=;
 b=t8hMimx4pvBClKPJgyC6jbaXKQ1va/H/cusNxNwofUJd0p1VnUqFy96/HAAlE3SRMlQPfPBM9RZ+9H36RHQ3dbdX9sysMU40zvHTvBc25BL+KXrec5LbW4Xmo3a+u57NJkS+BqVJsjYJ+BWucWEGfWd/9aNUVnUf2mRHrXh1u9Y=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB7132.namprd07.prod.outlook.com (2603:10b6:5:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 10:11:50 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 10:11:50 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Thread-Topic: [PATCH v1 7/7] dt-bindings: phy: cadence-torrent: Update Torrent
 PHY bindings for generic use
Thread-Index: AQHWbKNgb4eLlJb0pE6AuVCE/4rv2ak0SICAgAfYVSA=
Date:   Mon, 17 Aug 2020 10:11:50 +0000
Message-ID: <DM6PR07MB6154F2D1F939B03A58E14108C55F0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
 <1596795165-13341-8-git-send-email-sjakhade@cadence.com>
 <d7cfd890-2540-7d9e-72a9-8f2011b7b0ff@ti.com>
In-Reply-To: <d7cfd890-2540-7d9e-72a9-8f2011b7b0ff@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wZGUyN2QxYy1lMDcyLTExZWEtODUyNi1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcMGRlMjdkMWQtZTA3Mi0xMWVhLTg1MjYtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI2NzU2IiB0PSIxMzI0MjEzMjcwNjI4NTM5NTUiIGg9InY2MkVOUVVXMHJITlk5THhXRldXeVM2UVgyZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ba28b32-d342-4c5b-5888-08d84295f561
x-ms-traffictypediagnostic: DM6PR07MB7132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB71327E8A255C88D724A68263C55F0@DM6PR07MB7132.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uucVbuPWhknytJlNJTf7m0byBCaf68fZBszPuU4YXAbzLbArmsXHfwDoyYmPA4l/lwO+HmuEN2M+Vz2qy14JmSD9+xF8MgmVics2dRUb2Acp1uBhrviiBaBKuDguJindtxHBW53RU4CVraDQlT/nKoTOnuHHV2i/d8kTiZx+40PdKEChhZw0+IPt2b54yWw1y1AY+dlj9dtn9Xc7Bke8bVWTHA/Hhr8geGV+gbuKU87TVTFbPOgBSD6H3T/hEKfWIBQqbDQTQXdiZ5HwgEBqxukiPqrwEaEDcC6kyKcNKFccLLNop+kCu3K7YfMKGqZHgi7fqm4p9on2NQTxm25jNzDClckf5FXtMJwwTXuDsGClWRhHoWtrF9/Q40D1lg/oQOyiNOZ70qQUQEA5wJD2TftvXJ+jHO8nMgJrgKThy2fRVuQTP09DM7B5q3L+3ZE9/wBO3d3Vg5IXU1eLg8ul5mPp0bbxTrqAH3251m0wX0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(36092001)(5660300002)(83380400001)(76116006)(52536014)(6506007)(186003)(53546011)(2906002)(66946007)(66446008)(64756008)(66556008)(66476007)(9686003)(4326008)(55016002)(86362001)(8936002)(7696005)(478600001)(110136005)(316002)(33656002)(26005)(54906003)(71200400001)(8676002)(15650500001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 05W9rBZ0H7VSglxB6kwtuCt5GwGCQ0hV50Tdn/qYhqtLF2rqKV0YZFnrv2TptS0fr4Ro3fzytWigPX1gpUAYXMIMsLf0dq8oti+dfdJrj7RLBFc7w/SrsX/Y9L8XEMTSrlTmRIHoa8C/nBFFkP8iQ8qEcwEHRcRW/2YhTeWRQBYxmzE0K5n4xs6tOk8z6KuOHzrEnEL3ri8+67QsaoUALZZT0Qk/p0pL3cNPkBAu+oPHv3RL1hJJD0mFshvhxrjUWtBDMj9xul5Yo3Y8UEfqjRCryLpGvVGLYZAU6VbIFuKBfRth5urbEK1+Lc3Uo7DSdRQfE8Vjss1IZwIj/NiETc9uaG7huyvMp8ubi5YIJzcVwxC4Z3czab8/LM8/w1OzG9duK5EVxP0dsACoqF69aHP55tgoP7zdMnw6AW/WYwMYM3YDT5cOVDn4zE8g8Glo2vM3WulNH2YEM6/JeFO7tCivNuH+CEbMDpp8AVopkKgT9rcRrJrSqW9KNZbrrg81iplDnta+yek3CEiSJ6VU21JwxZa+fe+A0Djj3Qjz0zJF1YZRBP2ZfqwoXACBKe/zpXvmTB59nD+sQFhDTB56zzIORxEoXbbFT4PB6zYdjg4Tg1BmF561gnEvQblHq1/W9+T70Fz5GuS95vv5wtaoOw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba28b32-d342-4c5b-5888-08d84295f561
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 10:11:50.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QrfzOL+XmXe8o6HPYYbdnb9UNrtjbUrbzDcsvbaabk59htXtVTN/g7Xxi9ZOpTjafrEQBr5wNsf+A9xrqWqe+7A8Ujcmi5Em6SeGeVeTIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7132
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_02:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDEyLCAyMDIwIDM6NDEgUE0NCj4gVG86IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUgPHNq
YWtoYWRlQGNhZGVuY2UuY29tPjsNCj4gdmtvdWxAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBZdXRpIFN1
cmVzaCBBbW9ua2FyDQo+IDx5YW1vbmthckBjYWRlbmNlLmNvbT47IHRvbWkudmFsa2VpbmVuQHRp
LmNvbTsganNhcmhhQHRpLmNvbTsNCj4gbnNla2hhckB0aS5jb20NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MSA3LzddIGR0LWJpbmRpbmdzOiBwaHk6IGNhZGVuY2UtdG9ycmVudDogVXBkYXRlDQo+
IFRvcnJlbnQgUEhZIGJpbmRpbmdzIGZvciBnZW5lcmljIHVzZQ0KPiANCj4gRVhURVJOQUwgTUFJ
TA0KPiANCj4gDQo+IEhpIFN3YXBuaWwsDQo+IA0KPiBPbiA4LzcvMjAyMCAzOjQyIFBNLCBTd2Fw
bmlsIEpha2hhZGUgd3JvdGU6DQo+ID4gVG9ycmVudCBQSFkgY2FuIGJlIHVzZWQgaW4gZGlmZmVy
ZW50IG11bHRpLWxpbmsgbXVsdGktcHJvdG9jb2wNCj4gPiBjb25maWd1cmF0aW9ucyBpbmNsdWRp
bmcgcHJvdG9jb2xzIG90aGVyIHRoYW4gRGlzcGxheVBvcnQgYWxzbywgc3VjaA0KPiA+IGFzIFBD
SWUsIFVTQiwgU0dNSUksIFFTR01JSSBldGMuIFVwZGF0ZSB0aGUgYmluZGluZ3MgdG8gaGF2ZSBz
dXBwb3J0DQo+ID4gZm9yIHRoZXNlIGNvbmZpZ3VyYXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU3dhcG5pbCBKYWtoYWRlIDxzamFraGFkZUBjYWRlbmNlLmNvbT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS10b3JyZW50LnlhbWwgICAgIHwgNzYgKysr
KysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLXRvcnJlbnQueWFtbA0KPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS10b3JyZW50
LnlhbWwNCj4gPiBpbmRleCBhN2VlMTlkMjdjMTkuLmIyMjc1NzEyMzYzZCAxMDA2NDQNCj4gPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLXRv
cnJlbnQueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LWNhZGVuY2UtdG9ycmVudC55YW1sDQo+ID4gQEAgLTQsMTEgKzQsMTMgQEANCj4gPiAg
JGlkOg0KPiAiaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9zY2hlbWFzL3BoeS9waHktDQo+IGNhZGVuY2UtDQo+IHRvcnJlbnQueWFtbCpfXztJdyEhRUhz
Y21TMXlnaVUxbEEhV3E1emFxM0lZOHNkdU9taUpycGlXT0RuMkpZUE5FQg0KPiByNGNUbk1YNzRE
eHo1T0JXR3BheUZqSTFPUURZRlA4ZyQgIg0KPiA+ICAkc2NoZW1hOiAiaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLQ0KPiBzY2hlbWFzL2NvcmUu
eWFtbCpfXztJdyEhRUhzY21TMXlnaVUxbEEhV3E1emFxM0lZOHNkdU9taUpycGlXT0RuMg0KPiBK
WVBORUJyNGNUbk1YNzREeHo1T0JXR3BheUZqSTFPMTRHLUdKdyQgIg0KPiA+DQo+ID4gLXRpdGxl
OiBDYWRlbmNlIFRvcnJlbnQgU0QwODAxIFBIWSBiaW5kaW5nIGZvciBEaXNwbGF5UG9ydA0KPiA+
ICt0aXRsZTogQ2FkZW5jZSBUb3JyZW50IFNEMDgwMSBQSFkgYmluZGluZw0KPiA+DQo+ID4gIGRl
c2NyaXB0aW9uOg0KPiA+ICAgIFRoaXMgYmluZGluZyBkZXNjcmliZXMgdGhlIENhZGVuY2UgU0Qw
ODAxIFBIWSAoYWxzbyBrbm93biBhcw0KPiA+IFRvcnJlbnQgUEhZKQ0KPiA+IC0gIGhhcmR3YXJl
IGluY2x1ZGVkIHdpdGggdGhlIENhZGVuY2UgTUhEUCBEaXNwbGF5UG9ydCBjb250cm9sbGVyLg0K
PiA+ICsgIGhhcmR3YXJlIGluY2x1ZGVkIHdpdGggdGhlIENhZGVuY2UgTUhEUCBEaXNwbGF5UG9y
dCBjb250cm9sbGVyLg0KPiA+ICsgVG9ycmVudCAgUEhZIGFsc28gc3VwcG9ydHMgbXVsdGlsaW5r
IG11bHRpcHJvdG9jb2wgY29tYmluYXRpb25zDQo+ID4gKyBpbmNsdWRpbmcgcHJvdG9jb2xzICBz
dWNoIGFzIFBDSWUsIFVTQiwgU0dNSUksIFFTR01JSSBldGMuDQo+ID4NCj4gPiAgbWFpbnRhaW5l
cnM6DQo+ID4gICAgLSBTd2FwbmlsIEpha2hhZGUgPHNqYWtoYWRlQGNhZGVuY2UuY29tPiBAQCAt
NDksMTMgKzUxLDE0IEBADQo+ID4gcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBjb25zdDogZHB0
eF9waHkNCj4gPg0KPiA+ICAgIHJlc2V0czoNCj4gPiAtICAgIG1heEl0ZW1zOiAxDQo+ID4gLSAg
ICBkZXNjcmlwdGlvbjoNCj4gPiAtICAgICAgVG9ycmVudCBQSFkgcmVzZXQuDQo+ID4gLSAgICAg
IFNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvcmVzZXQudHh0DQo+
ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDINCj4gPiArICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBUb3JyZW50IFBIWSByZXNldC4NCj4gPiArICAg
ICAgLSBkZXNjcmlwdGlvbjogVG9ycmVudCBBUEIgcmVzZXQuIFRoaXMgaXMgb3B0aW9uYWwuDQo+
ID4NCj4gPiAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gLSAgJ15waHlAWzAtN10rJCc6DQo+ID4g
KyAgJ15saW5rQFswLTddKyQnOg0KPiANCj4gV291bGRuJ3QgdGhpcyBicmVhayBvbGRlciBkZXZp
Y2UgdHJlZSBiaW5kaW5nPyBPciBhcmUgdGhlcmUgbm8gdXBzdHJlYW0gRFQNCj4gbm9kZXMgd2l0
aCBwaHkgc3ViLW5vZGU/DQoNClRvcnJlbnQgUEhZIGRyaXZlciBoYXMgbmV2ZXIgYmVlbiBmdW5j
dGlvbmFsLCBhbmQgdGhlcmVmb3JlIGRvIG5vdCBleGlzdCBpbiBhbnkNCmFjdGl2ZSB1c2UgY2Fz
ZSwgc28gdGhpcyBzaG91bGQgbm90IGJyZWFrIHRoZSBiaW5kaW5nIGFzIHRoZXJlIGFyZSBubyBE
VCBub2Rlcw0KaW4gdXBzdHJlYW0gdXNpbmcgdGhlIHRvcnJlbnQgUEhZLg0KDQpUaGFua3MsDQpT
d2FwbmlsDQoNCj4gDQo+IFRoYW5rcw0KPiBLaXNob24NCj4gDQo+ID4gICAgICB0eXBlOiBvYmpl
Y3QNCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAgICBFYWNoIGdyb3VwIG9mIFBIWSBs
YW5lcyB3aXRoIGEgc2luZ2xlIG1hc3RlciBsYW5lIHNob3VsZCBiZQ0KPiByZXByZXNlbnRlZCBh
cyBhIHN1Yi1ub2RlLg0KPiA+IEBAIC03OCwxMyArODEsMTMgQEAgcGF0dGVyblByb3BlcnRpZXM6
DQo+ID4gICAgICAgICAgICBTcGVjaWZpZXMgdGhlIHR5cGUgb2YgUEhZIGZvciB3aGljaCB0aGUg
Z3JvdXAgb2YgUEhZIGxhbmVzIGlzIHVzZWQuDQo+ID4gICAgICAgICAgICBSZWZlciBpbmNsdWRl
L2R0LWJpbmRpbmdzL3BoeS9waHkuaC4gQ29uc3RhbnRzIGZyb20gdGhlIGhlYWRlcg0KPiBzaG91
bGQgYmUgdXNlZC4NCj4gPiAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzINCj4gPiAtICAgICAgICBlbnVtOiBbMSwgMiwgMywgNCwgNSwgNl0NCj4g
PiArICAgICAgICBlbnVtOiBbMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOV0NCj4gPg0KPiA+ICAg
ICAgICBjZG5zLG51bS1sYW5lczoNCj4gPiAgICAgICAgICBkZXNjcmlwdGlvbjoNCj4gPiAtICAg
ICAgICAgIE51bWJlciBvZiBEaXNwbGF5UG9ydCBsYW5lcy4NCj4gPiArICAgICAgICAgIE51bWJl
ciBvZiBsYW5lcy4NCj4gPiAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzINCj4gPiAtICAgICAgICBlbnVtOiBbMSwgMiwgNF0NCj4gPiArICAgICAg
ICBlbnVtOiBbMSwgMiwgMywgNF0NCj4gPiAgICAgICAgICBkZWZhdWx0OiA0DQo+ID4NCj4gPiAg
ICAgICAgY2Rucyxzc2MtbW9kZToNCj4gPiBAQCAtMTA4LDYgKzExMSw3IEBAIHBhdHRlcm5Qcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAtIHJlc2V0cw0KPiA+ICAgICAgICAtICIjcGh5LWNlbGxzIg0K
PiA+ICAgICAgICAtIGNkbnMscGh5LXR5cGUNCj4gPiArICAgICAgLSBjZG5zLG51bS1sYW5lcw0K
PiA+DQo+ID4gICAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPg0KPiA+IEBAIC0x
NDEsMTUgKzE0NSw1MSBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAgICAgY2xvY2stbmFtZXMg
PSAicmVmY2xrIjsNCj4gPiAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4g
ICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+IC0gICAgICAgICAgICBwaHlAMCB7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICByZXNldHMgPSA8JnBoeXJzdCAxPiwgPCZwaHlyc3QgMj4sDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8JnBoeXJzdCAzPiwgPCZwaHlyc3QgND47DQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAjcGh5LWNlbGxzID0gPDA+Ow0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgY2RucyxwaHktdHlwZSA9IDxQSFlfVFlQRV9EUD47DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICBjZG5zLG51bS1sYW5lcyA9IDw0PjsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgIGNkbnMsbWF4LWJpdC1yYXRlID0gPDgxMDA+Ow0KPiA+ICsgICAgICAgICAgICBsaW5r
QDAgew0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgcmVzZXRzID0gPCZwaHlyc3QgMT4sIDwmcGh5cnN0IDI+LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZwaHlyc3QgMz4sIDwmcGh5cnN0IDQ+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgI3BoeS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgIGNkbnMscGh5LXR5cGUg
PSA8UEhZX1RZUEVfRFA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgY2RucyxudW0tbGFuZXMgPSA8
ND47DQo+ID4gKyAgICAgICAgICAgICAgICBjZG5zLG1heC1iaXQtcmF0ZSA9IDw4MTAwPjsNCj4g
PiArICAgICAgICAgICAgfTsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsgICAgfTsNCj4gPiArICAt
IHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5Lmg+DQo+ID4gKyAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLXRvcnJlbnQuaD4NCj4gPiArDQo+
ID4gKyAgICBidXMgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsg
ICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsNCj4gPiArICAgICAgICB0b3JyZW50LXBo
eUBmMGZiNTAwMDAwIHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjZG5zLHRvcnJl
bnQtcGh5IjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDB4ZjAgMHhmYjUwMDAwMCAweDAgMHgw
MDEwMDAwMD47DQo+ID4gKyAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJ0b3JyZW50X3BoeSI7DQo+
ID4gKyAgICAgICAgICAgIHJlc2V0cyA9IDwmcGh5cnN0IDA+LCA8JnBoeXJzdCAxPjsNCj4gPiAr
ICAgICAgICAgICAgY2xvY2tzID0gPCZyZWZfY2xrPjsNCj4gPiArICAgICAgICAgICAgY2xvY2st
bmFtZXMgPSAicmVmY2xrIjsNCj4gPiArICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ID4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICBs
aW5rQDAgew0KPiA+ICsgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgcmVzZXRzID0gPCZwaHlyc3QgMj4sIDwmcGh5cnN0IDM+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgI3BoeS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgIGNkbnMscGh5LXR5
cGUgPSA8UEhZX1RZUEVfUENJRT47DQo+ID4gKyAgICAgICAgICAgICAgICBjZG5zLG51bS1sYW5l
cyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgIGNkbnMsc3NjLW1vZGUgPSA8VE9SUkVOVF9T
RVJERVNfTk9fU1NDPjsNCj4gPiAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgIGxpbmtAMiB7DQo+ID4gKyAgICAgICAgICAgICAgICByZWcgPSA8Mj47DQo+ID4gKyAgICAg
ICAgICAgICAgICByZXNldHMgPSA8JnBoeXJzdCA0PjsNCj4gPiArICAgICAgICAgICAgICAgICNw
aHktY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICBjZG5zLHBoeS10eXBlID0gPFBI
WV9UWVBFX1NHTUlJPjsNCj4gPiArICAgICAgICAgICAgICAgIGNkbnMsbnVtLWxhbmVzID0gPDE+
Ow0KPiA+ICsgICAgICAgICAgICAgICAgY2Rucyxzc2MtbW9kZSA9IDxUT1JSRU5UX1NFUkRFU19O
T19TU0M+Ow0KPiA+ICsgICAgICAgICAgIH07DQo+ID4gICAgICAgICAgfTsNCj4gPiAgICAgIH07
DQo+ID4gIC4uLg0KPiA+DQo=

Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1357C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740E620781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="SGTius+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMIcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:32:03 -0400
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242]:9838 "EHLO
        mx0a-0039f301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgHMIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:32:03 -0400
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07D6MVTC013413;
        Thu, 13 Aug 2020 06:32:29 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57])
        by mx0a-0039f301.pphosted.com with ESMTP id 32v9ptb7gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 06:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW9AqrMSjyT96t7PkEMt0KOiNIHl4RfWc8BIttPu8BCyM62/b5mBw6Ct5AkSJ6Jf3WxCVKaccny15ktRFhkhEDAQGLgQXFZaSJuZpIXHh31Pt2FhPnt3OG73Mjf/FNgGOc0GEV+5Xci8I8DoEoaWeJRN110QaJ1rF8gurMp3l50/L/Lc2FqiQQfVJDIbxKjiyZi7Znyc7FeNo3j/EM8IvnqjCpd3kzQQJAc4cSIRo1PBkvx46waCliMOTZp9fvSAy2nTgp6edOoi2N5RdxXFAIZkBtgGxRSG6mDnktrh1RMQflngK32BS08G/mhzcmtnu0yAj3ufXS4Z83wxAS22ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUG4qciZFWVY40UK+zGnDDQlKG0HkTB5KIEbuRNNetc=;
 b=BeIisR97fwNi1lCPw9L9frP/Gg57fAX35CsukY7LL7FrklRBwD0BLCIrHaWJeD0efTMwzTfj0Fhc+vARpNxDHijodgRjEcVbv0g/D2WZxyyHaCIhTDALC/eG5Qt4nUNuWuSBFPRugCYKb9xHnbAjAx/B8nsmh4LIqW0ahJCjxQOFNOAAVcFvqJeBmW4JWujjikOj1DVPeH0jK7N0i+j314r61Vw+T6YDUKG0UgoLRHS1uehYMFDn9OtlKgQtu2uS21GdJaJZrwKdtuBybXsUwc5J14IgL8YHEo2xF6izZslj42LHUBrAVKRQkF3If1nuOF9DrC5pke7fmj6tFbHTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUG4qciZFWVY40UK+zGnDDQlKG0HkTB5KIEbuRNNetc=;
 b=SGTius+w2JvhIgDjFugOrWMpv19c8WaH6THsua1b37xyd9uzRGkJpKenCm1vi1R6h/tOwZFFFGkTEX8Uzfkxai4v6ek8DjevHFjn345x0MmHXJrR1dzydjyVE3a1d4u5nSRScbXiZ79e6ZzpyxCToui2M75zQO6b4LNpPfFnUu4CikEHimnay2yVH4iT+h2dfV9NKKgFGlS+051xZem771RV826muSdFKgZ0KtqRcaRzb58H/WhgXGnYe5bNgd83sFzgS8IJvJ8KTN6YfD838AdRlW3ugdcifd0ygvUQWWhrwIVhObVnz1Kd5kDwcrFoEUaFvP8G4PObN7Qx2Wnb8w==
Received: from AM0PR03MB6324.eurprd03.prod.outlook.com (2603:10a6:20b:153::17)
 by AM0PR03MB5554.eurprd03.prod.outlook.com (2603:10a6:208:176::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 06:32:25 +0000
Received: from AM0PR03MB6324.eurprd03.prod.outlook.com
 ([fe80::21e5:6d27:5ba0:f508]) by AM0PR03MB6324.eurprd03.prod.outlook.com
 ([fe80::21e5:6d27:5ba0:f508%9]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 06:32:25 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>
CC:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/5] Fixes and improvements for Xen pvdrm
Thread-Topic: [PATCH v2 0/5] Fixes and improvements for Xen pvdrm
Thread-Index: AQHWcTn137mCP9TL7kicuRLSt2qi/qk1lI+A
Date:   Thu, 13 Aug 2020 06:32:25 +0000
Message-ID: <7c8cb6e9-8270-d27a-6480-793ef5599d09@epam.com>
References: <20200813062113.11030-1-andr2000@gmail.com>
In-Reply-To: <20200813062113.11030-1-andr2000@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=epam.com;
x-originating-ip: [185.199.97.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c99856f2-6009-4360-97fc-08d83f52a4c6
x-ms-traffictypediagnostic: AM0PR03MB5554:
x-microsoft-antispam-prvs: <AM0PR03MB5554779618B8905593FF9E84E7430@AM0PR03MB5554.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB6324.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(36756003)(2616005)(91956017)(76116006)(53546011)(6506007)(316002)(66476007)(478600001)(66556008)(66946007)(64756008)(66446008)(7416002)(5660300002)(31686004)(186003)(8676002)(6512007)(2906002)(966005)(6486002)(8936002)(83380400001)(31696002)(86362001)(26005)(4326008)(110136005)(54906003)(71200400001)(17423001);DIR:OUT;SFP:1101;
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <43EAECDDFA871B46B0F3D5560854501F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB6324.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99856f2-6009-4360-97fc-08d83f52a4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 06:32:25.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnxYaG79aAzCpN2Ps8hzISGrGH9ZTuBY+Hzm0tRrM4j5FdLfeTa+0JHzae25q0pT2nCXCYu2fMFtcicr7RAAVxwtse2KiWP/tjcFsK1UtmXNF18EbMybRVVjZ7p/DJsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5554
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_04:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVlcmdlbiwgQm9yaXMsDQoNCmNhbiB3ZSBwbGVhc2UgbWVyZ2UgdGhlc2UgdmlhIFhlbiBMaW51
eCB0cmVlIGFzIEkgaGF2ZSBjb2xsZWN0ZWQgZW5vdWdoIEFjay9SLWI/DQoNClRoZSBzZXJpZXMg
aGFzIERSTSBwYXRjaGVzLCBidXQgdGhvc2UgYW55d2F5IGFyZSBYZW4gcmVsYXRlZCwgc28gSSB0
aGluaw0KDQp0aGlzIHNob3VsZCBiZSBmaW5lIGZyb20gRFJJIHBvaW50IG9mIHZpZXcuDQoNClRo
YW5rIHlvdSwNCg0KT2xla3NhbmRyDQoNCk9uIDgvMTMvMjAgOToyMSBBTSwgT2xla3NhbmRyIEFu
ZHJ1c2hjaGVua28gd3JvdGU6DQo+IEZyb206IE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIDxvbGVr
c2FuZHJfYW5kcnVzaGNoZW5rb0BlcGFtLmNvbT4NCj4NCj4gSGVsbG8sDQo+DQo+IFRoaXMgc2Vy
aWVzIGNvbnRhaW5zIGFuIGFzc29ydGVkIHNldCBvZiBmaXhlcyBhbmQgaW1wcm92ZW1lbnRzIGZv
cg0KPiB0aGUgWGVuIHBhcmEtdmlydHVhbGl6ZWQgZGlzcGxheSBkcml2ZXIgYW5kIGdyYW50IGRl
dmljZSBkcml2ZXIgd2hpY2gNCj4gSSBoYXZlIGNvbGxlY3RlZCBvdmVyIHRoZSBsYXN0IGNvdXBs
ZSBvZiBtb250aHM6DQo+DQo+IDEuIE1pbm9yIGZpeGVzIHRvIGdyYW50IGRldmljZSBkcml2ZXIg
YW5kIGRybS94ZW4tZnJvbnQuDQo+DQo+IDIuIE5ldyBmb3JtYXQgKFlVWVYpIGFkZGVkIHRvIHRo
ZSBsaXN0IG9mIHRoZSBQViBEUk0gc3VwcG9ydGVkIGZvcm1hdHMNCj4gd2hpY2ggYWxsb3dzIHRo
ZSBkcml2ZXIgdG8gYmUgdXNlZCBpbiB6ZXJvLWNvcHlpbmcgdXNlLWNhc2VzIHdoZW4NCj4gYSBj
YW1lcmEgZGV2aWNlIGlzIHRoZSBzb3VyY2Ugb2YgdGhlIGRtYS1idWZzLg0KPg0KPiAzLiBTeW5j
aHJvbml6YXRpb24gd2l0aCB0aGUgbGF0ZXN0IHBhcmEtdmlydHVhbGl6ZWQgcHJvdG9jb2wgZGVm
aW5pdGlvbg0KPiBpbiBYZW4gWzFdLg0KPg0KPiA0LiBTR1Qgb2Zmc2V0IGlzIG5vdyBwcm9wYWdh
dGVkIHRvIHRoZSBiYWNrZW5kOiB3aGlsZSBpbXBvcnRpbmcgYSBkbWFidWYNCj4gaXQgaXMgcG9z
c2libGUgdGhhdCB0aGUgZGF0YSBvZiB0aGUgYnVmZmVyIGlzIHB1dCB3aXRoIG9mZnNldCB3aGlj
aCBpcw0KPiBpbmRpY2F0ZWQgYnkgdGhlIFNHVCBvZmZzZXQuIFRoaXMgaXMgbmVlZGVkIGZvciBz
b21lIEdQVXMgd2hpY2ggaGF2ZQ0KPiBub24temVybyBvZmZzZXQuDQo+DQo+IFRoYW5rIHlvdSwN
Cj4gT2xla3NhbmRyIEFuZHJ1c2hjaGVua28NCj4NCj4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL3hlbmJpdHMueGVuLm9yZy9naXR3ZWIvP3A9eGVuLmdpdDthPWNvbW1p
dDtoPWMyN2ExODQyMjVlYWI1NGQyMDQzNWM4Y2FiNWFkMGVmMzg0ZGMyYzBfXzshIUdGXzI5ZGJj
UUlVQlBBIWlBSE9kazRNMTY3Vk5NMUF5cE1HVm15S0p1LWlxQzllNWNYeXU2TjU5NU5wM2l5SVpE
blpsME1JQlgzSVJPSlNEMUdTTVhfR2ZRJCBbeGVuYml0c1suXXhlblsuXW9yZ10NCj4NCj4gQ2hh
bmdlcyBzaW5jZSB2MToNCj4gPT09PT09PT09PT09PT09PT0NCj4NCj4gMS4gUmVtb3ZlZCBwYXRj
aCB3aGljaCBhZGRzIEVESUQgdG8gUFYgRFJNIGFzIGl0IG5lZWRzIG1vcmUgdGltZSBmb3IgcmV2
aWV3Og0KPiAiNS4gVmVyc2lvbiAyIG9mIHRoZSBYZW4gZGlzcGxpZiBwcm90b2NvbCBhZGRzIFhF
TkRJU1BMX09QX0dFVF9FRElEDQo+IHJlcXVlc3Qgd2hpY2ggYWxsb3dzIGZyb250ZW5kcyB0byBy
ZXF1ZXN0IEVESUQgc3RydWN0dXJlIHBlcg0KPiBjb25uZWN0b3IuIFRoaXMgcmVxdWVzdCBpcyBv
cHRpb25hbCBhbmQgaWYgbm90IHN1cHBvcnRlZCBieSB0aGUNCj4gYmFja2VuZCB0aGVuIHZpc2li
bGUgYXJlYSBpcyBzdGlsbCBkZWZpbmVkIGJ5IHRoZSByZWxldmFudA0KPiBYZW5TdG9yZSdzICJy
ZXNvbHV0aW9uIiBwcm9wZXJ0eS4NCj4gSWYgYmFja2VuZCBwcm92aWRlcyBFRElEIHdpdGggWEVO
RElTUExfT1BfR0VUX0VESUQgcmVxdWVzdCB0aGVuDQo+IGl0cyB2YWx1ZXMgbXVzdCB0YWtlIHBy
ZWNlZGVuY2Ugb3ZlciB0aGUgcmVzb2x1dGlvbnMgZGVmaW5lZCBpbg0KPiBYZW5TdG9yZS4iDQo+
IEkgd2lsbCBzZW5kIHRoaXMgYXMgYSBkZWRpY2F0ZWQgcGF0Y2guDQo+DQo+IDIuIEFkZGVkIG1p
c3NpbmcgQ0Mgc3RhYmxlIGZvciB0aGUgcGF0Y2hlcyB3aXRoIGZpeGVzDQo+DQo+IE9sZWtzYW5k
ciBBbmRydXNoY2hlbmtvICg1KToNCj4gICAgeGVuL2dudGRldjogRml4IGRtYWJ1ZiBpbXBvcnQg
d2l0aCBub24temVybyBzZ3Qgb2Zmc2V0DQo+ICAgIGRybS94ZW4tZnJvbnQ6IEZpeCBtaXN1c2Vk
IElTX0VSUl9PUl9OVUxMIGNoZWNrcw0KPiAgICBkcm0veGVuLWZyb250OiBBZGQgWVVZViB0byBz
dXBwb3J0ZWQgZm9ybWF0cw0KPiAgICB4ZW46IFN5bmMgdXAgd2l0aCB0aGUgY2Fub25pY2FsIHBy
b3RvY29sIGRlZmluaXRpb24gaW4gWGVuDQo+ICAgIGRybS94ZW4tZnJvbnQ6IFBhc3MgZHVtYiBi
dWZmZXIgZGF0YSBvZmZzZXQgdG8gdGhlIGJhY2tlbmQNCj4NCj4gICBkcml2ZXJzL2dwdS9kcm0v
eGVuL3hlbl9kcm1fZnJvbnQuYyAgICAgIHwgMTAgKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3hl
bi94ZW5fZHJtX2Zyb250LmggICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3hlbi94
ZW5fZHJtX2Zyb250X2Nvbm4uYyB8ICAxICsNCj4gICBkcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9k
cm1fZnJvbnRfZ2VtLmMgIHwgMTEgKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJt
X2Zyb250X2ttcy5jICB8ICAyICstDQo+ICAgZHJpdmVycy94ZW4vZ250ZGV2LWRtYWJ1Zi5jICAg
ICAgICAgICAgICB8ICA4ICsrKw0KPiAgIGluY2x1ZGUveGVuL2ludGVyZmFjZS9pby9kaXNwbGlm
LmggICAgICAgfCA5MSArKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICA3IGZpbGVzIGNoYW5n
ZWQsIDExMSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4=

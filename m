Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFCD20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lbc8EXoT";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="aRzw4r1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgERGyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:54:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21620 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726040AbgERGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:54:53 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04I6jCRI001548;
        Sun, 17 May 2020 23:54:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0eoiZ64Rf8tFIWRft3LcuaADzJQJyTnrZeLKv+mXN+s=;
 b=lbc8EXoT1oBTdA3c6ooTp+ipun+JGA4p0LolmYqh4asOFN9wJOeLrTpV7MnM2IYP+XgT
 mZFzp5qBvfr/e9KIHNgAnX39+GYRUbVo5iOYhH1SutNXsftCY1CIWcWFrNPIg2vHRRgM
 rfXYlQJ67jhjPSL2P2IoDJXEBH7sGjcKlO0TFkK5boMW4w3C+pUN/BqKsHQ/htDYylmW
 bprUfkL0R3Pbh/7lIly8UZ4kt0WUX9Tm970cjTqsExFBK2lQDroy9jBjDYWpSAidolkg
 +McjzqIPI5Gr4mFtB2BAG63WuZI2ng1XhJXqm+0ETuSouWeSGNaTHOcTj0Ts20nzuhDk MA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-0014ca01.pphosted.com with ESMTP id 312bs05yej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 May 2020 23:54:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4wVEkun+Pjz3Dhgtv9esENs0rAzdjoMCmTH3yhnD1ls+wr7Lfw5vRCTOv/EfJVakeUFd1gON3wwuPQC1TTa4Bgx+DSVKpJg4F2k4p/K/OoVGrdn0qDwAueeY6tHc69cYvfCCh60mbBs38Ny+i0WqwTXDYlO/D/M9X1LZwMTQlpVV60vDoj6iUCpqtB7wuoT3l8oyOAi8APkZF4sMIfkpeQhIqvZoN6VgXH6eEZOMTMOt2uYsphzfHGGVWPx4v00Lk02/n43zwoJBmxQQC5FfvgZEd6VelR0BTlUdp6MhvXj29PCnL1oBmMKCZpMrA1dq7q6Sg4Pp51TaRlXlYiXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eoiZ64Rf8tFIWRft3LcuaADzJQJyTnrZeLKv+mXN+s=;
 b=BmsEy7QCv1z1iQv/jj8j0+DhIsgRyjBlwM43LbNSDJH0pfCoQ87hUbmNDG0qpn2bCAD+OvD836WNUhcPUCFwKVck04cj+diJeJLqDA7jzTrta8HISbpwtZiVSXIt9e3ZUWUfTgRdIRikKxUoHLGhhFm3nuksp5zFDnmYJcf3aFlqa5Pq4EQbUo6Ez4soo9/8KFgWSwTDDIopwVDCmYJJpAFDbkyYC+2YZRGAmAWf2nInB6jxd/FfOPkrFe0vYFoo3S2tI9omO1Bs6cXJk41NDAt2gfh5gQKa7n28k1IYUnuTV0IBlQAjjggxu4t8NbriNqsbZU6jnfCAVaomJSA1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eoiZ64Rf8tFIWRft3LcuaADzJQJyTnrZeLKv+mXN+s=;
 b=aRzw4r1C9XcAgzliXb2tOUUSpJfO7UiXnjDWby8apck/DuwWpqiLW7bcZfQGvZw+MJ//gMXvFq3+ujvDCxocFLWttS590DgHWhUq6ZenH7v2MW8iRX0OOTu6QNxQtCHHlGFmYR0Qsj7uo0bKS5XecfGQe4C4cnV6JqWKc7/fyBQ=
Received: from BY5PR07MB6982.namprd07.prod.outlook.com (2603:10b6:a03:1ec::13)
 by BY5PR07MB6983.namprd07.prod.outlook.com (2603:10b6:a03:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 06:54:37 +0000
Received: from BY5PR07MB6982.namprd07.prod.outlook.com
 ([fe80::30bd:728e:27db:1c5d]) by BY5PR07MB6982.namprd07.prod.outlook.com
 ([fe80::30bd:728e:27db:1c5d%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 06:54:37 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Maxime Ripard <maxime@cerno.tech>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Thread-Topic: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
Thread-Index: AQHWHSwc1RgU1BkduE6GLxxNwyDKs6iQCNkAgAGpv0CACzngAIAA88gAgAeETwCACAjvYA==
Date:   Mon, 18 May 2020 06:54:36 +0000
Message-ID: <BY5PR07MB6982568DE9F5A4BF00433CA6C5B80@BY5PR07MB6982.namprd07.prod.outlook.com>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
 <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
 <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
 <20200507171738.atzyfpueo6bjbwpb@gilmour.lan>
 <f6e0566a-8e15-5c55-3167-6a1526c37be7@ti.com>
 <c96c3fa8-a66f-7eca-8d23-8dd2a8f044aa@ti.com>
In-Reply-To: <c96c3fa8-a66f-7eca-8d23-8dd2a8f044aa@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02YjJlZTNkMi05OGQ0LTExZWEtODUxOC1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNmIyZWUzZDMtOThkNC0xMWVhLTg1MTgtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzMTYyIiB0PSIxMzIzNDI1ODQ2OTg0MjE5OTAiIGg9InlHNGh4blpqUkVXOHU0MmxGNzNOS3ZDaVp5OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e315952-c506-4cc4-d523-08d7faf8545c
x-ms-traffictypediagnostic: BY5PR07MB6983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB698362DFC8A6A301862FC1E9C5B80@BY5PR07MB6983.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dt6v4tQ02q18OjmfUrf6TL13/2oXM0uQ4JuUCukjdonuEvSvMITjjZEPsu3LToS5Fkz8EkCH26GAfzbAVpD/poEQjhXtNQNzuA+TGopIr6gmNGw4b3WMFKHNwtO99bvpFqqQwDCLOjYXWT7TDtHD9DqXoFiP0ze8xZWj+OHYb2dEjjXLro9C8vhPFh/Fy0yQFOUbhNblbzTfl2F2evhi6LXGPtdBbexPj7bFDVKtRQ+1ZIw7xJQsFyGf75RNpK8S7W3MxE7aAzB0EJw+09RHh6XKs2cH6v/qOx8i0/nrpfsc0mIDMXRZfrT2rJUkvcEa9DzWXGBJQZ56jJpChmwiI/HMK2pDjOLk+lrGQND7u1gjGITeQip+bMtTa6uH9fb7gqJ4Ix7R1zr7SfVGMOPDqSkClS9aJ4ORYoF533zXDIBQwq0ywu4hLH2c/jYDBxSPIUv4IKB+SG4al137RPA41m0fcbB8JrE57wGNsNP/9a1ficZgE2YluPMQ57aSVY88
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB6982.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(36092001)(52536014)(66946007)(66476007)(6506007)(71200400001)(55016002)(4326008)(53546011)(8936002)(316002)(7696005)(2906002)(9686003)(186003)(33656002)(66556008)(64756008)(66446008)(5660300002)(76116006)(110136005)(478600001)(86362001)(26005)(54906003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8seVHuxyUp6WkkDchDggOYZKmin+W/bZsML7/HgIAIUmXe6Mc3iGCvRzCzgJdG4BOWZxcsqXHP0MItvIQt2l/og1FZfNt0COZtSeYpjy8tCog5jGzs7J0IRAyfSuafkBPYALRf4RIKlQmbCeISti/RFhtI2Nvghe614mstgT7doTh4CP3M+m0/tY+XsgEbwujFt0jRnyVkPNG7/KhY1CgcsNUP0h1AZxZpBVWEAxsCo7f3gkrJ60QfZnb2sAirC8IIvPw25x+YaJIJY4gapO+jSgKMz5QBnsadMWQ6sIq953j3w8NkQyyD7cY9lu3eHUY+XLxyVxMZyTEOK+4Wiw2n6dua3vBIhsM8W/f94lxl7a/pOtxIYz4jksjY+RLF84d6Xx8W+cKx3gegfVGVT1nItIr6HwWmTeqUGQyJ7M2i4SVPCvhMLAwsKA/IZpKIY2WndE6VJKQXMMWeRc3d8eti4NFnMP7SjVRQ8YNjLGmw4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e315952-c506-4cc4-d523-08d7faf8545c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:54:36.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXefOZYQqgJ7tNAjPeRa/UWOhnpJtc9v2Ju3XsEDCPyLpdglMrAmb8Bx/RbKa+HQ+x8Y8RXF+trnf40A/ogy7H5oV//M2GAgp80MZvXOv8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6983
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_02:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5
IDEzLCAyMDIwIDg6MDggQU0NCj4gVG86IFRvbWkgVmFsa2VpbmVuIDx0b21pLnZhbGtlaW5lbkB0
aS5jb20+OyBNYXhpbWUgUmlwYXJkDQo+IDxtYXhpbWVAY2Vybm8udGVjaD47IFN3YXBuaWwgS2Fz
aGluYXRoIEpha2hhZGUNCj4gPHNqYWtoYWRlQGNhZGVuY2UuY29tPg0KPiBDYzogWXV0aSBTdXJl
c2ggQW1vbmthciA8eWFtb25rYXJAY2FkZW5jZS5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGpzYXJoYUB0aS5jb207DQo+IHByYW5l
ZXRoQHRpLmNvbTsgTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBWaW5vZCBLb3Vs
DQo+IDx2a291bEBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gcGh5
OiBwaHktY2FkZW5jZS10b3JyZW50OiBVc2UgUEhZIGtlcm5lbCBBUElzIHRvDQo+IHNldCBQSFkg
YXR0cmlidXRlcw0KPiANCj4gRVhURVJOQUwgTUFJTA0KPiANCj4gDQo+IEhpLA0KPiANCj4gT24g
NS84LzIwMjAgMToyMCBQTSwgVG9taSBWYWxrZWluZW4gd3JvdGU6DQo+ID4gT24gMDcvMDUvMjAy
MCAyMDoxNywgTWF4aW1lIFJpcGFyZCB3cm90ZToNCj4gPg0KPiA+Pj4gQWN0dWFsbHksIGZvciB0
aGlzIHBhcnRpY3VsYXIgY2FzZSwgY29uc3VtZXIgZHJpdmVyIHdpbGwgYmUgdGhlDQo+ID4+PiBD
YWRlbmNlIE1IRFAgYnJpZGdlIGRyaXZlciBmb3IgRGlzcGxheVBvcnQgd2hpY2ggaXMgYWxzbyB1
bmRlcg0KPiA+Pj4gcmV2aWV3IHByb2Nlc3MgZm9yIHVwc3RyZWFtaW5nIFsxXS4gU28gdGhpcyBE
Uk0gYnJpZGdlIGRyaXZlciB3aWxsDQo+ID4+PiBtYWtlIHVzZSBvZiB0aGUgUEhZIEFQSXMNCj4g
Pj4+IHBoeV9nZXRfYnVzX3dpZHRoKCkgYW5kIHBoeV9nZXRfbWF4X2xpbmtfcmF0ZSgpIGR1cmlu
ZyBleGVjdXRpb24gb2YNCj4gPj4+IHByb2JlIGZ1bmN0aW9uIHRvIGdldCB0aGUgbnVtYmVyIG9m
IGxhbmVzIGFuZCBtYXhpbXVtIGxpbmsgcmF0ZQ0KPiA+Pj4gc3VwcG9ydGVkIGJ5IENhZGVuY2Ug
VG9ycmVudCBQSFkuIFRoaXMgaW5mb3JtYXRpb24gaXMgcmVxdWlyZWQgdG8NCj4gPj4+IHNldCB0
aGUgaG9zdCBjYXBhYmlsaXRpZXMgaW4gdGhlIERSTSBicmlkZ2UgZHJpdmVyLCBiYXNlZCBvbiB3
aGljaA0KPiA+Pj4gaW5pdGlhbCB2YWx1ZXMgZm9yIERpc3BsYXlQb3J0IGxpbmsgdHJhaW5pbmcg
d2lsbCBiZSBkZXRlcm1pbmVkLg0KPiA+Pj4NCj4gPj4+IFRoZSBjaGFuZ2VzIGluIHRoaXMgUEhZ
IHBhdGNoIHNlcmllcyBhcmUgYmFzZWQgb24gc3VnZ2VzdGlvbnMgaW4gdGhlDQo+ID4+PiByZXZp
ZXcgY29tbWVudHMgaW4gWzFdIHdoaWNoIGFza3MgdG8gdXNlIGtlcm5lbCBQSFkgQVBJcyB0byBy
ZWFkDQo+ID4+PiB0aGVzZSBwcm9wZXJ0aWVzIGluc3RlYWQgb2YgZGlyZWN0bHkgYWNjZXNzaW5n
IFBIWSBkZXZpY2Ugbm9kZS4gVGhlDQo+ID4+PiBjb21wbGV0ZSBkcml2ZXIgYW5kIGFjdHVhbCB1
c2Ugb2YgdGhlc2UgQVBJcyBjYW4gYmUgZm91bmQgaW4gWzJdLg0KPiA+Pj4gVGhpcyBpcyBob3cg
d2UgYXJlIHBsYW5uaW5nIHRvIHVzZSB0aGVzZSBBUElzLg0KPiA+Pg0KPiA+PiBJIGhhdmVuJ3Qg
cmVhbGx5IGxvb2tlZCBpbnRvIHRoZSBkaXNwbGF5cG9ydCBzcGVjLCBidXQgSSdkIGFzc3VtZQ0K
PiA+PiB0aGF0IHRoZXJlJ3MgYSBsb3QgbW9yZSBwYXJhbWV0ZXJzIHRoYXQgd291bGQgbmVlZCB0
byBiZSBuZWdvY2lhdGVkDQo+ID4+IGJldHdlZW4gdGhlIHBoeSBhbmQgdGhlIERQIGJsb2NrPyBJ
ZiBzbywgdGhlbiBpdCB3b3VsZCBtYWtlIG1vcmUNCj4gPj4gc2Vuc2UgdG8gZm9sbG93IHRoZSBw
YXRoIHdlIGRpZCBmb3IgTUlQSS1EU0kgd2hlcmUgdGhlIHBhcmFtZXRlcnMgY2FuDQo+ID4+IGJl
IG5lZ29jaWF0ZWQgdGhyb3VnaCB0aGUgcGh5X2NvbmZpZ3VyZSAvIHBoeV92YWxpZGF0ZSBpbnRl
cmZhY2UuDQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVnb3RpYXRpb24sIGJ1dCBq
dXN0IGV4cG9zaW5nIHRoZSAobWF4KQ0KPiA+IGNhcGFiaWxpdGllcyBvZiBQSFksIGluc2lkZSB3
aGljaCB0aGUgY29uZmlndXJlIGNhbiB3b3JrLiBNYXliZSBhbGwNCj4gPiB0aGUgY2FwYWJpbGl0
aWVzIGNvdWxkIGhhbmRsZWQgd2l0aCBhIHN0cnVjdCAoc3RydWN0IHBoeV9hdHRycyksDQo+ID4g
aW5zdGVhZCBvZiBhZGRpbmcgc2VwYXJhdGUgZnVuY3Rpb25zIGZvciBlYWNoLCB0aG91Z2guDQo+
IA0KPiB5ZWFoLCB0aGF0IG1ha2VzIHNlbnNlLiBKdXN0IHRoYXQgdXNlcnMgc2hvdWxkIHRha2Ug
Y2FyZSBub3QgdG8gb3Zlci13cml0ZSBhbGwNCj4gdGhlIHBoeSBhdHRyaWJ1dGVzIHdpdGggcGFy
dGlhbCBpbmZvcm1hdGlvbi4NCg0KSXQgd291bGQgYmUgcmVhbGx5IGhlbHBmdWwgaWYgeW91IGNv
dWxkIGNsYXJpZnkgYSBiaXQgcmVnYXJkaW5nIGhvdyB0byBoYW5kbGUgdGhpcw0KZXhhY3RseS4g
V2hhdCBJIGNvdWxkIHVuZGVyc3RhbmQgZnJvbSBUb21pJyBzdWdnZXN0aW9uIGlzIHRoYXQgYWxs
IFBIWSBhdHRyaWJ1dGVzDQppbiBzdHJ1Y3QgcGh5X2F0dHJzIHNob3VsZCBoYXZlIHNpbmdsZSBw
YWlyIG9mIGZ1bmN0aW9ucyB0byBnZXQgYW5kIHNldCBhbGwgdGhlIFBIWQ0KYXR0cmlidXRlcyAo
ZS5nLiBwaHlfZ2V0X2F0dHJzIC8gcGh5X3NldF9hdHRycyksIGluc3RlYWQgb2Ygc2VwYXJhdGUg
Z2V0L3NldCBwYWlyIG9mDQpmdW5jdGlvbnMgZm9yIGluZGl2aWR1YWwgYXR0cmlidXRlIChidXNf
d2lkdGgsIG1vZGUsIG1heF9saW5rX3JhdGUgZXRjKS4gSXMgdGhpcw0KdW5kZXJzdGFuZGluZyBj
b3JyZWN0PyBJZiBzbywgaG93IHNob3VsZCB0aGUgZXhpc3RpbmcgZnVuY3Rpb25zIGZvciBidXNf
d2lkdGggYW5kDQptb2RlIGJlIHVzZWQ/DQoNClRoYW5rcyAmIHJlZ2FyZHMsDQpTd2FwbmlsDQoN
Cj4gDQo+IFRoYW5rcw0KPiBLaXNob24NCg==

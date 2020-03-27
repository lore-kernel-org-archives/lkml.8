Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402C206F8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="grn0YPw0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qM0KeN6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0KNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:13:15 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45272 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgC0KNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:13:15 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D6102C0F99;
        Fri, 27 Mar 2020 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585303994; bh=9rqs906F3siyh6RsvJgoywON8pnAR2n8KU9Dsj3Vls0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=grn0YPw0JLv4fL8J2tdaPg1vWfkZ94i0+5IqHGHgT2xoV2RRUsVRQPVDblvqxAduM
         upjOiJRFHAWFty22B1RMDT4Ve0VnZjbzNcYy5PoVICAgPfCWmCU7F46FgGnqUx3uHv
         PTVlZkpjEycFzpuwIvZLeT79L86cevdkzYCV0uQabo6S7iXzA3MRkzgCpZ//FDtbze
         gCWuJPSil8sUF3IaqAD9hfwTZzv79QxMd2GSEIwrQXR/ZZRwmrp71z9P4xOlRd5aym
         qG5VGThU3RR29XDFID6bRoNW7iH3lbzg8CuxTWm4C0V4x4dsu6hxyZ9xvSbjvbqSCd
         a/b99rr9G9BcQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4538EA006C;
        Fri, 27 Mar 2020 10:13:13 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 27 Mar 2020 03:12:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 27 Mar 2020 03:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N51fc9ZHteKWVT85Fa3yU6xpRPMWrFAGjkVl0L8+9YKVdqguG4Af07F5XmgEQ6ak8etAKVVjjy25nWlxANkTeXS9MItB1b92oqaL+aD41fKFPnICjk59KOQFnp+7vBYrur3OUm7SPPdwlEZBeh8K6rJn12MdfrXIRou9m3Yf3ik/P7qW0kryeGAnnIko1n8n74VRm/0FgEoEo8P0q3Hw31KAMXahcFKbzXRHgZf84LW0Nr/YS6L3QdJOzWAwXzc1sWz5pm80vJLqZNgKMnv9qm+O8a5CJNGud7kBgXSbAw4VJddqk1sRk0F/uK5qqRaKl08WgmxjOCu4f2heA1ZXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rqs906F3siyh6RsvJgoywON8pnAR2n8KU9Dsj3Vls0=;
 b=n2R6DjMLg0MQEqbxciEh9F7b4oUFItduFSBvFd9Z23HsFRIr6BhSGkdsk/pZhsjvAiet1TI7BD6O4TeVQu9XUztj1dBfN9dgVuY+ee9R5oEJRwE68UChJHpsTUCYQDNSoMRJDWCPDwI0PfIrK+i5IbJW/0y2iXfpeJy1EgOrz3QsR4v1VzwQUCWjaOLtc31X6A8nXKX8qRauNU/3yhgb83O9FcuUYV0IgVzwdrEzgz9gqrtLpTd1KlgobQaHGlpZm63qG4jzkQuhhUs36HLi3OL4mw6dHQH4gIgivjcPotPZOQlnmK8SPYw/SIbsorH8jGp/wlTVjRV8V4T8GzoCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rqs906F3siyh6RsvJgoywON8pnAR2n8KU9Dsj3Vls0=;
 b=qM0KeN6Yz5ePDZt2OSP6J6TRCS05X6YFlIY83c279MtM+Y8qEiD+32rzJ/1i6w7S/WgVa0wK/NSq6xCzG2BZ0QHlQWRUSsMmG7P4/ftp8bhZ/JZr5q+2+eKR1IunoapYcwuYZWw+EtE0EfPkDPy2sDCnhIHETL0g1IY8KEW7rbY=
Received: from DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12)
 by DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 10:11:59 +0000
Received: from DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::65a9:e78c:7f63:81ab]) by DM6PR12MB4251.namprd12.prod.outlook.com
 ([fe80::65a9:e78c:7f63:81ab%6]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 10:11:59 +0000
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Topic: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Thread-Index: AQHWBB3U2hXO07jC8U6J6+lTktLsnqhcOBAA
Date:   Fri, 27 Mar 2020 10:11:59 +0000
Message-ID: <11a058bc-a947-a763-680f-a11fd454925a@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
 <20200327095447.GA1698181@kroah.com>
In-Reply-To: <20200327095447.GA1698181@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joglekar@synopsys.com; 
x-originating-ip: [198.182.52.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 906ddf80-4c2e-4b14-e9ef-08d7d23749bd
x-ms-traffictypediagnostic: DM6PR12MB2681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2681AC32F5A033D124A37826A4CC0@DM6PR12MB2681.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(26005)(186003)(71200400001)(31696002)(5660300002)(2616005)(8936002)(86362001)(478600001)(2906002)(64756008)(31686004)(66476007)(66446008)(91956017)(66556008)(76116006)(36756003)(4326008)(66946007)(6512007)(8676002)(107886003)(81166006)(81156014)(54906003)(110136005)(6506007)(53546011)(316002)(6486002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB2681;H:DM6PR12MB4251.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2x/RSBlPoIf+2bf0vJa8AUYRtbSP3Uq2R5bwq/nlr2lA5zRrptWdGKkvI7f4u3bgZ9iVbyQxi7h/n9kRDDWxGJBM7RsKtVg672Jr0F/hbA0xg4Xj0KWu20KmQx11+TIHGnlCMRG5xwBBUB4gZkJgaW3r1+D2gWMG64uNF7QVE8bcd0Ab98UudsrXvRYGMPms5KkiXv7VgOqjjwHBwZ+THKc/jzheZdDzcRANy66zN5/kCzDLafquE5eagcFM5EVUmv6VjWY7QgsHiZ4c+UC7NYr5DWj8OBW5y6p9ueCMfLxBker4cGPW5aZVAJnfOATnwrkoAQ0Y0m1xKF9lxp14qUwzi6Hjcu4VUYLzZ+NI9A1TC2v8r1GS7YDf3P/D4+pvOjCjSVWCtnejhkRVPdwSSKIsHwLO8IjI8slGrTAON3zdWkNHbIf5pBTTkgZSd/laFbHVieDePvPj2W9JdRoAOL5OtLxH3zyrGRzejxR5IIAP64+vQDXIszEedTkI8BR
x-ms-exchange-antispam-messagedata: cK/ldNWITdUDTf9T66ncBX82lRczY0wBNEjnxQv+3vIgSoCleELlUL2PWyC+ZPAVl/kLloAj8i0Zm3kO8ieHxGmHOLOlz7ThCHXeZgG6nR0A+shYx7yv8R0acplW1BD1x6LVujxA3vAp326M6a/SOQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B9B2981A9EB8F44B39ECBADF2AABB52@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ddf80-4c2e-4b14-e9ef-08d7d23749bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 10:11:59.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epOv89I1URObmqFvOV1nbB2vKVRCGXHbRadSFN0wzS5Qw4w2pCenYhjOUJbvZTX3SSZH6U6GLyp25EVbYYvrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiAzLzI3LzIwMjAgMzoyNCBQTSwgR3JlZyBLSCB3cm90ZToNCj4gT24gRnJpLCBNYXIg
MjcsIDIwMjAgYXQgMDM6MTE6NTZQTSArMDUzMCwgVGVqYXMgSm9nbGVrYXIgd3JvdGU6DQo+PiBU
aGlzIGNvbW1pdCBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciBjb25zb2xpZGF0ZS1zZ2wsIGFu
ZA0KPj4gc25wcyxjb25zb2xpZGF0ZS1zZ2wgcHJvcGVydHkuIFRoZXNlIHdoZW4gc2V0IGVuYWJs
ZXMgdGhlIHF1aXJrIGZvcg0KPj4gWEhDSSBkcml2ZXIgZm9yIGNvbnNvbGlkYXRpb24gb2Ygc2cg
bGlzdCBpbnRvIGEgdGVtcG9yYXJ5IGJ1ZmZlciB3aGVuIHNtYWxsDQo+PiBidWZmZXIgc2l6ZXMg
YXJlIHNjYXR0ZXJlZCBvdmVyIHRoZSBzZyBsaXN0IG5vdCBtYWtpbmcgdXAgdG8gTVBTIG9yIHRv
dGFsDQo+PiB0cmFuc2ZlciBzaXplIHdpdGhpbiBUUkIgY2FjaGUgc2l6ZSB3aXRoIFN5bm9wc3lz
IHhIQy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUZWphcyBKb2dsZWthciA8am9nbGVrYXJAc3lu
b3BzeXMuY29tPg0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9kd2MzLnR4dCAgICAgfCAzICsrKw0KPj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvdXNiLXhoY2kudHh0IHwgMyArKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL2R3YzMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9kd2MzLnR4dA0KPj4gaW5kZXggOTk0NmZmOWJhNzM1Li4yOTJkMWY3OTY5ZTQgMTAw
NjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMu
dHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMu
dHh0DQo+PiBAQCAtMTA0LDYgKzEwNCw5IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+PiAgCQkJ
dGhpcyBhbmQgdHgtdGhyLW51bS1wa3QtcHJkIHRvIGEgdmFsaWQsIG5vbi16ZXJvIHZhbHVlDQo+
PiAgCQkJMS0xNiAoRFdDX3VzYjMxIHByb2dyYW1taW5nIGd1aWRlIHNlY3Rpb24gMS4yLjMpIHRv
DQo+PiAgCQkJZW5hYmxlIHBlcmlvZGljIEVTUyBUWCB0aHJlc2hvbGQuDQo+PiArIC0gc25wcyxj
b25zb2xpZGF0ZS1zZ2w6IGVuYWJsZSBzZyBsaXN0IGNvbnNvbGlkYXRpb24gLSBob3N0IG1vZGUg
b25seS4gU2V0IHRvIHVzZQ0KPj4gKwkJCVNHIGJ1ZmZlcnMgb2YgYXQgbGVhc3QgTVBTIHNpemUg
YnkgY29uc29saWRhdGluZyBzbWFsbGVyIFNHDQo+PiArCQkJYnVmZmVycyBsaXN0IGludG8gYSBz
aW5nbGUgYnVmZmVyLg0KPj4gIA0KPj4gICAtIDxERVBSRUNBVEVEPiB0eC1maWZvLXJlc2l6ZTog
ZGV0ZXJtaW5lcyBpZiB0aGUgRklGTyAqaGFzKiB0byBiZSByZWFsbG9jYXRlZC4NCj4+ICAgLSBz
bnBzLGluY3ItYnVyc3QtdHlwZS1hZGp1c3RtZW50OiBWYWx1ZSBmb3IgSU5DUiBidXJzdCB0eXBl
IG9mIEdTQlVTQ0ZHMA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvdXNiLXhoY2kudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi91c2IteGhjaS50eHQNCj4+IGluZGV4IDNmMzc4OTUxZDYyNC4uYTkwZDg1MzU1N2Vl
IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91
c2IteGhjaS50eHQNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvdXNiLXhoY2kudHh0DQo+PiBAQCAtNDMsNiArNDMsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVz
Og0KPj4gICAgLSBxdWlyay1icm9rZW4tcG9ydC1wZWQ6IHNldCBpZiB0aGUgY29udHJvbGxlciBo
YXMgYnJva2VuIHBvcnQgZGlzYWJsZSBtZWNoYW5pc20NCj4+ICAgIC0gaW1vZC1pbnRlcnZhbC1u
czogZGVmYXVsdCBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBpbnRlcnZhbCBpcyA1MDAwbnMNCj4+ICAg
IC0gcGh5cyA6IHNlZSB1c2ItaGNkLnlhbWwgaW4gdGhlIGN1cnJlbnQgZGlyZWN0b3J5DQo+PiAr
ICAtIGNvbnNvbGlkYXRlLXNnbDogaW5kaWNhdGUgaWYgeW91IG5lZWQgdG8gY29uc29saWRhdGUg
c2cgbGlzdCBpbnRvIGENCj4+ICsgICAgdGVtcG9yYXJ5IGJ1ZmZlciB3aGVuIHNtYWxsIFNHIGJ1
ZmZlciBzaXplcyBkb2VzIG5vdCBtYWtlIHVwdG8gTVBTDQo+PiArICAgIHNpemUgb3IgdG90YWwg
dHJhbnNmZXIgc2l6ZSBhY3Jvc3MgdGhlIFRSQiBjYWNoZSBzaXplLg0KPiANCj4gU2hvdWxkbid0
IHRoaXMgcmVmZXIgdG8gdGhlIGZhY3QgdGhhdCB0aGUgaGFyZHdhcmUgaXMgYnJva2VuPyAgT3Ro
ZXJ3aXNlDQo+IHdoeSB3b3VsZCBhbnlvbmUga25vdyBpZiB0aGV5IHNob3VsZCwgb3Igc2hvdWxk
IG5vdCwgZW5hYmxlIHRoaXMgb3B0aW9uPw0KPg0KV2UgaGF2ZSBub3Qgc2VlbiBpc3N1ZSB3aXRo
IExpbnV4IGVudmlyb25tZW50IGZvciBub3cuIEJ1dCB3aXRoIG90aGVyIE9TIHdpdGgNClNHIGxp
c3Qgd2l0aCB2ZXJ5IHNtYWxsIGJ1ZmZlciBzaXplcyB0aGUgeEhDIGNvbnRyb2xsZXIgaGFuZyB3
YXMgc2Vlbi4gU28gDQpjdXJyZW50bHkgaW50cm9kdWNpbmcgdGhlIGJpbmRpbmcgYXMgb3B0aW9u
YWwgb25lLiBPbmUgY291bGQgZW5hYmxlIHRoaXMgDQpvcHRpb24gd2hlbiB4SEMgaGFsdCBoYXBw
ZW5zIGR1ZSB0byBzbWFsbCBTRyBsaXN0IHNpemVzLiAgDQogDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQo+IA0KDQpUaGFua3MgJiBSZWdhcmRzLA0KIFRlamFzIEpvZ2xla2FyDQo=

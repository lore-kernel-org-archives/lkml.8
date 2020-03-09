Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5DFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42D420409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="SF4KwZgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCIKfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:35:13 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:6126
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgCIKfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:35:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt4E8CnHoTyYdBYMByvFIJ1WZOs+gRj371xaYH/o+a0Cuc8B2z7iOYcMsThcSnKkIa8E+vc/gP2S1GGt5LvKygVn0Fj2J6BfEw4N21jWyyb77CDxz1IOgF54QAWVtpLL3z9YqyZLBPe6sIZr7bVkit7fu7iFNRxq0rvtEhsG6KkJ8XBQZrQLy2odo+qnBEd6fADGLEH30xuhapziNilQEyxhyxA4a81awLdZkI1rqu33XLw5U+fGfO0mEM5ZVCyr/7jrKGJhDb7DSjgg1lEH34utStLYOYj78NpyReyRG8xV4QI5tCz3qTSzUpmTLTdx1nzaTTa8z0ekvOiWHe1/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G12k4CnTN/LxeCnLhY+q8Mq8GIC1Fyx5m7V/IJySAk=;
 b=GsJkMpOWq81pyhS2dmZF/Az4c8W0T+WWc1g+JoKSGg1x93SAl+pnz2PP5BC4DuhUzfGXM62QKCphwIC/KEwA0lizu/ZRe4UjgFiCYLWzHH/IkSqLsPLWP06ksJuguNlsKMScOqDtvJlOhT+wNCYr24mVumMGUIglpPDtcnkOr7MDjV8lPySX81cb+vOkjmWIAQN8yTlgapJmi9UeQaII4Vi8nADS6uohwp/s1mKOq9N+QSeqPskZPnIHdvQWoXX4kjGkgfxVEyGqvBObtkbCqjXpAYsby78+5JGgFa1HnNMLMcoR/NaFE8S1ADu1NHADvB+L8lzBcIsNLzp1lrgHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G12k4CnTN/LxeCnLhY+q8Mq8GIC1Fyx5m7V/IJySAk=;
 b=SF4KwZgbCp9f6sgYr8m9w3ww8FdcsTim4/i/JYgIc+Gmhy/ks5YFjk59GElxiSumlSxV3vXNVjVIeosnL3VAICuG5pdOM/3V5vGW0FPMEV1ZT6TxIk/GVuwGkY8ujTRk+ogOmMThlMJ/DcWuADRNP89E0xWb3hg1fz9T2iILEsU=
Received: from MN2PR08MB6397.namprd08.prod.outlook.com (2603:10b6:208:1aa::10)
 by MN2PR08MB6399.namprd08.prod.outlook.com (2603:10b6:208:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 10:35:11 +0000
Received: from MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4]) by MN2PR08MB6397.namprd08.prod.outlook.com
 ([fe80::884a:b0f5:3cf5:f4a4%4]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 10:35:11 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 0/6] Add new series Micron SPI NAND devices
Thread-Topic: [EXT] Re: [PATCH v5 0/6] Add new series Micron SPI NAND devices
Thread-Index: AQHV9f4hHhuTnsoUdkK9rZQqVPh4kKhAEIOA
Date:   Mon, 9 Mar 2020 10:35:10 +0000
Message-ID: <MN2PR08MB6397F6BCA6F0D597C66C0B44B8FE0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
 <20200309113256.6c6751f8@xps13>
In-Reply-To: <20200309113256.6c6751f8@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTU3OWI3NmMtNjFmMS0xMWVhLWIxZWEtOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XGE1NzliNzZlLTYxZjEtMTFlYS1iMWVhLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iMTkwMSIgdD0iMTMyMjgyMjM3MDg5NjUxNTgwIiBoPSIrM0xUOFphNElFZGlzQ1oxbHFzcmlaMTlqOEk9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIQUFBQUI4bTlKbi92WFZBZHRaWHBsTEdZK0kyMWxlbVVzWmo0Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFCQUFBQUlTQjI1d0FBQUFBQUFBQUFBQUFBQUE9PSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.86.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78490234-f4e9-4647-5378-08d7c4158b82
x-ms-traffictypediagnostic: MN2PR08MB6399:|MN2PR08MB6399:|MN2PR08MB6399:
x-microsoft-antispam-prvs: <MN2PR08MB6399246402B39FA8D1BECD2EB8FE0@MN2PR08MB6399.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(7696005)(54906003)(6506007)(110136005)(55236004)(316002)(66574012)(86362001)(4326008)(478600001)(71200400001)(81166006)(186003)(26005)(2906002)(33656002)(8936002)(81156014)(8676002)(9686003)(966005)(55016002)(52536014)(66946007)(66556008)(66476007)(64756008)(66446008)(5660300002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6399;H:MN2PR08MB6397.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwXeaQEWvh6EKSaprj35i7zKF7+Jgw0RBBJhpK5qiVDmn13yUCQJilFZFGsY/PKzpKSIT9M4+gRlbkC57493AIPa8zJQpURU5tGJydj9ixAGDGjVvKtvpyqqj4VWH35SGbkW2QPuLXAnXCL3CZDPMlBlmE4hVMT3AgWq1oiDGqJuqBpOBdrF2Inz+19B1yCVsxXXeqJZ6f7LNCDQoktomizkNoGPgjRp3AeqQ33qPPMGybwQtCjkTmCUSTN2PqL/hbU17Sx81toBZG4fLKdT/w+5ZJb5V9rtuG8SNQVVFnZesS4Umv+h5vwZZahW/JWwjINYcWNv8pEw1OyvFMAQOzThY1FDe0N/aZYTIV/WW2wJZ6X4ulOlsyOYNdaaXXgrNeje+cWDr6YDchRs32y00DfzNjbmLpiZeVidVsM3IhR1CrMmS6g3wfw9YlCNX+W29KTk44HuAR7e3NI0feVwNTI8kJFCznkhnz7WvBRLQw1WmTKA+xfOMrOls8/ryMf6a6+hHXCcN+tf7kJD5VLsvg==
x-ms-exchange-antispam-messagedata: ZJL8U+dplhY9Pp3l3Qpiztan0WQ6nLygFsmllKYoKwZX6tdfY+TKx9caarG6mNmqMCobtJInEFpm6Y6IeG9iKNHoI6MGDz7qXqBIgy9ezyDdqxPzjsD34P4pw4NA4bsOD8NKL6d5dmKpTzj2RFaUvw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78490234-f4e9-4647-5378-08d7c4158b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 10:35:10.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHNK+U6MIu6oTekujtelOLbxHpacyeJOOE2g/QC2NT1OcFiV6LrIMe+VuDqoXGc9ua8WJJmqnc/MN11atGGsxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IA0KPiBIaSBTaGl2YSwNCj4gDQo+IHNoaXZhLmxpbnV4d29ya3NAZ21h
aWwuY29tIHdyb3RlIG9uIEZyaSwgMjggRmViIDIwMjAgMTY6MDM6MDUgKzAxMDA6DQo+IA0KPiA+
IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+
DQo+ID4gVGhpcyBwYXRjaHNldCBpcyBmb3IgdGhlIG5ldyBzZXJpZXMgb2YgTWljcm9uIFNQSSBO
QU5EIGRldmljZXMsIGFuZCB0aGUNCj4gPiBmb2xsb3dpbmcgbGlua3MgYXJlIHRoZWlyIGRhdGFz
aGVldHMuDQo+ID4NCj4gPiBNNzhBOg0KPiA+IFsxXSBodHRwczovL3d3dy5taWNyb24uY29tL34v
bWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNoZWV0L25hbmQtZmxhc2gvNzAtc2Vy
aWVzL203OGFfMWdiXzN2X25hbmRfc3BpLnBkZg0KPiA+IFsyXSBodHRwczovL3d3dy5taWNyb24u
Y29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNoZWV0L25hbmQtZmxhc2gv
NzAtc2VyaWVzL203OGFfMWdiXzFfOHZfbmFuZF9zcGkucGRmDQo+ID4NCj4gPiBNNzlBOg0KPiA+
IFszXSBodHRwczovL3d3dy5taWNyb24uY29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2Rh
dGEtDQo+IHNoZWV0L25hbmQtZmxhc2gvNzAtc2VyaWVzL203OWFfMmdiXzFfOHZfbmFuZF9zcGku
cGRmDQo+ID4gWzRdIGh0dHBzOi8vd3d3Lm1pY3Jvbi5jb20vfi9tZWRpYS9kb2N1bWVudHMvcHJv
ZHVjdHMvZGF0YS0NCj4gc2hlZXQvbmFuZC1mbGFzaC83MC1zZXJpZXMvbTc5YV9kZHBfNGdiXzN2
X25hbmRfc3BpLnBkZg0KPiA+DQo+ID4gTTcwQToNCj4gPiBbNV0gaHR0cHM6Ly93d3cubWljcm9u
LmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLQ0KPiBzaGVldC9uYW5kLWZsYXNo
LzcwLXNlcmllcy9tNzBhXzRnYl8zdl9uYW5kX3NwaS5wZGYNCj4gPiBbNl0gaHR0cHM6Ly93d3cu
bWljcm9uLmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLQ0KPiBzaGVldC9uYW5k
LWZsYXNoLzcwLXNlcmllcy9tNzBhXzRnYl8xXzh2X25hbmRfc3BpLnBkZg0KPiA+IFs3XSBodHRw
czovL3d3dy5taWNyb24uY29tL34vbWVkaWEvZG9jdW1lbnRzL3Byb2R1Y3RzL2RhdGEtDQo+IHNo
ZWV0L25hbmQtZmxhc2gvNzAtc2VyaWVzL203MGFfZGRwXzhnYl8zdl9uYW5kX3NwaS5wZGYNCj4g
PiBbOF0gaHR0cHM6Ly93d3cubWljcm9uLmNvbS9+L21lZGlhL2RvY3VtZW50cy9wcm9kdWN0cy9k
YXRhLQ0KPiBzaGVldC9uYW5kLWZsYXNoLzcwLXNlcmllcy9tNzBhX2RkcF84Z2JfMV84dl9uYW5k
X3NwaS5wZGYNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjQ6DQo+ID4gLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPg0KPiA+IDEuIFBhdGNoIDIgaXMgc2VwYXJhdGVkIGludG8gdHdvIGFzIHBlciB0aGUg
Y29tbWVudCBieSBCb3Jpcy4NCj4gPiAyLiBSZW5hbWVkIE1JQ1JPTl9DRkdfQ09OVElfUkVBRCBp
bnRvIE1JQ1JPTl9DRkdfQ1IuDQo+ID4gMy4gUmV3b3JrZWQgZGllIHNlbGVjdGlvbiBmdW5jdGlv
biBhcyBwZXIgdGhlIGNvbW1lbnQgYnkgQm9yaXMuDQo+IA0KPiBJIHdhcyBhYm91dCB0byBhcHBs
eSB0aGlzIHNlcmllcyBidXQgdW5mb3J0dW5hdGVseSBpdCBpcyBub3QgYmFzZWQgb24NCj4gdjUu
Ni1yYzEgc28gbm8gcGF0Y2ggYXBwbGllcyBjb3JyZWN0bHkuIENhbiB5b3UgcGxlYXNlIHJlYmFz
ZSBhbmQgc2VuZA0KPiBhIHY2IHNvb24/DQoNClN1cmUsIEkgd2lsbCBkbyBpdC4NCg0KVGhhbmtz
LA0KU2hpdmENCg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQo=

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3500CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B852073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="IRVybI1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgC3GJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:09:53 -0400
Received: from mail-eopbgr150130.outbound.protection.outlook.com ([40.107.15.130]:12257
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgC3GJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiYCn1nH0BmImQJjVF71zKnMLv2HbIeLlnarUXoBhqvwz3T5HN37D5qpOqdyNC+7K1ix/EFKUSjvWczDP1YzOurkRDjh23dzARfTWf/77b/5YUuxXhi3tM27dBw6b0/YpRCO4xFjwosClJMFG97k1nFofFU9coPDsSuWr29FJi+7OBREvXOya4im58nEj8YoB1C/dFaIne4weTzw2Isww3JL3QO0mCXBFSNOmCQOSOLQM1aM+fej5OUrsPEYf7vWv+3SdaZfXKXTpFT2B4wbM+tPYCKu8MtNWs/g9i086i6aNeSfaSS8T8BPxUmO6veUF3rf6D2x40Kzz5nSe3oiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh2BwqhTDvYnvi2oRbFa035QqJOLhmrRKOWcenERX3k=;
 b=lnRYO0/UZk/JNKGZzpy6s/n42QmE1SekuNBF+oAutv7lva5D4+50sjEZDlCtidoAnSwUHBAly72uknPbDuTzSDmmiNK2Ej5uXCdlO0g8ajAPysWRi96/yPEuhxBXMZ+Eo4mVe89I6sHhAfIaIqLYjxq/s7Aai7fU6UfhMvJ7zjz9ZlhaT2d0KSdYiAeVbJ3lqMW6MATwMyDEQMaH+1A+SjQ5ZiMdfir5t1w5C9oEv/G0o0FLBKkjVT6MCYSwgDDR8nwcZzpKs+Y1ZuJdNGfm1bNuIRLEj2UgtQBTbzQmBghTdwLy66/SZEPpLvB8QPRf/el4yDAC+qq6w4Pr7TcP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh2BwqhTDvYnvi2oRbFa035QqJOLhmrRKOWcenERX3k=;
 b=IRVybI1t1z7LS8nGQFKO0yJs0L8aALimoKGWZ+sdfFGvDspNs5aY7muR7kZgOo+tUr49SV7EZ6qVoN9J6ReEjrhNaQ7dy0E0U++aPDZvEkX4bnBMAn0iMy1SSZ9k1rY/piMFUmCyTPGdnx9PajbZ5xKLVUW7/gmBiXVCDaAdAmM=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB3874.eurprd02.prod.outlook.com (52.134.80.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 06:09:49 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 06:09:49 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5/6] habanalabs: print warning when reset is requested
Thread-Topic: [PATCH 5/6] habanalabs: print warning when reset is requested
Thread-Index: AQHWBN5E+OQul0VFOkSPXBDPFVs+fKhgqUgg
Date:   Mon, 30 Mar 2020 06:09:49 +0000
Message-ID: <AM0PR02MB55239D7C6F4458F848654528B8CB0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
 <20200328085238.3428-5-oded.gabbay@gmail.com>
In-Reply-To: <20200328085238.3428-5-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.15.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8511c4f-a9dc-4d54-8c89-08d7d470f442
x-ms-traffictypediagnostic: AM0PR02MB3874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB3874AC187555731C3E87F5F6B8CB0@AM0PR02MB3874.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39840400004)(4326008)(2906002)(6636002)(9686003)(5660300002)(4744005)(186003)(52536014)(53546011)(8936002)(26005)(71200400001)(55016002)(316002)(76116006)(7696005)(6506007)(33656002)(110136005)(8676002)(66946007)(66446008)(66556008)(81166006)(81156014)(64756008)(478600001)(66476007)(86362001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HB+mXPLLQm7QoEgWrtFqsNp3bENke1CHGFyGO0Gf3OR1fuZAWI2YoBV175IgZ71f/HaLYP6VcoF4wODWexGQ0TXc+bMUvfF1v2SZIZ3GP8YyXpatNSXoC2MGMMUDA11K/yXgN9wkAMCYTAd7ZiMRVwYUFqY1iXJOGek7tlvZk6WLRqUpNMgTyASADF4DNawTTBMC0gu07qzxmxv6shmtICOx6kiNrLCNe0nxlF6Hy5ewnETpTahmiryD028GDahrZHUXcRmXelny23WzxWksFIblZWzMtJ1b5yGjeHqyrsRMZNP1cxfCliJln56GBXN9OyazgBTf6PH0rRBVHlHNZTwVbahhYeRHvhia92CO5PnfDMeYQBPnmkAl+sGwDbi27WaVkAvQ2Rwf/BvTSCROcnRw5SRJNqZiryw5ecZX4iq6NzQ0tsN63XbG856Xhug
x-ms-exchange-antispam-messagedata: sP+IDPvj9TXGO2w3ZwJHrJDsmvdrHKw/c+YynzD/goyocvQMJBjlycErrq3F3e3UySB1sqepuQN9yW7Cp6bnw7eKtkGQtO1Vo8RtIBoz1QaWXZUcPwEfLxvM9kVHlG2HoSyrMsDRGflITwv6G8nn2Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: d8511c4f-a9dc-4d54-8c89-08d7d470f442
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 06:09:49.4932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOO0JknLCJKdsmq0Owxmf6bQ8DuOBss9VmKT07qNlhCozJ32CBBNmyfLqh4aZxU845N9JKpQXMlBBpDz9GfrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgMTE6NTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBXaGVuIHRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRvciBhc2tz
IHRoZSBkcml2ZXIgdG8gc29mdCBvciBoYXJkIHJlc2V0IHRoZSBkZXZpY2UNCj4gdGhyb3VnaCBz
eXNmcywgdGhlIGRyaXZlciBzaG91bGQgZGlzcGxheSBhIHdhcm5pbmcgaW4gdGhlIGtlcm5lbCBs
b2cgdG8gZXhwbGFpbg0KPiB3aHkgaXQgc3VkZGVubHkgcmVzZXRzIHRoZSBkZXZpY2UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=

Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A6C11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A16208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="nHEtHXgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgBTPOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:14:53 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:37091 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728477AbgBTPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:14:52 -0500
Received: from [100.112.135.241] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 21/AA-41136-862AE4E5; Thu, 20 Feb 2020 15:14:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfUxTVxzt7Xt97xXp9gSUK5sGGpYhoV0LG3k
  qurkR8ticGw6VyOYso9KatrC2QNnIwuJwpsiHghlUoLXABojC2BwfRXCADoGAKegIyoiIDPAD
  J1MREPYeD932z805v3Puuecm9xKIWwnuRShNRqVep9CIMRc0bt0kLtlv375XNuTwpSZy2gB1L
  H8RoVp+h1T3nSGc6n84hVHmkzLqYEk1Rp1oC6EKx04D6oe+akCV/12AU32NhRjVYZlFqcm2AY
  w61TSOUOWV+eAtkm6wDOG0rTaRnjsP6J/K/enrV5swuvhSBN1SVIXTwxm/8WmHbZpPTzVfwej
  p2nUfrtgjUOti4k37BKrF8wOChBofk+P4DJIGZrzNwIVwIxcBHDsyjnNkHMCun0cRjqTz4Z30
  M3wzEDJkHsCSU56sAMgyBBZmVuEcuYhCe0X3MqkBMGN2GrAEJR0ILC1M43NhuXzYc2gA48gIg
  ENXzuJsMkb6QeuJApQVPMgcxvV93tJ+hBxEoCW9WsC63Mk98FuzgxEIxhUNm62hHAyEQ2e2sA
  6UfAW2fteGs2MRuQ8et5q44qnw7sGypaOEZATMzq/DWAzI1fBxZ9XS5RDSEw6OWpcwJElY2tS
  LcHgVnLi5IOD8O+HguSMCbu4NG7Mblv1rodOaATj8PqyoqlueB8Bf+vNQDofAC3/aULYaJH3h
  QmsKN46HHQ8r0BwQZPlPCwvjQsj1sLrxNW7sA/MybuAsFpEr4aWCUdQG0EoQHKNXx6mMWoVaI
  5HLZBK5PFAiDwqUBEsVX0hipIkGSbLSYJQEShXJBqkhRfuZJlaqUxprAfNGYxO+wepB7+kpaS
  tYQ/DFq0S7s7fvdXshJj42RaUwqD7VJ2qUhlbwMkGIochsY7SVemWc0rRfrWFe+jMZEq5iD9G
  ElZFFhgSF1qCO46ROsIHImSiyI8S9JyXM2l5UZkfcUF28TunlKUpg80h2gypR9zzu2d9xgrVe
  7iLA4/HcXBOUeq3a+H99EngSQOwuimJTXNU64/NTJ5lCfKbQlPs2tpBR8a/klcaH87P3d3Ruq
  G91hqYcTR3O/Ss0Uu5zaHzE5aOF0qDDsuvRG28mhTnmr222XqzeuqVmLvX2o5ie0k2vhn3p4Z
  T5+Y2PnR0WWng9X/mvGTzA67pftj5gR2XSH5KZkk/sSdGR5pDDZaQs+vI7n/u+3r5JqdG2K8Y
  C3kj5evXYe5bw25SPd+dO+oET74rO0sdGvbnN9cKKX+dq8hpCYz1Hi7NvXa7nh7VkVW7Oqhmu
  ExYJX3pa/2iX6cdehHf3Wlxke3DUSP/RD158es4r/N2iAUta9y1xcG7nyeS+vExHfTH2JOftj
  Zl25+77/fe0EX61NolGrtZXXe1QH9jV9vhBuGVr8w2hBX4sRg0qhdwf0RsU/wAXs/vFtgQAAA
  ==
X-Env-Sender: mpearson@lenovo.com
X-Msg-Ref: server-32.tower-346.messagelabs.com!1582211682!75939!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11895 invoked from network); 20 Feb 2020 15:14:45 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-32.tower-346.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2020 15:14:45 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 44D522E4C184FFB761FA;
        Thu, 20 Feb 2020 23:14:39 +0800 (CST)
Received: from reswpmail02.lenovo.com (10.62.32.21) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2; Thu, 20 Feb
 2020 10:14:31 -0500
Received: from va32wusexedge01.lenovo.com (10.62.123.116) by
 reswpmail02.lenovo.com (10.62.32.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1779.2
 via Frontend Transport; Thu, 20 Feb 2020 07:14:31 -0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.57)
 by mail.lenovo.com (10.62.123.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1779.2; Thu, 20 Feb 2020 23:14:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc5u79maBXN3IoVNeWaba8o1mc2pPZpSOKQDxFCodcUR5SfSwTGzzBBYKn8/PTjOIh2qGd2pfVuuZUFQQeO+mL+SskGhhspxtvL0kqNmCEFTimlcn8xZ3cSTFakTP8x/AxHR/t7R/LIkB9EpTaQ+5Z0iUp05gGeEs2Dt5a1kOQ0yUrxJt2wZxg8OhAlBAoyXi4gBizTQUoaNnqO+TwNcaL0yGphxN5fIANLebjUx9POhln2x35yTC07IoMAU6TJRC+TTrovFahQkFq/YJZ6Kgtrfk90A2JewW2U2dLcqUiiEBhSh81D5sP57xNcgrYqanzdJ0X6XJ7TGVFpJ97CvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGWowALbmCst9N7V+BOIDhQPc21SXUxxPEtCbFvYGtU=;
 b=VdlJ5uaLEV4lg3y7kzyAqMlDY5UkQ3eKeYTShgaPhUqU8aLGpxfFOf/3qujxqOmjNh3mN4vJPnSb0I5jrGeUPyM8Y27GSwglQDqTO4fGQTMbUgsTg2Lr0XvsIq3Ws4sKsEI8QCE4ptCigSRg0N179izSLQ/MTyrwNWGDBH1AGDaQ6ezDUY2PNFvvPlBW9YObYFQB0iqXdpCGmj51WJk5ZGT+xnj0Atk4GAA7LkfRJG6/HUe0I8VNxuY9ZzefGhvyzLqLC8PWgq7roYqENkRR2xXljWAJP+P1DA0SVU0jWeVdNxZ3r7DhkSXXogZDvvOmFHmTHQ6ZVRdqp+86XbIf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGWowALbmCst9N7V+BOIDhQPc21SXUxxPEtCbFvYGtU=;
 b=nHEtHXgKN0ei5F5XHmEdUfmIRGjcGUIR9BbQG50xLij+1rWPxJ5g7ev5nElgluAuEzeEkyKENFPyr9DFQ8X4JJNotPBSrFl1Fu9GeI2tHJblnQN7O4LOB6dEbE3oQE7T7U/1miwjzP9h7RS+/PGN2KmIcN+k9PaIw6kYKs3kcDY=
Received: from HK2PR0302MB2593.apcprd03.prod.outlook.com (10.170.146.17) by
 HK2PR0302MB2609.apcprd03.prod.outlook.com (10.170.149.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9; Thu, 20 Feb 2020 15:14:26 +0000
Received: from HK2PR0302MB2593.apcprd03.prod.outlook.com
 ([fe80::20bc:254b:6c9:b694]) by HK2PR0302MB2593.apcprd03.prod.outlook.com
 ([fe80::20bc:254b:6c9:b694%10]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 15:14:26 +0000
From:   Mark Pearson <mpearson@lenovo.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nitin Joshi <nitjoshi@gmail.com>,
        Mat King <mathewk@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>
CC:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Thinkpad-acpi devel ML" <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [External]  Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
Thread-Topic: [External]  Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
Thread-Index: AQHV59qPOpC1IkCjDkm9hRYaaz1mrqgkLFhg
Date:   Thu, 20 Feb 2020 15:14:25 +0000
Message-ID: <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com>
References: <20200220074637.7578-1-njoshi1@lenovo.com>
 <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
In-Reply-To: <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.48.229.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58a4cd3c-0015-4f89-5271-08d7b61792db
x-ms-traffictypediagnostic: HK2PR0302MB2609:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0302MB2609F81AF71A1235858D9B04BD130@HK2PR0302MB2609.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(7696005)(9686003)(5660300002)(52536014)(966005)(8676002)(81166006)(55016002)(33656002)(7416002)(478600001)(81156014)(54906003)(110136005)(71200400001)(26005)(66476007)(66946007)(76116006)(66556008)(66446008)(64756008)(186003)(86362001)(316002)(53546011)(4326008)(8936002)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0302MB2609;H:HK2PR0302MB2593.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAUMAejA6vHWKqRV6Y7VlrX6zJqpsOIik1JmxpvSyg1DrVjF1ER+50oOmJJ2kIgzyMg2BUMt67GWNkXnot/Zc5uNd2KU9inyXDMCpyQBZ25xf2Kye+Dk7ByMQI7xyEY652wi7K8RwiQvntWzLiK7oSahKuMFN9vUUXnkuQUfWabenmwmN3C7DRzzZG+puKqcdMOoMD6drbQOZc+gPRo9HMMqduyoAmBzM8yEKO/2MCiAj1hw2tLh78D8TXb6zqhFrdBXNSiHV+tpoSyQa+9O6HGGpkkFjw+zfGJiypNPfDGiQAVtCa4TgHKncexrS9GzWwKivUjrWwXZBC3N8Hqqh2QCqVsEvgLLS7MqBKIF/asOgL3aJZXKjuN6ZZDWlS10wzuvKvNIPzJB5nmdzMe5bAl6Bo9nZPry2WrYEhCFwgS6CEQ0wtSH1CxE8+CBde9V9JGSEzkW7caOH3IKdd3TzLfwct59/r/uLE/I18FgUxatqemmsq/4qZTQ+KYII8UuWxrumb0NHgMJ4fpoDpzSqw==
x-ms-exchange-antispam-messagedata: GD0kU7ARgXwv61Z+GmxJ6AYbKvmaoC0fZg/dICMaoiJo8g/MsVVFUffrMiNH9hqjQeIEvk/HRLC/sU+7pNGUzs1u4a8VfQqlNC1ncwbpb47ZSOJQ9YuE8ZyNQ7iFsc/3QN+2wqEp/lKAAc1JGzdiYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a4cd3c-0015-4f89-5271-08d7b61792db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 15:14:25.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5qn2QB5seEfTIUEKFsqsVPDMDB86jtAQEy5pI5aScyaoXtWwRkluE7ssoTb9B8+5QRPGps83HGAgfF0DNGs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2609
X-OriginatorOrg: lenovo.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hl
dmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZl
YnJ1YXJ5IDIwLCAyMDIwIDU6NDMgQU0NCj4gDQo+IE9uIFRodSwgRmViIDIwLCAyMDIwIGF0IDk6
NDggQU0gTml0aW4gSm9zaGkgPG5pdGpvc2hpQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiAg
IFRoaXMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgb24gc29tZSBUaGlua3BhZCBwcm9kdWN0cyBsaWtl
IFQ0OTBzLCBUaGlua3BhZA0KPiA+ICAgWDEgeW9nYSA0dGggR2VuIGV0YyAuIFRoZSBsY2RzaGFk
b3cgZmVhdHVyZSBjYW4gYmUgZW5hYmxlZCBhbmQgZGlzYWJsZWQNCj4gPiAgIHdoZW4gdXNlciBw
cmVzcyAiRm4iICsgIkQiIGtleS4gQ3VycmVudGx5LCBubyB1c2VyIGZlZWRiYWNrIGlzIGdpdmVu
IGZvcg0KPiA+ICAgdGhpcyBhY3Rpb24uIEFkZGluZyBhcyBzeXNmcyBlbnRyeSBhbGxvd3MgdXNl
cnNwYWNlIHRvIHNob3cgYW4gT24gU2NyZWVuDQo+ID4gICBEaXNwbGF5IHdoZW5ldmVyIHRoZSBz
ZXR0aW5nIGNoYW5nZXMuDQo+ID4NCj4gPiAgIFN1bW1hcnkgb2YgY2hhbmdlcyBpcyBtZW50aW9u
ZWQgYmVsb3cgOg0KPiA+DQo+ID4gIC0gQWRkZWQgVFBfSEtFWV9FVl9MQ0RTSEFET1dfQ0hBTkdF
RCBmb3IgY29uc2lzdGVuY3kgaW5zaWRlIHRoZQ0KPiBkcml2ZXINCj4gPiAgLSBBZGRlZCB1bm1h
cHBlZCBMQ0RTSEFET1cgdG8ga2V5bWFwDQo+ID4gIC0gQWRkZWQgbGNkc2hhZG93X2dldCBmdW5j
dGlvbiB0byByZWFkIHZhbHVlIHVzaW5nIEFDUEkNCj4gPiAgLSBBZGRlZCBsY2RzaGFkb3dfcmVm
cmVzaCBmdW5jdGlvbiB0byByZS1yZWFkIHZhbHVlIGFuZCBzZW5kIG5vdGlmaWNhdGlvbg0KPiA+
ICAtIEFkZGVkIHN5c2ZzIGdyb3VwIGNyZWF0aW9uIHRvIHRwYWNpX2xjZHNoYWRvd19pbml0DQo+
ID4gIC0gQWRkZWQgbGNkc2hhZG93X2V4aXQgdG8gcmVtb3ZlIHN5c2ZzIGdyb3VwIGFnYWluDQo+
ID4gIC0gSW1wbGVtZW50ZWQgbGNkc2hhZG93X2VuYWJsZV9zaG93L2xjZHNoYWRvd19lbmFibGVf
c3RvcmUNCj4gPiAgLSBBZGRlZCBoYW5kbGVyIHRvIHRwYWNwaV9kcml2ZXJfZXZlbnQgdG8gdXBk
YXRlIHJlZnJlc2ggbGNkc2hhZG93DQo+ID4gIC0gRXhwbGljaXRseSBjYWxsIHRwYWNwaV9kcml2
ZXJfZXZlbnQgZm9yIGV4dGVuZGVkIGtleXNldA0KPiANCj4gQWRkaW5nIGN1c3RvbSBQcml2YWN5
R3VhcmQgc3VwcG9ydCB0byB0aGlzIGRyaXZlciB3YXMgbXkgbWlzdGFrZSwNCj4gVGhlcmUgaXMg
YSBkaXNjdXNzaW9uIFsxXSBob3cgdG8gZG8gdGhpcyBpbiBnZW5lcmljIHdheSB0byBjb3ZlciBv
dGhlcg0KPiBwb3NzaWJsZSB1c2Vycy4NCj4gSSBDYyB0aGlzIHRvIHBlb3BsZSBmcm9tIHRoYXQg
ZGlzY3Vzc2lvbi4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLQ0KPiBk
ZXZlbC9DQUxfcXV2UmtuU1NWdlhOM3FfU2UwaHJ6aXcyb1ROUzNFTk5vZUhZaHZjaUNScTlZd3dA
bWFpbA0KPiAuZ21haWwuY29tLw0KPiANClRoYW5rcyBmb3IgdGhlIHBvaW50ZXIgdG8gdGhhdCB0
aHJlYWQgLSByZWFsbHkgdXNlZnVsIGFuZCBpbnRlcmVzdGluZywgd2Ugd2VyZW4ndCBhd2FyZSB0
aGVyZSB3YXMgYW4gb25nb2luZyBleGVyY2lzZSB0byBkbyB0aGlzLg0KDQpJIHdvcmsgd2l0aCBO
aXRpbiBhcyBwYXJ0IG9mIHRoZSBMaW51eCB0ZWFtIGF0IExlbm92by4gV2UncmUgdHJ5aW5nIHRv
IGdldCBtb3JlIGRpcmVjdGx5IGFuZCBhY3RpdmVseSBpbnZvbHZlZCBpbiB0aGUgb3BlbiBzb3Vy
Y2UgY29tbXVuaXR5IHRvIGltcHJvdmUgdGhlIExpbnV4IGV4cGVyaWVuY2Ugb24gTGVub3ZvIGRl
dmljZXMgYW5kIG9mIGNvdXJzZSB3YW50IHRvIG1ha2Ugc3VyZSB3ZSBjb250cmlidXRlIHRoZSBy
aWdodCB3YXkuIFdlJ3JlIGFsbCBzdGlsbCBwcmV0dHkgbmV3IHNvIHBvaW50ZXJzIGFuZCBoZWxw
IGFyZSB2ZXJ5IG11Y2ggYXBwcmVjaWF0ZWQgKHdlJ3ZlIGJlZW4gZ2V0dGluZyBzb21lIGdyZWF0
IHN1cHBvcnQgZnJvbSB0aGUgZGlzdHJvcyB0byBnZXQgdXMgc3RhcnRlZCkuDQoNCkZvciB0aGlz
IHBhcnRpY3VsYXIgaXNzdWUgd2hhdCBpcyB0aGUgYmVzdCB3YXkgdG8gY29udHJpYnV0ZSBhbmQg
Z2V0IGludm9sdmVkPyBXZSdkIGxpa2UgdG8gbWFrZSBpdCBzbyBlUHJpdmFjeSBjYW4gYmUgdXNl
ZCBtb3JlIGVhc2lseSBmcm9tIExpbnV4LiBJIGFncmVlIGEgbW9yZSBnZW5lcmljIHdheSBvZiBj
b250cm9sbGluZyBpdCB3b3VsZCBiZSBnb29kLg0KSSBsb29rZWQgYXQgdGhlIHByb3Bvc2VkIHBh
dGNoIGZyb20gUmFqYXQgKGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEwLzIyLzk2NykgLSBp
dCBzZWVtcyBsaWtlIGEgZ29vZCBzb2x1dGlvbiB0byBtZS4gV2UgY2FuIGhlbHAgd2l0aCB0ZXN0
aW5nIHRoYXQgb24gb3VyIHBsYXRmb3JtcyBpZiB0aGF0IHdvdWxkIGJlIHVzZWZ1bC4NCg0KSSBu
ZWVkIHRvIHVuZGVyc3RhbmQgaG93IHdlIGNvbm5lY3QgdGhhdCBpbXBsZW1lbnRhdGlvbiB3aXRo
IHRoZSBBQ1BJIGNvbnRyb2xzIHdlIGhhdmUgKGFzIEkgYmVsaWV2ZSB3aGF0IHdlIGhhdmUgYXJl
IHRoaW5rcGFkIHNwZWNpZmljIGFuZCBub3QgdG8gYSBkcm0gc3BlYzsgd2UgbmVlZCB0byBjb25m
aXJtIHRoYXQpLiBXZSBhbHNvIGhhdmUgdGhlIEFDUEkgZXZlbnRzIHRoYXQgbm90aWZ5IGlmIGVQ
cml2YWN5IHdhcyBjaGFuZ2VkIGJ5IHRoZSBob3RrZXlzIGFuZCB0aGF0IHNlZW1zIGxpa2Ugc29t
ZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGRvbmUgaW4gdGhpbmtwYWRfYWNwaS5jIGFuZCBub3QgdGhl
IGRybSBjb2RlLiBOb3Qgc3VyZSBpZiB0aGUgdHdvIG5lZWQgdG8gYmUgY29ubmVjdGVkIHNvbWVo
b3cgKG9yIGlmIGhhbmRsaW5nIHRoZSBldmVudCBpcyBhY3R1YWxseSBub3QgaW1wb3J0YW50IGFu
ZCBwb2xsaW5nIGlzIGFjY2VwdGFibGUpPw0KDQpBcyBhIG5vdGUgTml0aW4gaGFzIGJlZW4gd29y
a2luZyB3aXRoIHRoZSBSZWQgSGF0IGZvbGsgYW5kIGlzIGxvb2tpbmcgYXQgdGhlIHVzZXIgc3Bh
Y2UgYXNwZWN0IG9mIHRoaXMgKGluIHBhcnRpY3VsYXJsIGdub21lIHNldHRpbmdzKSBhcyB3ZWxs
Lg0KDQpUaGFua3MNCk1hcmsgUGVhcnNvbg0K

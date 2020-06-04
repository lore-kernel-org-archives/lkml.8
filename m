Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79433C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C302207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OVOU8wgQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tzmbXo/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFDUA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:00:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60822 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgFDUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:00:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3094CC0085;
        Thu,  4 Jun 2020 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591300856; bh=4iyYGm9kU4tXwwTrh4TcBOJ+9qYc+ODucXbiTbKnD28=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OVOU8wgQZrIM30U7yZovqW7RajBZdEAvw1dqdZoOl+B+5PRWfCx248BPMmcWVRcZP
         EmxG7ar3uHLVurkLp6e0lkF6/Ue6OemDmbvD0Bd3Ce8FJ8s3juA6XYy4KjIVkwEwL9
         ZeD598gGsrqqyyay2mxK1mzFN17oJA2+cLPARkfkgugAK8vgBRXPPAUaigYcCheWBf
         ZRmfWSuCvF6+mOyKEb+Nw0VnT5CbtQrCxXcitpDWq6/XhhmKtStKMrNScbF9ASFb6c
         Ir4JsN5G1N8CIjuFaq45233qIRrV89jix4K5UiEFxSdQIG1tKlhl7W52c58EUlt1C8
         TKg/qC+poqGVQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BF2A9A0069;
        Thu,  4 Jun 2020 20:00:55 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 4 Jun 2020 13:00:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 4 Jun 2020 13:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuVfcQZWTmZkJZe608/A5ui48VKIDoPaXp8BeQ6snO0tgdJ2YEjm8b06U9SDrAhsDZmNfLgKZvKXRGciGRxupFYZMNBfsG0/VpQMqf25YzRHOe3WL1cxjBznXz8eRUMX+21s5BxNgoydNGcydD/468RabgvOrnYbm5gkMhfiDEfoB/qWeKbVOzLC8eoNF2cO816RXQJF5Po5Vu9nAFMnSLORKOPniPoXuXKAJgtdOIwQvQkXan7eVWGz3BB54f+qopR1fjzvpzx4E6ua6MuVEF0ymgSXNY6pDxrP4dVxIOVlp5/v/AqUD1kPw4uWk03HK53MRMd6SVsZlksErNrAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iyYGm9kU4tXwwTrh4TcBOJ+9qYc+ODucXbiTbKnD28=;
 b=JluDGMEd/mNCSzKeR9M0Gsil5aG4z1CfWlcip9BhbmsJmrZ7rtDr4S+mkRI5NHU3Ldg5D69pds00DHntBBHpKzk+jg4+hr2eEvm4K/fhUwA4vBLCriQFDco8aGkqbX4WyTov7fAJwcegz8SOt/Ycbzn1UIB5ZXkkyD7kT0G7w+grtDcQ/7w8ZGLAcxeWzUkE1CrUF3hXbFo1vKxNpEDScI6TN3pIkR9mU/ZUDhibQybUEDqXKIkFyZ0rhCGWahdkaVCGmIbEmMro25LlHb5nFsSAcgrmMux5mJxHvzoppzbLqRONlztPgooiasDqyel0B84omhyCLLyk02INk0FYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iyYGm9kU4tXwwTrh4TcBOJ+9qYc+ODucXbiTbKnD28=;
 b=tzmbXo/nr+vffGHp3886HHRX/EccTSkIuqphrrBndAG3NmqqgobulKbefrK0m20pyvaRaiFpAUhkQFPOM+IEEiHwTi1+PS94jTXMAcLRLs5uBsNPoe2HatxgmzawaRD/z6ZCXDBb60WihYyiIx7tN5CNuDoQf+EifLAcTDnZ9dc=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2647.namprd12.prod.outlook.com (2603:10b6:a03:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 4 Jun
 2020 20:00:54 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 20:00:54 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: [plat-hsdk-4xd] initial port for HSDK-4xD
 board
Thread-Topic: [PATCH v2 0/4] ARC: [plat-hsdk-4xd] initial port for HSDK-4xD
 board
Thread-Index: AQHWOpc5Ca0pDE8WGEerFDRoKZEMvKjI4IWA
Date:   Thu, 4 Jun 2020 20:00:54 +0000
Message-ID: <feba6ef6-0782-ee5e-b51c-30cf79166486@synopsys.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2601:641:c100:83a0:fee2:8ed0:e900:96d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 896d18fe-e2bf-40e2-7f24-08d808c1fd41
x-ms-traffictypediagnostic: BYAPR12MB2647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2647421A17E2BEABD2C89D16B6890@BYAPR12MB2647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9J8sBx5kdU3GoOXtzS90sTqvlkHzezj4+MAqzkDAAgkgeewSDgTVHVEPyHiuP2PF1E3u7TEfn7ueHarAazOMENY/QBrszqE26vZDwr7vjtujtSFFd8DMjkCX/Ja6iznfiKOD2y17z7yTMjiDM1NzAt4BJ4YpO/NnD666f8QA4m41ghnENvCFP5vLqqFMVVxIPYVnKh1u4uDYt/QPiNozrOBZps8BwOjx8lEBrCHBqlGtMie3B3/GTcqMhHDPkzmSvepwo/2VGAmynp/NL6N4yY2RG/aDAlmdEfpOxwD4RbjdGATErZHE5yEQIcUHLUtHbhqvoEpFFIagOlS3FOwDfBnjaAPuLAZUiaf6fS3uBQHnXoS+OQgxagP3dPYS7wu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(396003)(366004)(39860400002)(376002)(53546011)(31696002)(2906002)(186003)(6512007)(36756003)(31686004)(54906003)(316002)(86362001)(110136005)(71200400001)(4744005)(66446008)(76116006)(66476007)(5660300002)(6506007)(66556008)(64756008)(8936002)(4326008)(107886003)(8676002)(6486002)(2616005)(66946007)(478600001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tZ2DHuPjUwt1eSp3xEAavF4vsYrcMlYhI82HgVFo+yA90jc7kXxhhzSqVu5RALbghyMVyMO7xTW9h78stGiVYB5JI2cJlA2e9uUK/pE+pLdXJZoUv4hwK2s++1FSlyiZYjopZGi9/sPWqT216Z7QfcXfz6d3z/i0QeW0MF6v+3n2fMAT1qAbh3A81TD3CqgzDxXAXWn0E4YCs36HZkgqx65IS5N507hu0Kc0j1jI6hx4+snwbklMFQZVxMPYvkmG8J3M9rhiKJ89QEzTsHipzbjpUpSohp2YrILSKt7A6Z7/lctwH97T7cHFfUd55UjXaxpMQSTwUYVRjKPev6DrWxdbIJQlcEgoW8DrEAxfIJOAm2caIcCcDrdkVKlgyhLjSh3X6GZ2q94Cz6BdR8h1jr8zx1GnLFlXgX9O4lr+WsOwna1PbK2HHr2I7YhV8vkxgkWo0FGOgNW4icw408XjMpabGRXCzeP/m0TrAZ32FSidUfslF+15IYl64ZztU3COAnovfN/sxGIZAL5570U27R/gu/oDQ8HBbCYeayQ/HH3LK4aY9hvyIhP+dHkbBetY
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBDC6C79001E5144A82BE410828D7132@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 896d18fe-e2bf-40e2-7f24-08d808c1fd41
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 20:00:54.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtkhDouhW4CEMhGUNwKzlfeVVEr4BSe9vajuatsQhwrZ2QXwsD/Rgxt/paANNPnr2L+TmwzZJVkyfgrc/0tEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2647
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzIwIDEwOjM5IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IENoYW5nZXMgdjEt
PnYyOg0KPiAgKiBGYWxsYmFjayB0byBJU0EgZGVmYXVsdCBtY3B1IGZsYWcgaWYgY3VzdG9tIG9u
ZSBpc24ndCBzdXBwb3J0ZWQgYnkNCj4gICAgY29tcGlsZXIuDQo+ICAqIERyb3AgSFNESyBjdXN0
b20gS2NvbmZpZyBvcHRpb25zIChjaG9vc2UgYmV0d2VlbiBIU0RLIGFuZCBIU0RLLTR4RCkgYXMN
Cj4gICAgd2UgZG9uJ3QgbmVlZCBpdCAoYXQgbGVhc3QgZm9yIG5vdykuIEluc3RlYWQgd2Ugc2Vs
ZWN0IEFSQ19MUEJfRElTQUJMRQ0KPiAgICBmb3IgYm90aCBib2FyZHMgYnV0IGl0J3MgdG90YWxs
eSBPSyBhcyBIU0RLIGRvZXNuJ3QgaGF2ZSBMUEIgc28NCj4gICAgZGlzYWJsaW5nIHdpbGwgYmUg
c2tpcHBlZCBieSBCQ1IgY2hlY2sgaW4gcnVudGltZS4NCj4gICogQWRkIG1pc3NpbmcgSFNESy00
eEQgZGV2aWNlIHRyZWUgYmluZGluZ3MuIENvbnZlcnQgSFNESyBkZXZpY2UgdHJlZQ0KPiAgICBi
aW5kaW5ncyB0byBqc29uLXNjaGVtYS4NCj4gDQo+IEV1Z2VuaXkgUGFsdHNldiAoNCk6DQo+ICAg
QVJDOiBhbGxvdyB0byBvdmVycmlkZSBkZWZhdWx0IG1jcHUgY29tcGlsZXIgZmxhZw0KPiAgIEFS
QzogQVJDdjI6IHN1cHBvcnQgbG9vcCBidWZmZXIgKExQQikgZGlzYWJsaW5nDQo+ICAgQVJDOiBb
cGxhdC1oc2RrLTR4ZF0gaW5pdGlhbCBwb3J0IGZvciBIU0RLLTR4RCBib2FyZA0KPiAgIEFSQzog
W3BsYXQtaHNkaypdIGRvY3VtZW50IEhTREstNHhEIGJvYXJkL1NvQyBiaW5kaW5ncw0KDQpMVEdN
IG92ZXJhbGwuIERyb3BwaW5nIG9mIG5ldyBLY29uZmlnIGl0ZW1zIGlzIG5pY2UgdG9vLg0KDQot
VmluZWV0DQo=

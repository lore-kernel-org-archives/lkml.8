Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C768C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3FB20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="t97kv+dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:54:29 -0400
Received: from mail-eopbgr50122.outbound.protection.outlook.com ([40.107.5.122]:61194
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgERMy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzvi412MnlYEMNKQRRUhyAacbj1yxPu8mhZrKH0pLofHn4eoeGxA0LlUBEEDGKDxfbKnShBH28hKfPBhCa51aMepGAAqXp3z+2anfDWVxzyeimUwoI7+yp8SzMcZeu3BErdt+IQjZ6VNp/qZdFMdAsYg26OITzAOdpaZatemp+131PkxZrLq4662yNEWFXWvvHsYVZPT6e7s/yXilH3Tv1CirBq2TlA4faoa7CZdnupP5tR6iEliJr1q7D2+Nrqu6ildwfcgYY5wwI+JmlbLyHxbOHhIEPYFH/njnOMjQa5kLKRsrC7iaOrOskf6asDq308TwW/eRFtKetLNoT9w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUU2XvCtOWkW8oYBKMrbYFKytvQQVW87VGExJa9wUVw=;
 b=VmzTi+Jz4vAE4sB2htwbTqIcl17Qi8CBySzkcReSOvRuBNf600sGi+k7enM31JDbsERg87KKOqDyZG/XVqfmXw2Rd8qxCLnvlx0U1pThZUKQHzZ+1Y2/dATvNwmd/MJM3xixBMsUBogvyVBoG6NTzOd8TX/h6lLEmcC78iPb1kciYGOTv15hTUkKm+7MT0XQVAQgxwEZDHWWw5WOePx4eniYRO+5DbeKtzikrLcHo3pkewPKsHYhGNNlq+SDYfUlMSeINj6HlrTmy3rPjiDw5zJVJCm3t12EPBHp0HaCzWbdIZ7CKsFlEgPl79DPR0cRImUEtuyztZrSKyiBGD1DiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUU2XvCtOWkW8oYBKMrbYFKytvQQVW87VGExJa9wUVw=;
 b=t97kv+dcrFBkSdCDIFvGRy25IJMyio6FrCb8Y90EQsf9cNdnVLtGcot3Dzb7WDeo7HxifJAPwlrn8ctDLvDAIdAhYGlAeY0ezfWKbl2YWctFBN1yFB8TzCmb3B11DkVhf7tbsXoAAlwTGUFFxT90Ef2g15fSGip5cHRdeb5V8ug=
Received: from VI1P193MB0384.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:43::23)
 by VI1P193MB0589.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 12:54:25 +0000
Received: from VI1P193MB0384.EURP193.PROD.OUTLOOK.COM
 ([fe80::4c2a:55d3:f81b:ded5]) by VI1P193MB0384.EURP193.PROD.OUTLOOK.COM
 ([fe80::4c2a:55d3:f81b:ded5%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 12:54:24 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
CC:     David Rientjes <rientjes@google.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
Thread-Topic: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
Thread-Index: AQHWLQ4JT53iIUBh1EGtbwEppGChNaitzMsA
Date:   Mon, 18 May 2020 12:54:24 +0000
Message-ID: <cd43b4d6-7a2e-3e92-0a15-19597e9df4fd@sony.com>
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
 <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
 <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com>
 <6bf5e178-f2c8-f453-9035-93e31995bb53@sony.com>
 <CAHD1Q_yk4GhUgTMc5KcvpaW-oMNEfvSj7vxOCOQGALs4qe8VUQ@mail.gmail.com>
In-Reply-To: <CAHD1Q_yk4GhUgTMc5KcvpaW-oMNEfvSj7vxOCOQGALs4qe8VUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86365bc5-850d-46f6-4a50-08d7fb2a97c1
x-ms-traffictypediagnostic: VI1P193MB0589:
x-microsoft-antispam-prvs: <VI1P193MB05893AF10A8EF3EBA1004AB886B80@VI1P193MB0589.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRcmIa8ZkIoxpDgWZD2VlDGHR2trBRGf9Ip3oDzlYF2dDYZrEt5LI0bps42z/zNl5LVx7Lf/oBdbTAeLjRCCPvsq+U/MtTSTpTQPopnjXoko/31K3Zf0x3bRne0lTjqjNDVG0n3O4CMQrlM+WXZ1o57uyZ2jyLLEd6w4GKSnmtB+YTVnCDAJUKio+i3cLycBp2ClWPfSB+cfc5608+Z0AOepwX/TyxL7CuBaakO2n2wdUW+HXtlqGMI9hKkogz1EWnAAa2ISLTAJOvwNiHCjGowUGNXfjZWwHWBlwL/RHI87G8fRZ/Z66joNKImHp6h/eRNNTGt5h9sRDN0cIcvqgkPlY7nOrGd3AFWPSYA6LH9scveRWZDNkSZjV2kfZQXLEQgrqpJQ0nz+Hii33u7VMOLjitymYJ/98YNMJxmxr8xK58H8BgLPTie51bNfJYBiFK2RTzqOKssP7fQ1QQYTQxQzSeGehvCnMV52quzD9zq+Iw6RFnNQEpUGbewPa9tW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0384.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(86362001)(66946007)(66556008)(64756008)(66446008)(31696002)(53546011)(6506007)(54906003)(66476007)(36756003)(71200400001)(316002)(8676002)(8936002)(6916009)(478600001)(2616005)(31686004)(6512007)(5660300002)(6486002)(2906002)(186003)(4326008)(91956017)(76116006)(26005)(4744005)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tU8Zi9FIDreL/9Jp9vy075zIbDPO6T4pcFOfQP2OaN3aNWkmMtOXCUUakA6+g4F9LYjsl6mg6Ys5UfV28VRNGFAqD6Y5jEeO9JtTZHrTqfvMiIF5YxUg8aa2gmhx/x3V45umRH46fXkSg6Xko/i5qO6rLsfINCq9GFHYxFj02rlGUen8O7bnsS0w3w+AmCsEskir2CJeqWe/o7LaKZZqAVFlxkFLD8cHIM/sjQiL18x6culA/sJ4CPM/bQNDMF6iCNiDRCwl4DVagI2YLH6WJTXqsPH9PRtqqNg7+KvMbHJaRu6v+hyDE1An9epWoHMOWIg5oExDwXiroXMicdo0nCzWQKuwk6mO9gZDw8A8enfsOPesb/e0r8d6Gg8XkVanFnkIemP36rCbXRShzCAQrfkT2xyC/234d1aXTT1MquFZKpN9EubRVF0hB/YixLDjVy8OzzsBC8fjs/5qzIA0avz9VHBXhxgBOd/xC6848Rg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F85BEAA8FB24184C94B39681B953C6A8@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86365bc5-850d-46f6-4a50-08d7fb2a97c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 12:54:24.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xREqSwzz5FEHC3yH+B97gaSRmi2H28Ao8UGJMbR+zwrVlUbsfN2uJZGS9OjS4rRyUmGDCfjd/W2lWjfsB//V1B2y4/c0/1Z5ipudL5P80GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xOC8yMCAyOjE0IFBNLCBHdWlsaGVybWUgUGljY29saSB3cm90ZToNCj4gSGkgUGV0ZXIs
IHRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJ0cmFjZQ0KPiBu
b3RpZmljYXRpb24iID8gV2Ugc2VlbSB0byBoYXZlIGEgdHJhY2UgZXZlbnQgaW4gdGhhdCBmdW5j
dGlvbiB5b3UNCj4gbWVudGlvbmVkLiBBbHNvLCBhY2NvdW50aW5nIGZvciB0aGF0IGZ1bmN0aW9u
IGlzIGVub3VnaCB0bw0KPiBkaWZmZXJlbnRpYXRlIHdoZW4gdGhlIGNvbXBhY3Rpb24gaXMgdHJp
Z2dlcmVkIGJ5IHRoZSBrZXJuZWwgaXRzZWxmIG9yDQo+IGJ5IHRoZSB1c2VyICh3aGljaCBpcyBv
dXIgdXNlIGNhc2UgaGVyZSkgPw0KDQpVc3VhbGx5IGNoYW5nZSBleGlzdGluZyBjYXVzZXMgY29u
ZnVzaW9uLiBJdCBzaG91bGQgbm90IGJlIGEgcHJvYmxlbSBidXQgaXQgaGFwcGVuLg0KDQoNCj4g
Q2hlZXJzLA0KPg0KPg0KPiBHdWlsaGVybWUNCg0K

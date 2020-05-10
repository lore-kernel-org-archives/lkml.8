Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEF2C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7DA2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gEu2+Loq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgEJWRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 18:17:25 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53990 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgEJWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 18:17:25 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BFD26891B0;
        Mon, 11 May 2020 10:17:17 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1589149037;
        bh=SrgIz+PJYHKXN8CEOXRS3rQhCzXZZWj0itaj5yb73VI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gEu2+LoqCppAt8TRqOphp/vqL/bORRCpyc75HO2xMe7P2uzzetrCirReJdLrP72hg
         BRzJ+9E/PAS0mct2NLJ1JVpaifeXxb31Kg7soOOdDCggCh6POqPVPD8JqNDfX9BcFN
         sx9J8tVPeiuTZZxcS4g5bQjZJBMaZvdLug6iBmpNMJNx3/0eda8V9+NaC45gFIrPzD
         34UD/8Ope365T8ynddyjKfiIzmWerkDn2wsl8pVNEqiVf91kqEySmfr65jplqgOmmG
         qUUxMQihQsB+BHsA3TcWnQxj2cjmp6DAU6lcY0I6815ZZ6YDKEuuKexPyBjPjfEadW
         l1O+ZjQJQaYEg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5eb87d6e0001>; Mon, 11 May 2020 10:17:18 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 11 May 2020 10:17:17 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 11 May 2020 10:17:17 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Chuanhong Guo" <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Eddie James" <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Thread-Topic: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Thread-Index: AQHWJR1LjfOM6n85g0qPl2lemRFsA6idRtCAgAJndYCAAW/cAA==
Date:   Sun, 10 May 2020 22:17:16 +0000
Message-ID: <740f1569-d8d3-606a-73a8-f9feeb20e06f@alliedtelesis.co.nz>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
In-Reply-To: <20200510002039.hwahqasnnceowskz@mobilestation>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0C745804143EC40B042AF8A4CCB7FE5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8wNS8yMCAxMjoyMCBwbSwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDA4LCAyMDIwIGF0IDEyOjM3OjUxUE0gKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo8c25pcD4N
Cj4+PiArCXdyaXRlbChCSVQocmVxLT5jcyksIGJzLT5yZWdzICsgQkNfU1BJX1NFUik7DQo+Pj4g
KwlpZiAocmVxLT5jc19ncGlvZCkgew0KPj4+ICsJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChy
ZXEtPmNzX2dwaW9kLA0KPj4+ICsJCQkJCSAhIShicy0+Y2ZnLm1vZGUgJiBTUElfQ1NfSElHSCkp
Ow0KPj4gSWYgeW91IGhhdmUgYSBHUElPIGNoaXAgc2VsZWN0IHlvdSBzaG91bGQganVzdCBsZXQg
dGhlIGNvcmUgbWFuYWdlIGl0DQo+PiB0aHJvdWdoIGNzX2dwaW9kIHJhdGhlciB0aGFuIG9wZW4g
Y29kaW5nLg0KPiBPZiBjb3Vyc2UgSSBrbm93IHRoaXMsIGFuZCBub3JtYWxseSBJIHdvdWxkIGhh
dmUgb21pdHRlZCB0aGUgR1BJTyBtYW51YWwNCj4gYXNzZXJ0aW9uIChob3BlZnVsbHkgc29vbiBt
eSBoYW5kcyBnZXQgdG8gbWVyZ2luZyB0aGUgQVg5OTEwMCBkcml2ZXIgSSd2ZQ0KPiBkZXZlbG9w
ZWQgc29tZSB0aW1lIGFnbykuIFRoZSB0aGluZyBpcyB0aGF0IHRoaXMgQmFpa2FsLVQxIFN5c3Rl
bSBTU0kgZGV2aWNlDQo+IGRyaXZlciBoYXMgYmVlbiBpbml0aWFsbHkgd3JpdHRlbiBiZWZvcmUg
Y29tbWl0IDA1NzY2MDUwZDViZCAoInNwaTogc3BpLW1lbToNCj4gZmFsbGJhY2sgdG8gdXNpbmcg
dHJhbnNmZXJzIHdoZW4gQ1MgZ3Bpb3MgYXJlIHVzZWQiKS4gU28gYXNzZXJ0aW5nIEdQSU8gQ1Mg
aGFkDQo+IGJlZW4gcmVxdWlyZWQgdG8gaW5pdGlhdGUgdGhlIFNQSSBtZW1vcnkgY29tbXVuaWNh
dGlvbnMgc2VlaW5nIHRoZSBnZW5lcmljDQo+IHNwaV9tZW1fZXhlY19vcCgpIGRvZXNuJ3QgZG8g
dGhpcy4gTWFudWFsIEdQSU8gbWFuaXB1bGF0aW9uIGlzIGluZGVlZCByZWR1bmRhbnQNCj4gZm9y
IHRoZSBjdXJyZW50IFNQSS1tZW0gb3AgZXhlY3V0aW9uIHByb2NlZHVyZS4NCj4NCj4gU2Vjb25k
bHkgdGhlIG1lc3NhZ2Ugb2YgdGhhdCBjb21taXQgc3RhdGVzICJEZXZpY2VzIHdpdGggY2hpcCBz
ZWxlY3RzIGRyaXZlbg0KPiB2aWEgR1BJTyBhcmUgbm90IGNvbXBhdGlibGUgd2l0aCB0aGUgc3Bp
LW1lbSBvcGVyYXRpb25zLiIgSSBmaW5kIHRoaXMgc3RhdGVtZW50DQo+IHF1ZXN0aW9uYWJsZSwg
YmVjYXVzZSBmb3IgaW5zdGFuY2UgdGhpcyBkZXZpY2Ugc3VwcG9ydHMgbWVtb3J5IG9wZXJhdGlv
bnMgd2l0aA0KPiBHUElPLWRyaXZlbiBDUy4gVGhvdWdoIGluIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gdGhlIGRyaXZlciBmYWxsYmFjayB0byB1c2luZyBub3JtYWwNCj4gcHVzaC1wdWxsIElPIG1v
ZGUgaWYgR1BJTyBDUyBpcyB1dGlsaXplZCBhcyBzYWZlciBvbmUuIEJ1dCBldmVuIGluIHRoaXMg
Y2FzZQ0KPiBpdCdzIGJldHRlciB0aGFuIHNwbGl0dGluZyB0aGUgbWVtb3J5IG9wZXJhdGlvbnMg
dXAgaW50byB0aGUgdHJhbnNmZXJzLCB3aGljaCBpcw0KPiBkZXZlbG9wZWQgaW4gdGhlIHNwaV9t
ZW1fZXhlY19vcCgpIG1ldGhvZC4NCk9uIHRoaXMgc3BlY2lmaWMgYml0LiBNeSB1c2UtY2FzZSBm
b3IgMDU3NjYwNTBkNWJkIHdhcyBhIFNQSSBjb250cm9sbGVyIA0KdGhhdCBzdXBwb3J0ZWQgZGly
ZWN0IG1lbSBhY2Nlc3NlcyBidXQgYSBoYXJkd2FyZSBkZXNpZ24gdGhhdCByZXF1aXJlZCBhIA0K
R1BJTyBDUy4gU28geWVzIEkgcHJvYmFibHkgc2hvdWxkIGhhdmUgcXVhbGlmaWVkIGl0IGFzIF9z
b21lXyBkZXZpY2VzLg0KPiBTbyBpbiB0aGlzIG1hdHRlciBteSBxdWVzdGlvbiBpczogaG93IHRv
IG1vZGlmeSB0aGUgU1BJLW1lbSBpbnRlcmZhY2Ugc28gdGhlDQo+IFNQSS1tZW1vcnkgb3BlcmF0
aW9ucyB3b3VsZCBhbHNvIHdvcmsgd2l0aCBHUElPIGRyaXZlbiBDUz8gU29tZSBhZGRpdGlvbmFs
IGZsYWcNCj4gbWlnaHQgd29yay4uLg==

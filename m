Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D50C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5B7205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="AebH3Ry5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGSWaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:30:35 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40353 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:30:34 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4DC1F891B0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:30:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595197831;
        bh=k5Enp37KQPL0tZZpopihDElAPlTA1Tv66k8A4Q1G2ig=;
        h=From:To:CC:Subject:Date;
        b=AebH3Ry5thzDUB4Vz+HgOmlQTFQrtfUWHAjQpq1UE6O7tbO9djnZEs/IfKrV+E/+v
         MuBYgnyyuz8wlf3xDrmUIo/U8chlKleEUF3a7yijk4rXY9r8VMkoVrxCBVvux753YL
         ThhcdSlHGOuhIZz2rk8uj6rwf3mpdLbr+7AusLeI94JFaDPT0WAE3P0ZR3+jUWihZS
         ja6KNipacq5FcS/IVyB2+TkHHEpWHWipUhnYDW23SPUZu9q/lECQoclYt+d8cmgUu7
         TK+97AQOk7hlTKoc/couFnPeHoO13Il+ovnXXhXXLo7OJpVjJ0F+JCakwF1zs92but
         bcSC/0CaG0dDA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f14c9870001>; Mon, 20 Jul 2020 10:30:31 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Jul 2020 10:30:31 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 20 Jul 2020 10:30:31 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Per-process memory usage increased between kernel 4.4.x and 5.6
Thread-Topic: Per-process memory usage increased between kernel 4.4.x and 5.6
Thread-Index: AQHWXhw1BV2q6sOgREW4dSSPj6GBHA==
Date:   Sun, 19 Jul 2020 22:30:30 +0000
Message-ID: <fa4134a6-c4fe-344b-cdfb-81cc07ac97c6@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94FF859BADE28B449C5448DC3BB3166F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk5vdCBzdXJlIGV4YWN0bHkgd2hlcmUgdG8gZGlyZWN0IHRoaXMgc28gSSdtIGp1c3Qg
aGl0dGluZyBsaW51eC1tbSBhbmQgDQpsaW51eC1rZXJuZWwgYW5kIGhvcGluZyBzb21lb25lIHNl
ZXMgaXQuDQoNCldlJ3JlIGluIHRoZSBwcm9jZXNzIG9mIHVwZGF0aW5nIG91ciBlbWJlZGRlZCB0
YXJnZXRzIGZyb20gTGludXggNC40LnggDQp0byB0aGUgbGF0ZXN0IGtlcm5lbCAoY3VycmVudGx5
IHY1LjYgYnV0IHdlJ3JlIHBsYW5uaW5nIHRvIGdvIHRvIHY1LjcgDQphbmQgbWF5YmUgdjUuOCBk
ZXBlbmRpbmcgb24gdGltaW5nKS4NCg0KV2UndmUgaGl0IGFuIGlzc3VlIHdoZXJlIGFjcm9zcyBt
dWx0aXBsZSBhcmNoaXRlY3R1cmVzIChhdCBsZWFzdCBhcm0sIA0KbWlwcyBhbmQgcG93ZXJwYykg
d2UncmUgc2VlaW5nIGEgc2lnbmlmaWNhbnQgZGVjcmVhc2UgaW4gdGhlIGFtb3VudCBvZiANCkZy
ZWUvQXZhaWxhYmxlIG1lbW9yeSAoNDAgdG8gOTAgTUIpLiBJdCBzZWVtcyB0byBnZXQgd29yc2Ug
d2l0aCBtb3JlIA0KcHJvY2Vzc2VzIHJ1bm5pbmcgYnV0IG5vIHNpbmdsZSBwcm9jZXNzIGlzIGNv
bnN1bWluZyBhIHNpZ25pZmljYW50bHkgDQpncmVhdGVyIGFtb3VudCBvZiBtZW1vcnkuDQoNCklz
IGFueW9uZSBhYmxlIHRvIHByb3ZpZGUgc29tZSBoaW50cyBhcyB0byB3aGVyZSB3ZSBzaG91bGQg
aW52ZXN0aWdhdGUgDQpvciB3aGF0IGluIHRoZSBrZXJuZWwgbWlnaHQgaGF2ZSBhIHBlci1wcm9j
ZXNzIGltcGFjdCBvbiBtZW1vcnkgdXNlZC4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==

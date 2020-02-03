Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F716C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEE82086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PjhjgezT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="FvnvA7Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgBCSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:40:05 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:37692 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbgBCSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:40:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C775404D1;
        Mon,  3 Feb 2020 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580755204; bh=Z9EMkszueL9oVRSdj463ht52C1qhCV9O6tO9dsoXKPw=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=PjhjgezTU/n9aQbClnYGhWyeBaSaur5GEGPqEvY5fBTolikNf8RK+g1ELQl0wrX8q
         egDJizh8WP5hENs2Th/0ur9BFniXVZlRjE4rwQ7tS4sBbp+h/URi53xksWKP5Bi258
         Fo3eGz7FMvu5MwmD9hmqs768b3Gae/WqoJIBwFXDvsRbY3VM6N6yKDOCWNGCE3q0Ve
         Xl05zXTGb27bVoKTekMlBU9W/VulUuVGjPOvwRdFoOkillK7YrC0H8Twf3YYnbtall
         jl4Y8QWKJHtqG7T9MA3I7zhk4PucweyiU15Dc37SPTisdsrHdaYO26m+8xU8vao9VU
         d48CnfBMgTTGA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB2EAA00B6;
        Mon,  3 Feb 2020 18:40:01 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 10:40:01 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 3 Feb 2020 10:40:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzopPVPXyigmfGzsCEo7YGskoABmTW3uK+NdQQieuI5X0ZDyYSKk+OBQzW0SFv2okJ2r2fBeWm999dHFAcBD8N0/RsZaJ0fhme4jE4zvl2VFOEgj1Yt1hOv0lhGeTBHToPOd2EU/VatDUfa6/Q1+CkkEUh1o0hpJASdxnPZHZUf0Loc41fl8s1hTS4xgW8MjxQ3CfX46vU6hPZ19mMLFuk7rxQekFs15qU/qNAw+R2yFhbjG1MMMlFJu7kkUf8tbIPKclgrzO4dGVHsJ933fVZ+CFRulONB6K2OAkSBJCJaWkclRY0lvzkiQ4qAL8wJWFcxL8R6B8vIz30YtLcdgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9EMkszueL9oVRSdj463ht52C1qhCV9O6tO9dsoXKPw=;
 b=VYFZz4BE+CA3oTlJw28UWq2vsyK/eD8CsoFDDQjUL0XU+P59394DNm3VsxdUQUUwfHsLYrtqKQB1+Ik6O1xH4xJrIalVr6LcQhnKGZWmVV8F6aflqQnoRe44811EiRrwt8wXADyyu0bwW8H8XKiHXRvL4hLjgS0oMFWb0P7ycGC2vDrgWLzGx9DxvKrM3TznY01QW2Pd2pVkOByrSMBsb8nFApq+MOL5HRYIq7pl1ruBe8ukNgCEeSneWbc92U5TNa0MGZbsKOrk8RUyJUS0CoW6vOx958AY6XBwxMPUdBn3I0nLmIJey1xpgKynflIuVvlV1MNiHKf0xIFVtgcG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9EMkszueL9oVRSdj463ht52C1qhCV9O6tO9dsoXKPw=;
 b=FvnvA7Ie1CsFEkAuHpvTyy8ZoNKPCAHW+C97HpLWod7lCtLss80GUPBSfBW88yzFZ9zlDtZfElhWj8Upd9Q1GgHqLslu4s/qM5RB8bWixfAzfAAmqynF7X2guuHo3wk5zX7shqY30MlwlnAbCjjg7qd01av2vR1jgON5I5ihMeY=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2998.namprd12.prod.outlook.com (20.178.54.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 18:40:00 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:40:00 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: Cleanup old Kconfig IO scheduler options
Thread-Topic: [PATCH] ARC: Cleanup old Kconfig IO scheduler options
Thread-Index: AQHV16L2pzpjUToSIECUgzznedEkl6gJ02aA
Date:   Mon, 3 Feb 2020 18:40:00 +0000
Message-ID: <deb5929b-b265-8256-a709-7a5f149514ba@synopsys.com>
References: <20200130192403.2982-1-krzk@kernel.org>
In-Reply-To: <20200130192403.2982-1-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38a04b1-3345-4117-5be1-08d7a8d879a8
x-ms-traffictypediagnostic: BYAPR12MB2998:
x-microsoft-antispam-prvs: <BYAPR12MB2998354FA8CD44EEC35E25C9B6000@BYAPR12MB2998.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(6506007)(53546011)(31696002)(4744005)(6486002)(2906002)(71200400001)(66446008)(66556008)(66476007)(64756008)(76116006)(86362001)(66946007)(8936002)(36756003)(186003)(5660300002)(26005)(81166006)(31686004)(2616005)(8676002)(81156014)(6512007)(478600001)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2998;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIfNITvywuqTHGyYGNmDZ6GruFpw66fb870sJjaNOUvRhJvDEWbBLadfc+HZjU/Nxbt3OtgSK/kDqUsQvKb/xhhBA+6a0LkB4ilVEF+ZlKSnFTjHfuSWrwxAAu8VUnD9tq62MNRVp55rt9mGjdrP0TafWccZoVgHaZ68YsF/SqbrVdItSUiFb09I0ZK/cWFN+zK7RPuKkSRuQPprAmq8lk/qPCRroZCR6H4FQfFLZCWi0T7SxJCRuh/u0gOoKUpRhfpxRN6vEwYSqAQiHGBDi+aXWJZmrAmni5Y6hpUXNlGCoruIz0JWdf1YsgBv2b9nRpjpPyyYvlxISkTjZphu6KwgAp5Iqd3JOX4YoDddAW1Qc0JGUm8vYbEQV5sThPy/8iawoPmfguGcemzBrc2Q0Z2okQF327TUqTNHWVPYRQTK79otMxwYaiAqONqobCTE
x-ms-exchange-antispam-messagedata: cupnuFrVemBH3ZnctqPlczowF6KG9bH+FoigXIhbWj7vDO0vRaIWYzJtJxwHu7tSokN0WUXmtiH/wqysuK/1dpHSsKjEvpGxL/BXfkTkn0telquulc+WX1RbOpLX1Q1uILFctThM3ph5f7UUEEyYCw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33D3DE8D1B54964DBBE1F14F9F3088ED@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a38a04b1-3345-4117-5be1-08d7a8d879a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 18:40:00.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGWNV97WkQwIwuqUerHtHAw4TLpOIhq/gqhu9QWrBs5Luc1NqkWBDUl543l1eAJWlRrIoD6zyLRrec77wqy12g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMC8yMCAxMToyNCBBTSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gQ09ORklH
X0lPU0NIRURfREVBRExJTkUgYW5kIENPTkZJR19JT1NDSEVEX0NGUSBhcmUgZ29uZSBzaW5jZQ0K
PiBjb21taXQgZjM4MmZiMGJjZWY0ICgiYmxvY2s6IHJlbW92ZSBsZWdhY3kgSU8gc2NoZWR1bGVy
cyIpLg0KPg0KPiBUaGUgSU9TQ0hFRF9ERUFETElORSB3YXMgcmVwbGFjZWQgYnkgTVFfSU9TQ0hF
RF9ERUFETElORSBhbmQgaXQgd2lsbCBiZQ0KPiBub3cgZW5hYmxlZCBieSBkZWZhdWx0IChhbG9u
ZyB3aXRoIE1RX0lPU0NIRURfS1lCRVIpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQoNClRoeCwgYWRkZWQgdG8gZm9yLWN1cnIuDQoN
Ci1WaW5lZXQNCg==

Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC53C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8E21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OJ0VTs+o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="TX1XebtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBLRab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:30:31 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:37926 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727041AbgBLRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:30:31 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 50ED3C0626;
        Wed, 12 Feb 2020 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1581528629; bh=sxejxhbJ1f3uOUzXUDDvGmo5PthiUVeQLc2Un0OTFQQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OJ0VTs+oDDUOC0p1gaXMn7rwQ6ZPvSefI1D2JWfq6zp3s4ttTpyX57P25eDmdxXN+
         TIRfEehfX3fug8IcW6BKTHjPs2mS4BEmrFLZqm1IqMj8vsBBgWdaZO2fiMJgaohiMq
         lGAAgtI0s5DS4RjwOeKfzhxzH6N0s/Tx4otZ6roIc1dEPyFhKmEdg8CP9KbkrN+Hez
         1XKBzY/YSpt9hwfwlhEFQy2c86BiuwE+fWs8XzsZ45Jfu5cSEE/ZSCdxXH/f8xpSw0
         okfrcyVUFQlS3UcbNtdhvKaa1gDsdWsWPEtMezJROEApB3gdf+xYiiMmBC46SnXBuF
         mUXg3LXmc73XA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6D0CAA0067;
        Wed, 12 Feb 2020 17:30:17 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 09:30:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 12 Feb 2020 09:30:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1oMEotak4xJB0VyvYS4mjE6LVAENVuMw01ALTwN3aBUa5oBHjg5BlaKi+OoYAGbVhyLrx/SBpR25P4Y0Dk3RPlp/3T1ysDg+4M9DbZBAIjY7bDW5xHvhcLJESksCsrZF2aLRpWXeEPdRb7NMXFx8P6Qy7uu0qpOJdbw8ZP86o0cKU77b89EwBr6wSS9tQsfhtiJ6HJCnm4ZPs+YL7LqTs68r7HoGP7FdWq5Odm4Sn5hRy+XWbe8vlJKqIKdN6R8w0fLg5z+w9T1DPvZJ+wXv3C9dpBEvnkXcupeSY+Vh/EG1ZWgDt5xQKhe63MsLDCHpZ+NTLmYBxEaqmh16bdLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxejxhbJ1f3uOUzXUDDvGmo5PthiUVeQLc2Un0OTFQQ=;
 b=Gb77eIQBwqoV5TVxspFbl8Mq99+1/oPRQEgLcs3o0VIVDgw8ii7zS/uCmmxPq+6TgT1uH/NvPE9KmK3SyuPmv23XwqYC207qTwdder/o41BOqyVaslyZWxALz2iQQbo6nd82pLHNkCl8FzOHXWw9wnknWWiPAiRJDoPHl/BlpSz2pdtRJdSvKk26KFPPYlQAQf8AA1mCjeebRFjIruF//YytFcpNlFjFCq+y12zMjtMuDnLwDNvI5emj++IR2QNlBZyiYhkvDG9uOIvWd95xUa752z9lrqsoIw/+jZZ5+3RhVwvE9Op3NvqM2t10XXD+0hdNyAcZr+9Liw25rSZ2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxejxhbJ1f3uOUzXUDDvGmo5PthiUVeQLc2Un0OTFQQ=;
 b=TX1XebtJ2to5Xls1pk+9E9yosqifL+3A69CjXCq8ViqXq1MvsfHAhgguE2MFN4wBHEirygWRmK7SZfSnOfybhfr0OsQBoBh9P4frFfLZcJuWud8MXbrTlj49coXWYv/laNYuJRwjwGQSMIJywWaoV/5am7kOT6DLwrE4SUtzIFg=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3367.namprd12.prod.outlook.com (20.178.53.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 17:30:14 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::5d03:e088:d949:7f24]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::5d03:e088:d949:7f24%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 17:30:13 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Thread-Topic: [PATCH] ARC: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Thread-Index: AQHV4Yt2N0DebMkAcES6FRQ2RHyd9agX0REA
Date:   Wed, 12 Feb 2020 17:30:13 +0000
Message-ID: <adba9217-352b-97a0-b1f7-d6895eb0c0d5@synopsys.com>
References: <20200212100047.18642-1-geert+renesas@glider.be>
In-Reply-To: <20200212100047.18642-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0342bf07-3ade-4ea0-357f-08d7afe13804
x-ms-traffictypediagnostic: BYAPR12MB3367:
x-microsoft-antispam-prvs: <BYAPR12MB33676ECF41FDE77D05B07B34B61B0@BYAPR12MB3367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(64756008)(76116006)(6512007)(186003)(66556008)(81156014)(31686004)(81166006)(31696002)(2616005)(66946007)(66446008)(66476007)(26005)(2906002)(8936002)(8676002)(54906003)(558084003)(4326008)(6506007)(53546011)(478600001)(316002)(6486002)(86362001)(5660300002)(36756003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3367;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZIRHmmgDTkgA62K0+EPLX7N2AL47FAe4ajnkTYZBGNPW1V9nKLNWNmCKs8UXl7cu8sIKuaR7EfVX0q8Ox3kseDZypqwyFKr4+Q3VGpDwxZlfJO7CfB1m71bvre24Y1xNx2fP27ZB/uPXGV2eEjhal7fwPDFbZvjgtRylrV94xSKm1t8cnSue7+7V60XR3WliiBr9vaaW68ic2GoDjWOv975eRTStYR9uegZy7TmVFcYoXn2ddmuBZao58Y1S2TMpfjgYQvFyl7o/IyBphDW8p0XY58noVD5b+ZMl0apNa4guBF75EZJoe234pCvK/vHgm6Okq0wDrec3s0swV3j/FX4NoRweIWm4oQ5UNjn3MOxznjg7Nmfzs5XDafeJmQsbGMDPypHS7brGgp7zlJ6C4Z19qvTnQWNzJzvI27cPdBRwTOQK2yDwIODX+AZcGhH
x-ms-exchange-antispam-messagedata: iIvc/fBi07YN/Tbw2Fhg6CzxqtCvFXBeywyWN4wogP/0sjyPbaDFnoH3GLquUCf/82Buaz52yED+Ft3mdwE80qOCi7Kr0eetli+BTGxbSrZQz2aYk3RZign2YpJg7EXBqlxgXHpzOdTXPDcTHlwyag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB9A91B8C3CD004F83FEACA941747D3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0342bf07-3ade-4ea0-357f-08d7afe13804
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 17:30:13.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Xlzr9fkRk72Df6o4So7sT2Hqfz0m0Csp6hBv66A5F3NJlG+5dS7ADtbGPs7iQJthbhSzkJmvYSU3DYZSrkXfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMi8yMCAyOjAwIEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+IFRoZSBBUkMg
cGxhdGZvcm0gY29kZSBpcyBub3QgYSBjbG9jayBwcm92aWRlciwgYW5kIGp1c3QgbmVlZHMgdG8g
Y2FsbA0KPiBvZl9jbGtfaW5pdCgpLg0KPg0KPiBIZW5jZSBpdCBjYW4gaW5jbHVkZSA8bGludXgv
b2ZfY2xrLmg+IGluc3RlYWQgb2YgPGxpbnV4L2Nsay1wcm92aWRlci5oPi4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCg0K
VGh4IGZvciB0aGlzIEdlZXJ0LiBEbyB5b3Ugd2FudCBtZSB0byBwaWNrIHRoaXMgdXAuDQoNClRo
eCwNCi1WaW5lZXQNCg0K

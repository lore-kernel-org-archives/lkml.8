Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C18C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C7020786
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="JnivlYWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGIN0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:26:42 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com ([40.107.68.57]:27621
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbgGIN0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX1smQ6UI/tpLmKiYhvkbjz1Z7OayeVpUCKHQdri6YTTSGEhDmSEMD5jLhrHMBoIOyE7F9ygobqxUfdNYG5GBfQMXjkORnuDPK6ZkkNGjjT3mOQu7XJf4+Cne4AufFZmXxcFJTIF9emSUwzf5SIQpWdtHxQaQ4avtfAlQurSc1ct69pYI1fS9xMdKivD3vwq6j/3rfvU5zxZa+wsI9Je5ivXw+6gM9ORdsL0A3FCqQiK6TIln/mFzDC38MWtMj8n4VcP65P+OLiHOmPD1XLKlax92Ul6gg4LjQIPgrYyPGIyP4ec4W+2JgcnmeWpPLwcakVsJlQucHsuIUQXnQaC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxX81gYE1KafYsFPLJTILRmuCQ5f3NNkEJLJzWLe9vk=;
 b=eDC1TD2l3Q9VqxyDZHOh0+KaP0a/wJOmgGczBwrqfoTbYUNUrHmwf7VMy56ot4ly0EMjRVXDoYfRHmWGD9jWM4lw0hdzv1rZPhsIV7c0N0YE9+MIUQlTNsIvjGL4iNustjYgivCeZn9RmBRmrvcb5wj45K/Frg1PBZSstWM6jUHIJf8c0zRgEsjcn8l4up1mynOm5Hhva55wRyCeOis8sFMGSMQQKN/rBphl4qK/fS7liJc6HjTp0LX/0PhPD1yqiNDQgBab2+34LlAXw901fdoxujJeyMHrXKOvRPaXI+RccESiFDQ5/M/tJ2veYZrBiIH8Qq/MENyXMtO/nxlrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxX81gYE1KafYsFPLJTILRmuCQ5f3NNkEJLJzWLe9vk=;
 b=JnivlYWxZ5aT9gHs7ReHDxBZsZY1fc9IAY+uQjzh46rkYVPfxJRr+MD6AN9Uug3hrRDnAkPl7PWxIkEGq7eY4ujHHQW85B2PSJcZEMDtziJnax8WHCdhJHw+T3cOfI6vhdhtFlKljWR7cbTkN7okn3m1C4D8kk4TDw9dcKVul1g=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR1001MB2143.namprd10.prod.outlook.com
 (2603:10b6:301:36::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 9 Jul
 2020 13:26:38 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 13:26:38 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "schwab@linux-m68k.org" <schwab@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: printk of non NULL terminated strings ?
Thread-Topic: printk of non NULL terminated strings ?
Thread-Index: AQHWVezV9c8qp7AVfk6iUQJ/gxZBLaj/NP1GgAAIToA=
Date:   Thu, 9 Jul 2020 13:26:37 +0000
Message-ID: <0a4fb48c210c867139f4b171384b8d53a420ff7d.camel@infinera.com>
References: <4436dd281299b46f431ad1707c5de42af45ea4f7.camel@infinera.com>
         <87h7ugu9rk.fsf@igel.home>
In-Reply-To: <87h7ugu9rk.fsf@igel.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd543841-0fe1-4965-5220-08d8240bb573
x-ms-traffictypediagnostic: MWHPR1001MB2143:
x-microsoft-antispam-prvs: <MWHPR1001MB2143BEE6A9D42D8E44C941C7F4640@MWHPR1001MB2143.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DMUdleat6cNMSd1f1YXTEN1aFXMz/PZMHqGU7Z+vNMr5BPc0dz2/+/3mYZk+mz4FP0GzM1s1r7LcjL6YTRVKmCmY3JovZYaYkMMVVlRlVgkDcyawK+CR6S5bws+j2I2vPD0KLgC57JytGtfx2ZGDk8JliMra7f5SPl47bkAGtQGmDHgfnhJ9YNOnsqjDvLD5XRP7TAg9rdP3tF64aq26EYJwooJpxSqBPJ3XE7akiwZSqnuGY5i2vWTz2DU3yYC5Wuj3p1KUaCxLsTH6t0drgPp0LSoB/+eo5Gbkb/VEiNgei8NwPVWR6huxryEKvWWwjweRBUg3DXa/ugrpsEC5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(26005)(6916009)(6512007)(316002)(478600001)(6506007)(36756003)(86362001)(6486002)(186003)(4326008)(71200400001)(2616005)(4744005)(5660300002)(91956017)(66946007)(76116006)(66446008)(66556008)(8936002)(66476007)(64756008)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EhVin5Cq9bpwoqDJyU9lo9+OEjDQYp6B0AusObw1bO4G1daetAl82nCJBwyQ5pzKVcUFUzSRc4ZwYsX1vF1kuOrBEbEUb8CRW3FSfkshtoQmR0WIN99NqQGKX+aBNjQgF457GnEb3XzMNbC8geDi/JoVRYcEEJduTCQKcLewz10rilJLuRdm59KbFqTZ94iKQALr1mtT9ROVNee/eA+e3WKsyMEr6S2XUOsG6UXg6iIjupqwSoPh8uVF0etJrPK4i0qeIxqVgPQbuUQuLyQ4nx/PcUpERG3r+YsQ2vZveO2jFoJDNjk0wXTJSLyVTJlJEPV0MGyXlHMqdiSWQnINthaWWSI31HFCoLkvv3cEpHYr5yKdBxABnNBq5TNrFYKvgwU/AKde8WJ29cNLhXra5TcUQOmp68aAYwnKTqfcQHobcewh9x7G3K2FyLus6PbqCWwfE9UiDfsS3Gh+Dpt3414a4YVQLHOP3k49rleF+Lk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EAB138085AFE54ABFECFA30E24A6D70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd543841-0fe1-4965-5220-08d8240bb573
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 13:26:37.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uL8nXCQ41Qgfym30SZf/DqYBigdFt3x0mFx5OH9BpL/gsopboPDwzSMZJVeb+0rSgI1iNyFWYXms3xMivi/jeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTA5IGF0IDE0OjU2ICswMjAwLCBBbmRyZWFzIFNjaHdhYiB3cm90ZToN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
IA0KPiANCj4gT24gSnVsIDA5IDIwMjAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+IA0KPiA+
IElzIHRoZXJlIGEgZm9ybWF0IChvciBvdGhlciBmdW5jdGlvbikgdGhhdCBsZXRzIG1lDQo+ID4g
cHJpbnQgc3RyaW5ncyB3aXRob3V0IGFuIFwwIHRlcm1pbmF0b3IgdXNpbmcgYW4gZXhwbGljaXQg
bGVuZ3RoIGFyZyBpbnN0ZWFkPw0KPiANCj4gVXNlIHRoZSBwcmVjaXNpb24uDQoNCkxvb2tpbmcg
YXQgdGhhdCBub3cgYnV0IGhhdmUgYSBoYXJkIHRpbWUgZmlndXJpbmcgaG93IHRvIHVzZSBpdCwg
Y2FuIHlvdSBnaXZlIG1lIGFuIGV4YW1wbGU/DQoNCiBKb2NrZSANCg==

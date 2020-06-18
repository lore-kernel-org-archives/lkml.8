Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6720888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="yejhHcAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgFRK62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:58:28 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:6409
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbgFRK60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3nRa0AUyWiEXMru1CYwi/FMfyVNA4RQpBsjI0wGKCl2B5hOeju2FWzzWH+gwLTPBQsQIZj7Kr/YQNXwn7/OKNEo6OHmUKIhx+f0VaeWo7Jzq+lQnWoUlbni4nz/cNCUHoJ4rMYf1GgW3PudAONwE2GnKhistWtxmy3WmzpgsY3DzPhBEArrdbwedN1jth1iVPvmf5MeBOX1qiXKzA+xvCSKpZNYFgB34pZu4vaaV0bWeC7HxBTbReekGXYxxydncRhzT3ScdPHKaHbSovHtyH87zTTedT+uDEx6U6j3IJXcGuPKREWd0y+cv3lmQK5wRTFfPaIn4vxXL0fg11TiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTW6Q+jK7YztwrGhXa1E+/bR3+HrN4uhM+sbt5jD7Rs=;
 b=mbV3Nw6X/q/blM95Bux9Acg5b9S3GZq2fEW0+FM7TReiFp+Vz9pDCj79WwhrXojpyflYtF0E7AG2T+y1b3JJWOYmSiWr/Ixhfv8/8N2olG/IM5Qew5eoutKDOLFouORezBjRBm2U1dSZUOUho+AgVAAHx8KFYMVSH2ocGJ7UjUkxbev/3HVkBvWfBgiqvaC5HNMqNABepDT8Qw51NDAfkkWgokdscI1Xmh4HJAhnC4GSpPjlUoflsmqyeEpGwDe8hPb/zC1La1USW628MMxK2ebtSeE0C7RoCcifPl9uCp4BCJmBunhk+3tTskpk6mkI00jIeddjPnFjZecWBjE43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTW6Q+jK7YztwrGhXa1E+/bR3+HrN4uhM+sbt5jD7Rs=;
 b=yejhHcAIitgRoCryBPok7+/BImKLhBBfxFYE2JU6XyOeg4q6g1y0smaXzQ7QkeAVSZLDYhTVmmxg34/4XbDtrfnp9tBAofwM4UaFnLxWvJuxVI7HMUUIlB1u5l7GVwcoED3gnPgWRsVSupfDxQJRDkaB/0IB1rzraJ8T3jCYcos=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR02MB5842.eurprd02.prod.outlook.com (2603:10a6:208:180::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 10:58:23 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:58:23 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 6/7] habanalabs: align armcp_packet structure to 8 bytes
Thread-Topic: [PATCH 6/7] habanalabs: align armcp_packet structure to 8 bytes
Thread-Index: AQHWQ6VKnhI9O+I2WUCAVj8uZY4jY6jeNuhA
Date:   Thu, 18 Jun 2020 10:58:23 +0000
Message-ID: <AM0PR02MB5523406D1B3BF4A17B392A4EB89B0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
 <20200616061327.12006-6-oded.gabbay@gmail.com>
In-Reply-To: <20200616061327.12006-6-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [5.102.253.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bcc893d-f67b-40c5-e958-08d813768515
x-ms-traffictypediagnostic: AM0PR02MB5842:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB58424F19305BA97ED5C5C42EB89B0@AM0PR02MB5842.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Opk8y0xBAuSdrSHTFcZXZdG25AvYaOhkx8cVC8DWHF46ACvt1eWPQ/REm6VvpTjLdfqRYWxXvAdn/oVnBT0+cHmmWy3VfEm+JWoRp3k6/yt70kaVGoKHWjN421zApsyFQa6n88wNST9Y/v9mF/RCQ02Bg2gr6D/Jf3cKuKwiOrdkfk+jn0mPmJHVN9NtgHS2hHQkBMfiWAx7KUFut9UatszMjppBWGexbwuxF0LWcD8KK54CQwCs/iWAqVhM7h/tEhnO9M370Q5KKyVpn5uQevnufxBkY97ndGp6Gmnil2RCuztK5x9+iCpuSjIlVeRL5s1ckgtX5KJA017IhLdBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(83380400001)(71200400001)(6506007)(498600001)(53546011)(86362001)(6636002)(8676002)(8936002)(52536014)(4744005)(2906002)(26005)(33656002)(66446008)(66476007)(66556008)(64756008)(110136005)(5660300002)(76116006)(4326008)(9686003)(7696005)(55016002)(186003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: d1JanLFqzcQfG3lf3Nkahsmi713bLLiEDf8z5IdATWKWmiBuAr1mLrIUxgwhJTye8ksRnDr8QSR5goEKHAMOvhBFg/JCp1dgwG1eSCVe/V2YKD43ZMTnxZrTBP0yhk4G6QZtOJUB4EmfpEFgUCsTkqv6qgSKIip9BuKZ2yXv0MMyCwcTSXvfC267UlqeRcqlI8fsitKh3BIw0phnNSbG/KaktYJzbc90ZmE4HPqRDyHrsD7E56QEGYFuPe9022OUQsHFS/3FcTvNfiOntUaI/dkfj9IJaKjguUsqch+GsqqDEgafFUnIohBnADAidQtOQHlVOwf/Kg1olIchWsR2+e9memr0B4Hb7fsxbq56qrplPNJi5cWn3p6K5hJ9xcHKOFNFqVStUc5zxqdN7DL9wMN52kjCL9jnOJbU8fSFpBhtNhHXm4CRpuh02cS4WPRbFIve2B3Y+0jbH7584l4lNwq+4H6F3WyirZ964lD/UhqcNGvPeG7xiP4rGGg9Jsyv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcc893d-f67b-40c5-e958-08d813768515
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 10:58:23.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9oa8f0hKUVRo/162/Vt53dh05MzeTbdhjXPmvDHWeFBf/FnqnVKK+y8uODz4xmqgmAULe7mebGhfSmLiW0lWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMTMsIDIwMjAgYXQgMDk6MTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbmNlIHRoZXJlIGlzIGEgNjQtYml0IGZpZWxkIGluIGEg
c3RydWN0dXJlLCBHQ0MgY29tcGlsZXIgZm9yIEFSTSBhbGlnbnMgdGhlDQo+IHN0cnVjdHVyZSB0
byA4IGJ5dGVzLiBJbiBvcmRlciB0byBhdm9pZCBjb25mdXNpb24gd2hlbiB0aGVzZSBzdHJ1Y3R1
cmVzIGFyZQ0KPiBiZWluZyBwYXNzZWQgYmV0d2VlbiBDUFVzIGZyb20gZGlmZmVyZW50IGFyY2hp
dGVjdHVyZXMsIHdlIGV4cGxpY2l0bHkgYWxpZ24NCj4gdGhlIHN0cnVjdHVyZSB0byA4IGJ5dGVz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFp
Pg0K

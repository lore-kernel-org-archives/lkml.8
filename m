Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59726C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF7820720
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="WA20g1Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgFRKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:53:42 -0400
Received: from mail-vi1eur05on2097.outbound.protection.outlook.com ([40.107.21.97]:55350
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbgFRKxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:53:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnU48FTjc8rl+xPEqFZBt7X58xue1CP/7DYLMS6Ba2xYBFcH/DKwAf+cJStvbDgvDRtpWldTlthxpaz7K+ZQsBA1jKDXAYlt5afuyq0uO90ElWp5Tsyh6fqSpHPE2eu979wRgr4t/DlYO7qr5wJWSiLRWrF1mTQyWnUOBMfXPRT2fS6AjWCYlHmnS11nuLhFqFkedCZrZoj8/2LqhZphznCL9eTQB4SHDF+cZwZhacZ066U6ETOGr6nMfF9xE87l3mO5X1gB8ciHNGsJ4/wTDSfczBE6XszX5+fgMVT86aFq2n3OnE1c5idtUsSrmz9QnN5NGvR2kgKLym70fqRN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xbYU13okmBe/JX8/JSggOu8pzumexBZC/1qbOMgFfg=;
 b=ecgk+QUCb52VEwGZqHA58WQMB7Q8PwakJ4m5rVCgBts3EsUR3rcWsogE0sgR8gbJQ+YgU4V2qpiB66XsuXnkpiMI9bD8RIl3uzjxTGZYzKbqCGklH+MtN/RQ4a9MKYynzCzUo6WyCXt657/gWKjO+D1RwNJxyVa/3GyUyNhhgXDzz09VFT6+u9dsqppl9XKVtbbt5NuhB6LXsaSOpWlhaeBOxxWXAo0wGBA63Ad4CP48PnIAKZn4Z1qOuifjz6Sv/Evaozd9dPTY3qslSPb4woUrZJz7y3vf7F1ySwE8P3Y3IHgbc4kWxhZMcr09pOVS2B3rLshfcTxT4yzPHbnVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xbYU13okmBe/JX8/JSggOu8pzumexBZC/1qbOMgFfg=;
 b=WA20g1GwZQK3W76m4kg2NfdW/1zaV6DaMibH6MHrIIlph6QWYYwFiJzuUUSwc5ZmKW6eYjRe7R6foX63HJg8rEnpD86GgzHaJlZoxss5PLk1HaK++y2RH3FEOukEATqSK/LN7u4iqzQHKVXfWoq43GZMc/6VxxFCNcaN4dl3/AM=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR02MB3603.eurprd02.prod.outlook.com (2603:10a6:208:4d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 10:53:33 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:53:33 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5/7] uapi/habanalabs: fix some comments
Thread-Topic: [PATCH 5/7] uapi/habanalabs: fix some comments
Thread-Index: AQHWQ6VJLYFIso/4M0SBs40MPAF8qajeNWNQ
Date:   Thu, 18 Jun 2020 10:53:33 +0000
Message-ID: <AM0PR02MB552303AB9901BF6F46A31254B89B0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
 <20200616061327.12006-5-oded.gabbay@gmail.com>
In-Reply-To: <20200616061327.12006-5-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [5.102.253.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edffe41a-162c-46fd-82c8-08d81375d880
x-ms-traffictypediagnostic: AM0PR02MB3603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB3603C4099EB0316933E132CBB89B0@AM0PR02MB3603.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rrc5xUlIC6MEg3Lo3uCRfFFGjXREqijy6DWQWwHN0PpTuYXUZNWBRx9qP8s38eVsWLVeSyyLRTMRTPULzXZ3VkKl2J49S4+PnHWJmtNCKHziryNqVWiT/DzwM1+Jcp5Eh2zEHIyXeB7AhZyxjYcJfzsWg5ggUlSgMGYHS5oJxQx554QUW9EQcSDbuP7cU9+dIeuJCp1eolts9Iv3Oi7K2GZRfmXGRV689r59xAiGxjDHBfYzWuPYbue9N+FEU1kWt0CKdUofwfkjb8Aw2/iROHrnHB697c4ARi39xicsLwaRQ/7R42413xeIzHXnvC0K+mxXzqyRrJI3uHTu36X+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39850400004)(396003)(376002)(346002)(136003)(186003)(26005)(4326008)(53546011)(7696005)(6506007)(52536014)(33656002)(8676002)(2906002)(478600001)(8936002)(5660300002)(71200400001)(110136005)(66446008)(76116006)(64756008)(316002)(558084003)(6636002)(86362001)(9686003)(66556008)(66946007)(55016002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K+NC0oYNT7FNkZKT6UqnhYbHtnz7yGTkdiC99CJbtM4FuTKqC6DdBiU+IgH6FmXJWttAWX/zQ4fCYx/zUhGdBX/E9y1otHcaJAqRy5HZTfuW1do9YExfIQAqOO1/Q6hWd9dWJYUkFS1eAIbJ3yxHXMmVkusLsXekds2OK+c0yQoPkzvKJ+GZLnTVcPk877T5+g2RyJ6PJfFX9L51p1PmUwao/fahmybmaFmybyE2vrJsuUVo+/l1/jnglC3UGLhsrIXogxVcaT9KvJ0kD93dGEIsSCyzf/zmisQNBRNmOiMu/SlKp5rX+3C2PA26jLLsB+q3QLpPRDr5wVL9p2RObcgKJxZUkysOrzDGWTkX4oGn3lCsyJjyY8dHg3EZPCl23Ac+4EiXUM4PWfpH3F6y2ovm20y23WPTTEYY/9WaHR073IL4FHjodW0Cu+UmqIBhQNgO+sGoT9TH5Tnn/eAKNcukTWspu11U7OFLSEgwvTc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: edffe41a-162c-46fd-82c8-08d81375d880
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 10:53:33.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoUzpXcvPUWuc73kW/XWSgTVpiCPAFUt7xGPzzeZgQ9yLKC0c0mhMyl9ViI+H+mHOyW1HCLln0rqmT/426SPDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMDk6MTMgQU0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBNQVAvVU5NQVAgYXJlIGRvbmUgYWxzbyBmb3IgZGV2aWNl
IG1lbW9yeS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBn
bWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGlnZWxtYW4gPG9zaHBpZ2VsbWFuQGhh
YmFuYS5haT4NCg==

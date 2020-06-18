Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B52C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C870206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="sVKi219s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgFRKud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:50:33 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com ([40.107.4.122]:8274
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729369AbgFRKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiOO6RCKBRHRxhkav3huqhhn5lzq/460cV2tWFl+09RijCAr7wUXaIFQQ5DpnuObmXyK14Ktpt4cI/A4XF9soKTODIvvrTdswVg54pDsE8F0ARgI92wQNp94McXFloJODiXSJBnwds0w8Kos8apj5YXAdZ3maDEBhQk00bWSXOJyVZl+gN5WKBTSkmulE8g7AwJrcnc+xEGveOUO9Zrjma/UbkgjPMQTzdbRnViNbDTF8t1xS2QoKrgnD0j1HAsRiv6SnLQBK5ldlUFGpy5WDhckItdz3TE4IuYoDQixTJ8yRXp6bBeVC3rghRzsrRY4rZKb4rL0rPpAvI4Uk6s//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOejePt4Sc2sFSR1LK5bw19sJBRUK1XBZGj5naBPXHY=;
 b=EylqDagpAHtuT/wlFWGx34a/KhRBZwk4nA+hHfGJPBcaI56T9horuqJrewOx/BW8N9Q89o6wLsCbmvtJVOMgHM0o9LpNSQKTZfTat5LCVoTfVOYlOun12xApse9YxCr11L/kQAY9qSHFkiIOEsNatGyip56J83qww+nXr0pVsImJH1IZobMKPwOuLkVVlHB+BwXnZZ48UC1MEHuPLftG20kaVN1ol8aEc0+9AHQ14YX9/0CLNKbAQwJXZbOjwPnm1wXzvRao7Jjks8ju1JW6HigzNQKp5MJHYkU21+CY+duKLPqlmTzDnLnzyvwkDx20iEGXOSnFfzD4uQfnw02fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOejePt4Sc2sFSR1LK5bw19sJBRUK1XBZGj5naBPXHY=;
 b=sVKi219sr7tU2LdzaWrEgQ8wqucQlgImWRo24fmE3Xqadr4C/zCQJ7JTRFr3sAD3twtwBE3abxSVYw3PSBO96Ww2ZXepQsToQOky1xOTzUq8s0XOZMNBqB/QF34uOtCJP9RaramZpVkkym67cUt1+PKRjn3hxzPzZyAwBiV972w=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR02MB5842.eurprd02.prod.outlook.com (2603:10a6:208:180::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 10:50:26 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:50:26 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/7] habanalabs: remove rate limiters from GAUDI
Thread-Topic: [PATCH 1/7] habanalabs: remove rate limiters from GAUDI
Thread-Index: AQHWQ6VEmi2GdLeJAkmWPUysCkeIhKjeNG4w
Date:   Thu, 18 Jun 2020 10:50:26 +0000
Message-ID: <AM0PR02MB5523360A3D19F8EFD846C4A1B89B0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [5.102.253.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1820977f-0d54-43f1-61b4-08d8137568e5
x-ms-traffictypediagnostic: AM0PR02MB5842:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB584260CF033E56F9143DCB2CB89B0@AM0PR02MB5842.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFvHM9dcfe07fHYfAEcodI4sa7BkjeSCLOnmLMXe9ztn4OPeCPR6qrv9hZuZ1OXB9C2rqgvCZOWXU5C5YmFLSq/M2qJZXwUpA8f0cXAjfv5TvdfazW/t+sR9SD5uPht2XbmcEloHiVmw+88scm9CrG+cnaY6T0hoofCBPlmF5n3bAv4HDxMGnGOC+iGBn+2qA6jUJmgvi0w/Wdo0/fEO2YDgor63Aa1fGcgi0/I3zxigiQ9So5ox8AiKKPA9qL7l2SXOZW0JkdkixVQqPsdEPqWlYOfhlLfS+NPe8iYe/G8el36URkge1iifyWGX6/eW+75fv5BptUPtyJwdMZkYCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(136003)(346002)(39850400004)(396003)(26005)(2906002)(558084003)(76116006)(4326008)(9686003)(5660300002)(66946007)(7696005)(55016002)(186003)(110136005)(64756008)(33656002)(66446008)(66476007)(66556008)(316002)(71200400001)(83380400001)(478600001)(6506007)(52536014)(6636002)(8936002)(8676002)(86362001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: DxQMCRCfP1y8b1n5y2FCHjpuibo3cSqGJXe31XWLR6ZcQUD6Yi1IxBeO9GCoaUrq36aGK9PaQYKBK0jg3SAYrY01OuMlpBf3j1l4Y6xW0Dbe6P9wHJ/4mjQBzaAolb3S2B2+ONQw9QzTLB2z0LQvDujYe9pNI7A0uatcjKf/vD5KV+ojfrR90KRFKeFnJvtqIUM1iBKMoJwSVCYqRKiFleEq/doWZGNLuh5bEHKNCgGzrIR3ggDTe7FLlLptkDbCJPLZ78JM+S2GQ6QK+v9C5vjaVZprHETHcrhTIr8yhbpfKsPfMszax2x8/7RuGvUZf0bbTO8cmsSQcMngmvAk1h5+v5GdGL1osYLfMni7z9KTer1AI9BUShLR+xridWGmOPpP5vUPo84gcOlIexTAVIG/R5YtFmAeRAiGQIrQiGOSeiRVSsperBzW2FtLBi1SkzmhYPfRgJ7SowFAG0Xt5rOIFGV3iHc0wU7jnyD+dIQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820977f-0d54-43f1-61b4-08d8137568e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 10:50:26.4410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2rNx9ENW7FSM59Lelh9glh06h/qmWiQECRCJ1QuiWRQ93r/t2Su2/TvBZTLeT15ww/5NifrRmpEreWYOQYObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgOToxMyBBTSwgT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IFdlIG5vIGxvbmdlciBuZWVkIHRvIGluaXRpYWxpemUgdGhl
IHJhdGUgbGltaXRlcnMgaW4gR0FVREkgQTEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdh
YmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2Vs
bWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=

Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611A4206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="RFFmm+KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgGOK4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:56:43 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:41028
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbgGOK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiWvyegoNyUT77265c9gY4XI2+VJrcoR7KX1fd1+RxeK4jy6Hu/CvUoKhoeA9zFB/KuIWaZnMmPK+ff5JUGFlmfIWmzhU4vcMqsVU7f0O70U829CmoaZu5cZPQ+Jh1TCQt63u2FRw6w+VAdIv7OUyfXRiRcjzPKblNRqNvfX0u3ghz1DKobmaGFFH7RJzTsmn2HBprgYgi93ToRh9tVv3MoiS9YJT/oaknz1xYYegH0xEz1+7WvA6ZYt7w5sdKzFh8Q0GhfXdh1nfSZCCdHJYo5ApF3Y6MbYQU33+qHL5m7Pq1HRIwgyAZYAO/g7gIypjOv8QA3BlWUOg7SU2eNt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOd7BWvhfC4vhnjOGMkMuv+2B419y2ZmoKJL9FL6ylY=;
 b=n2QHN0ZEhQuhBQyfWkY3CHKabiOshypNiMwbGz8nIDR5uhCwm8D2SNfreckX3NgvISLW0Yy5zIsZTfHAleLrCv7vFcFjAE31vEmj5VKt83Q6ebNe/Ai5AfDO16QuHI/4C2+fRwDgtF97MGAeO1LllyT6X5Ph06WZqZAZlnIuG6vwriDY+xjP6UAteuyWX/oKM0D9dzP9DjLYV+UODr1Iro+davLj9V3WTjYaugpmvw3n8EVhTIhAE1V+8Klkx90jlWYZoHk7Ewv7K229F9ywZju2gylz/WHqYF4hP9C3yrsO/Et4jDuZiV4BojtTZ0YQPHnRFEIU8MrVZ7gbFhpYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOd7BWvhfC4vhnjOGMkMuv+2B419y2ZmoKJL9FL6ylY=;
 b=RFFmm+KZRKdCK+rT/bAd/PcVjvHMLugtYdcL8gSz7ZXJN7X6dnwo5dpStNHrD9wYfXTYlv4nb4WmGpJ0hxswSdLSGf+oEG/SY5ew7ymehpbR1FkttI5yymlqcgxGRuZrnNR0keJ374dlCdaq4MYk7uHYw9dpapdI+0NOzeCWcas=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR0202MB3507.eurprd02.prod.outlook.com (2603:10a6:208:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 15 Jul
 2020 10:56:38 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::dd30:3782:bf4e:2316]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::dd30:3782:bf4e:2316%7]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 10:56:38 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 2/3] habanalabs: create common folder
Thread-Topic: [PATCH 2/3] habanalabs: create common folder
Thread-Index: AQHWWSShuoHSJ/YyP0+6H5xlKe0OyakIeg3g
Date:   Wed, 15 Jul 2020 10:56:38 +0000
Message-ID: <AM0PR02MB552359BAD01388A59B877124B87E0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
 <20200713155424.24721-2-oded.gabbay@gmail.com>
In-Reply-To: <20200713155424.24721-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [5.102.239.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352333da-a477-469b-f5e2-08d828adc003
x-ms-traffictypediagnostic: AM0PR0202MB3507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0202MB3507F93A33EAB21A14492C65B87E0@AM0PR0202MB3507.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C2moxhlCTG7KCuB8Et5oTA5bDLIfjv8CcRj8iBdZ3TLeDdSjWWt1bsEPmjrcFeljJGRIh+uSMs/3avxQ5qQ6VooZdZ8cnsbH9J36sYQvnr8MbE3u0jBfXRWmPuwTcXf3wBP86Ylm8djjxW/evHh6t6dV+wpKiryLxn9c7HpTcbsD8+dSNE6+EfYVyQhVZ7tLdf1gQy6+J9gR5UgfnxeS+4Y9XNrWJAZzyt8vc0e61e3TzoUW6TUbuY5TEeNEmJFnfnV5/YxHS1N/XyRLFUi+9YPpBeC82V620d7quu6JIZWwYHhqK1Q/LTmz5J/atf3iOUNRi8MkCb7HKj75JhJlJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39850400004)(376002)(346002)(2906002)(6636002)(186003)(26005)(316002)(76116006)(64756008)(66476007)(55016002)(52536014)(66556008)(478600001)(66946007)(5660300002)(9686003)(86362001)(66446008)(8676002)(4744005)(7696005)(33656002)(6506007)(53546011)(71200400001)(8936002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Duo+1Zk1irwyyl0u6iaYEolRhtr1k9o6DBxlEOurLhcixd6sYsZkc44wBXpVh8y5yu3VINSKMucKXi5P75afDabw0koddvr7bjFS3aDeMcbHsmT5MzYxqOmuI05fEZY8DDfBL+2FDcJy8dv4Ca5WB65LJhfRoYyXfudEBVd/MEuG4FGgX5I21lSb+fizcaFwS6CAh+d2oJIrM5Ig184qQB/ec8r8pUpSfDjiR22JQAYeQHEujzu5+2hwJ2mK1jduPQMxt0T5idbT/nR38G7The9xFktALBdMpZy3VsdBlMB+c+9HzW3MGUX5xM8P4q+jEoj6cXZlxaEap9gmkv7xA+b5oAJcoh0AbpBl7Ul8VrygPGRoA5JRcCjvKQkJf/pkZnJCsW6CPUULCAy78a2xf6ifTOOyd+aoI7RIlEOaqn/vK8jRxDnT0gpigTk4ajjyWEu5s8bYn/ITgL9uHdeetfOD8Ga57+vkwAxaXPZmn3M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352333da-a477-469b-f5e2-08d828adc003
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 10:56:38.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW3VMgGSakxwTaRb6PiyUH2Hl0r4zqvQ/V2VOjd0iPTNIjPsgY5O2N5cDcZgRHEQCEZU4tvDavZ//VQ92YMR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTQsIDIwMjAgYXQgMDY6NTQgUE0sIE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJh
eUBnbWFpbC5jb20+IHdyb3RlOg0KPiBGb3IgaW50ZXJuYWwgbmVlZHMgb2Ygb3VyIENJIHdlIG5l
ZWQgdG8gbW92ZSBhbGwgdGhlIGNvbW1vbiBjb2RlIGludG8gYQ0KPiBjb21tb24gZm9sZGVyIGlu
c3RlYWQgb2YgcHV0dGluZyB0aGVtIGluIHRoZSByb290IGZvbGRlciBvZiB0aGUgZHJpdmVyLg0K
PiANCj4gU2FtZSBhcHBsaWVzIHRvIHRoZSBjb21tb24gaGVhZGVyIGZpbGVzIHVuZGVyIGluY2x1
ZGUvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEu
YWk+DQoNCg==

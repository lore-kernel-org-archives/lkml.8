Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B69C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15A7218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="GMP1aKdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDTIOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:14:21 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:54623 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgDTIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:14:19 -0400
Received: from [100.112.198.136] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 5C/14-46623-6D95D9E5; Mon, 20 Apr 2020 08:14:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRWlGSWpSXmKPExsWSoc9ipnstcm6
  cwc1fwhb3vx5ltLi8aw6bA5PHnWt72Dw+b5ILYIpizcxLyq9IYM04uriDreAtZ8XeY9fZGxjv
  cHYxcnEwCixlltg+YRkjhHOMRWLiholQzmZGid+9P9lAHBaBE8wSqy6cAHOEBOYzSdzdugXI4
  QRy7jNKfP5kA2KzCVhITD7xACwuIhApsePrSUYQm1mgXGL/j2/sILawQKrE+5YXUDVpEgtv/W
  DtYuQAssMlPlyKAwmzCKhKfJx2DaycVyBWovPHPkaIvSuZJabcmsUCkuAU0JRY8Wo1M4jNKCA
  r8aURwmYWEJe49WQ+E4gtISAgsWTPeWYIW1Ti5eN/rBD1qRInm24wQsR1JM5efwJlK0p8+/8b
  ypaVuDS/G8r2lVh+cQIbyJ0SAloS7yblQ4QtJJZ0t7JAhFUk/h2qhDBzJM6fgmpUk9h+7TzUM
  TISy04egjpmLovEknXqExgNZiG5eRZQNzPQX+t36UOEFSWmdD9knwUOB0GJkzOfsCxgZFnFaJ
  FUlJmeUZKbmJmja2hgoGtoaKRraGmpa2hqopdYpZukl1qqW55aXKJrqJdYXqxXXJmbnJOil5d
  asokRmGhSCo7P2sF4bO17vUOMkhxMSqK8HRZz44T4kvJTKjMSizPii0pzUosPMWpwcAhcOXhk
  NqMUS15+XqqSBC9jBFCdYFFqempFWmYOMBnClEpw8CiJ8O4KB0rzFhck5hZnpkOkTjFackx4O
  XcRM8fOo/OA5JG5SxcxC4HNkxLnTQSZJwDSkFGaBzcOlrAvMcpKCfMyMjAwCPEUpBblZpagyr
  9iFOdgVBLmPQWyliczrwRu6yugg5iADso3nQ1yUEkiQkqqgcld43WClYa0WtAjhkW12Q2fS/w
  m+zbWzHLm+8iw5v+9tam17Y+uzbi5ILs0ICLH7e767k/tYkd2X+mZvWDrwjgruag/9jK5++4n
  3/Lc+vPptciP8dsNlJfkxjxzfv30oEqm1pSLxso/blypKb5QcuxAh8sT31f9Fgsnz3w2j7H36
  q6IR1dMpP8t7LAJ1vS66LfPsKRUPlGz7GXJp4myjksLvuv8+5CdKbDUTi2CX08qhY3p35HtxV
  f3TtnScylQ2aSuRTyOK6N/ZtGUh/6lUsF9nx9fXmOiF6q2pvSaX4dXm9/hfxMOVf9VaJ/sf0u
  PJZT97wW/HQ0HMr/u68052HX7wt+y8oeCqskMkzhlM5VYijMSDbWYi4oTAcHKW8ZTBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1587370453!3554297!1
X-Originating-IP: [104.47.4.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22620 invoked from network); 20 Apr 2020 08:14:14 -0000
Received: from mail-am5eur02lp2054.outbound.protection.outlook.com (HELO EUR02-AM5-obe.outbound.protection.outlook.com) (104.47.4.54)
  by server-20.tower-282.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Apr 2020 08:14:14 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrvsP9Iyo2OFj/wQAVo19WtuXBWIynWrdQkwySrW6iSmY/fTCxO1O3T5jyRDnGglcvzHtSeUjyKKxIYWZiU/zMRCNgVQWNevVhRX8q4xESEEyht4Wyxlg/CBNBFQx+ImA3/9xXDAuBENqyiXnMmYvFU44ssroKDN1BpM8lCVzUX5JlSAg7JRPh324fNfQlACdDjuDFeeSQkPuFm577+5g+jOm5Wr9nhDK1gpqoX6xoJA00irwOjpOcFiWASRyosSRzybgq1oA7CqaJz0Bku2ozB0IZy5tGCU2yWgCmyoxfu6PsMwdsI4pFzeHgCBkHxXr7Ku04Pbm8OH5E/Cu5wgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsKpsUZBEIc2h/GWrsMpIsd94GRAAS+I5AQgPp0ZlI0=;
 b=NjNE8B4u4/3PuyxU33I/ObgxY3XxhDBukhAOZRyZ7Qqy42A/09dqr4zYKLiabIoEOoXLTfGU/9Keqaxh4cQPhQpEbqlnEKeD4zRCrQr0riuSkl3oDIwsuwKRs/4/7vdD71b2fO2eRgLNZH5+UmNIbcJVh3zL1Qm9Qijyk9VuKJjRqFHl8UCjOjnVPQiQ0Gn/oMes+7DkufsADHbYDkmx5Lhovhmyabm8g5SjAhwx76mbR5zUDKJLUOBewyrouQNXEidB9PlaI7wUNBriIUcOS/oLJLAEv1eaeVEm/70M3W/14pMqG8Eo9M0Lt1OPVrJ4EBTetMXAIwiVLCZrwj4e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsKpsUZBEIc2h/GWrsMpIsd94GRAAS+I5AQgPp0ZlI0=;
 b=GMP1aKdVwI0Biv2kGebF1xSyIvFnKuYZdn5iS9BMWO2djhsO2IRIrDZYnFTeUJrYYxPVoPSmg1hcg8IIl1yhaSiO2RltkbZIlca0sI0OKiMPD6VurHzl9IP81uD1JgLDUuoqjveuPn/09sM0bic1gXOIXs/eEdfOMwpeZ1AKM7A=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 08:14:13 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 08:14:13 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHWC/ENSER4gvf5u0yNBk4BhQAwn6h7chgAgAARuaCAAZgzAIAABiBAgASRgoCAAAs+oA==
Date:   Mon, 20 Apr 2020 08:14:13 +0000
Message-ID: <AM6PR10MB22631CD857CCB2C153D009CA80D40@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416075944.GU2167633@dell>
 <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200417092410.GF2167633@dell>
 <AM6PR10MB2263F5CE9B3627A256BD695880D90@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200420073155.GK3737@dell>
In-Reply-To: <20200420073155.GK3737@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 517cb5a5-6668-4da3-36c9-08d7e502cfac
x-ms-traffictypediagnostic: AM6PR10MB2918:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2918D49336B81FE8A48F82D6A7D40@AM6PR10MB2918.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(4326008)(9686003)(52536014)(55016002)(55236004)(66446008)(107886003)(26005)(186003)(478600001)(76116006)(66946007)(66476007)(66556008)(64756008)(4744005)(71200400001)(86362001)(7696005)(110136005)(81156014)(54906003)(8936002)(8676002)(316002)(33656002)(53546011)(6506007)(5660300002)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxIZo8e2kbKTWYtW+rGIele85fjnE7Obi7Z4dPdNnSB5BO8+2xasxEsxafFY2kP+H73c4NcSXSz7qgTVNlwFL0ofyuqxUmlzGYxfjnpxfg2DyhjyVHdY78dJckFSPsa2aGA69heDya8VdjXZiTDyLo+RV9w5Uu2dYRi2Va+++ViuMij8h8dU4/fJ1TvJcLLz4hzkEwDCOSvwej48CQNli5jDqOpagenSkw3nl9UMNEQg68Cfh7XCWGXyiCyBQQ2qxbZTIWyedoYe9OWfsGuDnhl6gmVLbc7yeAAMZyU2soSIYiEoxUQ+kGhKAWgtoHk/B/U7eiDO49V7L4fTiYV8/4nmyL0r7bgCxVhNCANCtU/8JPjR/92Olw+njhvWRonOT+eOhOlB/K6YCoDX1AppmQeg9sK1l1y45jqavD54EuB7omo4/umjNQYBZYIk01WS
x-ms-exchange-antispam-messagedata: 0+JiD4wmIMcTrPU3sPR4qQyM1iWwVpdUt7SrDp+zbFBprusULBwmbZhdGiFH7mI/mQ749Dtea1NkE9q4817WYW7qd4S3uZf5Je63Vh5+vtt9Qd7LKW7g6aaLQmnaemMDM3XIfSwNzjCgl65h6i23uA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517cb5a5-6668-4da3-36c9-08d7e502cfac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 08:14:13.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHrGPmGDEbV765oCu3Z6ss8kGg7WiFX2DvGciPNUVZf8cW4WY8Wfq5Jdn3QmkLeqqA8RiQxSFo5ixYhgs/cFRv8LsWHEc1G4gqHET7IjKj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAgQXByaWwgMjAyMCAwODozMiwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+ID4NCj4gPiA+ID4g
PiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRG8geW91IHdhbnQg
dG8gZmFpbCBzaWxlbnRseSBoZXJlPw0KPiA+ID4gPg0KPiA+ID4gPiBXZWxsIGFuIGVycm9yIG1l
c3NhZ2UgaXMgcHJpbnRlZCBpbiB0aGUgY2FsbGluZyBjb2RlLCBzbyBkaWRuJ3QgZmVlbCBsaWtl
IGl0DQo+ID4gPiA+IHdhcyBuZWNlc3NhcnkgdG8gaGF2ZSBhZGRpdGlvbmFsIGRlYnVnIGhlcmUu
IEZlbHQgbGlrZSBibG9hdC4NCj4gPiA+DQo+ID4gPiBBcyBhIHVzZXIsIEkgd291bGQgcHJlZmVy
IGEgbW9yZSBzcGVjaWZpYyByZWFzb24uDQo+ID4gPg0KPiA+ID4gVGh1cywgSSB3b3VsZCBwcm92
aWRlIGFuIGVycm9yIG1lc3NhZ2UgaGVyZSBhbmQgb21pdCB0aGUgZ2VuZXJpYyBvbmUuDQo+ID4N
Cj4gPiBJIGNhbiB1cGRhdGUgYWx0aG91Z2ggSSdsbCBvZiBjb3Vyc2UgdGhlbiBuZWVkIHRvIGRv
IHNpbWlsYXIgbWVzc2FnZXMgZm9yIHRoZQ0KPiA+IG90aGVyIGVycm9yIGxlZ3Mgb2YgdGhpcyBm
dW5jdGlvbi4gRldJVywgYXMgdGhpcyBpcyBvbmx5IGJlaW5nIGNhbGxlZCBvbmNlIGluDQo+ID4g
dGhlIHNhbWUgZmlsZSB0aGlzIGVycm9yIGxlZyBvZiBjb2RlIGN1cnJlbnRseSBjYW4gbmV2ZXIg
b2NjdXIuDQo+IA0KPiBBcyBhIHRpbnkgaW1wcm92ZW1lbnQsIGl0J3Mgbm90IGEgZGVhbCBicmVh
a2VyLiAgSWYgaXQncyB0b28gbXVjaA0KPiB3b3JrLCB5b3UgY2FuIGVpdGhlciBzdWJtaXQgYSBz
dWJzZXF1ZW50IHBhdGNoIG9yIG9taXQgaXQgY29tcGxldGVseS4NCg0KVGFrZW4gY2FyZSBvZiBp
biB0aGUgdjMgcGF0Y2ggc2V0IEkgc3VibWl0dGVkIEZyaWRheS4gSG9wZWZ1bGx5IHRoYXQgY292
ZXJzDQpldmVyeXRoaW5nLiA6KQ0K

Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="OXLvyCTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBLO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:56:13 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:59707 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbgBLO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:56:12 -0500
Received: from [100.113.3.77] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 07/B4-54715-802144E5; Wed, 12 Feb 2020 14:56:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRWlGSWpSXmKPExsWSoc9grMsh5BJ
  ncHUzu8XUh0/YLLbuUbX4dqWDyeLyrjlsDiwe6w6qeuycdZfdY9OqTjaPz5vkAliiWDPzkvIr
  ElgzNq9/yVTQJFnRumkJWwPjDYkuRi4ORoGlzBILNmxlh3COsUgcOLeRBcLZzCjxu/cnG4jDI
  nCCWWJm820wR0hgEpPEticPWSGcu4wSN1f1AGU4OdgELCQmn3gAViUi8IRRYu+Fs0wgCWYBR4
  nbe9+C2cICsRLrNt1mB7FFBOIkOvfPZoOwnSQunb7AAmKzCKhK3LwJspuDgxeo/vxRF4hlOxg
  lFrzoBZvDCVTf3vKCFcRmFJCV+NK4mhlil7jErSfzwWokBAQkluw5zwxhi0q8fPwPqj5V4mTT
  DUaIuI7E2etPoGxFiT3nFkL1ykpcmt8NFfeVmLJ+JgvIPRICWhL/tvFAhC0klnS3QoVVJP4dq
  oQI50hsOXaQBcJWk3i/7ALURBmJ1TPXgcNNQuAts8T7LdtZJzAazEJy9SygUcwCmhLrd+lDhB
  UlpnQ/ZAexeQUEJU7OfMKygJFlFaNlUlFmekZJbmJmjq6hgYGuoaGxLpA0MtdLrNJN1Est1U1
  OzSspSgTK6iWWF+sVV+Ym56To5aWWbGIEpqWUQob6HYyb177XO8QoycGkJMo75bdznBBfUn5K
  ZUZicUZ8UWlOavEhRhkODiUJXnN+lzghwaLU9NSKtMwcYIqESUtw8CiJ8D4ASfMWFyTmFmemQ
  6ROMRpzTHg5dxEzx5G5SxcxC7Hk5eelSonzegsAlQqAlGaU5sENgqXuS4yyUsK8jAwMDEI8Ba
  lFuZklqPKvGMU5GJWEeQVApvBk5pXA7XsFdAoT0CnXTRxATilJREhJNTDpG3/a2BlTsJf7C8O
  mg5IPr619PUWfRd9/SsgzHg1H4Xe/1i+adDE9IOkUm0vLufKpW/nCVv3qKn9tp9A3Q12l4tGZ
  Wft0dIV3n/xw0vtGtXjw1h2LDy5V6Lct/Zk5KfKv86rdn7c1LOpZ8f7tPE6p/AD5mXc+K8/md
  udXvT7Dryzu1pVGmc11k29vs9zltH/ls838RpGr/0dN9jLZ0XVV7+C6W+aOYslzP5od/VyzeO
  0quaePdk/+vatvq+XC1w8qVS4e2noj4Xd4R5r5pMfL5gnp5CnnmwvL116z2/1u15ezTGz3rZV
  CI98IGvDLntCZecCwL0rz+1v+jDlbfPtztuVk+Xfq//S2THWNU+m5qsRSnJFoqMVcVJwIAAGr
  u8BYBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-223.messagelabs.com!1581519367!2041675!1
X-Originating-IP: [104.47.0.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2048 invoked from network); 12 Feb 2020 14:56:08 -0000
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.51)
  by server-12.tower-223.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 14:56:08 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEBoCK2lw68u7sJPptnX4p/6ydXVgRspnzWfJn7coUFB2iQBnkfj490XebmbgqtKn8N2dngvGWzh6ovt+aKm1lZfhLqeYWmkIE84xirapacIdKXCc0enMTXPRhHXlNo02b7NtVkxeYn2K0QOOOCrQ+M1g5RiQbM4dq6cwFbi6OdOmMgDa3yF2r/qLvLrS2Nku87wnpD3PWbavwWl+m//WdyJWoaU+EAa68JTgNtB0FSJ1oznhOoLNqgS9mMUGpiQHOieGGzTKahAEwyhyTzIa/mMrct0ZAPghERJwGl/nwGjeyf2WoqixXrs3L0bI+tAvj8VE9f4lS7utWkAliRTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl/kHnuxDG7UQXK2W6tvsYKfzKaQCzuJGITtyGtW7JA=;
 b=XzYZTwjp8/tU0JzH2GbEyXCUM1nNobxglOObNbOm+GTum7ksjpHBb9Ewwo7h0elw7SNmk96AQ8+y18fsvxIvx0WsP6ZY6bjekYmlVijszs6Y972A7dlbPFyUR6TDlNvtZyfyuC6qpDCm50TcgfQ6r7oxktu0hyyjpMQyGAL2PdFrIxK3L3o100F35LjEwabgVi1aQSa8y9XD82slP8vRGhpQ97jR4BpITuZivWKWF+HpHD76RZ21bTlrL0973y3h7PNlCSR4tBrou9enWogu42SIzEl5cYSq5aQpMcEEcboxRqRBbKJ3wDV27ffhQwBo/oVd2k3gQ+SI58ieR5umcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl/kHnuxDG7UQXK2W6tvsYKfzKaQCzuJGITtyGtW7JA=;
 b=OXLvyCTHVR65kDAnG4eW885ZdFyeRvK8XfEJBteFeKhbmE1kTppGoW3ZfPqbxNbaG5jxeLgtESflaaFZXZYH3ZGQZBbof7OCEfavwywYqtGwGze3YnkTVsFFxnBXQCbbkD3n1LRqSa6gRF1GCN+K4o2EVd3CvZLD80ScySvC0tA=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB3398.EURPRD10.PROD.OUTLOOK.COM (10.255.123.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Wed, 12 Feb 2020 14:56:05 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 14:56:05 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9063: Replace zero-length array with
 flexible-array member
Thread-Topic: [PATCH] regulator: da9063: Replace zero-length array with
 flexible-array member
Thread-Index: AQHV4TU7XbdeFIRzwE217omIGbXoEqgXaC9QgAA29gCAAAdJQA==
Date:   Wed, 12 Feb 2020 14:56:05 +0000
Message-ID: <AM6PR10MB22632DDE0CB4AC71796E9464801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200211234710.GA29532@embeddedor>
 <AM6PR10MB226386E325F5EEA41A1C47BA801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <575985a9-cc82-1eae-6651-30a603f494d7@embeddedor.com>
In-Reply-To: <575985a9-cc82-1eae-6651-30a603f494d7@embeddedor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 729f61f6-de02-46b7-6cca-08d7afcbafd9
x-ms-traffictypediagnostic: AM6PR10MB3398:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB3398790C143A5631DCF451B1A71B0@AM6PR10MB3398.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(498600001)(66476007)(52536014)(966005)(86362001)(7696005)(76116006)(64756008)(66556008)(55016002)(66446008)(66946007)(71200400001)(26005)(6506007)(186003)(53546011)(81166006)(8936002)(81156014)(8676002)(110136005)(9686003)(33656002)(5660300002)(55236004)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB3398;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8seEW69l9zkY9d3qVbOrkmaCg26jpeWudyqT3A4WPwqrQwEYIzwETj/OAxrp5tfz4r9DHTol3OZmExSvSHrIvgWpgNgq+5AUIBZyY2GyzzOQafrD/qUwBODN7y+7yyC6p2LEeid2zNB+33uzQSW1lCzzPUmmOE/U5uEkELV4BMdJzQ9htQIPQnEBXlmAPBDFlzklVivWHXsF1HeMH442dpJkY0fsmnQYzWHRyknnLBPV0SqISF0109kQbRJr6rOVCaI1122insMQ96aDkl2LvvyuYTP+xg2n5IwbDlHOvFTc83PTNhlll92dYOprZAfSw8vmvTuJX2h3wynU5gM7s7Oi3bB1TQF9mCdITklPLwxObE06hpGKQfq5kON1skEs+uzSZtyYrqh7yca0KMiKQj6SjAWyTPmeQ+rxT6mE0CgRHjKcUlp9/2vp6zroscRiJBYAepocQ+sZxIzVD/x4NlpuKfXnUVALZcwH4WV5HDysT0hr2iNlKJNDfMMbO4g1LYjYsOIh8D6hEoOQb3oUw==
x-ms-exchange-antispam-messagedata: dJ/qHhUvIyxcZDNjPti7AkQyh7uAidVbFyCGG4Io4DtZyQ6I4Cv2nS3zY4m1LdRlPXjIs8yNhI8SJRCQUtPVs8hRoDCNpPLuBNOyLejKZdisZXBcjPRnL39k12gsZMlpyu6VTOQ46wGpR7qJWuqCcg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f61f6-de02-46b7-6cca-08d7afcbafd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:56:05.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRI32Yv/RjYKlJ37U5VHefWJjIqE3pjmmp0p/n6o5bW59UlzZjH1D0lGGSLlybm3lYkNpCQNiwusxJfoF1u4ODMhVS9X8WozqIKQQzgMI74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIgRmVicnVhcnkgMjAyMCAxNDoyOSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCg0K
PiBPbiAyLzEyLzIwIDA1OjE0LCBBZGFtIFRob21zb24gd3JvdGU6DQo+ID4gT24gMTEgRmVicnVh
cnkgMjAyMCAyMzo0NywgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gPg0KPiA+PiBUaGUg
Y3VycmVudCBjb2RlYmFzZSBtYWtlcyB1c2Ugb2YgdGhlIHplcm8tbGVuZ3RoIGFycmF5IGxhbmd1
YWdlDQo+ID4+IGV4dGVuc2lvbiB0byB0aGUgQzkwIHN0YW5kYXJkLCBidXQgdGhlIHByZWZlcnJl
ZCBtZWNoYW5pc20gdG8gZGVjbGFyZQ0KPiA+PiB2YXJpYWJsZS1sZW5ndGggdHlwZXMgc3VjaCBh
cyB0aGVzZSBvbmVzIGlzIGEgZmxleGlibGUgYXJyYXkgbWVtYmVyWzFdWzJdLA0KPiA+PiBpbnRy
b2R1Y2VkIGluIEM5OToNCj4gPj4NCj4gPj4gc3RydWN0IGZvbyB7DQo+ID4+ICAgICAgICAgaW50
IHN0dWZmOw0KPiA+PiAgICAgICAgIHN0cnVjdCBib28gYXJyYXlbXTsNCj4gPj4gfTsNCj4gPj4N
Cj4gPj4gQnkgbWFraW5nIHVzZSBvZiB0aGUgbWVjaGFuaXNtIGFib3ZlLCB3ZSB3aWxsIGdldCBh
IGNvbXBpbGVyIHdhcm5pbmcNCj4gPj4gaW4gY2FzZSB0aGUgZmxleGlibGUgYXJyYXkgZG9lcyBu
b3Qgb2NjdXIgbGFzdCBpbiB0aGUgc3RydWN0dXJlLCB3aGljaA0KPiA+PiB3aWxsIGhlbHAgdXMg
cHJldmVudCBzb21lIGtpbmQgb2YgdW5kZWZpbmVkIGJlaGF2aW9yIGJ1Z3MgZnJvbSBiZWluZw0K
PiA+PiBpbmFkdmVydGVubHkgaW50cm9kdWNlZFszXSB0byB0aGUgY29kZWJhc2UgZnJvbSBub3cg
b24uDQo+ID4+DQo+ID4+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIHdpdGggdGhlIGhlbHAgb2YgQ29j
Y2luZWxsZS4NCj4gPj4NCj4gPj4gWzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9n
Y2MvWmVyby1MZW5ndGguaHRtbA0KPiA+PiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGlu
dXgvaXNzdWVzLzIxDQo+ID4+IFszXSBjb21taXQgNzY0OTc3MzI5MzJmICgiY3hnYjMvbDJ0OiBG
aXggdW5kZWZpbmVkIGJlaGF2aW91ciIpDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rh
dm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+ID4+IC0tLQ0KPiA+PiAg
ZHJpdmVycy9yZWd1bGF0b3IvZGE5MDYzLXJlZ3VsYXRvci5jIHwgMiArLQ0KPiA+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9kYTkwNjMtcmVndWxhdG9yLmMgYi9kcml2ZXJzL3Jl
Z3VsYXRvci9kYTkwNjMtDQo+ID4+IHJlZ3VsYXRvci5jDQo+ID4+IGluZGV4IDJiMGM3YTg1MzA2
YS4uMzY4ZjhhZDJhOWY5IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9kYTkw
NjMtcmVndWxhdG9yLmMNCj4gPj4gKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvZGE5MDYzLXJlZ3Vs
YXRvci5jDQo+ID4+IEBAIC0xMTksNyArMTE5LDcgQEAgc3RydWN0IGRhOTA2M19yZWd1bGF0b3Ig
ew0KPiA+PiAgc3RydWN0IGRhOTA2M19yZWd1bGF0b3JzIHsNCj4gPj4gIAl1bnNpZ25lZAkJCQlu
X3JlZ3VsYXRvcnM7DQo+ID4+ICAJLyogQXJyYXkgc2l6ZSB0byBiZSBkZWZpbmVkIGR1cmluZyBp
bml0LiBLZWVwIGF0IGVuZC4gKi8NCj4gPj4gLQlzdHJ1Y3QgZGE5MDYzX3JlZ3VsYXRvcgkJCXJl
Z3VsYXRvclswXTsNCj4gPj4gKwlzdHJ1Y3QgZGE5MDYzX3JlZ3VsYXRvcgkJCXJlZ3VsYXRvcltd
Ow0KPiA+DQo+ID4gU2FtZSBjb21tZW50IGFzIGZvciBkYTkwNjIuIFRoZSBwcm9iZSB1c2VzIG1h
bGxvYyBhbmQgZG9lcyBub3Qgc3RhdGljYWxseQ0KPiA+IGluaXRpYWxpc2UgZm9yIHRoaXMgc3Ry
dWN0IHNvIHRoaXMgd2lsbCBicmVhayB0aGUgcHJvYmUuDQo+ID4NCj4gDQo+IER5bmFtaWMgbWVt
b3J5IGFsbG9jYXRpb25zIHdvbid0IGJlIGFmZmVjdGVkIGJ5IHRoaXMgY2hhbmdlOg0KPiANCj4g
IkZsZXhpYmxlIGFycmF5IG1lbWJlcnMgaGF2ZSBpbmNvbXBsZXRlIHR5cGUsIGFuZCBzbyB0aGUg
c2l6ZW9mIG9wZXJhdG9yDQo+IG1heSBub3QgYmUgYXBwbGllZC4gQXMgYSBxdWlyayBvZiB0aGUg
b3JpZ2luYWwgaW1wbGVtZW50YXRpb24gb2YNCj4gemVyby1sZW5ndGggYXJyYXlzLCBzaXplb2Yg
ZXZhbHVhdGVzIHRvIHplcm8uIlsxXQ0KPiANCj4gWzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25s
aW5lZG9jcy9nY2MvWmVyby1MZW5ndGguaHRtbA0KDQpBcyBmb3IgZGE5MDYyOg0KDQpBY2tlZC1i
eTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21zb24uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCg0K
PiANCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rhdm8NCg==

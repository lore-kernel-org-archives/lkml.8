Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07687C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E8B20702
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaEMThep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBQHbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:31:23 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:63349
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbgBQHbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:31:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENUHbDCaG9EFZ0zo/+YVWcusCTPGBrePLASJL0EDCfPdIdALUMacZkYeQF//Pl2rujvlafYuBHPxurQ733lS8gLVRWc5UbooLl0KQ4hTItJD8wnmDU8Z0gzOB8B/WBvHLuEkHppsNXSF+P26Nldgj8EBpZCrHKTBwAC85hIviT4tOLKAk8GvyDUa1RufPUohZK+Z+H1SGArcXw0t5eg8W3U+I11yPe5N4Zj+pZsB4timM5902avGASUVN99e/oMtqfKD3OveCZ9LEjX/gc3+fM2mqs3NugS4V2rMMuS+HN7l9zGMFWL1J+05pI/HUtug/oFMMvT9PNkkxm36aRL68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSA7GTWhBULoMd6R7Fb1tL5bJ3okeGzEO3VNRv8ozg8=;
 b=F5rxyZ8VFLu5DhLmxpuWN80upFK/TecL53Uarq3qlTY5vStiRlVlzJQ2VQcQa70PbWaDUjTYCBJanKLaIzsUx0k/72WbRym5VGDjWzSe9nooVtAiIdOepEzu2JXn/uVO6I4UkEsbyUngSzoC5KKrqqFoRACFJACcYlY9wokxW23+axEWICPuR+qUQm81qMWM6F9wPv+gxtSHzkh6oW+jG4aXUHZlFU86GeFcZpePB+4xy/u9BSa+CiNf3tvay2vy7O/WZeHz1mKZcxuEogR/4hGhB8I+p3eRsqlBiubJpg5TYn2eqQN40gN6AVYgw9l9+PA70WGUOJ96wB+k62A4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSA7GTWhBULoMd6R7Fb1tL5bJ3okeGzEO3VNRv8ozg8=;
 b=eaEMThepnjTUr4IC9ok6DE5pWeKh/Fa+Tc7opolFAxXtKRdI+WsEZqkdxjcBTjgEwIJuA3c8DHSgsxPO6wOXX+mSEmMiUuw0oif2YJ1d4Yv+ipn9fTYKwACVbxr0T1hQlWUl9xaRvKYck0p96JTHbbSfIwitJ8gjRt7Dcq6tkOA=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.133.15.19) by
 VI1PR04MB5648.eurprd04.prod.outlook.com (20.178.127.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 07:31:19 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::282a:936e:f46e:9d7f]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::282a:936e:f46e:9d7f%6]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 07:31:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     Oliver Graute <oliver.graute@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: clk: imx: clock driver for imx8qm?
Thread-Topic: clk: imx: clock driver for imx8qm?
Thread-Index: AQHV4oK4jf4Yk7gIB0yfade2LGWp9agZS8HggAAZIYCAAMrjIIAEzDUAgAAAw7A=
Date:   Mon, 17 Feb 2020 07:31:18 +0000
Message-ID: <VI1PR04MB42220B24B1C46756A4B9E7B180160@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20200213153151.GB6975@optiplex>
 <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200213174225.GA11566@ripley>
 <AM0PR04MB42111BF00621C1949E1FBA9080150@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200217070429.GB7973@dragon>
In-Reply-To: <20200217070429.GB7973@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00cc6d3c-51d1-4c47-5a37-08d7b37b6167
x-ms-traffictypediagnostic: VI1PR04MB5648:|VI1PR04MB5648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5648BAEB5A5514F01948557180160@VI1PR04MB5648.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(44832011)(4326008)(2906002)(186003)(6506007)(9686003)(54906003)(55016002)(86362001)(110136005)(26005)(8676002)(71200400001)(52536014)(478600001)(8936002)(5660300002)(81156014)(81166006)(7696005)(33656002)(966005)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5648;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crGwXCirNM8onl9wu1cuSnyH3QDdeK98P19FE1fx53e2rf6GY/sRRPRiYXqXap9GMjxUO4Z6S/pppEqt0DyecoO0p89pU8ZfW+eGaAowocaw/45KhR1YBBykcsAaHbeJglVIcbEhx3CXcgwHlbwaYLfztlbUrSGtRNqjvmjzI0oad5EyxtIEW9YZQ1P77Xyk2Qe3C4mWybQmmaQK620NuDmarquKKTqqglHkEUQQNlxayHLO28/KQ0j9MwTLwB4NmRgat/A6xy0Tv6lqMl/2ff+SKvao4IeIDcIKnaRq6yF0MPO75Wy6fk/I6GWK6abg2156oDTvHIaRs9DbRTl8RTufmEOGT8Nf4oGXEPKs+9Jj1RqQdBmA3r8bDIoV0A1NHfpNuGOYLIJWk6//jaG/nNMtjRg1moDzQMa8g+2ECyVNKtWo+gt9hWiUQBTgpk/6qwATojaHfLa1nBl6jqnaTrGLsRwX/woKtK3yTyXp2KANkUKJWsnZvjf0S/J/Ij3g3kBS0NHJtCOkNDpNSGXgBL6JKohVNOb4jP0mQf42TQDe4LRRWp4ZOwPzW74Nx7mP
x-ms-exchange-antispam-messagedata: HR92ZMiv9lQ+664YkREMQbEWkkr4iM3xZ6MIvdMfX3pBc0D9YmXm3T+jgg0KzjBa/DqT87I2Liq42+x/LUuw+q/MYQVGrJl3LM6XV0HAu0mqaOl2JhsufgWSJuqZxC0uonMt1n0MyWKfXJC2wLFyEg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cc6d3c-51d1-4c47-5a37-08d7b37b6167
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 07:31:19.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibggN0oRFlQJzLq6W9C1rslpwiY7mNkFJondU6KcC8N+BZfwdMni9YF+y+lYbcJ7FsIQTdp3oT2lCOTiJFgjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
RmVicnVhcnkgMTcsIDIwMjAgMzowNSBQTQ0KPiANCj4gT24gRnJpLCBGZWIgMTQsIDIwMjAgYXQg
MDU6NTA6NDhBTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+ID4gRnJvbTogT2xpdmVy
IEdyYXV0ZSA8b2xpdmVyLmdyYXV0ZUBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDE0LCAyMDIwIDE6NDIgQU0NCj4gPiA+DQo+ID4gPiBPbiAxMy8wMi8yMCwgQWlzaGVu
ZyBEb25nIHdyb3RlOg0KPiA+ID4gPiBIaSBPbGl2ZXIsDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBpcyBzb21lb25lIHdvcmtpbmcgb24gY2xvY2sgZHJpdmVyIGZvciBpbXg4cW0/IEkg
bWlzcyBhdCBsZWFzdCBhDQo+ID4gPiA+ID4gY2xrLWlteDhxbS5jIGluIHRoZSBkcml2ZXJzL2lt
eC9jbGsvIGRpcmVjdG9yeS4gSSBzYXcgdGhhdCB5b3UNCj4gPiA+ID4gPiBhcmUgd29ya2luZyBp
biB0aGlzIGFyZWEgYW5kIHBlcmhhcHMgeW91IGNhbiBnaXZlIG1lIHNvbWUNCj4gPiA+ID4gPiBp
bnNpZ2h0cyB3aGF0IGlzDQo+ID4gPiBuZWVkZWQgaGVyZS4NCj4gPiA+ID4gPg0KPiA+ID4gPg0K
PiA+ID4gPiBNWDhRTS9RWFAgYXJlIHVzaW5nIHRoZSBzYW1lIGNsb2NrIGRyaXZlciBjbGstaW14
OHF4cC5jDQo+ID4gPg0KPiA+ID4gb2sgdGh4LCBmb3IgdGhhdCBjbGFyaWZpY2F0aW9uLg0KPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gW1BBVENIIFJFU0VORCBWNSAwMC8xMV0gY2xrOiBpbXg4OiBh
ZGQgbmV3IGNsb2NrIGJpbmRpbmcgZm9yDQo+ID4gPiA+IGJldHRlciBwbSBUaGUgcmV2aWV3IG9m
IHRoYXQgcGF0Y2ggc2VyaWVzIGlzIHBlbmRpbmcgZm9yIGEgY291cGxlIG9mDQo+IG1vbnRocy4N
Cj4gPiA+DQo+ID4gPiB5ZXMgdGhhdCBpcyB3aGF0IEkgY3VycmVudGx5IHVzZS4gU28gZnVydGhl
ciBpbXg4cW0gZGV2ZWxvcG1lbnQgY2FuDQo+ID4gPiBoYXBwZW4gaWYgdGhpcyBpcyBpbnRlZ3Jh
dGVkPw0KPiA+DQo+ID4gWWVzLCBpdCBibG9ja3MgdGhlIG1vc3QgZm9sbG93aW5nIE1YOFFYUC9R
TSB3b3JrLg0KPiA+IExldCBtZSBsb29wIGluIFNoYXduIHRvIHNlZSBpZiBhbnkgc3VnZ2VzdGlv
bnMuDQo+ID4NCj4gPiBTaGF3biwNCj4gPiBBbnkgaWRlYXM/DQo+IA0KPiBJIGd1ZXNzIHRoZXJl
IGFyZSBzdGlsbCBzb21ldGhpbmcgU3RlcGhlbiBpcyB1bmhhcHB5IGFib3V0LCBhcyB3ZSBoYXZl
bid0IGdvdCBhDQo+IG5vZCBmcm9tIGhpbS4gIERvIHdlIHJlYWxseSBhZGRyZXNzZWQgYWxsIGhp
cyBjb21tZW50cyBhbmQgY29uY2VybnMgYWxyZWFkeT8NCj4gDQoNCkkgcmVtZW1iZXIgSSBhZGRy
ZXNzZWQgYWxsIFN0ZXBoZW4ncyBjb21tZW50cyBpbiB0aGUgbGFzdCByb3VuZCBvZiByZXZpZXcN
CndoaWNoIGlzIG1hcmtlZCBpbiB0aGUgVjUgcmVzZW5kIGNoYW5nZSBsb2cuDQpodHRwczovL3d3
dy5zcGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzc2OTM2NS5odG1sDQoNCkJ1dCBJIGNh
biBkb3VibGUgY2hlY2sgaXQuDQpTaG91bGQgSSByZS1zZW5kIGFmdGVyIGEgY2hlY2tpbmcgb3Ig
d2FpdCBmb3IgU3RlcGhlbidzIGZlZWRiYWNrPw0KDQpBcyB0aGlzIGRvZXMgYmxvY2sgYSBsb3Qg
b2YgZm9sbG93aW5nIHFtL3F4cCB3b3JrIGZvciBhIGxvbmcgdGltZSwgaG9wZWZ1bGx5IHdlDQpj
YW4gZ2V0IHNvbWUgZmVlZGJhY2svZ3VpZGFuY2UgZnJvbSBTdGVwaGVuLg0KDQpCVFcsIHRoaXMg
cGF0Y2hzZXQgaXMgYWxyZWFkeSB1c2VkIGluIE5YUCBpbnRlcm5hbCA1LjQgcmVsZWFzZSBhbHRo
b3VnaCBpdCdzIG1pc3NlZA0KNS40IExUUyBrZXJuZWwuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
PiBTaGF3bg0K

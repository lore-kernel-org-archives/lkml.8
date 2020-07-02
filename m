Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE602077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="idrNaLrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGBGLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:11:19 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:14467
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgGBGLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNAZnszeO+pfAHUVpTUJga3oFPRuQA6xbfYt3HdlEEC5fhKRTe/2NdKTPXbKe2HEZRZ7QCBsbY4Tuk/WgkXfl9ojVhPYVHQnwT3eJNCOHSJx0wCpfCW//Mr0AVCbtj/AKd/Ecex3hWRO/JucmroIeIr+sRHnf/omp7C1qntrpOZSw6bvc1ozfAZO1OYpWt1M/TRyfmiTeivFSufXsv/NuNCcBXgfiqGyXiiMJ/mBQv4aeQwNzqyJETDOxUoyPUQW65qd6TdvS3kDYRgHRBlWOX3YKSjN0p1b1jDBXEgGJeJxsoYOyixJDTulOrtvxjpkgVS5qxvebSRTEbb10tgDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMBZqSmQ277l1bUlsSPRSsdi/Od79rBGvD7yt5nMsDM=;
 b=UYJRDmF8hTjvZw2F6a5gLDbwow4yG7v+ycZK8sOB0ZrMMS2CibRrZIRLY6INomsm0TTD+vBhq0KdTlCqNweLdGrCa0ywZQ6HJn8Hm3bB9WdFcH8OnT6Rkr2Zk2xrmeqCU54LXa7O6Ab9GcV/R2oEX/d7caY+L+3t6IGgzZaMy27USHutJBR7irOW9NUTPp6AjQ/KUo14mvg88ZJ11hvDrL9ZhEtPa7tDZV3fHNL7Wb4FqKEgvLIh/0iro/iMX8kVlts8RviT1vNrlfH64rrrJAFjmnlgjQYF36jtbvPU3RXG35IK5CIBRRDXIwUExa+yVwXzqK+q0zUPAO2yhJXOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMBZqSmQ277l1bUlsSPRSsdi/Od79rBGvD7yt5nMsDM=;
 b=idrNaLrk7QacKRzh1rHxh4PfCI2nvQt9BK3o6ricjNTuzrwxGNoWo8gH0f6vrGVtG12Km0wWtTpGjYlFPuVM2plN8WeuPbQeboKLFgQcdn8XFYEa/vCXYMwPF5S7q2kgMIAxb0XYU1qfZLangAQ6BpDtIj429EAQ52HJn1PFSKU=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM5PR04MB2946.eurprd04.prod.outlook.com
 (2603:10a6:206:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 06:11:13 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f%4]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 06:11:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Topic: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Index: AQHWUBb/eaArIN5lW0eg3m9Qeje+NajzluoAgAAJBACAACXUAIAABbYg
Date:   Thu, 2 Jul 2020 06:11:13 +0000
Message-ID: <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com>
 <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
In-Reply-To: <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1caecfb-de69-4ad0-00c5-08d81e4eb903
x-ms-traffictypediagnostic: AM5PR04MB2946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB2946168868A43C517B71AC9CF56D0@AM5PR04MB2946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqtMmgXU67Q/Kp43o3cCwuwqZKGIwuZdy3454gVEoXfGuTQl8DzMqEoeil9qQVXGYiM1/6eLWzq8s7Ub4r4BST3sKl1rK6xjhZNwF79cyg7wHktxdR5iat5H0erAGTX8u864u1X+6r5BnBGAXiwhaLG/gKR1lukghygs7jH7muWH5VKnPG7InUeISPMDhmR0fXDjPiz6c8qQwxpyL42DOLWOLOtYw661BIFDEibngELepwg05s9/Hl85bFu/n2m5EQGcz0H+TFYdufqdfuDlqelYquZ52RZMPefRfCF6vlm14EbWFQAdGVPSu+lcCz9n08c1HDoshunMipKGXtmuBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(186003)(26005)(83380400001)(53546011)(6506007)(7696005)(6916009)(55016002)(8936002)(71200400001)(8676002)(9686003)(7416002)(2906002)(54906003)(33656002)(4326008)(316002)(86362001)(478600001)(66946007)(66476007)(76116006)(44832011)(52536014)(64756008)(66446008)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /ZwkfyoK0dWK0PmY86TrEojGVvLiWPjuBj29K9oGLFZ/c7XWCoxEJ+ngEzh77kKXHzrhuNHVtkZ3+nVlYQoTzaYDnBS1NxKQokTegadNv1VXJStgggWR4nEe9hn6s0WJ4U0GAZLh19hO3Nim6PqOcpRI7pFtEr9Hh0V9H+6+vLCcb+sUrvEShmI2orxv9WfuVc5aLJ1nbqV3D1BBJXeLQ1RpxPByO2X1KJPtMJROD4hI0Tf5VTJjfQkHz8q7AL4hMG5XH0k6iOcECAzXCbshAYfpx9N2/v/ckQpl54MzF4ZewvdYr7rOuoT+xEc03bmVTyBk8MguD8eThVWkUMbWqoqeoSLo8CoH6rhK4bvBCP4NsWcOUj0GM2TEAllGrZ+FvSnsd8xNzPkskmlTIpX1kKUUAy1C7ZECxc1bDI0pm15hWWpWq8AiFKSJ2WDKeOTR2ZZMvNjPyM/dViW67dUPxiJohabIV+6JZvva2k4jK2ay77VCyPfd2Ll4j57IoDiM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3911.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1caecfb-de69-4ad0-00c5-08d81e4eb903
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 06:11:13.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/XY6M4AZfrDFgAnGV+Tib3OudFewE37Fxwv8wE9UBIW7QykAFmAq/F2eNrHz1YbJ2fUSZPbaqAimMZ2tMXoJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAzLzVdIGNsazogaW14OiBTdXBwb3J0IGJ1aWxk
aW5nIGkuTVggY29tbW9uIGNsb2NrDQo+IGRyaXZlciBhcyBtb2R1bGUNCj4gDQo+IE9uIFRodSwg
SnVsIDIsIDIwMjAgYXQgMTE6MjYgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+
DQo+IHdyb3RlOg0KPiBbLi4uXQ0KPiA+ID4gPiBAQCAtMTQzLDE2ICsxNDgsMTggQEAgdm9pZCBp
bXhfY3NjbXIxX2ZpeHVwKHUzMiAqdmFsKSAgc3RhdGljIGludA0KPiA+ID4gPiBpbXhfa2VlcF91
YXJ0X2Nsb2NrczsgIHN0YXRpYyBzdHJ1Y3QgY2xrICoqIGNvbnN0DQo+ID4gPiA+ICppbXhfdWFy
dF9jbG9ja3M7DQo+ID4gPiA+DQo+ID4gPiA+IC1zdGF0aWMgaW50IF9faW5pdCBpbXhfa2VlcF91
YXJ0X2Nsb2Nrc19wYXJhbShjaGFyICpzdHIpDQo+ID4gPiA+ICtzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIGlteF9rZWVwX3VhcnRfY2xvY2tzX3BhcmFtKGNoYXIgKnN0cikNCj4gPiA+ID4gIHsN
Cj4gPiA+ID4gICAgICAgICBpbXhfa2VlcF91YXJ0X2Nsb2NrcyA9IDE7DQo+ID4gPiA+DQo+ID4g
PiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+ICsjaWZuZGVmIE1PRFVM
RQ0KPiA+ID4gPiAgX19zZXR1cF9wYXJhbSgiZWFybHljb24iLCBpbXhfa2VlcF91YXJ0X2Vhcmx5
Y29uLA0KPiA+ID4gPiAgICAgICAgICAgICAgIGlteF9rZWVwX3VhcnRfY2xvY2tzX3BhcmFtLCAw
KTsNCj4gPiA+ID4gX19zZXR1cF9wYXJhbSgiZWFybHlwcmludGsiLCBpbXhfa2VlcF91YXJ0X2Vh
cmx5cHJpbnRrLA0KPiA+ID4gPiAgICAgICAgICAgICAgIGlteF9rZWVwX3VhcnRfY2xvY2tzX3Bh
cmFtLCAwKTsNCj4gPiA+DQo+ID4gPiBJIGZlZWwgbm90IG9ubHkgdGhlIF9fc2V0dXBfcGFyYW0s
IHRoZSB3aG9sZSBsb2dpYyBvZg0KPiA+ID4ga2VlcF91YXJ0X2Nsb2NrcyBhcmUgbm90IG5lZWRl
ZCBmb3IgTW9kdWxlIGNhc2UuIElzIGl0IHRydWU/DQo+ID4NCj4gPiBZZXMsIGJ1dCB0aGUgJ2tl
ZXBfdWFydF9jbG9ja3MnIGlzIGZhbHNlIGJ5IGRlZmF1bHQgYW5kIHRoZSBmdW5jdGlvbg0KPiA+
IGlteF9rZWVwX3VhcnRfY2xvY2tzX3BhcmFtKCkgYWxyZWFkeSBoYXMgJ19fbWF5YmVfdW51c2Vk
JywgaXQgZG9lcyBOT1QNCj4gPiBpbXBhY3QgYW55dGhpbmcgaWYgaXQgaXMgZm9yIG1vZHVsZSBi
dWlsZCwgc28gSSBkaWQgTk9UIGFkZCB0aGUgI2lmbmRlZiBjaGVjaw0KPiBmb3IgdGhlbSwganVz
dCB0byBrZWVwIGNvZGUgZWFzeSBhbmQgY2xlYW4uDQo+ID4NCj4gDQo+IElNSE8gZG8gbm90IGNv
bXBpbGUgdGhlbSBpcyBhIG1vcmUgZWFzeSBhbmQgY2xlYW4gd2F5LiBUaGVuIHVzZXJzIGRvbid0
DQo+IGhhdmUgdG8gbG9vayBpbnRvIHRoZSBjb2RlIGxvZ2ljIHdoaWNoIGlzIG1lYWluZ2xlc3Mg
Zm9yIE1vZHVsZSBjYXNlLg0KPiANCj4gQlRXLCBpdCByZWFsbHkgZG9lcyBub3QgbWFrZSBhbnkg
c2Vuc2UgdG8gb25seSBjb25kaW9uYWxseSBjb21waWxlDQo+IF9fc2V0dXBfcGFybSgpIGJ1dCBs
ZWZ0DQo+IHRoZSBwYXJhbSBmdW5jdGlvbnMgZGVmaW5pdGlvbiB0byBiZSBoYW5kbGVkIGJ5IF9f
bWF5YmVfdW5udXNlZC4NCj4gVGhleSdyZSB0b2dldGhlciBwYXJ0IG9mIGNvZGUsIGFyZW4ndCB0
aGV5Pw0KDQpJIGFtIGZpbmUgb2YgYWRkaW5nIHRoZSAnI2lmbmRlZiBNT0RVTEUnIHRvIGlteF9j
bGtfZGlzYWJsZV91YXJ0KCkgYW5kIGlteF9rZWVwX3VhcnRfY2xvY2tzX3BhcmFtKCkNCmFzIHdl
bGwgaW4gbmV4dCBwYXRjaCBzZXJpZXMuIE90aGVycyBsaWtlICcgaW14X2tlZXBfdWFydF9jbG9j
a3MgJyBhbmQgaW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKCkgbmVlZCB0bw0KYmUga2VwdCBhbHdh
eXMgYnVpbHQsIHNpbmNlIHRoZXkgYXJlIHVzZWQgYnkgZWFjaCBjbG9jayBkcml2ZXIgbm8gbWF0
dGVyIGJ1aWx0LWluIG9yIG1vZHVsZSBidWlsZC4NCg0KU28gdGhhdCBtZWFucyBJIGhhdmUgdG8g
YWRkIGFub3RoZXIgJ2lmbmRlZiBNT0RVTEUnIG9yIEkgbmVlZCB0byBhZGp1c3Qgc29tZSBjb2Rl
IHNlcXVlbmNlIHRvIG1ha2UNCnRob3NlIGNvZGUgY2FuIGJlIGJ1aWx0LW91dCBpbiBzYW1lIGJs
b2NrIGFuZCBqdXN0IHVzZSBzaW5nbGUgJ2lmbmRlZiBNT0RVTEUnLCBJIHRoaW5rIGFkanVzdCB0
aGUgY29kZQ0Kc2VxdWVuY2Ugc2hvdWxkIGJlIGJldHRlciwgd2lsbCBnbyB3aXRoIHRoaXMgd2F5
Lg0KDQpBbnNvbg0K

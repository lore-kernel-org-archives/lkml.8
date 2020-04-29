Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA55DC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CC62074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NMFjGHXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2KNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:13:07 -0400
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:1792
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD2KNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLeg9jBE5NXjRvPcqrSlkxYF1gsS4PLSbU3y3b6RsN2HkAwPb6wki5lqdAeF6kEja1M+9pamIuAUTjIBty3r/xY9xWhIxjZZHXW46hx1joNGNUt3+PRG0+Zi/YiDn/Zdb2ROD1OLK22b0qQNvAiWqG0OIyWEEOFi9BUbpf4DkgzDJ9YNFH/lVIVYIQ+0KfKKwEFP5PLjo73gsx5QFntdVx3AjDPIta+8EpvyMpNz/Rbpc4xPDYS5pHdBAGODIxvq3dt+2b0yuFa2El4VxFs9YYLaGIFVqAkH81prrN7XcuJ9Ig2Q1cptFeM8ww/PuQZAIlkGMphFlmKcdFLHb8O1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAUNEgp3TrIYJJEeYe6qlCP1rTH0JbXPF+dASCSsV/s=;
 b=m7aPmTP8R48yWnVPm0H488aXJ9H2Liz4pCXPIzhQRLSFRj8ZssHhbyKriT5duw8woSOXiydsDy61r29t7LP0SKXbKFvrWmh7bYZnAhkdsQIHXg5x32c5GYJX/104hd6jtHn490FIBjW0QWe0EtpmP7iFJ0Q71k6fljlPd4IVzKRyGHZiFFWMZoPKggBzLtdsfD6gByIUMPnUNwosRig0lLHLQ0FE/hjpK+l7gMlD7hYsz2dW0YUM1036e3jKbzauUizeHsZZOEC5X/8fGQUufQ6XzI6JOQebJVwr48h4i16dX3lLZvunX13OCbb6LZ9kn3H7nCeDCk5/r+Lh5GPzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAUNEgp3TrIYJJEeYe6qlCP1rTH0JbXPF+dASCSsV/s=;
 b=NMFjGHXT9Ik+6+LYbMRd9ys4BlBxzfrxnkmSrXbov0TT5d91kWNHkRZJyyCpxeXRcBO3ddoDfXI6B7wsuVOIXXwS+K8zqFoBNevnBpnrJq1qYcCE4jJivmcDmy4PsrI77EbeR9SrzgMYo69f7rBDBTl3lX3PvqelRwDKWyykZ8Q=
Received: from DB7PR04MB4972.eurprd04.prod.outlook.com (2603:10a6:10:1c::11)
 by DB7PR04MB5033.eurprd04.prod.outlook.com (2603:10a6:10:16::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 10:13:02 +0000
Received: from DB7PR04MB4972.eurprd04.prod.outlook.com
 ([fe80::8cb5:8821:ad1a:7f6e]) by DB7PR04MB4972.eurprd04.prod.outlook.com
 ([fe80::8cb5:8821:ad1a:7f6e%4]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 10:13:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Andy Duan <fugang.duan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible
 string
Thread-Topic: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible
 string
Thread-Index: AQHWHg47YrygX0mIJEOxLhRnMOvDo6iP4TZQ
Date:   Wed, 29 Apr 2020 10:13:02 +0000
Message-ID: <DB7PR04MB497216070F792503C6A8DC2580AD0@DB7PR04MB4972.eurprd04.prod.outlook.com>
References: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
In-Reply-To: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bfab5f3-994e-46c4-cc51-08d7ec25e6cf
x-ms-traffictypediagnostic: DB7PR04MB5033:|DB7PR04MB5033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5033043DBD421334E5FC8C1E80AD0@DB7PR04MB5033.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4972.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(110136005)(9686003)(4326008)(55016002)(54906003)(6506007)(66446008)(66556008)(76116006)(64756008)(71200400001)(66476007)(66946007)(4744005)(26005)(5660300002)(7696005)(316002)(186003)(86362001)(478600001)(8676002)(2906002)(8936002)(33656002)(44832011)(52536014)(142933001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+rmoV7W3kO9Q2z9smip50DX7voCGEVp+oZ2F3pZofjXo/TuJ2g/DKlrE9TBLNYh0H5wKZCb2B11iMOgbLypLyRjH/qzD9Z6593RfEK+JPu3WuHYCVAKrnJBIm2NpGns5ZEGogCAD4AThM1aF4nsnVV7JWZ8t5MOUAtyWcr4FP2x2+idks+io5KobiPlp4Q5AI7rdHbrBXoZLBu/gymoGiSyVjP5F6j9Pyy5kLV+yGdqWOiLr7dKD7xMX8AFIPhnjx2l1wDbq2GkViBvYRPD8/6Teaxoqb9vM8cwpyP95o9ZhqFjCyL7PPgyuIzlyMQTaq3mF45yJqPVWVn2aWOsyBVo+KVn5UkWSLdooLCbuCjeP0BUOwMABjmkcYdZQz+X8UgeuwGwPHEgVxFP8lXI7tNzXtOL8a+anfstLDpHO1IgyvB9Mhev+U5WlF8wA0SoXVYVy7OD+ExyiCfih2Pj2+jE3oL3cMm/QS7XBKjRUqxam2eNiXxqGHCwinPJ6gSIeBbK98nviscFKIYlvAJZVA==
x-ms-exchange-antispam-messagedata: NZEHwZKPe3JOCdxvdtHuhKsyvmNPI+4GV2QNHllcVZynE8z3u7RPINudl447oUvTDYkdkdMZATOshF6GrfE+JMDZJNclz0fLieQTOGJENRFqF9rS/iSm39pphVRZfnUMte2V+3U6bKQCxKXXb3atv2+JtGH8bp2ngHFbJN90bOj5p0Uk6JEsPryNqaacU9ARChLp6Uevzp3rmUKDOWuST5mIxnpCpj0V95b0SoitEYA4+1QpVbm4mJZniBOqOM5aDqQHKy1HupHqIoOKtj+BkQPAm0QfmCxwZqKLTTrUXDmwSI8WulKZw/rK6KIjafyixWFSesGNWIqmdJwl7dHJIWIZpkanNzUgDk95ePBQ1EfDvq1lBT/m5jIgTXlWEqgAsB961lEeqMSIDFbQ9tI8cZNqGY44fFdOXZ6lrHXfK4iWe3ZycazaeaSTpHqsZDduBBOR9tisDOl8vg6gG01u/AOcCkJbIBg1B4hS8Po9FpeC5GoQHQwuNPGt9D8IxXTOYkkB3x2i5FNClUvIDqX4+iRh4KU9RaaSGZwKsce3lxfY593QRes7h7XqB7uAP8BOD2f3hPWNbsOqBDVtiQWYm9yqEespmiZ8ue3kSfqp/Welln3ZqZTIyzZX6LsU3LtVMKlypUGISY3O8f39f0YAiNaWjT1WFVyqOHf7nM+WNWIgAU/1gstXRagqNR31GJlcfHhBj01jETEXmj1ZNPtqvoPTxwfXBH3wAwIvrs2AYEmFyR1fFRQpQmxxBVCx2kC8gUX34uaPIfQVuQjmFTuXtSWM6cRQMhdTEwm723xedEA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfab5f3-994e-46c4-cc51-08d7ec25e6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 10:13:02.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YECx4yaO9KjCbZce7zmt/GRTpi5fmZ72CcC49IjkteZNPS0VSAzTtaffl7NeINFf0MXgOhU47enUWJvdbWHMYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXByaWwgMjksIDIwMjAgNjowNCBQTQ0KPiANCj4gQWRkICJmc2wsaW14NnN4LWZlYyIgY29t
cGF0aWJsZSBzdHJpbmcgZm9yIGZlYyBub2RlLCB0aGVuIGkuTVg4TVAgRVZLIGV0aGVybmV0DQo+
IGZ1bmN0aW9uIGNhbiB3b3JrIG5vdy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZ1Z2FuZyBEdWFu
IDxmdWdhbmcuZHVhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IC0tLQ0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+IGluZGV4IDliMTYxNmU1OWQ1OC4uYjVk
Zjk1N2M1MDYzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXAuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAu
ZHRzaQ0KPiBAQCAtNjE1LDcgKzYxNSw3IEBADQo+ICAJCQl9Ow0KPiANCj4gIAkJCWZlYzogZXRo
ZXJuZXRAMzBiZTAwMDAgew0KPiAtCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1mZWMiLCAi
ZnNsLGlteDhtcS1mZWMiOw0KPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1mZWMiLCAi
ZnNsLGlteDhtcS1mZWMiLA0KPiAiZnNsLGlteDZzeC1mZWMiOw0KPiAgCQkJCXJlZyA9IDwweDMw
YmUwMDAwIDB4MTAwMDA+Ow0KPiAgCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMTggSVJRX1RZ
UEVfTEVWRUxfSElHSD4sDQo+ICAJCQkJCSAgICAgPEdJQ19TUEkgMTE5IElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KPiAtLQ0KPiAyLjE3LjENCg0K

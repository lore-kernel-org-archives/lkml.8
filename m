Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C720888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="HhR7BXoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgE1Bor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:44:47 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:36317
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgE1Boq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:44:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU7T+MI7x7XR3Px/C/OIK8/jkEAM0RlMI0eSUWeJDVGwaqkSu4gpaTs/QntiZpy7vI7Ecr3t85i3LKTj/X3iLWwh3aQfeHYHvgwI6r+j/mlHNvb8QXSw8LIxXr20v1FQ1RpyOMcFp9DEHNaJa4y3GPua6MAZAv6lUg3U1gFBuJM5qSYHUKSyv6r8kP2ZHN5upqFJKi99zmtWnvmU9IOdz+99ulCcF0J+aH6AVIt5n7AesECeX5r0x4+BO8qB4uH7uVwV/PQ8XjFcQHqagoN9nT4hjwfZDI1sl76EkqvAPv9AAG5ygt0MBzyzXY2zR6Mji6wndKox81cvLVDrRgbAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohI81OQyDdz1Zw8CqOCwLpqkpffNKp1TS1gRmIr0OLs=;
 b=LoULZ1sWp8JQ4JMK+U2q9X0JSvfHgvoLNFpyh8me7+PxofX4b2HbOj1M4ffC35zcOofWJmoGkUbKgG2wydGK+WA6uxIoPBkXMk+u0J30oLdUuNEJVRb++B5dQQPTWu1apkbf/dYj27ulWcFFUlk/senBjHEXGpRVoh6BThfHemRUC9YaIuJlrryb/eHz6axkMAX/413xxuaKNaIhnyktpyZ9TsNoIGT+TmgScXSPEWAuLN5CEmfPNpUpMcC9TXYos9pKTNS3OTr/mhWOIEsa+zFLYxgou9dZl0EYTCIjBntaUeydB6ggHdOktjp5vpr+2N8llIp3xrLFzZzJZ3QTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohI81OQyDdz1Zw8CqOCwLpqkpffNKp1TS1gRmIr0OLs=;
 b=HhR7BXoPOpGMgi5ZYC130w9rNaxo6y2BAAGDernNJE0Ht3h6GIQ5D55jaeFn4+tApBmuvn5Zd9HYZSd14fBpkmnXr3fJCfB0vC014p6fdGSQNpBLgeA+sAnzfmFvY5D5VUio1u1GJBuY7IlVgYokNHGzxOqeQe/t35UwylrcqOw=
Received: from DM6PR11MB3257.namprd11.prod.outlook.com (2603:10b6:5:5c::21) by
 DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 28 May 2020 01:44:44 +0000
Received: from DM6PR11MB3257.namprd11.prod.outlook.com
 ([fe80::cc67:a9f1:5cc2:72c0]) by DM6PR11MB3257.namprd11.prod.outlook.com
 ([fe80::cc67:a9f1:5cc2:72c0%6]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 01:44:44 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Markus Elfring <markus.elfring@web.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY1XSB3b3JrcXVldWU6IFJlbW92ZSB1bm5lY2Vzc2Fy?=
 =?gb2312?B?eSBrZnJlZSgpIGNhbGwgaW4gcmN1X2ZyZWVfd3EoKQ==?=
Thread-Topic: [PATCH v5] workqueue: Remove unnecessary kfree() call in
 rcu_free_wq()
Thread-Index: AQHWM/tQSttnTCPl40yJQVJDnEmgd6i7l3oAgAEgMAmAAANGQA==
Date:   Thu, 28 May 2020 01:44:43 +0000
Message-ID: <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>,<284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>,<DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aff99fe-83b3-4bbb-c5f1-08d802a8b23c
x-ms-traffictypediagnostic: DM6PR11MB4692:
x-microsoft-antispam-prvs: <DM6PR11MB469231AEEF8943B2976FEF4BFF8E0@DM6PR11MB4692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWBUU454yxlncTTHmSvMnaLHW1dWdL+GNmzBf9oKW3j6W5wMUFFtzR6euefQ3vcdCCQlBi4yhvKPLmNGYtP3vmG0Gk8l6+hwXU2SBW5tQln5v+PC0Bf1/YTPwWhrt3Cwei45+5od/RWhVjtEoavhbT6NtPyT0jxzcMNcg7FaeN5TirGpI1DdMziZ6+O9rvCR/BMNYw8MWtig2qZtexZhvj4KIuJiVsUzj2klNjgRxgLtpwEIqRYDvOaJbyPsZpm8igkky9/ywLIickwKlsWRGggWiyao24LJzlFAEGItG8TanIZCpsy8vzjcJEfZrsX00lMOEM0pVmB4XqCJNjkbhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(346002)(376002)(366004)(136003)(5660300002)(478600001)(54906003)(2940100002)(2906002)(110136005)(316002)(224303003)(7696005)(26005)(186003)(6506007)(4326008)(55016002)(9686003)(71200400001)(8936002)(52536014)(64756008)(66556008)(66476007)(66946007)(66446008)(86362001)(33656002)(91956017)(76116006)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JjTg1b8Dn1XeIQo2Q4fXfNN8Uw2cxdElIWZoVziHeBw1+L9BAsI1blMnsPTJSyIH22mIhyI5yDwVaJbVRSv5khml2+P3VFdL2mDMvuGaEyYAlIUUe7rgxVPvi/+KaAXQxy8PcQ85od11eCuISafuP9IoFg8QmY+nUHVtHTP9OKf56667/fVAeh2jdLTwe58aCOf7ybSgtWWCBGH8HMwxrmhN4TbjeF0DiY24VVSaqsbbxHvjBh+hUcCsrQ4twz/NsKSCtZzLH74SGTvgE8qtciHWB148neB1t/JbwyAt3BX6E4SNfpgxOgXuTG8Zh02F9CEGOHDlUYW3OwmrUpRuUJHVooQiXZTodnzyecEsPUcQiNT0NOmkqeowV7HxsqWezCaRRHtJyahkkUKguRo0rqZxa8HJ66rLosQ/ZQqdfgrkWx6ZQWcCTa0JyFyeH9JtM7Df1tWWecqfQ9/urZrC3PDAUTJMr1pu1xYgWEp1DKE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff99fe-83b3-4bbb-c5f1-08d802a8b23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 01:44:43.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoqdAFRhVhJPw/gAvotbWccQF35vt4gDm31GhqFdcUDcD4xLicjZVSfbHJdJ8c9cAOxVfVvny1wqgW+02K8eL0i1hoR/VCK129Xj5tc66L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGd1aWRlLg0KSSB3aWxsIHRyeSB0byBjaGFuZ2UgdGhlIHdlYWtuZXNz
IG9mIHdlYWsgd29yZGluZy4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0Kt6K8/sjLOiBaaGFuZywgUWlhbmcgPFFpYW5nLlpoYW5nQHdpbmRyaXZlci5jb20+DQq3
osvNyrG85DogMjAyMMTqNdTCMjjI1SA5OjQxDQrK1bz+yMs6IE1hcmt1cyBFbGZyaW5nOyBUZWp1
biBIZW87IExhaSBKaWFuZ3NoYW4NCrOty806IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6ILvYuLQ6IFtQQVRDSCB2NV0g
d29ya3F1ZXVlOiBSZW1vdmUgdW5uZWNlc3Nhcnkga2ZyZWUoKSBjYWxsIGluIHJjdV9mcmVlX3dx
KCkNCg0KVGhhbmtzIGZvciB5b3VyIGd1aWRlLiBJIHRyaWVkIHRvIGNoYW5nZSB0aGUgd2Vha25l
c3Mgb2Ygd2VhayB3b3JkaW5nDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CreivP7IyzogbGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVs
LW93bmVyQHZnZXIua2VybmVsLm9yZz4gtPqx7SBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJp
bmdAd2ViLmRlPg0Kt6LLzcqxvOQ6IDIwMjDE6jXUwjI3yNUgMTY6MjANCsrVvP7IyzogWmhhbmcs
IFFpYW5nIDxRaWFuZy5aaGFuZ0B3aW5kcml2ZXIuY29tPjsgVGVqdW4gSGVvIDx0akBrZXJuZWwu
b3JnPjsgTGFpIEppYW5nc2hhbiA8amlhbmdzaGFubGFpQGdtYWlsLmNvbT4NCrOty806IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBr
ZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnIDxrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJu
ZWwub3JnPg0K1vfM4jogUmU6IFtQQVRDSCB2NV0gd29ya3F1ZXVlOiBSZW1vdmUgdW5uZWNlc3Nh
cnkga2ZyZWUoKSBjYWxsIGluIHJjdV9mcmVlX3dxKCkNCg0KPiBUaHVzIGRlbGV0ZSB0aGlzIGZ1
bmN0aW9uIGNhbGwgd2hpY2ggYmVjYW1lIHVubmVjZXNzYXJ5IHdpdGggdGhlIHJlZmVyZW5jZWQN
Cj4gc29mdHdhcmUgdXBkYXRlLg0Koa0NCj4gU3VnZ2VzdGVkLWJ5OiBNYXJrdXMgRWxmcmluZyA8
TWFya3VzLkVsZnJpbmdAd2ViLmRlPg0KDQpXb3VsZCB0aGUgdGFnIKGwQ28tZGV2ZWxvcGVkLWJ5
obEgYmUgbW9yZSBhcHByb3ByaWF0ZSBhY2NvcmRpbmcgdG8gdGhlIHBhdGNoIHJldmlldw0KdG8g
YWNoaWV2ZSBhIG1vcmUgcGxlYXNpbmcgY29tbWl0IG1lc3NhZ2U/DQoNCg0KPiAgdjEtPnYyLT52
My0+djQtPnY1Og0KPiAgTW9kaWZ5IHdlYWtseSBzdWJtaXR0ZWQgaW5mb3JtYXRpb24uDQoNCk5v
dyBJIHdvbmRlciBhYm91dCB5b3VyIHdvcmRpbmcgY2hvaWNlIKGwd2Vha2x5obEuDQoNClJlZ2Fy
ZHMsDQpNYXJrdXMNCg==

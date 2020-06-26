Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2377C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95121206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cGrSoGLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgFZK6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:58:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3507 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgFZK6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:58:39 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5d4db0000>; Fri, 26 Jun 2020 18:58:35 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:58:35 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:58:35 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:58:35 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 26 Jun 2020 10:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/6mS8S/pyt3lus0D5a+xKrSb/ptUaYezyMCW1HLm29sp7/wa1E4eOL5dPuwfhbAsrP5zBmlsp1QNfP3qT8Gw4/QzdLFZCAob5ctjYREry29ZWQv4RwmL7HIL13nou7B5WBjjijouWZMuvFKtf/SqWP50B9z1G4MzWkeyB3dGPKJuWphEJOUN2bdqpANjV3WL4Js3mjadoQyp1AVDKVQq5YVBIijKiZ7ylYI7mKr0GnUDc0FCU6VQsq4vfPG4tfdVkluUBnDrnjmOZZUj5XxhXhm79AcsIC9rznvyuo+WKc/cpvWfqz3QInY5Jop2781oaT6lwmgCiafSiTAw9irEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFlurWMLtXb1gjgKLYxsdPm4gP+aTEYBHjjtIOt6hWo=;
 b=O3vZ8QDWu29on22fc+m5RHuWOEITWKmzTkbxLWSu7BJS7PiEzIij2T6WshUdhenLYteEmWAvt22TgQ38Iq36j5rhR086yHP1+5RiLT16jwYYUapUcCdMXSlmm0g/O1sH1v5bK31FnLaZeEPDH1gzhLY383QvmiSx98kjqHSIjIK+PiD+NyAwjLVQerA/yRuNWlkS/qW/ct2QWuXt+u30wLdiKS68DQSNoDmXXTVdtjX3jDqbrA64dXQCbx8v8myw33/YQFfvmsP3Ax+Zsgdi1RQ8nhDzPrxqp4qgrSxJGn775VAAKFy1biH7LXOWGZtxzvh63GtBY+kfxkiuHYHGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 10:58:31 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 10:58:31 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Bibek Basu <bbasu@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc/tegra: Add Tegra Soc Version support
Thread-Topic: [PATCH] soc/tegra: Add Tegra Soc Version support
Thread-Index: AQHWS6S7ubiO3CeqS0Gqi2LcocUE5ajqt9mAgAABuJA=
Date:   Fri, 26 Jun 2020 10:58:31 +0000
Message-ID: <BYAPR12MB3014E02C6146B87221E7923FAD930@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1593167369-25901-1-git-send-email-spatra@nvidia.com>
 <64d65736-62c2-de17-5657-389475fff6e2@kapsi.fi>
In-Reply-To: <64d65736-62c2-de17-5657-389475fff6e2@kapsi.fi>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-06-26T10:58:28.3750000Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=98a67af2-b1e6-4121-a0f9-731f57323591;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: kapsi.fi; dkim=none (message not signed)
 header.d=none;kapsi.fi; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [115.114.90.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f21be01-f9aa-4bb9-7f3f-08d819bfdd62
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4019C2B5F2A49D100B05B2F0AD930@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xXoxPWP7LofKN41HvIruUoo6FxyaUt+Mmv05SxGhSVMjNrfaJpPYcinDR0K2ZkxIDUI5YGLgA4Uw8d/Jj4V+OPmISfM3+lzv/DLQ0eAfnZT1B4zaIBFi4PAQSQFNPtotypguguyFLdS4GvnNu0+Fj8H5k0yKJpq3zL5wv7uexgW91CaX8lk22aC23KbdQLM/jAE11QfJyyo6fNxPMo7x5V2lyhC2kYM56vJsaIWziiVMGgVWe3E5/TGMvVp7UkUrMB/sXqiqsumYlJQnLkmkwnxxQ/ISMqASo0zg7480mquTnXzb0Xkkow/4wxLpomYpMXYH0fL3SvZ8wIsbEVI4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(55016002)(8936002)(71200400001)(186003)(5660300002)(6506007)(26005)(55236004)(9686003)(53546011)(52536014)(6636002)(2906002)(86362001)(76116006)(66946007)(316002)(7696005)(66556008)(66446008)(110136005)(54906003)(4326008)(66476007)(64756008)(33656002)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rjvYEhr8jnvH5asvnMwNrAetjxBxl9lOi0NXn3U7j+iUUjlon1JcjI/f/CGm50vjYlW32NAAoVZCUdHI7wjn8kmaMLxKmaOtLgsmVlb8UP7/NVmoqoMBdljLGNzSd3DcRAwTsK4dlrIcqhnDHWx1a/QOT8jEcgbjtO284TRydAwnYwwsRhlDAQpvgBOJiJppYqmJbDZjdk8v0iTjFJFr1khvQOXQiQJWAP/itHC70vgncWZ8rapY6LEiYj4JIBswmV7fmMccpIZPzW9TGx6zfxd1HzSM7yDmYax8Cu37jQhT8LaAeZBNTivx6OJZzy5911FJMHnO1lN8n7ezlbaPEE9zgiC+0oUnW0MxAMod31VckU14pwqkLl2zN+UZLBlSp7Ux19QmQ71r7typ2B3+QfVEwnUTfBCAl/tBSD1ajnSVBE8k62sBt0L7eDu9h46XWj0DOqkn+1OtCVzf8343Z59sl5rbyht1vfQak28BIfY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3014.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f21be01-f9aa-4bb9-7f3f-08d819bfdd62
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 10:58:31.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1DV2PEQ/UFhMhmUvyqGpSeCpSJ4NT8uA+mPTgcRq3lGsjH9MHbe2s4yPWy/IxWZfv8T01owv3RU/deeKLLNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593169115; bh=cFlurWMLtXb1gjgKLYxsdPm4gP+aTEYBHjjtIOt6hWo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=cGrSoGLNl4QpIJj/UzvpDGOx6mYZvmvJUoAnpAL+8abmCkKi0bME7cqCRRWdLO32L
         /uUm0wOHUK4C4UC+SRjl+vhMv7ObS7ejTZljEueNT2Zh2EXvUi/EX6EKvVJaVuocon
         XkPSbLrC6HmKq79XHG4xa/1+CYfeN6ItzbUUyzpnuOyTxA7MXG0QzXAXD/Iqawwncj
         7Y9FuDt0Lz2Do0PjIa/B/UqNzATuE237j8MEqHfoqwAWFS46Uoa9CbKOTuPFe8wgLl
         Ysrf5Nnj9ATa7NIvcz9zzKdKp65YEzVR4U0T/36qMrPwjBewTwXiFu/K1M7UIAX4Wk
         gJwUF915E5yXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlra28gUGVydHR1bmVu
IDxjeW5kaXNAa2Fwc2kuZmk+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNiwgMjAyMCA0OjIwIFBN
DQo+IFRvOiBTYW5kaXBhbiBQYXRyYSA8c3BhdHJhQG52aWRpYS5jb20+OyBUaGllcnJ5IFJlZGlu
Zw0KPiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZp
ZGlhLmNvbT4NCj4gQ2M6IEJpYmVrIEJhc3UgPGJiYXN1QG52aWRpYS5jb20+OyBLcmlzaG5hIFlh
cmxhZ2FkZGENCj4gPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+OyBsaW51eC10ZWdyYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHNvYy90ZWdyYTogQWRkIFRlZ3JhIFNvYyBWZXJzaW9uIHN1cHBvcnQNCj4gDQo+
IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRz
DQo+IA0KPiANCj4gT24gNi8yNi8yMCAxOjI5IFBNLCBTYW5kaXBhbiBQYXRyYSB3cm90ZToNCj4g
PiBBZGQgdGhlIGNoaXAgSURzIGZvciBOVklESUEgVGVncmExODYsIFRlZ3JhMTk0IGFuZCBUZWdy
YTIzNCBTb0MNCj4gPiBmYW1pbHkuDQo+IA0KPiBmYW1pbGllcw0KPiANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNhbmRpcGFuIFBhdHJhIDxzcGF0cmFAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGluY2x1ZGUvc29jL3RlZ3JhL2Z1c2UuaCB8IDUgKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3NvYy90ZWdyYS9mdXNlLmggYi9pbmNsdWRlL3NvYy90ZWdyYS9mdXNlLmggaW5k
ZXgNCj4gPiAyNTJlYTIwLi40YTUyMzZiIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvc29jL3Rl
Z3JhL2Z1c2UuaA0KPiA+ICsrKyBiL2luY2x1ZGUvc29jL3RlZ3JhL2Z1c2UuaA0KPiA+IEBAIC0x
LDYgKzEsNiBAQA0KPiA+ICAgLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25s
eSAqLw0KPiA+ICAgLyoNCj4gPiAtICogQ29weXJpZ2h0IChjKSAyMDEyLCBOVklESUEgQ09SUE9S
QVRJT04uICBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTIt
MjAyMCwgTlZJRElBIENPUlBPUkFUSU9OLiAgQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gPiAgICAq
Lw0KPiA+DQo+ID4gICAjaWZuZGVmIF9fU09DX1RFR1JBX0ZVU0VfSF9fDQo+ID4gQEAgLTEyLDYg
KzEyLDkgQEANCj4gPiAgICNkZWZpbmUgVEVHUkExMjQgICAgMHg0MA0KPiA+ICAgI2RlZmluZSBU
RUdSQTEzMiAgICAweDEzDQo+ID4gICAjZGVmaW5lIFRFR1JBMjEwICAgIDB4MjENCj4gPiArI2Rl
ZmluZSBURUdSQTE4NiAgICAgMHgxOA0KPiA+ICsjZGVmaW5lIFRFR1JBMTk0ICAgICAweDE5DQo+
ID4gKyNkZWZpbmUgVEVHUkEyMzQgICAgIDB4MjMNCj4gPg0KPiA+ICAgI2RlZmluZSBURUdSQV9G
VVNFX1NLVV9DQUxJQl8wICAgICAgMHhmMA0KPiA+ICAgI2RlZmluZSBURUdSQTMwX0ZVU0VfU0FU
QV9DQUxJQiAgICAgMHgxMjQNCj4gPg0KPiANCj4gQWxzbywgY2FuIHlvdSBtYWtlIHRoZSBjb21t
aXQgbWVzc2FnZSBzb21ldGhpbmcgbGlrZSAic29jL3RlZ3JhOiBBZGQgZGVmaW5lcw0KPiBmb3Ig
VGVncmExODYrIGNoaXAgSURzIj8NCg0KT2ssIHdpbGwgcGxhY2UgdGhpcyBleGFjdGx5Lg0KDQpU
aGFua3MgJiBSZWdhcmRzLA0KU2FuZGlwYW4NCg0KPiANCj4gdGhhbmtzLA0KPiBNaWtrbw0K

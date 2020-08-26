Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96863C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646952075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pLtCIIrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHZP0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:26:07 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:7558
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726947AbgHZP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMiM1szRBI7o+sTvbFR0IdXeKLCYemW+TwYBJ81kstukF/Rg2FuRdB8Vo3FtcmgrPKZN5lbhuTra0CF/OaZeHm7WhiZ0MxV9DUPEHiwUpZ91Em89EpWAn2IIN0toXzjlDbVzP9I3/MKGCtnjIPnCNyZH+TipvkTOkqRfGGub1rWtPwzUFyxFdIAao0XYXOA96dZTHzLVKUvUrXEaRuM57vdieyhpvkMJx5CorUuKJRvdUGKurp3tYbXyEF5Sj3lHmGMMPQarR9IBUXfSffAd7HejyRdSagsahxCr7UePnNrThHW14tSn2JHsk4C1KNNqOUOSXuNGFBNiDjKbhpH1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Vl1qu09+gdoU0PT5mzj18pxRChE5315g04VguuCBE=;
 b=CYwiqKSh7A0xyYuG18KYQ0qRd7j1yQW+2bbNHBEzg3iPcHXz/eYVMi4IqBFbNzzx2qgknrHPCiW4EhbSrFmo41i5arZb4bpaZJ3TC2sB12GdeA7fTvWeqQ2agTkHjG5xx7KikXfNugMHQKXGpJA6iPYuUhIlbAoD4Rjb34oBRVBRxOIn/w0jHso+tMeujnOPSRUFvtn4bgbOkYEYTUTkWbh85DEQS8z2YOhTLHUDE8gP8dgMMGMPCn38be0MdqNdGOp612Ux/X1DuRgy8iWnkEWHQUP3U5xPWq+MkxcAIFAck29OJsD7lsFZM+YJUDtOFpalIhCjMZGp0H8FxQBTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Vl1qu09+gdoU0PT5mzj18pxRChE5315g04VguuCBE=;
 b=pLtCIIrIuX5AqgJSFi7ANmhjYWi2wlKpRr1LhBkRsEn/sDl/MO2HEiqqF4TrLqhseG+ySNgXOz1d8pxcpNp5Zj7hgXPZUBQu7zfUG6ffXH+iXc8AaTX+3PNcvB71Y3yfTpRQrTBxoAahuKq6BRRFFdLOZXBaOJ7+acT4LRS0+Ss=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 15:25:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 15:25:58 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "jroedel@suse.de" <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Topic: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Thread-Index: AQHWegTrKFaLvteaIU+zNTDEWFvNM6lKcXK8gAATzoCAAABa0A==
Date:   Wed, 26 Aug 2020 15:25:58 +0000
Message-ID: <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
In-Reply-To: <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-26T15:25:54Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6ae8be09-ce8e-4efa-a4a1-00008c7e989e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-26T15:25:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e8f06bcb-5e94-45a5-ad11-000086ddffd9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-26T15:25:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1eebae05-bcb0-4c5e-a089-0000f220ab8b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f7af918-9711-43f5-b6b1-08d849d4551a
x-ms-traffictypediagnostic: MN2PR12MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40469978AB4A1C39E19F6E77F7540@MN2PR12MB4046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yLp+PSRr3pubdCTZRlHarhLC2K82D0dghTT1jzLtrw3Wd9ByIjYO6aZd4+K2kTLBiuMa9IR24ektyPE7b6skkrjqqVd5e8srdScolJcYLHOXjtSfd3T/BAmmAtWmS1rOQQHP5YQR6OioL5x7Y/MsYrFdJUaAOUY4hs8ziSEHUVX+ihbpl8tEiecJWCkSwU1PM6KUs9yaPH5K68WvCl1RfCFiuHqKk8gK5Bptu9YaoD2THuvF1S9FhMZ7jRx7qdlUI1GsFhx3WiPjgsm7lLsbEiux6q+7gfarTEWajsrhtKCyVmWfojhfFv3oDKXw/MlMnz1eh1xB3ZyCy9z5/5doQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(86362001)(8936002)(8676002)(7696005)(4326008)(71200400001)(6506007)(186003)(53546011)(26005)(110136005)(83380400001)(54906003)(52536014)(66946007)(64756008)(66476007)(76116006)(316002)(66446008)(66556008)(55016002)(9686003)(478600001)(33656002)(5660300002)(6636002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C2Kd5a0n4y1hfVwJSYcYBFg89Sj3vVeKPWyj/1xT4pYdeSFgeXc+xuGAkU2RfwyjvmdsKAxu5qWoqDJ1aTYlLqG0RfHAWqmOaKS/lGDiznCAmBZByV3WQ1dq2uSKZgSoVIm9Kvv+EHELLESEvcyl6YODV9qBfW+ZfQWqpEXeATUNvb7U443yY8+au5wWnofUN3Ti4Y+fDBhlyGWn3//rL4IXmvy5jGW4hy8umj1uMZXi1qJfa9w94erMUojUG2/+9A7plB29L6/BUi3cSZAnLWdwJ579OCbw82A2xprJiL+rMv49zZzx1XoamCajQIlOey6u0hV70ylG5QSUWIPWKfWjUvZzBRB13rquxijjCv4oDJ+JhbcaEw5g7/LilI2/vVVJiwdBopChW0EnwU5oiNVcybWnFSg1SbHulPt1cOBnTD/VYIrjeOLqrKcPgho0jYUOZnjtRt4Rc2OyWDqyX5uV4myAnYQnOXcayxNjiB0kNZYpYXpsI5jDOIvo5UddatvoY3ZMdI3KZPxCCFZ6TB40AF46iseE0wiqa7xoOuq+2MuuC6u+nBHwqI566WbEYFB/NiwJrf2JCTKKJLU8e5cvwnVKzGwJikeVLO8kx1Wn9GyENYhs+YKDq/0upz0vRNBrFwQq72C8PPJ5+jJ57w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7af918-9711-43f5-b6b1-08d849d4551a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 15:25:58.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsNKzfSQi9qLCBDGyXb3OIfdVQYcw4SQX0pNmp5URc8B1J810Szyy+NXkiDydLbA4+XIxxnaZ5g4eDd0jvdWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQogKyBDaHJpc3RpYW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI2LCAyMDIwIDExOjIyIEFNDQo+IFRvOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBKb2VyZyBSb2VkZWwN
Cj4gPGpvcm9AOGJ5dGVzLm9yZz47IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBI
dWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6IGpyb2VkZWxAc3VzZS5kZTsg
TGVuZGFja3ksIFRob21hcyA8VGhvbWFzLkxlbmRhY2t5QGFtZC5jb20+Ow0KPiBTdXRoaWt1bHBh
bml0LCBTdXJhdmVlIDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT47IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBpb21tdS9h
bWQ6IEZpeCBJT01NVXYyIGRldmljZXMgd2hlbiBTTUUgaXMNCj4gYWN0aXZlDQo+IA0KPiBbK1Jh
eV0NCj4gDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBoZWFkcyB1cC4gQ3VycmVudGx5IEtGRCB3b24n
dCB3b3JrIG9uIEFQVXMgd2hlbiBJT01NVXYyDQo+IGlzIGRpc2FibGVkLiBCdXQgUmF5IGlzIHdv
cmtpbmcgb24gZmFsbGJhY2tzIHRoYXQgd2lsbCBhbGxvdyBLRkQgdG8gd29yayBvbg0KPiBBUFVz
IGV2ZW4gd2l0aG91dCBJT01NVXYyLCBzaW1pbGFyIHRvIG91ciBkR1BVcy4gQWxvbmcgd2l0aCBj
aGFuZ2VzIGluDQo+IFJPQ20gdXNlciBtb2RlLCB0aG9zZSBmYWxsYmFja3MgYXJlIG5lY2Vzc2Fy
eSBmb3IgbWFraW5nIFJPQ20gb24gQVBVcw0KPiBnZW5lcmFsbHkgdXNlZnVsLg0KPiANCj4gDQo+
IEhvdyBjb21tb24gaXMgU01FIG9uIHR5cGljYWwgUENzIG9yIGxhcHRvcHMgdGhhdCB3b3VsZCB1
c2UgQU1EIEFQVXM/DQoNCkkgdGhpbmsgdGhlIGh3IHN1cHBvcnRzIGl0LCBidXQgaXQgYXMgZmFy
IGFzIEkga25vdyBpdCdzIG5vdCBmb3JtYWxseSBwcm9kdWN0aXplZCBvbiBjbGllbnQgcGFydHMu
DQoNCj4gDQo+IA0KPiBBbGV4LCBkbyB5b3Uga25vdyBpZiBhbnlvbmUgaGFzIHRlc3RlZCBhbWRn
cHUgb24gYW4gQVBVIHdpdGggU01FDQo+IGVuYWJsZWQ/IElzIHRoaXMgY29uc2lkZXJlZCBzb21l
dGhpbmcgd2Ugc3VwcG9ydD8NCg0KSXQncyBub3Qgc29tZXRoaW5nIHdlJ3ZlIHRlc3RlZC4gIEkn
bSBub3QgZXZlbiBzdXJlIHRoZSBHUFUgcG9ydGlvbiBvZiBBUFVzIHdpbGwgd29yayBwcm9wZXJs
eSB3aXRob3V0IGFuIGlkZW50aXR5IG1hcHBpbmcuICBTTUUgc2hvdWxkIHdvcmsgcHJvcGVybHkg
d2l0aCBkR1BVcyBob3dldmVyLCBzbyB0aGlzIGlzIGEgcHJvcGVyIGZpeCBmb3IgdGhlbS4gIFdl
IGRvbid0IHVzZSB0aGUgSU9NTVV2MiBwYXRoIG9uIGRHUFVzIGF0IGFsbC4NCg0KQWxleA0KDQo+
IA0KPiANCj4gVGhhbmtzLA0KPiDCoCBGZWxpeA0KPiANCj4gDQo+IEFtIDIwMjAtMDgtMjYgdW0g
MTA6MTQgYS5tLiBzY2hyaWViIERldWNoZXIsIEFsZXhhbmRlcjoNCj4gPg0KPiA+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+DQo+
ID4gKyBGZWxpeA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+ICpGcm9tOiogSm9lcmcg
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+ID4gKlNlbnQ6KiBNb25kYXksIEF1Z3VzdCAyNCwg
MjAyMCA2OjU0IEFNDQo+ID4gKlRvOiogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcN
Cj4gPiA8aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gKkNjOiogSm9lcmcg
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBqcm9lZGVsQHN1c2UuZGUNCj4gPiA8anJvZWRlbEBz
dXNlLmRlPjsgTGVuZGFja3ksIFRob21hcyA8VGhvbWFzLkxlbmRhY2t5QGFtZC5jb20+Ow0KPiA+
IFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgPFN1cmF2ZWUuU3V0aGlrdWxwYW5pdEBhbWQuY29tPjsg
RGV1Y2hlciwNCj4gPiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+DQo+ID4gKlN1YmplY3Q6KiBbUEFUQ0ggMC8yXSBpb21tdS9hbWQ6IEZpeCBJT01NVXYyIGRl
dmljZXMgd2hlbiBTTUUgaXMNCj4gPiBhY3RpdmUNCj4gPg0KPiA+IEZyb206IEpvZXJnIFJvZWRl
bCA8anJvZWRlbEBzdXNlLmRlPg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBTb21lIElPTU1VdjIg
Y2FwYWJsZSBkZXZpY2VzIGRvIG5vdCB3b3JrIGNvcnJlY3RseSB3aGVuIFNNRSBpcyBhY3RpdmUs
DQo+ID4gYmVjYXVzZSB0aGVpciBETUEgbWFzayBkb2VzIG5vdCBpbmNsdWRlIHRoZSBlbmNyeXB0
aW9uIGJpdCwgc28gdGhhdA0KPiA+IHRoZXkgY2FuIG5vdCBETUEgdG8gZW5jcnlwdGVkIG1lbW9y
eSBkaXJlY3RseS4NCj4gPg0KPiA+IFRoZSBJT01NVSBjYW4ganVtcCBpbiBoZXJlLCBidXQgdGhl
IEFNRCBJT01NVSBkcml2ZXIgcHV0cyBJT01NVXYyDQo+ID4gY2FwYWJsZSBkZXZpY2VzIGludG8g
YW4gaWRlbnRpdHkgbWFwcGVkIGRvbWFpbi4gRml4IHRoYXQgYnkgbm90DQo+ID4gZm9yY2luZyBh
biBpZGVudGl0eSBtYXBwZWQgZG9tYWluIG9uIGRldmljZXMgd2hlbiBTTUUgaXMgYWN0aXZlIGFu
ZA0KPiA+IGZvcmJpZCB1c2luZyB0aGVpciBJT01NVXYyIGZ1bmN0aW9uYWxpdHkuDQo+ID4NCj4g
PiBQbGVhc2UgcmV2aWV3Lg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gwqDCoMKgwqDCoMKg
wqAgSm9lcmcNCj4gPg0KPiA+IEpvZXJnIFJvZWRlbCAoMik6DQo+ID4gwqAgaW9tbXUvYW1kOiBE
byBub3QgZm9yY2UgZGlyZWN0IG1hcHBpbmcgd2hlbiBTTUUgaXMgYWN0aXZlDQo+ID4gwqAgaW9t
bXUvYW1kOiBEbyBub3QgdXNlIElPTU1VdjIgZnVuY3Rpb25hbGl0eSB3aGVuIFNNRSBpcyBhY3Rp
dmUNCj4gPg0KPiA+IMKgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuY8KgwqDCoCB8IDcgKysrKysr
LQ0KPiA+IMKgZHJpdmVycy9pb21tdS9hbWQvaW9tbXVfdjIuYyB8IDcgKysrKysrKw0KPiA+IMKg
MiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiAtLQ0KPiA+IDIuMjguMA0KPiA+DQo=

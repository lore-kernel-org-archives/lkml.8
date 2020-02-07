Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4AC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C4A20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2sFce6uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBGIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:40:38 -0500
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:6174
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgBGIkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:40:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nai1NKUeg+lGQ77alJx/QsvLnNVZKwDLqlltzhi+NCFh1dOVYNomelYAcV3WurpJO87KbkogJJHr0k0ciV58JvM13jK6lH1snOmguAdOnjwPoArHYOPhghDRccN0cNFbAixWjtJx4/V2p6a+gzw0JA8NhhJZ4Yd0kD3WpkP4ZqCRBHnt9aGh7I4ad0nqfN6OGsIgx6DPrX4E9o07lb9NRpXS/YG6d+NLJfboH7qAPtra7Q6icGE1hwviyrMx1Sz+4blbMDhUKFI7H0Q+ZRbp2/IywyVA9zxKx7ZkZ1Bf6lMNaXDlE5cz2HHMorypr/x1dFed87ngLu1AmHU4238irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeX/cWXYGdyYQL6EmQprmMPsfiIjuqEs8zKuZrK2nH8=;
 b=X9ptcVCvMm9jxd7r/HrClQ+qILTNA3vySscfdnX5ROhHFxANZJW7kuA294fbT5mV5eLrSFQQD8l3oZs9tgjD/ZMyUYFKrKAhDxPSWJ1Lkr1zO3x6nNxWA1xtsXNe8942VqvsWSlR2nE+42Z9aVtVviVSkE7V4ERZDaMEjeD4ygIYtCSF5pyzSJ6RHpHVjm+UbFBmBTT5xBZ9C17lyxwAquYExwpgdx4iPKtiKr1p24ILsOyKQ4+LRng+zFM3AQ987cn4DDqcXehgsWrU0tFi7Cblhw+01VcQM2qf6ncqzdE945QbzxM+ICwNtR8SWbyrnoo2ErmgH7u6ebG47whfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeX/cWXYGdyYQL6EmQprmMPsfiIjuqEs8zKuZrK2nH8=;
 b=2sFce6uwOszU18ROAoyGwUBDddBOQpHq4ZyEUUjFEjS6DyxEPc5tpOVOFNqUJg6AESpPZekkS3JQ9KaFqaFixYsp8ShdptumFfF8WJR6nGJKhQ3IlDLa06V1E3vjz2zHEBAQuxWB2VklmdbtB4QxFCrhw69eW13b+g970coVBjg=
Received: from MN2PR12MB3232.namprd12.prod.outlook.com (20.179.80.221) by
 MN2PR12MB4125.namprd12.prod.outlook.com (52.135.50.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 08:40:34 +0000
Received: from MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c]) by MN2PR12MB3232.namprd12.prod.outlook.com
 ([fe80::d8f:800:975a:b8c%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 08:40:34 +0000
From:   "Nath, Arindam" <Arindam.Nath@amd.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] ntb_perf: pass correct struct device to
 dma_alloc_coherent
Thread-Topic: [PATCH 3/4] ntb_perf: pass correct struct device to
 dma_alloc_coherent
Thread-Index: AQHV3EgxqGrkcNoh8EaPHAUSJUkGoKgM7+uAgAJ7LEA=
Date:   Fri, 7 Feb 2020 08:40:34 +0000
Message-ID: <MN2PR12MB323292771789FEBE5EEFCD439C1C0@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
 <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
 <761e76e0-2e5e-6c71-3384-1ec10dcf8e88@deltatee.com>
In-Reply-To: <761e76e0-2e5e-6c71-3384-1ec10dcf8e88@deltatee.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-07T08:40:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8c756baa-bfa7-4db6-bc0c-0000d7812d4a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-07T08:40:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e91af601-e38c-44fb-8ae2-0000148709d9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Arindam.Nath@amd.com; 
x-originating-ip: [122.182.243.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd302c4c-6740-4129-41ef-08d7aba965ee
x-ms-traffictypediagnostic: MN2PR12MB4125:|MN2PR12MB4125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41251174A36F50F0C8F8FC549C1C0@MN2PR12MB4125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(86362001)(2906002)(6636002)(66946007)(64756008)(66446008)(5660300002)(55016002)(66556008)(4326008)(9686003)(45080400002)(54906003)(66476007)(966005)(7696005)(478600001)(52536014)(76116006)(81166006)(81156014)(110136005)(33656002)(71200400001)(316002)(6506007)(53546011)(8676002)(8936002)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4125;H:MN2PR12MB3232.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKLd5P1WXtgHBcVJsmgis6u1xGEHPnB0mpyzr7tRBDuUpf54vwtz6EIeqLdl+Lh3JqCSJr5sec+Vv2mSmOnfZfjdqCiEhCLUJ+oC61665l5e4j0Rma5SV9bzZmTeseJWOH3+tjnFy0MfXHzWNijj7/y5KrI34tEZR8luWwSio3hQ+j4F06cENvXHCKiizphlCm2i5ot6XK+2MvldF0wZBtfY9jeZUSzJxx9FxQooagL0mnluPk8HZbKrIgch0ssO5d26R0/Zj3B2HCaavrWZdGNDODWg6EO50SiRDHl1gYo49lwj/JzrSkaNwqJ5v3Qg/X+jfuYDZPrMUGKlQhw+1ve5pXeM/CZcDs19A2Fmjjt4kCzfsPmwZU/OxzB1o341keC3wxzPaCe4s9XdYE5C6vNI6tjvUcJMFjSoBs90vOEY6+3WTYy2G0FBCDeK7tL1qeRRMF+lmO0sW1mT9ywZkP12OtQhDngV4mqL2ibEh5/vX4elil8m3HqpmelNUbK1/nnxa7NJrDapKuN9YXgonzj2z6dcpeMAwvLdfA4UYIaLOM/g2K7M5a7ou55tAWKamIj9wCaAhrQNerec4mnRrBD/5XEci2EfDIx3dedf/Bp2qpfHAh2Pzm5Kwm/QtY9T
x-ms-exchange-antispam-messagedata: 8ezXFcgspD+rNXPQwc4OIOvu9C6dPUFZaZgcaG1NuiyRTbhpWor6iQQDlxs3o62FWQzeeENWyfETiCGYDkPPiSsrMIvb3Nattdbl+rW9BNqBLzG5LwMJFJf+7U5rZVW6NlObSH/1MIEnLPlAL0H21g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd302c4c-6740-4129-41ef-08d7aba965ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 08:40:34.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kc7xMh1TWOSJaaeq2UYIVrvENvmqlWqUHLPR8zi7h1ck88sBjb5wlm3Eubo3Obse
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvZ2FuIEd1bnRob3JwZSA8bG9n
YW5nQGRlbHRhdGVlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjAgMDA6
MTQNCj4gVG86IE5hdGgsIEFyaW5kYW0gPEFyaW5kYW0uTmF0aEBhbWQuY29tPjsgSm9uIE1hc29u
DQo+IDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+
OyBBbGxlbiBIdWJiZQ0KPiA8YWxsZW5iaEBnbWFpbC5jb20+OyBNZWh0YSwgU2FuanUgPFNhbmp1
Lk1laHRhQGFtZC5jb20+DQo+IENjOiBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbTsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gbnRiX3Bl
cmY6IHBhc3MgY29ycmVjdCBzdHJ1Y3QgZGV2aWNlIHRvDQo+IGRtYV9hbGxvY19jb2hlcmVudA0K
PiANCj4gDQo+IA0KPiBPbiAyMDIwLTAyLTA1IDEwOjE2IGEubS4sIEFyaW5kYW0gTmF0aCB3cm90
ZToNCj4gPiBGcm9tOiBTYW5qYXkgUiBNZWh0YSA8c2FuanUubWVodGFAYW1kLmNvbT4NCj4gPg0K
PiA+IEN1cnJlbnRseSwgbnRiLT5kZXYgaXMgcGFzc2VkIHRvIGRtYV9hbGxvY19jb2hlcmVudA0K
PiA+IGFuZCBkbWFfZnJlZV9jb2hlcmVudCBjYWxscy4gVGhlIHJldHVybmVkIGRtYV9hZGRyX3QN
Cj4gPiBpcyB0aGUgQ1BVIHBoeXNpY2FsIGFkZHJlc3MuIFRoaXMgd29ya3MgZmluZSBhcyBsb25n
DQo+ID4gYXMgSU9NTVUgaXMgZGlzYWJsZWQuIEJ1dCB3aGVuIElPTU1VIGlzIGVuYWJsZWQsIHdl
DQo+ID4gbmVlZCB0byBtYWtlIHN1cmUgdGhhdCBJT1ZBIGlzIHJldHVybmVkIGZvciBkbWFfYWRk
cl90Lg0KPiA+IFNvIHRoZSBjb3JyZWN0IHdheSB0byBhY2hpZXZlIHRoaXMgaXMgYnkgY2hhbmdp
bmcgdGhlDQo+ID4gZmlyc3QgcGFyYW1ldGVyIG9mIGRtYV9hbGxvY19jb2hlcmVudCgpIGFzIG50
Yi0+cGRldi0+ZGV2DQo+ID4gaW5zdGVhZC4NCj4gPg0KPiA+IEZpeGVzOiA1NjQ4ZTU2ICgiTlRC
OiBudGJfcGVyZjogQWRkIGZ1bGwgbXVsdGktcG9ydCBOVEIgQVBJIHN1cHBvcnQiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNhbmpheSBSIE1laHRhIDxzYW5qdS5tZWh0YUBhbWQuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFyaW5kYW0gTmF0aCA8YXJpbmRhbS5uYXRoQGFtZC5jb20+DQo+IA0KPiBV
Z2gsIHRoaXMgaGFzIGJlZW4gZml4ZWQgcmVwZWF0ZWRseSBhbmQgaW5kZXBlbmRlbnRseSBieSBh
IG51bWJlciBvZg0KPiBwZW9wbGUuIEkgc2VudCBhIGZpeFsxXSBpbiBtb3JlIHRoYW4gYSB5ZWFy
IGFnbyBhbmQgU2FuamF5IHJlcGVhdGVkIHRoZQ0KPiBlZmZvcnQgYSBjb3VwbGUgbW9udGhzIGFn
b1syXS4NCj4gDQo+IEkgaGF2ZSB0aGUgc2FtZSBmZWVkIGJhY2sgZm9yIHlvdSB0aGF0IEkgaGFk
IGZvciBoaW06IG9uY2Ugd2UgZml4IHRoZQ0KPiBidWcgd2Ugc2hvdWxkIGFsc28gZ28gaW4gYW5k
IHJlbW92ZSB0aGUgbm93IHVubmVjZXNzYXJ5DQo+IGRtYV9jb2VyY2VfbWFza19hbmRfY29oZXJl
bnQoKSBjYWxscyBpbiB0aGUgZHJpdmVycyBhdCB0aGUgc2FtZSB0aW1lDQo+IHNlZWluZyBpdCBu
byBsb25nZXIgbWFrZXMgYW55IHNlbnNlLiBNeSBwYXRjaCBkaWQgdGhpcyBhbHJlYWR5Lg0KDQpU
aGFua3MgTG9nYW4uIEkgd2lsbCBpbmNsdWRlIHlvdXIgcGF0Y2hlcyBpbiBteSBuZXh0IHZlcnNp
b24gb2YgdGhlIHNldCwNCmFuZCBtZW50aW9uIHlvdSBpbiB0aGUgIkZyb20iIHRhZy4NCg0KQXJp
bmRhbQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBMb2dhbg0KPiANCj4gWzFdDQo+IGh0dHBzOi8v
bmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmxvcmUuDQo+IGtlcm5lbC5vcmclMkZsa21sJTJGMjAxOTAxMDkxOTIyMzMuNTc1Mi0zLQ0KPiBs
b2dhbmclNDBkZWx0YXRlZS5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FyaW5kYW0ubmF0aCU0
MGFtZC4NCj4gY29tJTdDYWJjNzI5OGM4NmM1NGI4MmRiMWEwOGQ3YWE2YjY2YWElN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4Mg0KPiBkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE2NTI1MTAwNDE5Mzk2
OSZhbXA7c2RhdGE9NTJET1RIcEtqc2VaanYNCj4gRTZqbVdXVlZMUUxlUmlheWtiVlRRaXBHUWJM
VDAlM0QmYW1wO3Jlc2VydmVkPTANCj4gWzJdDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUuDQo+IGtlcm5lbC5v
cmclMkZsa21sJTJGMTU3NTk4MzI1NS03MDM3Ny0xLWdpdC1zZW5kLWVtYWlsLQ0KPiBTYW5qdS5N
ZWh0YSU0MGFtZC5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FyaW5kYW0ubmF0aCU0MGFtDQo+
IGQuY29tJTdDYWJjNzI5OGM4NmM1NGI4MmRiMWEwOGQ3YWE2YjY2YWElN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWENCj4gODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE2NTI1MTAwNDE5Mzk2OSZhbXA7
c2RhdGE9UkZSJTJCTEZwNWENCj4gT04xTUE0RXJ4NHNvcUw5cExIYyUyQkxXVk51TFkwJTJCMHpj
Ym8lM0QmYW1wO3Jlc2VydmVkPTANCg==

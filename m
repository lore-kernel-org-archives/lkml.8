Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E42C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400B62087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IoswEnUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgHUAmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:42:07 -0400
Received: from mail-eopbgr760071.outbound.protection.outlook.com ([40.107.76.71]:63205
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgHUAmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAVXYt7Nb4ysq3S3hjOdMoPQrfvIbWlzKly5iECDnkKDeEvImQY47kPujpBbv7QAmyYvz3/QlrHr4WJpknYw/ZBg3mNiKJMS6Ll4Qt9LcWSr1zPhP0+MrjyPyMGqgS+GACXq6T5ku4uPWjqj8qBZYvtqcnNzQQOF9X37TmkE3JlIRUfASzhFPKw2g49QQJ/55GOMlqY8QBhgGjHMeBTSg/4xO/bpPXNF13IHJUM/EZwVn3BVkXB6Yl+jH0oT/TUqeaqBvb9M81NvbRneBHUzpWXwhaTneBKCr0k5THjDPfKy3Wo8eL54euv7sqL6abG+Yf4bJFntW6X2CTHqgJFfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXnBqlMTikO1Mmzej4O3q0TMlNm43vNfrW7jdDJjwTM=;
 b=m7kQ15zsElSyBXReseWbRNih4YJIbaHMkMzVyh/A2IiMxGxdnDYGhCObDHbj2nRUHoepni91qdrrQZaIPnxjpqTyLCWt2Fb72b8etiO4cEaD4110aLK9HOU4IdM8AJbrZVoXBM1E6F5+cKFpS8i8SjieiArqC6OtzFc+VzfsOVIM79Fthcr3WjvcqXy/pTjpEPNklekkIe6iU8c+MyRe79kWxyjft5dWzsznOuADAAr6DBqkxuiknxqRKNv7lrMCV4wXXfGm8RI9tblXVpTTNSa/082c43CeO6WJwLYWEBjxpK5sFCVvHWmSYLWRFzJ9qz8jB3BYz/Dzt/uBQ2RPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXnBqlMTikO1Mmzej4O3q0TMlNm43vNfrW7jdDJjwTM=;
 b=IoswEnUECz4rGEPxuIESg4Zvfc330ttz2mcV4g93rT79+jUhgJLpVtc3NZAhz6IFjDWDgwTbFBekYAaZfH836wZ2ZsN1cK+mhkMWFIV7qgjXn/yWDutfBUXzPYV09i/5JanshobovTq/7ZlDd4ht7PbSxb5sUwS2HFZy4/8edlk=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 21 Aug 2020 00:42:01 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 00:42:01 +0000
From:   "Li, Dennis" <Dennis.Li@amd.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Guchun" <Guchun.Chen@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: RE: [PATCH] drm/amd/display: remove unintended executable mode
Thread-Topic: [PATCH] drm/amd/display: remove unintended executable mode
Thread-Index: AQHWdgFN5RxpUMiy2ki/zUpsHmcnuqlBub3A
Date:   Fri, 21 Aug 2020 00:42:01 +0000
Message-ID: <DM5PR12MB25339FED33ECA4DABF7830B3ED5B0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-21T00:41:55Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=010041bf-f40c-43f4-bec0-fc466a7b714a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0598ecd-29c2-4ba8-9883-08d8456b04aa
x-ms-traffictypediagnostic: DM6PR12MB4298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB429826441CC8CD515799B930ED5B0@DM6PR12MB4298.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TEavBBa6SebdvOI7D2znb+0VohAEVlhwGdVDFykq/6QOoOEbZ1Yj4nLehudfbdBa3cNagVhZ4433q/FIJ+ElfXtWF8Qr7x6rz0SHkbe6t7dG5NOx8TfrT3CUGVqd5v3kU+4764NoPIdFFlI41NND75OPFncXsD/NfOe8Mnc/1PMzcV6nxWAxp+vh92sVQ+/COBaWD6MiRfXWbQ4eqnyeVLErVIC7Nn/ihUhSvaOkcxHV7Z3ra7ibaQuqr3hIWbNX/pFscHomhiknj/df3UnrQhBX7Cho/wI3+AZp6jOL7T28eftrctV9xYqouqGSXi3F7YNKJoqQDLZm+PK7wFnig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(2906002)(33656002)(478600001)(8676002)(86362001)(4326008)(9686003)(6636002)(110136005)(55016002)(66476007)(8936002)(76116006)(66946007)(7696005)(71200400001)(54906003)(316002)(66446008)(66556008)(64756008)(83380400001)(52536014)(5660300002)(26005)(186003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FIC7F8tUQblTXKwPVrT0MIrOFkY9z8oeNxZwwCZH0Tmhod7iYN/93RY5yDF3F0nu1Yd8Wl2sHCfT8aixJJdg9ea70FNXhrwJNqkPVg9JfIBRDfwNlD/Iu9MJ9tBPXAJE25ke8Pg1srbhxlfWHHYD6SEZPabvrFLCb6Nz8//hg7YDGQhkbYlb1934yH606D6spoRBB6RkY6xMxV47akVf2bbUsSKBvaatwx5dMGALpWrEnhY40BXP/QesgWa9LHMLSoa6C0DBgk9zv4hjcLmc0PKwUcqi3OV8Pzyquv65Sy7jp3CV/MwPPT6nzJUK2ItRKmy9ab1m5O28/b8ZXCm/JHXAr0eamIDz4cuhUXj63QicZRM56XdAHQIUlpBovOODDGPtLrw3Dejsy9vovJQTEFGtxYQG8+Ojpb9e00JUstBWK3gj0PoFRydNboOrThz0GAE1uc0y+2VxxMQcBQrGfq/l6lHblGfuJ/FrVF1VLUB8RhJR+2lBAx1UbdoMwGbtgx6CcmzKfZF5qIe8B4UjBbwJxoQSIXTwCJUevoS2bIT4OoRP+HdrkbIx8mdtneuofcWmrdpiIlpC3UnKYdq1cEjO7ZBGVvFP1jaHsuprpo4w0dh6x6Pu6t6yB+5pcv7cwbwaarxN8/JJrb7j82/lyA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0598ecd-29c2-4ba8-9883-08d8456b04aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 00:42:01.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLp5NiriZszzbTYW9MEW1ynq+5CYNuIf65tCGu7YDXaLeLMMhLIMnS79tCTA0PPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgTHVrYXMsDQogICAgICBUaGFua3MgZm9yIHlvdXIgZml4LiBUaGlzIGlzc3VlIHdhcyBjYXVz
ZWQgYnkgdGhhdCBJIG1vZGlmaWVkIHRoZXNlIGZpbGVzIGluIHdpbmRvd3Mgc3lzdGVtIHdpdGgg
U2FtYmEuIEkgd2lsbCB0YWtlIGNhcmUgaW4gdGhlIGZ1dHVyZS4gDQoNCkJlc3QgUmVnYXJkcw0K
RGVubmlzIExpDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVrYXMgQnVsd2Fo
biA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTks
IDIwMjAgNDoxOCBQTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBM
aSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQu
Y29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGVuLCBHdWNo
dW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBXdSwgSGVyc2VuIDxoZXJzZW54cy53dUBhbWQuY29t
PjsgTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvZGlzcGxheTogcmVtb3ZlIHVuaW50ZW5kZWQgZXhlY3V0YWJsZSBtb2RlDQoN
CkJlc2lkZXMgdGhlIGludGVuZGVkIGNoYW5nZSwgY29tbWl0IDRjYzExNzhlMTY2YSAoImRybS9h
bWRncHU6IHJlcGxhY2UgRFJNIHByZWZpeCB3aXRoIFBDSSBkZXZpY2UgaW5mbyBmb3IgZ2Z4L21t
aHViIikgYWxzbyBzZXQgdGhlIHNvdXJjZSBmaWxlcyBtbWh1Yl92MV8wLmMgYW5kIGdmeF92OV80
LmMgdG8gYmUgZXhlY3V0YWJsZSwgaS5lLiwgY2hhbmdlZCBmcm9tb2xkIG1vZGUNCjY0NCB0byBu
ZXcgbW9kZSA3NTUuDQoNCkNvbW1pdCAyNDFiMmVjOTMxN2UgKCJkcm0vYW1kL2Rpc3BsYXk6IEFk
ZCBkY24zMCBIZWFkZXJzICh2MikiKSBhZGRlZCB0aGUgZm91ciBoZWFkZXIgZmlsZXMge2RwY3Ms
ZGNufV8zXzBfMF97b2Zmc2V0LHNoX21hc2t9LmggYXMgZXhlY3V0YWJsZSwgaS5lLiwgbW9kZSA3
NTUuDQoNClNldCB0byB0aGUgdXN1YWwgbW9kZXMgZm9yIHNvdXJjZSBhbmQgaGVhZGVycyBmaWxl
cyBhbmQgY2xlYW4gdXAgdGhvc2UgbWlzdGFrZXMuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KDQpT
aWduZWQtb2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCi0t
LQ0KYXBwbGllcyBjbGVhbmx5IG9uIGN1cnJlbnQgbWFzdGVyIGFuZCBuZXh0LTIwMjAwODE5DQoN
CkFsZXgsIENocmlzdGlhbiwgcGxlYXNlIHBpY2sgdGhpcyBtaW5vciBub24tdXJnZW50IGNsZWFu
dXAgcGF0Y2guDQoNCkRlbm5pcywgSmVycnksIHBsZWFzZSBhY2suDQoNCkRlbm5pcywgSmVycnks
IHlvdSBtaWdodCB3YW50IHRvIGNoZWNrIHlvdXIgZGV2ZWxvcG1lbnQgZW52aXJvbm1lbnQgaW50
cm9kdWNpbmcgdGhvc2UgZXhlY3V0YWJsZSBtb2RlcyBvbiBmaWxlcy4NCg0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAwDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5jICAgICAgICAgICAgICAgICAg
ICAgICB8IDANCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvZGNuL2Rjbl8z
XzBfMF9vZmZzZXQuaCAgIHwgMA0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3Jl
Zy9kY24vZGNuXzNfMF8wX3NoX21hc2suaCAgfCAwICBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvYXNpY19yZWcvZGNuL2RwY3NfM18wXzBfb2Zmc2V0LmggIHwgMCAgZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2FzaWNfcmVnL2Rjbi9kcGNzXzNfMF8wX3NoX21hc2suaCB8IDANCiA2IGZp
bGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkgIG1vZGUgY2hhbmdl
IDEwMDc1NSA9PiAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzQuYw0K
IG1vZGUgY2hhbmdlIDEwMDc1NSA9PiAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjFfMC5jDQogbW9kZSBjaGFuZ2UgMTAwNzU1ID0+IDEwMDY0NCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvZGNuL2Rjbl8zXzBfMF9vZmZzZXQuaA0KIG1vZGUgY2hh
bmdlIDEwMDc1NSA9PiAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVn
L2Rjbi9kY25fM18wXzBfc2hfbWFzay5oDQogbW9kZSBjaGFuZ2UgMTAwNzU1ID0+IDEwMDY0NCBk
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvZGNuL2RwY3NfM18wXzBfb2Zmc2V0
LmgNCiBtb2RlIGNoYW5nZSAxMDA3NTUgPT4gMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9hc2ljX3JlZy9kY24vZHBjc18zXzBfMF9zaF9tYXNrLmgNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfNC5jDQpvbGQgbW9kZSAxMDA3NTUNCm5ldyBtb2RlIDEwMDY0NA0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzAuYw0Kb2xkIG1vZGUgMTAwNzU1DQpuZXcg
bW9kZSAxMDA2NDQNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNp
Y19yZWcvZGNuL2Rjbl8zXzBfMF9vZmZzZXQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9hc2ljX3JlZy9kY24vZGNuXzNfMF8wX29mZnNldC5oDQpvbGQgbW9kZSAxMDA3NTUNCm5ldyBt
b2RlIDEwMDY0NA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2lj
X3JlZy9kY24vZGNuXzNfMF8wX3NoX21hc2suaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9hc2ljX3JlZy9kY24vZGNuXzNfMF8wX3NoX21hc2suaA0Kb2xkIG1vZGUgMTAwNzU1DQpuZXcg
bW9kZSAxMDA2NDQNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNp
Y19yZWcvZGNuL2RwY3NfM18wXzBfb2Zmc2V0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvYXNpY19yZWcvZGNuL2RwY3NfM18wXzBfb2Zmc2V0LmgNCm9sZCBtb2RlIDEwMDc1NQ0KbmV3
IG1vZGUgMTAwNjQ0DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Fz
aWNfcmVnL2Rjbi9kcGNzXzNfMF8wX3NoX21hc2suaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9hc2ljX3JlZy9kY24vZHBjc18zXzBfMF9zaF9tYXNrLmgNCm9sZCBtb2RlIDEwMDc1NQ0K
bmV3IG1vZGUgMTAwNjQ0DQotLQ0KMi4xNy4xDQo=

Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B1CC55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80D9214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LCa13vlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDWPTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:19:01 -0400
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com ([40.107.244.47]:17889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729008AbgDWPTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyvsPckLXVt+mqfaWvkXAv0JkFGIr96PTCekDOiARLmyWRYgh7bBFnflUeJ0BevgpWLnX2r61ZuqaQuoQRr9tHRumqpouC1zU98wCIx1ga3sFq/Rn7CVUigBh7kA3PLg2l2tBCsEF1TDGbdSM5AOo+25DE8f06lG5OqawZ7R7eEg1oSXTvngfcc6LmxsH0Ysicpp0I5mr8ELPNZl+GNdjkACP6D7yNbGkdcD1n8/oOdNKcjx0WoeA4uX4ApLoCELC0BAmtRetn6QPK2Ul1x3N7wa8zos4yHgHXy89t76sZ8csPsbkkfwW3gUbsFbdVy9h76piAXImNZHgOair3a6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcmhwNCxjK7dEr+92JeavpdrpIruY5oEORvnE5a4pUM=;
 b=DZMFUkktuSs1QLm9lWOUDSR2EwZ4vaA+n3LDWZOCllAWbdExgeRUshzWxdcO0zGTN2rUSMIrCEzDV1yoou0LJGXDt+rAvvrWaRL6Spc/35Dt4JSm0iwfpnW5u32OEfRZSrUUlQ27qNaU3393MBYkACpKSevJ3z7pqZAJ4XCWKQjHN/1/1L4OeuKJVGMAKXp23TBXgkuscXB1iwUTZmU/KhHO44uhbPsV7Wv6tOO99ESVI6oBDEcYVxPZd8hF6j8+QaFzpqvcd5Wjidf+8uxtALcxerqZDcDCPrbDq+lzzv4g/EPcSpRfdZa37UDOYW4uLzNArGJF18Mvk6PzVQKKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcmhwNCxjK7dEr+92JeavpdrpIruY5oEORvnE5a4pUM=;
 b=LCa13vlAmyRUEFv+CBF1VF+2ENVEuW/GrWygLULDF3RdIzWf0UCW/Ax+ZP5oQJ1SzpGG7StrTtY1U/ZvG+/xB3H0LE2/jMUhda6zDGiNCbdvG0xhg+5I/M4eztlbq+vvGTldh8H32+Ey2b4nvQA5vf43gdQBt9RsJUlkCbQikT0=
Received: from DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15)
 by DM6PR12MB3291.namprd12.prod.outlook.com (2603:10b6:5:186::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 15:18:56 +0000
Received: from DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::14f2:ab:f326:5c2d]) by DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::14f2:ab:f326:5c2d%4]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 15:18:56 +0000
From:   "Koo, Anthony" <Anthony.Koo@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drm/amd/display: fix incorrect assignment due to a
 typo
Thread-Topic: [PATCH][next] drm/amd/display: fix incorrect assignment due to a
 typo
Thread-Index: AQHWGXfcCvNW3AoRMUmTjU6+P3IpdqiGzUOQ
Date:   Thu, 23 Apr 2020 15:18:56 +0000
Message-ID: <DM6PR12MB4545A35BA8D16B0218FF142FF3D30@DM6PR12MB4545.namprd12.prod.outlook.com>
References: <20200423140240.19360-1-colin.king@canonical.com>
In-Reply-To: <20200423140240.19360-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9343ede9-6b1f-486a-8545-0000cf844351;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-23T15:01:43Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anthony.Koo@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18eaeeff-6935-4fb9-57dd-08d7e799a44e
x-ms-traffictypediagnostic: DM6PR12MB3291:|DM6PR12MB3291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32919D7558E213871298BB43F3D30@DM6PR12MB3291.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4545.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(81156014)(8936002)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(9686003)(110136005)(76116006)(7696005)(86362001)(8676002)(33656002)(55016002)(4326008)(52536014)(26005)(478600001)(71200400001)(186003)(2906002)(53546011)(5660300002)(6506007)(316002)(921003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mH9bozma0sWmNFQsyQecF3xBTeRMDhUZQ6H82/U53XdLhKZ3zVRJQPNeu0hV7m65jXJjz4p2wFwGOhaPrvNQazpLznkeUxxNHc9HgdziSXGXF4uzJh07eg+pruWzqLIPNaEVIqYe/bGfy2j5MVEptt6hbwMH1aoCZfkcV+k0s0+58MYAnEhURncPu7D0qVbCZXl0aGpC0GOhjHXVazGcYDXByLNR+mVNod7W3duSGO36eZwwhouXD+G3WGkh9WCQEC0kuK5CzVlE3z89NFKYPPAEJV4N6xsHb+Tqhfq6R5aX13Qbhkt9bD+7yXahEy3bUd9kCsMwJ+cBUagBGeE+wnkOtokAp8ZGb046W9Z0+WnsJxDjsMZERFdp+pK9VZKAcvD+LPJUd3S6N4KddwImAoKR9WWYp1Sznm2hpYROeuzliZc8E+xV0ULkdxiiIPOy6+sv8gOroE+qWd1hYr29ZEjMMq7Hw/gtvy2/2VLQls=
x-ms-exchange-antispam-messagedata: 1jH8QHPvN6G2jOBdVScAwgWuGscoNtjLgURchqu5gUZd8+XbfSlRhZAWHKfgQUzA1fbUlaF6ARBMxCRnGbb4m0rk4mReJ8MAUJJIBFMfBKyN5WCy8QWQpIk4cta9hSqHyx+ezKhfz3aeUzTadsSwZw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eaeeff-6935-4fb9-57dd-08d7e799a44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 15:18:56.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtky5W0zJvtXvfuHt7V0CdW93i8PI8YBSpENPdxU3wyL3TOsFE7qXwaUBDhmmwTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNClNvcnJ5IGZvciBhbnkgY29uZnVzaW9uIG9mIHRoaXMgY29kZS4NCkkgdGhp
bmsgaW4gdGhpcyBjYXNlLCBpdCBzZWVtcyBsaWtlIHRoZSBjb21tZW50IGlzIHdyb25nIChidXQg
b3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaXMgc29tZXdoYXQgd3JvbmcgYXMgd2VsbCkuIFByb2Jh
Ymx5IHRoZSBvcmlnaW5hbCBjb2RlIGltcGxlbWVudGF0aW9uIG1ha2VzIGl0IHVuY2xlYXIuDQoN
ClRoZXJlIGFyZSB0aHJlZSBzY2VuYXJpb3M6DQoxLiBWYXJpYWJsZSByZWZyZXNoIGFjdGl2ZSwg
dGFyZ2V0aW5nIGEgZml4ZWQgcmF0ZQ0KSW4gdGhpcyBjYXNlLCB0aGUgbWluID0gbWF4ID0gZml4
ZWQgcmF0ZQ0KDQoyLiBWYXJpYWJsZSByZWZyZXNoIGFjdGl2ZSwgd2l0aCBhIHZhcmlhYmxlIHJh
bmdlDQpJbiB0aGlzIGNhc2UsIHRoZSBtaW4gPSBtaW5pbXVtIHJlZnJlc2ggcmF0ZSBvZiB0aGUg
cmFuZ2UuDQpBbmQgdGhlIG1heCA9IG1heGltdW0gcmVmcmVzaCByYXRlIG9mIHRoZSByYW5nZS4N
Cg0KMy4gVmFyaWFibGUgcmVmcmVzaCByYXRlIGlzIGRpc2FibGVkIChUaGUgY2FzZSB5b3UgYXJl
IG1vZGlmeWluZykNCkluIHRoZSBkaXNhYmxlZCBjYXNlLCB3ZSB3YW50IHRvIGluZGljYXRlIHRv
IHRoZSBkaXNwbGF5IHRoYXQgdGhlIHJlZnJlc2ggcmF0ZSBpcyBmaXhlZCwgc28gd2Ugd2FudCB0
byBwcm9ncmFtIG1pbiA9IG1heCA9IHRoZSBiYXNlIHJlZnJlc2ggcmF0ZS4NClRvZGF5IHRoZXJl
IHNlZW1zIHRvIGJlIGFuIGltcGxpY2F0aW9uIHRoYXQgbWF4IHJlZnJlc2ggPSBiYXNlIHJlZnJl
c2gsIHdoaWNoIGlzIG5vdCBuZWNlc3NhcmlseSB0cnVlLg0KSSBndWVzcyB0byBtYWtlIHRoZSBj
b2RlIG1vcmUgY2xlYXIgYW5kIGNvcnJlY3QsIHRoZSBtaW4gYW5kIG1heCBzaG91bGQgYm90aCBi
ZSBwcm9ncmFtbWVkIGVxdWFsIHRvIHRoZSBiYXNlIHJlZnJlc2ggcmF0ZSAobm9taW5hbCBmaWVs
ZCByYXRlIGZyb20gbW9kX2ZyZWVzeW5jX2NhbGNfbm9taW5hbF9maWVsZF9yYXRlKQ0KDQpEb2Vz
IHRoYXQgbWFrZSBzZW5zZT8NCg0KVGhhbmtzLA0KQW50aG9ueQ0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQ29saW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPiAN
ClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCAxMDowMyBBTQ0KVG86IFdlbnRsYW5kLCBI
YXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4gcGVuZyAoTGVvKSA8U3VucGVu
Zy5MaUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpob3Us
IERhdmlkKENodW5NaW5nKSA8RGF2aWQxLlpob3VAYW1kLmNvbT47IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IEtvbywgQW50
aG9ueSA8QW50aG9ueS5Lb29AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzoga2VybmVsLWphbml0b3JzQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogW1BB
VENIXVtuZXh0XSBkcm0vYW1kL2Rpc3BsYXk6IGZpeCBpbmNvcnJlY3QgYXNzaWdubWVudCBkdWUg
dG8gYSB0eXBvDQoNCkZyb206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5j
b20+DQoNClRoZSBhc3NpZ25tZW50IHRvIGluZm9wYWNrZXQtPnNiWzddIGxvb2tzIGluY29ycmVj
dCwgdGhlIGNvbW1lbnQgc3RhdGVzIGl0IGlzIHRoZSBtaW5pbXVtIHJlZnJlc2ggcmF0ZSB5ZXQg
aXQgaXMgYmVpbmcgYXNzaWduZWQgYSB2YWx1ZSBmcm9tIHRoZSBtYXhpbXVtIHJlZnJlc2ggcmF0
ZSBtYXhfcmVmcmVzaF9pbl91aHouIEZpeCB0aGlzIGJ5IHVzaW5nIG1pbl9yZWZyZXNoX2luX3Vo
eiBpbnN0ZWFkLg0KDQpBZGRyZXNzZXMtQ292ZXJpdHk6ICgiQ29weS1wYXN0ZSBlcnJvciIpDQpG
aXhlczogZDJiYWNjMzhmNmNhICgiZHJtL2FtZC9kaXNwbGF5OiBDaGFuZ2UgaW5mb3BhY2tldCB0
eXBlIHByb2dyYW1taW5nIikNClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5r
aW5nQGNhbm9uaWNhbC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9k
dWxlcy9mcmVlc3luYy9mcmVlc3luYy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMNCmluZGV4IGViNzQyMWU4M2I4
Ni4uZmUxMTQzNjUzNmU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYw0KQEAgLTU4Nyw3ICs1ODcsNyBAQCBz
dGF0aWMgdm9pZCBidWlsZF92cnJfaW5mb3BhY2tldF9kYXRhX3YzKGNvbnN0IHN0cnVjdCBtb2Rf
dnJyX3BhcmFtcyAqdnJyLA0KIAl9IGVsc2Ugew0KIAkJLy8gTm9uLWZzIGNhc2UsIHByb2dyYW0g
bm9taW5hbCByYW5nZQ0KIAkJLyogUEI3ID0gRnJlZVN5bmMgTWluaW11bSByZWZyZXNoIHJhdGUg
KEh6KSAqLw0KLQkJaW5mb3BhY2tldC0+c2JbN10gPSAodW5zaWduZWQgY2hhcikoKHZyci0+bWF4
X3JlZnJlc2hfaW5fdWh6ICsgNTAwMDAwKSAvIDEwMDAwMDApOw0KKwkJaW5mb3BhY2tldC0+c2Jb
N10gPSAodW5zaWduZWQgY2hhcikoKHZyci0+bWluX3JlZnJlc2hfaW5fdWh6ICsgDQorNTAwMDAw
KSAvIDEwMDAwMDApOw0KIAkJLyogUEI4ID0gRnJlZVN5bmMgTWF4aW11bSByZWZyZXNoIHJhdGUg
KEh6KSAqLw0KIAkJaW5mb3BhY2tldC0+c2JbOF0gPSAodW5zaWduZWQgY2hhcikoKHZyci0+bWF4
X3JlZnJlc2hfaW5fdWh6ICsgNTAwMDAwKSAvIDEwMDAwMDApOw0KIAl9DQotLQ0KMi4yNS4xDQoN
Cg==

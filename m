Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12360C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5C82080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jMJ+vgcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCXKRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:17:02 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:6065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbgCXKRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy2Pa1zIxM9CrlDKyuk3cMnMFBRfyRBphODKX0lz8InBc0vimSwU7jwIH540Y2XlrgEvIdPW427L6DKvCd/OhVU2tcgbUW2ztz6D3naRX8ISsvXKWazs+Iy4jkGUVpZ0jxcL0IAnif1HSOi0iYFt4BTYscbr5P+pMM11Il7nteW9XRT2+nHgn6Fi7aN92gU/lFD+zHI1XE/X5asN+sDacjjxYBzYxyQSHKPpgJKAq+Xnd2F7oHjFwoXwcGUW5vdZpV0slPgAuD8bFXGCKoZDEstjNaX89oNbsKZvmXxgI6WpVW/adLw2brPEPV9pRM207RW0TiJy8ZDn7ce34Wnw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZGoJm8zZjWpW/WdF2vCsHJb1xIH5da/MAJybKXAt64=;
 b=DKxTuFhkyY5o71hHEH/hnQu4LINcf3nJZb+iVW+IxliGDXiP0LEmXEBdESOa9o4uIW3Oce8p2qN9KsfoZ4t4arezUkmWhCvy9Kf9wHb8rZOhQwjqj448Lf3zSjiO22qGk97RkXnfoNxOItHsjQ8gdZ9fmG90swo4LPdYSqYspfQg0/AwRCADYVVv2vfqOLZtTcEN7ZAF6SM7Sl3nOfFfJPzsLrsboy7u7KhvMzoj6XBwZ4PIUWZLbWcFsYW5c/hWeNcac0ZsvpmkLVTtUXXYv+79vilaBcTs3+wxekW12y5JCFXpLIt7Pt8C2G6FZhZHA0f8X5YSSmmYhlMlQz8Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZGoJm8zZjWpW/WdF2vCsHJb1xIH5da/MAJybKXAt64=;
 b=jMJ+vgcNQ8TEx2LvtWsPQHU8nhSAGVfL12Ux1WvB0mph5E23K/0X36SrsVM2jdp27Ot/YnDo54cNOobomcbOc/tDao1NhX/SSZbhyJGbpjDA6LYjKmDuNT1IUwLsebAmsP7wXBRnKeshPw/K8rKRTt4plFiqSPmSA97phEsIe08=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.23; Tue, 24 Mar
 2020 10:16:59 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::acd1:24ec:991:f353]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::acd1:24ec:991:f353%5]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 10:16:59 +0000
From:   "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: amd: Changing Audio Format does not reflect.
Thread-Topic: [PATCH] ASoC: amd: Changing Audio Format does not reflect.
Thread-Index: AQHV/eExzQV7kweCEUmZ8WmfSn/hDqhQ3ueAgAauqrA=
Date:   Tue, 24 Mar 2020 10:16:58 +0000
Message-ID: <DM6PR12MB3868649B82B3FAD978283F7AE7F10@DM6PR12MB3868.namprd12.prod.outlook.com>
References: <1584616991-27348-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <8b1ab5dd-954e-29b7-b51f-f8c3e09a1521@amd.com>
In-Reply-To: <8b1ab5dd-954e-29b7-b51f-f8c3e09a1521@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-24T10:16:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d9773e8e-47c3-4130-abdd-0000e94a6e24;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-24T10:16:54Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2ecd9bfd-b325-4342-aafc-00002b7c6b4a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f87dee05-15d7-4c26-c58c-08d7cfdc7cdc
x-ms-traffictypediagnostic: DM6PR12MB2812:|DM6PR12MB2812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2812616DC24C11294466A43DE7F10@DM6PR12MB2812.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(186003)(2906002)(6862004)(86362001)(4326008)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(54906003)(478600001)(76116006)(6636002)(52536014)(33656002)(5660300002)(7696005)(81166006)(8936002)(8676002)(71200400001)(55016002)(6506007)(53546011)(9686003)(26005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2812;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoUYeliOWwpZNaG8uKtF4aCzxc6sbViTE39udnkuy6d18dMqotB25Fa0Fg9+qOcCNGKaFcprtFWdjHZj3yjfDz+QxF2VDit9LFfxtM0usOzTEPCB4PiBO1c9voA3/W7b2gp5kLB37RARfLd7cF7wxEaznVbQEfwvlrZCK/Rev5bZm6Q8N9lVG8SMa5FByWjQCtaeGXQEiA5Mpux8fggnLPJt13qLjUTpdGISEw/OE9P+l7dJb0NLEiESh0tQ9nUnspUQaCQQGWxc21X9BTtfNsK5A1i1/dmPAizBDJ+Y/MMiXhrrTLY5Xdsnjzxi+2R32Q8n6fB/TYpmPJ4FbSGBLs5JN2I4bec6dqYgXR6x3ke+sR02PI2tSoB7x193Bb+/Ekck/TBgBIb/LEdleYJBgYXBH6/SwSmXEhJjqIAE6sEr4mL29wwolWNJ73CC9Y2S
x-ms-exchange-antispam-messagedata: +uKmgQHc1szYcuau+z//1ogrnk+7Krv4bFBHyaEvZdmfFOCITgaO4sJIdROzzubkHYxyjovAFxjI4LkCMdY+QVfYkahqTuJiOniLjoT0/tmb/ZZLj2MHzb7mQ5h3S9XQnunKgsAhBs1A4xa7hyQQrw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87dee05-15d7-4c26-c58c-08d7cfdc7cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 10:16:58.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK5eoUJQjC3YjyR6f4FjnecFq5gi03jZLOXto9BiE116GAwmZyuYuPioDWyK0wE1XHxAuwCflcBT+5I1jHrsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFncmF3YWwsIEFrc2h1IDxBa3No
dS5BZ3Jhd2FsQGFtZC5jb20+IA0KU2VudDogRnJpZGF5LCBNYXJjaCAyMCwgMjAyMCA5OjM5IEFN
DQpUbzogUkFWVUxBUEFUSSwgVklTSE5VIFZBUkRIQU4gUkFPIDxWaXNobnV2YXJkaGFucmFvLlJh
dnVsYXBhdGlAYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBicm9vbmllQGtlcm5lbC5vcmc7IExpYW0gR2lyZHdvb2QgPGxnaXJkd29v
ZEBnbWFpbC5jb20+OyBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsgVGFrYXNoaSBJ
d2FpIDx0aXdhaUBzdXNlLmNvbT47IEFncmF3YWwsIEFrc2h1IDxBa3NodS5BZ3Jhd2FsQGFtZC5j
b20+OyBXZWkgWW9uZ2p1biA8d2VpeW9uZ2p1bjFAaHVhd2VpLmNvbT47IG1vZGVyYXRlZCBsaXN0
OlNPVU5EIC0gU09DIExBWUVSIC8gRFlOQU1JQyBBVURJTyBQT1dFUiBNQU5BR0VNLi4uIDxhbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBhbWQ6IENoYW5naW5nIEF1ZGlv
IEZvcm1hdCBkb2VzIG5vdCByZWZsZWN0Lg0KDQoNCk9uIDMvMTkvMjAyMCA0OjUyIFBNLCBSYXZ1
bGFwYXRpIFZpc2hudSB2YXJkaGFuIHJhbyB3cm90ZToNCj4gV2hlbiB5b3UgcnVuIGFwbGF5IHN1
YnNlcXVlbnRseSBhcyBiZWxvdyBieSBjaGFuZ2luZyB0aGUgc3RyZWFtIGZvcm1hdDoNCj4NCj4g
YXBsYXkgLURodzoyLDAgLWMyIC1mUzE2X0xFIC1yNDgwMDAgL2Rldi96ZXJvIC12diAtZCA1O2Fw
bGF5IC1EaHc6MiwwDQo+IC1jMiAtZlMyNF9MRSAtcjQ4MDAwIC9kZXYvemVybyAtdnYNCj4gYXMg
YSBzaW5nbGUgY29tbWFuZCwgdGhlIGZvcm1hdCBnZXRzIGNvcnJ1cHRlZCBhbmQgYXVkaW8gZG9l
cyBub3QgcGxheS4NCj4NCj4gU28gY2xlYXIgdGhlIEFDUF8oSTJTL0JUKVRETV9JVEVSL0lSRVIg
cmVnaXN0ZXIgd2hlbiBkbWEgc3RvcHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFJhdnVsYXBhdGkg
VmlzaG51IHZhcmRoYW4gcmFvIA0KPiA8VmlzaG51dmFyZGhhbnJhby5SYXZ1bGFwYXRpQGFtZC5j
b20+DQo+IC0tLQ0KPiAgIHNvdW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3gtaTJzLmMgfCA0ICstLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4LWkycy5jIA0KPiBiL3NvdW5k
L3NvYy9hbWQvcmF2ZW4vYWNwM3gtaTJzLmMgaW5kZXggM2EzYzQ3ZS4uYjA3YzUwYSAxMDA2NDQN
Cj4gLS0tIGEvc291bmQvc29jL2FtZC9yYXZlbi9hY3AzeC1pMnMuYw0KPiArKysgYi9zb3VuZC9z
b2MvYW1kL3JhdmVuL2FjcDN4LWkycy5jDQo+IEBAIC0yNDAsOSArMjQwLDcgQEAgc3RhdGljIGlu
dCBhY3AzeF9pMnNfdHJpZ2dlcihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwN
Cj4gICAJCQkJcmVnX3ZhbCA9IG1tQUNQX0kyU1RETV9JUkVSOw0KPiAgIAkJCX0NCj4gICAJCX0N
Cj4gLQkJdmFsID0gcnZfcmVhZGwocnRkLT5hY3AzeF9iYXNlICsgcmVnX3ZhbCk7DQo+IC0JCXZh
bCA9IHZhbCAmIH5CSVQoMCk7DQo+IC0JCXJ2X3dyaXRlbCh2YWwsIHJ0ZC0+YWNwM3hfYmFzZSAr
IHJlZ192YWwpOw0KPiArCQlydl93cml0ZWwoMCwgcnRkLT5hY3AzeF9iYXNlICsgcmVnX3ZhbCk7
DQoNCkNsZWFyaW5nIHRoZSBlbnRpcmUgcmVnaXN0ZXIgbWlnaHQgcmVzdWx0IGluIGlzc3Vlcy4N
Cg0KSU1PIGJldHRlciBmaXggaXMgdG8gaGF2ZSBhIHNhbXBsZV9sZW4gbWFzayBmb3IgSVRFUiBh
bmQgSVJFUiByZWdpc3Rlci4NCg0KVXNlIGl0IHRvIGNsZWFyIHNhbXBsZSBsZW5ndGggYml0cyBp
biBhY3AzeF9pMnNfaHdwYXJhbXMgZnVuY3Rpb24gYmVmb3JlIHNldHRpbmcgdGhlIG5ldyBmb3Jt
YXQgcmVzb2x1dGlvbi4NCg0KDQpUaGFua3MsDQoNCkFrc2h1DQoNCg0KV2hlbiBzdHJlYW0gaXMg
b3BlbiBvbmNlIGFnYWluIGFsbCB0aGUgdmFsdWVzIHdpbGwgYmUgc2V0Lg0KU28gd2l0aCBjbGVh
cmluZyBJVEVSL0lSRVIgdG8gMCB3aGVuIGRldmljZSBjbG9zZXMgdGhlcmUgd2lsbCBiZSBubyBp
c3N1ZXMuDQoNCi1WaXNobnUNCg==

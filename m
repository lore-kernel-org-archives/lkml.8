Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9FFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C358320720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8YTenLjS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8YTenLjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgGFMsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:48:06 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:14215
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729016AbgGFMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H9vSBzGwjo9vjVxTn5keE/VPhQt9+IFpWIJKJP7l68=;
 b=8YTenLjSkYKN2niFtZncbHqc73mGGieDdw+hcdXqvKxsM9gcm2KM9/K28jj+nm2CdsujLkQ41I6UfKS0lmiLbiGQcGAeLcn50FSOeqODfaE3iDcAeQZJUlABu9fsDM6JreYihNofnKuaV9nt4855F0vRw5i1LikYMbxtEYgK9L8=
Received: from DB6PR07CA0189.eurprd07.prod.outlook.com (2603:10a6:6:42::19) by
 DB7PR08MB4619.eurprd08.prod.outlook.com (2603:10a6:10:7d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Mon, 6 Jul 2020 12:47:58 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::b) by DB6PR07CA0189.outlook.office365.com
 (2603:10a6:6:42::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend
 Transport; Mon, 6 Jul 2020 12:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 12:47:58 +0000
Received: ("Tessian outbound e44de778b77e:v62"); Mon, 06 Jul 2020 12:47:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from 8bd243c088e2.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5E55989E-274C-410E-8C90-5B0750552187.1;
        Mon, 06 Jul 2020 12:47:53 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8bd243c088e2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Jul 2020 12:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCpWsKop6rmCOv/PhSnWyLGF/im6vipPHHSN3t6DDat5nT6e8KRnh1rVs/2Jv3FGicbOk3BqNWBKB1UmkVt3tCQYLCottFCdAGk40Xu+FxW8tR0Ss8GL56/BJIvg8Vn6xll86il8EebKJdHStW08wUOyRA24iFfD5gQxbfhOAp15cKI24pRyk7RDu1utB20Qt3Rsn7yr1B0GdQAZukvHH1TCY43fSKOnT50NipzBaBvavPK8OC4fTBh3ZxRtxO1WQXYxFhOY6jdgUVdzO3Gi1K9jdgCxzkUfgz7S0LlMpxJV6hdZFr5SrnRADn1iLIdLgMEBO9bdDei8Tudd/he51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H9vSBzGwjo9vjVxTn5keE/VPhQt9+IFpWIJKJP7l68=;
 b=iVS2v255aMOi2q7SLQIUYVGH/VECiP2AHRfgwvyk5EqdvkbPCDLFcrLa5jp5fWQiyIhLri0LRD2MZEJszMx4Zv+4uTni/3IuIRoLPOGlmdjM5hf2rZ2TFjB/wo+gl+PDagIWr9ieDY7d6O8/EXHaxPITXbPka2+1isTW0xrfiGe/JGKar0GrOMAzJy0SPhd9OP8WBTUkqvmjGxObcJKe3KIaFYiaJD6CdwQHc4hKwadBacwA92DsQQeQ4e7JWqfFYEpJm06yQ+xefAsu29BEi5Vk2Nca3R0cA2Ni6KmmvD0Sa/YYG8MrkYlrsilLmDWp3+0+4hBj4jddDXrIAxtDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H9vSBzGwjo9vjVxTn5keE/VPhQt9+IFpWIJKJP7l68=;
 b=8YTenLjSkYKN2niFtZncbHqc73mGGieDdw+hcdXqvKxsM9gcm2KM9/K28jj+nm2CdsujLkQ41I6UfKS0lmiLbiGQcGAeLcn50FSOeqODfaE3iDcAeQZJUlABu9fsDM6JreYihNofnKuaV9nt4855F0vRw5i1LikYMbxtEYgK9L8=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 12:47:51 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:47:51 +0000
From:   Justin He <Justin.He@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: RE: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Thread-Topic: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Thread-Index: AQHWUzObVAN7sC9CEkOu+o81HJjSXaj6WjeAgAAErYCAAB7QUA==
Date:   Mon, 6 Jul 2020 12:47:51 +0000
Message-ID: <AM6PR08MB4069BCD0E17BD37CC5591C63F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200706011947.184166-1-justin.he@arm.com>
        <20200706011947.184166-2-justin.he@arm.com>
        <20200706112921.00006f7f@Huawei.com> <20200706114605.000050ac@Huawei.com>
In-Reply-To: <20200706114605.000050ac@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5cfbf25e-5080-4120-b847-830a0e84c58b.1
x-checkrecipientchecked: true
Authentication-Results-Original: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.167.32.51]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f1179d9-7bd8-4b3d-8ffd-08d821aacf8a
x-ms-traffictypediagnostic: AM6PR08MB2982:|DB7PR08MB4619:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB4619806962984F8014DFF9D7F7690@DB7PR08MB4619.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gS4WULELbUo00rcqSIrUmCIK82b7VnlVoLuZnsBltJq+/Wquh/kmIuL4oG5Mr2EfrNElUYiIncQHvWZ/iaOfVCOXY1kiLiTwIwkPLqft7t3bhMO9D/Zg9vCHR5CLSH6cai5P1SiUQ7/Qgvq62moFkxGH0esOretFB5FKExVvF8JpCA/rRnnwlH27J5gevfrAkQ5/aNlWu8s8VnsoGWgNKXhjF2el82XeMKfX2cLQI+YAHuwiXLJFSchj53iRsu8pre3avHjnJlCsbk3dIkvr/HALIiA5x0bpSFunSW7S4RV6V0IOoEifFUfIaOy4lNRJluUDpWmY9W8ZDLCqJ9E6UkLDCt7mtdnMx4UX5TUSXG4Ab/JVXZiWj104UheQAbt+bBoIojWh9JTokBeYQyM7dA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(186003)(26005)(6916009)(2906002)(7696005)(76116006)(966005)(83380400001)(86362001)(71200400001)(478600001)(66446008)(64756008)(66476007)(66946007)(66556008)(8676002)(5660300002)(316002)(53546011)(6506007)(33656002)(55016002)(9686003)(7416002)(54906003)(8936002)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1I1Rr0DsazUIlUTbWQGD8PAjqlv6eAP4x/0SBGCIJa3YP7oAF4w6nn8cKsqbAq/B4KTuEXTk1LtAKtebHPKlPDXFXJoB2IhrjUrD5xxcs1GwUoiLFFCntCTeQqtbkyDtFE7/wGvPZhrbGxoOAOl4pOVfUwi1/zYbWpzPkilFp7+9tpwu/j6cUxexRx2Hi3N/juv7dmGl8gUwlXpYz1pndDNW0hPNt9y0ayLttS37TisFEAsNCYpgJW6LbFh5AQ49MigGqTWWmEvkdjeCjIMwJNGJU4Tkpt/rglcVcXBCXmCAZhbKRphiXU17akBqWrIOzHLk3Nl5pe2WRpfE4vUJVHRkOOq3KfgUFpclulmrPJRzcuKuRwH3DgieG0mV92ZPvII6+uvrF8Ns6SZ2a6FbBUQcq+NGWrN8qnrWurEIF+zCaWxxJF78MVdeKU3TWgFKi2YjNecbto7UNU5gBSecj8qGIZHLRT6q3bROS1s6YrI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Original-Authentication-Results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(52536014)(5660300002)(54906003)(2906002)(316002)(83380400001)(8676002)(33656002)(4326008)(70206006)(336012)(70586007)(107886003)(356005)(26005)(55016002)(966005)(186003)(7696005)(8936002)(478600001)(53546011)(6506007)(82740400003)(6862004)(86362001)(82310400002)(81166007)(9686003)(47076004);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 229684b7-d747-41c1-7411-08d821aacb44
X-Forefront-PRVS: 04569283F9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TCGJwqeDejQIuoHWgqRXsF51g16iWU5/HXXNtJc6umM80Em3o7VrtWhXWsLh8xzrfog/rI+CoJ8P2CGWJKy8vqGM93RC41Pmi/rheY9p+6TH5fHiLkG6iK35dKQsRCYIRsczlTBTNnn48cvlhiwytQG4mDP8haGZYDVn6RZ+AYBxfBSx7aBtUg5VPTwTzJ9AEgpaPqO/ySi/QyX3fE2O6LhX8BLj1db0F6Ym1RZT49PcH/KKph6WCpOxyerbS/yok6Z+pdfFGxDw1sipHX0PvHuTcKM2y+ZVbpn+hLy3FzyE5+vhGmWquzRU/C+4AuiyMbiFU1n6rKzbxywsywMlGFqimzCvA1Rb66owxMpyoU3ywr8AgVaLK6XpjwuN0NkBOr3VSFFA/vIDL6QW1FSXhvJLJbXdM4cAeI34HNFlBp6dp/LbkhKRWSHE84OXHrU2fDoaj0mQ/3YDV5bCbMx4TdDqlrnZ1IDzhrslKeO7Xw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 12:47:58.2986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1179d9-7bd8-4b3d-8ffd-08d821aacf8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sIHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25A
SHVhd2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDYsIDIwMjAgNjo0NiBQTQ0KPiBUbzog
SnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0
YWxpbi5NYXJpbmFzQGFybS5jb20+OyBXaWxsIERlYWNvbg0KPiA8d2lsbEBrZXJuZWwub3JnPjsg
QW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IE1pa2UNCj4gUmFwb3Bv
cnQgPHJwcHRAbGludXguaWJtLmNvbT47IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPjsgQ2h1
aG9uZyBZdWFuDQo+IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LW1tQGt2YWNrLm9yZzsgS2FseSBYaW4gPEthbHkuWGluQGFybS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS8zXSBhcm02NC9udW1hOiBzZXQgbnVtYV9vZmYgdG8gZmFsc2Ugd2hlbiBudW1h
IG5vZGUNCj4gaXMgZmFrZQ0KPiANCj4gT24gTW9uLCA2IEp1bCAyMDIwIDExOjI5OjIxICswMTAw
DQo+IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNvbT4gd3JvdGU6
DQo+IA0KPiA+IE9uIE1vbiwgNiBKdWwgMjAyMCAwOToxOTo0NSArMDgwMA0KPiA+IEppYSBIZSA8
anVzdGluLmhlQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiA+IFByZXZp
b3VzbHksIG51bWFfb2ZmIGlzIHNldCB0byB0cnVlIHVuY29uZGl0aW9uYWxseSBpbg0KPiBkdW1t
eV9udW1hX2luaXQoKSwNCj4gPiA+IGV2ZW4gaWYgdGhlcmUgaXMgYSBmYWtlIG51bWEgbm9kZS4N
Cj4gPiA+DQo+ID4gPiBCdXQgYWNwaSB3aWxsIHRyYW5zbGF0ZSBub2RlIGlkIHRvIE5VTUFfTk9f
Tk9ERSgtMSkgaW4NCj4gYWNwaV9tYXBfcHhtX3RvX25vZGUoKQ0KPiA+ID4gYmVjYXVzZSBpdCBy
ZWdhcmRzIG51bWFfb2ZmIGFzIHR1cm5pbmcgb2ZmIHRoZSBudW1hIG5vZGUuDQo+ID4NCj4gPiBU
aGF0IGlzIGNvcnJlY3QuICBJdCBpcyBvcGVyYXRpbmcgZXhhY3RseSBhcyBpdCBzaG91bGQsIGlm
IFNSQVQgaGFzbid0DQo+IGJlZW4gcGFyc2VkDQo+ID4gYW5kIHlvdSBhcmUgb24gQUNQSSBwbGF0
Zm9ybSB0aGVyZSBhcmUgbm8gbm9kZXMuICBUaGV5IGNhbm5vdCBiZSBjcmVhdGVkDQo+IGF0DQo+
ID4gc29tZSBsYXRlciBkYXRlLiAgVGhlIGR1bW15IGNvZGUgZG9lc24ndCBjaGFuZ2UgdGhpcy4g
SXQganVzdCBkb2VzDQo+IGVub3VnaCB0byBjYXJyeQ0KPiA+IG9uIG9wZXJhdGluZyB3aXRoIG5v
IHNwZWNpZmllZCBub2Rlcy4NCj4gPg0KPiA+ID4NCj4gPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwg
cG1lbSBjYW4ndCBiZSBwcm9iZWQgYXMgYSBSQU0gZGV2aWNlIG9uIGFybTY0IGlmDQo+IFNSQVQg
dGFibGUNCj4gPiA+IGlzbid0IHByZXNlbnQuDQo+ID4gPg0KPiA+ID4gJG5kY3RsIGNyZWF0ZS1u
YW1lc3BhY2UgLWZlIG5hbWVzcGFjZTAuMCAtLW1vZGU9ZGV2ZGF4IC0tbWFwPWRldiAtcyAxZw0K
PiAtYSA2NEsNCj4gPiA+IGttZW0gZGF4MC4wOiByZWplY3RpbmcgREFYIHJlZ2lvbiBbbWVtIDB4
MjQwNDAwMDAwLTB4MmJmZmZmZmZmXSB3aXRoDQo+IGludmFsaWQgbm9kZTogLTENCj4gPiA+IGtt
ZW06IHByb2JlIG9mIGRheDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMjINCj4gPiA+DQo+ID4gPiBU
aGlzIGZpeGVzIGl0IGJ5IHNldHRpbmcgbnVtYV9vZmYgdG8gZmFsc2UuDQo+ID4NCj4gPiBXaXRo
b3V0IHRoZSBTUkFUIHByb3RlY3Rpb24gcGF0Y2ggWzFdIHlvdSBtYXkgd2VsbCBydW4gaW50byBw
cm9ibGVtcw0KDQpTb3JyeSwgZG9lc24ndCBxdWl0ZSB1bmRlcnN0YW5kIGhlcmUuIERvIHlvdSBt
ZWFuIHlvdXIgWzFdIGNhbiByZXNvbHZlIHRoaXMNCmlzc3VlPyBCdXQgYWNwaV9tYXBfcHhtX3Rv
X25vZGUoKSBoYXMgcmV0dXJuZWQgd2l0aCBOVU1BX05PX05PREUgYWZ0ZXINCmZvbGxvd2luZyBj
aGVjazoNCglpZiAocHhtIDwgMCB8fCBweG0gPj0gTUFYX1BYTV9ET01BSU5TIHx8IG51bWFfb2Zm
KQ0KCQlyZXR1cm4gTlVNQV9OT19OT0RFOw0KU2VlbXMgZXZlbiB3aXRoIHlvdXIgWzFdIHBhdGNo
LCBpdCBpcyBub3QgaGVscGZ1bD8gVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uDQppZiBteSB1bmRl
cnN0YW5kaW5nIGlzIHdyb25nLg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0
Y2gvMTE2MzIwNjMvDQoNCj4gPiBiZWNhdXNlIHNvbWVvbmUgc29tZXdoZXJlIHdpbGwgaGF2ZSBf
UFhNIGluIGEgRFNEVCBidXQgd2lsbA0KPiA+IGhhdmUgYSBub24gZXhpc3RlbnQgU1JBVC4gICBX
ZSBoYWQgdGhpcyBoYXBwZW4gb24gYW4gQU1EIHBsYXRmb3JtIHdoZW4NCj4gd2UNCj4gPiB0cmll
ZCB0byBpbnRyb2R1Y2Ugd29ya2luZyBfUFhNIHN1cHBvcnQgZm9yIFBDSS4gWzJdDQo+ID4NCj4g
PiBTbyB3aGlsc3QgdGhpcyBzZWVtcyBzdXBlcmZpY2lhbGx5IHNhZmUsIEknZCBkZWZpbml0ZWx5
IGJlIGNyb3NzaW5nIHlvdXINCj4gZmluZ2Vycy4NCj4gPiBOb3RlLCBhdCB0aGF0IHRpbWUgSSBw
cm9wb3NlZCBwdXR0aW5nIHRoZSBudW1hX29mZiA9IGZhbHNlIGludG8gdGhlIHg4Ng0KPiBjb2Rl
DQo+ID4gcGF0aCBwcmVjaXNlbHkgdG8gY3V0IG91dCB0aGF0IHBvc3NpYmlsaXR5ICh3YXMgcmVq
ZWN0ZWQgYXQgdGhlIHRpbWUsIGF0DQo+IGxlYXN0DQo+ID4gcGFydGx5IGJlY2F1c2UgdGhlIGNs
YXJpZmljYXRpb25zIHRvIHRoZSBBQ1BJIHNwZWMgd2VyZSBub3QgcHViaWxjLikNCj4gPg0KPiA+
IFRoZSBwYXRjaCBpbiBbMV0gc2hvdWxkIHNvcnQgdGhpbmdzIG91dCBob3dldmVyIGJ5IGVuc3Vy
aW5nIHdlIG9ubHkNCj4gY3JlYXRlDQo+ID4gbmV3IGRvbWFpbnMgd2hlcmUgd2Ugc2hvdWxkIGFj
dHVhbGx5IGJlIGRvaW5nIHNvLiBIb3dldmVyLCBpbiB5b3VyIGNhc2UNCj4gPiBpdCB3aWxsIHJl
dHVybiBOVU1BX05PX05PREUgYW55d2F5IHNvIHRoaXMgaXNuJ3QgdGhlIHJpZ2h0IHdheSB0byBm
aXgNCj4gdGhpbmdzLg0KDQpPa2F5LCBsZXQgbWUgdHJ5IHRvIHN1bW1hcml6ZSwgdGhlcmUgbWln
aHQgYmUgMyBwb3NzaWJsZSBmaXhpbmcgd2F5czoNCjEuIHRoaXMgcGF0Y2gsIHNlZW1zIGl0IGlz
IG5vdCBzYXRpc2ZpZWQgYnkgeW91IGFuZCBEYXZpZCDwn5iJDQoyLiBteSBwcmV2aW91cyBwcm9w
b3NhbCBbMl0sIHNpbWlsYXIgYXMgd2hhdCBEYXZpZCBzdWdnZXN0ZWQNCjMuIHJlbW92ZSBudW1h
X29mZiBjaGVjayBpbiBhY3BpX21hcF9weG1fdG9fbm9kZSgpDQplLmcuDQouLi4NCglpZiAocHht
IDwgMCB8fCBweG0gPj0gTUFYX1BYTV9ET01BSU5TIC8qfHwgbnVtYV9vZmYqLykNCgkJcmV0dXJu
IE5VTUFfTk9fTk9ERTsNCg0KWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzgvMTYvMzY3
DQoNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0KDQoNCg==

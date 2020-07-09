Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DBCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE282073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="78LAvTS6";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="78LAvTS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGIFNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:13:35 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:53988
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgGIFNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=78LAvTS6+lh3bxCxaSawrml6yAPVzm1T90ysCP68srNIeY5iPiE3WZZZRhsuzaI2jkcSqm+cbhIskFWcoNr87Flx4s/+GFArODNWtkcxiAQil/ewz6OaxQRNzhItXyCMxqTCbQ/PQjUk3dosH5HON4LFZHjnQIUtWLsYd+NLcR4=
Received: from MRXP264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::22)
 by VI1PR0801MB1918.eurprd08.prod.outlook.com (2603:10a6:800:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 05:13:28 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:14:cafe::8c) by MRXP264CA0034.outlook.office365.com
 (2603:10a6:500:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Thu, 9 Jul 2020 05:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 05:13:28 +0000
Received: ("Tessian outbound 1c27ecaec3d6:v62"); Thu, 09 Jul 2020 05:13:27 +0000
X-CR-MTA-TID: 64aa7808
Received: from f52441a98fb4.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4007E773-5DA6-4C6A-B5A2-3FB6CEF10A18.1;
        Thu, 09 Jul 2020 05:13:21 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f52441a98fb4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Jul 2020 05:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFh2x/GAO2XMmi/DRIOrhF1wfVKb7ahSpKYTu1ffQnZfgtgtFRUwkcsRY2OE7xCVR9ffFreL6iSYUA/PL2Bo4S9+Rn8WP7j4Adh7R2aDglDqkDh6qqN5hoZjEjBhfh4G9DarF0B/v3636m+JSiuoLdae3a8+s7TQdOGiNBKqdGos6+rcIRrfgbQ0Zh+ecem+DyWrKQspgvzUNebkvo68OzKNPs4978tLZz5/p/7203vU1qFmHKcr9ctt+YKnyDdNyU/QZzGhQKDxa6fj8HW2AvC50wFcCPNaYc5chRP2f+OnSX6CUfP0QxsLt3maQtrA5+1QdcG8LkrQzUdXkLTW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=VWi12XQ2NnMohOZ6J+zYEOhkiggspcxRMaTo6r+oPiEFVbNiowHfuE2obFPkroLUgCGUEhbLzRIdsFrtXJK4C9r/CRV4rj4Hd5isKWtQ08uKZWn/p/f3acdtGKIElvyksgne09MmL4qOJ6O2Kwq9GZDQuLpuvZS9+kOXIDPsBwnyHV7PYI/txulMeD+5cLv96g40j50LBn1+w7e1jKA6vT5v7c8oDV5mcbZyFg1sE3jp4Ch1yRzBraMrfwVuXl1gMaYJ5TyJ1Jjm+nDYjQVlXuLc4avKV8O/IX+ft+yW0xBzdcSwrfturWIFl94Nc/WLHO6kUSqi62hPe1cJ9TFWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sN+udc5fe7rcS4kOYX0bFZpVWtQBB+c87d5Xdiyt0Q=;
 b=78LAvTS6+lh3bxCxaSawrml6yAPVzm1T90ysCP68srNIeY5iPiE3WZZZRhsuzaI2jkcSqm+cbhIskFWcoNr87Flx4s/+GFArODNWtkcxiAQil/ewz6OaxQRNzhItXyCMxqTCbQ/PQjUk3dosH5HON4LFZHjnQIUtWLsYd+NLcR4=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM7PR08MB5335.eurprd08.prod.outlook.com (2603:10a6:20b:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Thu, 9 Jul
 2020 05:13:20 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 05:13:20 +0000
From:   Justin He <Justin.He@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: RE: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is
 invalid
Thread-Index: AQHWVZW+nx78d4gAuUOw9EWfEfkjTKj+macAgAAZ3LA=
Date:   Thu, 9 Jul 2020 05:13:19 +0000
Message-ID: <AM6PR08MB4069D206048464CFCBBFDC9EF7640@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-6-justin.he@arm.com>
 <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
In-Reply-To: <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 569fc01c-900f-4ac6-9a2e-06ed3fe017b2.1
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6edc466-9a2f-4cf3-41dc-08d823c6d0ca
x-ms-traffictypediagnostic: AM7PR08MB5335:|VI1PR0801MB1918:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB19184E61C9BC0C04F8C19F13F7640@VI1PR0801MB1918.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8Xbtp0259dtbnwCyTYPbOIVhEFoz+RPJOv7cNTnlI3Ff6NCyJBeGnEQj9r8qJEIuGZRM8BljAbbZkv9gvhNAjvCES85YbpE7ezGy/U82BfQm2vYB1MdovrMiugzggiztqeuNBO5ycNKAFOKloPWexdp3NLoZuCdTZ/Z8V7dbTF8xpwBDxwR2vsptRn+H/59sT+CjdW3yxD+BQ3SeNpizverlZ1Uyh6VvYonkgisZfW+ffcDBzdNtlmxUWOpy0W6kHhag9mm4t9NzJ6s/ZfgUcZHcjkUg4KmUhFHqd+z3PU5dsG1lKeWJwIZTQMIZaPHJOElcJ6bFc7Qi0HbysnkOQQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(54906003)(6506007)(26005)(8676002)(83380400001)(6916009)(76116006)(7406005)(7416002)(4326008)(8936002)(66446008)(7696005)(71200400001)(53546011)(478600001)(66946007)(66556008)(66476007)(316002)(64756008)(2906002)(5660300002)(9686003)(33656002)(86362001)(186003)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fkW/kph5UtYTIUPfsMjWGqBZaEYj9emNUlh9LjN0Tgpq3mTQxjGDzJC6w2tjJZP+faSBLrzfpLJCc52N27Njd7rFX/lLFmSUgVInJv+TL3AX2ZuJlEF7Ur9k5uTW89OSfnj6g3+z707uztDSUiGA6JJ7Lkpn0782fA6iZtK3LbGVBgATToe7bKhw2/FUjRoqtjihdK1sAIbM//koG1NF517P+FDLdta8ENbUPzOD49wcB5WNad8kUT/LWPIN4gy8rUj3Aoxal8fis1c7wtY3yiuQqj9FJehKA6HZA5VdOnDQYy+t/FzRz7/ELT96urZ2HlyZ/lXmGq0n5/M5NEcvrKNcoMTA7coOzGg/bwV3BAMQxZcDOkMG1Wr9TrniwVRG6h5rK/wK7YLVJEQg1Zq8EoHX5JmhxHORBkTlEc6ueKjJhM0a5fjSY7GhN2i2diWQ4HnkMoHC7gWS0meFtKTN17ccNOP2fqTidWXGfju3Tlg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5335
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(8676002)(70586007)(70206006)(86362001)(5660300002)(33656002)(6506007)(53546011)(186003)(26005)(478600001)(36906005)(81166007)(82310400002)(336012)(7696005)(47076004)(83380400001)(8936002)(356005)(82740400003)(52536014)(4326008)(55016002)(6862004)(9686003)(316002)(54906003)(450100002)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c56af25b-e866-4f30-64fa-08d823c6cbdc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09nTB/INn7zMIfjvXY3xrkzx+u8JihGfvOEQG51cAXfdKM5jDCyTn5kyTWSEkuDGMo/ENwhBAukEDggRIh+MtflC5d57Bk6jDewDoDdatU/xx5cO+J/6FzZqjGq19bwaEsV2s0ClVlbXDfKUp7yPfR5euFVYm1c9jmozX/PLxaFc5c6EfT4UrI9NiWpEr5MgilvJM4XjUhJxiFMtGPu45eAkUr5ay/t5m9V+z9Pk4QKCN3jtUTJv22PGYulAcrZldyjch6gL3a3H0+LLA8bbhrLW/VLhNYoTAnRpsiPWRl8zK06wYmr10YTTAwI8LZsE4+nXTn+VHpTobRtFgyhtbYQbhfT/WVPT8dE5bw84B9Mfk8uP1Dkhw6FiPLo+QcLmu6rpRO7ANKkj7VfGwdP++g==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 05:13:28.4418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6edc466-9a2f-4cf3-41dc-08d823c6d0ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDks
IDIwMjAgMTE6MzkgQU0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENj
OiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24N
Cj4gPHdpbGxAa2VybmVsLm9yZz47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IEZl
bmdodWEgWXUNCj4gPGZlbmdodWEueXVAaW50ZWwuY29tPjsgWW9zaGlub3JpIFNhdG8gPHlzYXRv
QHVzZXJzLnNvdXJjZWZvcmdlLmpwPjsgUmljaA0KPiBGZWxrZXIgPGRhbGlhc0BsaWJjLm9yZz47
IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyBBbmR5DQo+IEx1dG9t
aXJza2kgPGx1dG9Aa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFk
Lm9yZz47DQo+IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xu
YXIgPG1pbmdvQHJlZGhhdC5jb20+Ow0KPiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47
IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPjsgWDg2DQo+IE1MIDx4ODZAa2Vy
bmVsLm9yZz47IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgVmlzaGFsIFZlcm1hDQo+
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVs
LmNvbT47IEFuZHJldw0KPiBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBCYW9x
dWFuIEhlIDxiaGVAcmVkaGF0LmNvbT47IENodWhvbmcNCj4gWXVhbiA8aHNsZXN0ZXI5NkBnbWFp
bC5jb20+OyBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+OyBMb2dhbg0KPiBHdW50
aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+OyBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBr
ZXJuZWwub3JnPjsNCj4gTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+OyBMaW51eCBBUk0g
PGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwg
TWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWlh
NjRAdmdlci5rZXJuZWwub3JnOyBMaW51eC1zaCA8bGludXgtDQo+IHNoQHZnZXIua2VybmVsLm9y
Zz47IGxpbnV4LW52ZGltbSA8bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZz47IExpbnV4IE1NDQo+
IDxsaW51eC1tbUBrdmFjay5vcmc+OyBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb20+OyBLYWx5DQo+IFhpbiA8S2FseS5YaW5AYXJtLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyA1LzZdIGRldmljZS1kYXg6IHVzZSBmYWxsYmFjayBuaWQgd2hlbiBudW1h
X25vZGUgaXMNCj4gaW52YWxpZA0KPiANCj4gT24gV2VkLCBKdWwgOCwgMjAyMCBhdCA3OjA3IFBN
IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gbnVtYV9vZmYgaXMg
c2V0IHVuY29uZGl0aW9uYWxseSBhdCB0aGUgZW5kIG9mIGR1bW15X251bWFfaW5pdCgpLA0KPiA+
IGV2ZW4gd2l0aCBhIGZha2UgbnVtYSBub2RlLiBBQ1BJIGRldGVjdHMgbm9kZSBpZCBhcyBOVU1B
X05PX05PREUoLTEpIGluDQo+ID4gYWNwaV9tYXBfcHhtX3RvX25vZGUoKSBiZWNhdXNlIGl0IHJl
Z2FyZHMgbnVtYV9vZmYgYXMgdHVybmluZyBvZmYgdGhlDQo+IG51bWENCj4gPiBub2RlLiBIZW5j
ZSBkZXZfZGF4LT50YXJnZXRfbm9kZSBpcyBOVU1BX05PX05PREUgb24gYXJtNjQgd2l0aCBmYWtl
IG51bWEuDQo+ID4NCj4gPiBXaXRob3V0IHRoaXMgcGF0Y2gsIHBtZW0gY2FuJ3QgYmUgcHJvYmVk
IGFzIGEgUkFNIGRldmljZSBvbiBhcm02NCBpZg0KPiBTUkFUIHRhYmxlDQo+ID4gaXNuJ3QgcHJl
c2VudDoNCj4gPiAkbmRjdGwgY3JlYXRlLW5hbWVzcGFjZSAtZmUgbmFtZXNwYWNlMC4wIC0tbW9k
ZT1kZXZkYXggLS1tYXA9ZGV2IC1zIDFnIC0NCj4gYSA2NEsNCj4gPiBrbWVtIGRheDAuMDogcmVq
ZWN0aW5nIERBWCByZWdpb24gW21lbSAweDI0MDQwMDAwMC0weDJiZmZmZmZmZl0gd2l0aA0KPiBp
bnZhbGlkIG5vZGU6IC0xDQo+ID4ga21lbTogcHJvYmUgb2YgZGF4MC4wIGZhaWxlZCB3aXRoIGVy
cm9yIC0yMg0KPiA+DQo+ID4gVGhpcyBmaXhlcyBpdCBieSB1c2luZyBmYWxsYmFjayBtZW1vcnlf
YWRkX3BoeXNhZGRyX3RvX25pZCgpIGFzIG5pZC4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlh
IEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kYXgva21lbS5j
IHwgMjEgKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZGF4L2ttZW0uYyBiL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+IGluZGV4IDI3NWFhNWY4NzM5OS4u
MjE4ZjY2MDU3OTk0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+IEBAIC0zMSwyMiArMzEsMjMgQEAgaW50IGRldl9k
YXhfa21lbV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBpbnQgbnVtYV9u
b2RlOw0KPiA+ICAgICAgICAgaW50IHJjOw0KPiA+DQo+ID4gKyAgICAgICAvKiBIb3RwbHVnIHN0
YXJ0aW5nIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIG5leHQgYmxvY2s6ICovDQo+ID4gKyAgICAg
ICBrbWVtX3N0YXJ0ID0gQUxJR04ocmVzLT5zdGFydCwgbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMo
KSk7DQo+ID4gKw0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIEVuc3VyZSBnb29kIE5V
TUEgaW5mb3JtYXRpb24gZm9yIHRoZSBwZXJzaXN0ZW50IG1lbW9yeS4NCj4gPiAgICAgICAgICAq
IFdpdGhvdXQgdGhpcyBjaGVjaywgdGhlcmUgaXMgYSByaXNrIHRoYXQgc2xvdyBtZW1vcnkNCj4g
PiAgICAgICAgICAqIGNvdWxkIGJlIG1peGVkIGluIGEgbm9kZSB3aXRoIGZhc3RlciBtZW1vcnks
IGNhdXNpbmcNCj4gPiAtICAgICAgICAqIHVuYXZvaWRhYmxlIHBlcmZvcm1hbmNlIGlzc3Vlcy4N
Cj4gPiArICAgICAgICAqIHVuYXZvaWRhYmxlIHBlcmZvcm1hbmNlIGlzc3Vlcy4gRnVydGhlcm1v
cmUsIGZhbGxiYWNrIG5vZGUNCj4gPiArICAgICAgICAqIGlkIGNhbiBiZSB1c2VkIHdoZW4gbnVt
YV9ub2RlIGlzIGludmFsaWQuDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAgICAgIG51bWFfbm9k
ZSA9IGRldl9kYXgtPnRhcmdldF9ub2RlOw0KPiA+ICAgICAgICAgaWYgKG51bWFfbm9kZSA8IDAp
IHsNCj4gPiAtICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAicmVqZWN0aW5nIERBWCByZWdp
b24gJXBSIHdpdGggaW52YWxpZA0KPiBub2RlOiAlZFxuIiwNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgcmVzLCBudW1hX25vZGUpOw0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gPiArICAgICAgICAgICAgICAgbnVtYV9ub2RlID0gbWVtb3J5X2FkZF9waHlzYWRk
cl90b19uaWQoa21lbV9zdGFydCk7DQo+IA0KPiBJIHRoaW5rIHRoaXMgZml4dXAgYmVsb25ncyB0
byB0aGUgY29yZSB0byBzZXQgYSBmYWxsYmFjayB2YWx1ZSBmb3INCj4gZGV2X2RheC0+dGFyZ2V0
X25vZGUuDQo+IA0KPiBJJ20gY2xvc2UgdG8gaGF2aW5nIHBhdGNoZXMgdG8gcHJvdmlkZSBhIGZ1
bmN0aW9uYWwNCj4gcGh5c19hZGRyX3RvX3RhcmdldF9ub2RlKCkgZm9yIGFybTY0Lg0KDQpTaG91
bGQgTXkgdGhpcyBwYXRjaCg1LzYpIHdhaXQgb24geW91ciBuZXcgcGh5c19hZGRyX3RvX3Rhcmdl
dF9ub2RlKCkgcGF0Y2g/DQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KDQotLQ0KQ2hl
ZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K

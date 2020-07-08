Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0790C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hWHqFXm5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hWHqFXm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgGHBlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:41:53 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:30478
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbgGHBlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=hWHqFXm5KEPG/dYPQE+SQ86jTUa48YopNWv347vds1MAu4nHnm6+u6BCd2MO1qW/cnSTvAz6ZXKTh2++uvf1OX0w0fwfxcN6/y0JwU6ER3/3r/fjPhjnfe7hSh3qK/NHt5EY6gSOwEA4MvIP2+j3OQupPj6bUsLrQmqX2U42IIo=
Received: from AM6PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::22)
 by DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 01:41:47 +0000
Received: from AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80::4) by AM6PR10CA0045.outlook.office365.com
 (2603:10a6:209:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 01:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT010.mail.protection.outlook.com (10.152.16.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 01:41:47 +0000
Received: ("Tessian outbound 2dd9eeca983c:v62"); Wed, 08 Jul 2020 01:41:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from 49216f569693.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 29479A2D-34D6-43B3-A907-D5F8CE15721D.1;
        Wed, 08 Jul 2020 01:41:41 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 49216f569693.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 01:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJmGgOKU4H4zFKY/2b1TN1pmOFwazUDFvC7cJLe1vulzcorx3v8ZgINaRWjmaPll4VASdWh6c9WRgyIWUYcpRJS6CC6fvqpxfW/hVQZtjcCMx+4Cb2WnTITyT/0txHjK0sMv+botsRne9ZNKv+Zfvho9AP4ETxpRv2hpiSQkZKOAa8XcnH7f8xN8IRhzgwWoH/21qd2arHvILlnCOcrDknTCl0BXw888RC6sQQF4TTJXGpXGtvZh4RjRsGo63sLfTHmxy/qbgc482IdRt81fI3j2Cm2oD/hwhMiS8ZE6Eh92SvBIuTgFeTG0U2wB3rWbt8p8i7fawdBl4kSBrZcW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=ZPywwhlM3CbgmC/wpNOUackAhm5H2zydPIrdpyJxeSzRxPJNCNCcQd0iFySmhFh1butyP9nvgoYphAW483FJMR8tdUF3RsY+gvUtkcDL1Sn1blQNI2bJty3itCcGhogC/Xd2Pv+VM90QVdn4yL4U3b9tP6jiL7D5Bglmxp4VpF9KnOaMuppc1vtDiJtDh2lWakjszzepTML9u3pcoqyLop+gUSLgc54TD7WVR3VP+FFAjOcmW8kuOdfFa60U/uvDpxmf25g38nO0wI4lShpY14yqxjqGVmwhkYyLNpFbf5EJ4tH8vp0S7Qb24PLc3diUnTJB1+zFgloaPxV3Q9uPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eupO9Er5ZfcbCNiFSm1+GrqCsX1S9J7XVa0Xvxph5Yo=;
 b=hWHqFXm5KEPG/dYPQE+SQ86jTUa48YopNWv347vds1MAu4nHnm6+u6BCd2MO1qW/cnSTvAz6ZXKTh2++uvf1OX0w0fwfxcN6/y0JwU6ER3/3r/fjPhjnfe7hSh3qK/NHt5EY6gSOwEA4MvIP2+j3OQupPj6bUsLrQmqX2U42IIo=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4405.eurprd08.prod.outlook.com (2603:10a6:20b:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 01:41:40 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 01:41:40 +0000
From:   Justin He <Justin.He@arm.com>
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: RE: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node
 is invalid
Thread-Index: AQHWVCPVY5+RvFDzZEO2wqan5w9kVKj7/MoAgADsitA=
Date:   Wed, 8 Jul 2020 01:41:40 +0000
Message-ID: <AM6PR08MB4069EDE5D2D539BC186D091EF7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-3-justin.he@arm.com>
 <2409a5d4-e77b-f570-c788-feb4f6ebb498@redhat.com>
In-Reply-To: <2409a5d4-e77b-f570-c788-feb4f6ebb498@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: bec86d11-e5c5-4b6e-9e2c-8c1ac8a218ba.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3b5c42a-4e88-44e0-9e5e-08d822e013ad
x-ms-traffictypediagnostic: AM6PR08MB4405:|DB6PR0801MB2021:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB202172096D34BA98E3DDBBBFF7670@DB6PR0801MB2021.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lEzGUtPNHLqYjeuRLQOb/srAEqhLIU+mDxQwjfO/QtdelMerRCcJcKwcI20mXcLVEalMhdPO1nOicjpq0zkUZK/j77WYjBnhcX2On2UZimXQYbwPsfHS2zu99O1q15csV6YXF6jW3unKTNjcpZODpbEEC5IKd4B+WrdBirzla6sBmUc84069ocIkh7mND5g9zJ1bf6o1CKOqm5KJRbJsMkilun/2dgbyHWDqzBWJJ21EIKSKGoB2LqJ/9sH221TWM35w+ngiqf3fjtJKajs8LvF+Wlwt9pLZvSJFWDE5PtSG9nfszaQ5THiqd5kGJOO2a5g6Z9z1cs9IEnkfrZcU9w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(66946007)(71200400001)(8676002)(5660300002)(186003)(7696005)(52536014)(6506007)(26005)(86362001)(53546011)(110136005)(4326008)(316002)(66476007)(66556008)(64756008)(66446008)(54906003)(76116006)(8936002)(55016002)(83380400001)(2906002)(33656002)(478600001)(9686003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /OkL9YRd6u7ntzMuItcwBAR6NrlKYmkrhpRFpzl4OcX64/TTYnEqJLtFQrYKfUbsC05l9RhjNIjTDvlRs9jjRMa9RMe0M9add3hb30/qDJrsx7neFn37zELCVOlXShUNyziF8HfQs5+uyaCAMnogsSCRxAW3jGp7hfXocr1GFr2WA9UPlFH4d93aEOhOpREAFNAZCMVN18sCWxi02gDOFGef26LSbfws/Swip/S+8sepVjOgjTcrqMG4Ozk/nXeHO6MRwnuEXtkytKXH2PM7o4pyjvXuiyaB2GQr4JOP8pXrzNGsZyGVjw9HmfKXLTS/y0RErU44A2r6ZTBc6SrwXxKbV7oPFZ5b4/VCpdq4/IuH2lJoQpzHZqxFmf778D4g+/gHD+CSeq4HIQ+mYPChgRMXZTRBmEQa7bb0458gfrlff/y5V61g4GN6K3f4EpVvqEYtOltxx6Fst0msnJCaZge0ox2XFsrX/WeuyfyQmTA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4405
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(46966005)(26005)(82310400002)(55016002)(9686003)(47076004)(52536014)(86362001)(8676002)(356005)(81166007)(110136005)(33656002)(336012)(478600001)(316002)(54906003)(36906005)(186003)(2906002)(6506007)(53546011)(70586007)(70206006)(5660300002)(8936002)(7696005)(82740400003)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: aaf9bdd2-4b6c-4831-25da-08d822e00fa1
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3bcZkomX7W94AO5k9nrdT+0S8iE7o3Qdrz21lerpyWR5o0CYtYPIcNkDF5ykU5WpETzdNJWw0WJTd14mcgUAyTco170ShN7IS/fsdS5k0P9YC/7ImirFMfn8KH4yW1M7+YMtzWJhQHL/1dw68ZlQTeHNqNMFVptffNC7W0+3+E/IYImQQBtnqCn4X+TDJyA7lGZ33FiEWIkRna8q2OGQnt4WKfo6cGL3R6kYmdg5a7hE1OKV6AReR/v7j65jSEZquaD/PhdVD9wBQV3VADT7McZ0Gk6JttCNfc1ix/+BLuOSS6QkUYylmT/8n6oZRtrYBaRXXgzzoDWMIPuOkMYGZI03ADs5DOnlSQ3mbyL108vlGrAk2JsUZOd8jNBysoq/uVsL2fDqL3vex7NQqY9MQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 01:41:47.0449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b5c42a-4e88-44e0-9e5e-08d822e013ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSA3LCAy
MDIwIDc6MzQgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBDYXRhbGlu
IE1hcmluYXMNCj4gPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxA
a2VybmVsLm9yZz47IERhbiBXaWxsaWFtcw0KPiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsg
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBEYXZlDQo+IEppYW5nIDxk
YXZlLmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29t
PjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+OyBCYW9xdWFuIEhlDQo+IDxiaGVAcmVkaGF0LmNv
bT47IENodWhvbmcgWXVhbiA8aHNsZXN0ZXI5NkBnbWFpbC5jb20+OyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gbW1Aa3ZhY2sub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBLYWx5IFhp
biA8S2FseS5YaW5AYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMi8zXSBk
ZXZpY2UtZGF4OiB1c2UgZmFsbGJhY2sgbmlkIHdoZW4NCj4gbnVtYV9ub2RlIGlzIGludmFsaWQN
Cj4gDQo+IE9uIDA3LjA3LjIwIDA3OjU5LCBKaWEgSGUgd3JvdGU6DQo+ID4gUHJldmlvdXNseSwg
bnVtYV9vZmYgaXMgc2V0IHVuY29uZGl0aW9uYWxseSBhdCB0aGUgZW5kIG9mDQo+IGR1bW15X251
bWFfaW5pdCgpLA0KPiA+IGV2ZW4gd2l0aCBhIGZha2UgbnVtYSBub2RlLiBUaGVuIEFDUEkgZGV0
ZWN0cyBub2RlIGlkIGFzIE5VTUFfTk9fTk9ERSgtMSkNCj4gaW4NCj4gPiBhY3BpX21hcF9weG1f
dG9fbm9kZSgpIGJlY2F1c2UgaXQgcmVnYXJkcyBudW1hX29mZiBhcyB0dXJuaW5nIG9mZiB0aGUN
Cj4gbnVtYQ0KPiA+IG5vZGUuIEhlbmNlIGRldl9kYXgtPnRhcmdldF9ub2RlIGlzIE5VTUFfTk9f
Tk9ERSBvbiBhcm02NCB3aXRoIGZha2UgbnVtYS4NCj4gPg0KPiA+IFdpdGhvdXQgdGhpcyBwYXRj
aCwgcG1lbSBjYW4ndCBiZSBwcm9iZWQgYXMgYSBSQU0gZGV2aWNlIG9uIGFybTY0IGlmDQo+IFNS
QVQgdGFibGUNCj4gPiBpc24ndCBwcmVzZW50Og0KPiA+ICRuZGN0bCBjcmVhdGUtbmFtZXNwYWNl
IC1mZSBuYW1lc3BhY2UwLjAgLS1tb2RlPWRldmRheCAtLW1hcD1kZXYgLXMgMWcgLQ0KPiBhIDY0
Sw0KPiA+IGttZW0gZGF4MC4wOiByZWplY3RpbmcgREFYIHJlZ2lvbiBbbWVtIDB4MjQwNDAwMDAw
LTB4MmJmZmZmZmZmXSB3aXRoDQo+IGludmFsaWQgbm9kZTogLTENCj4gPiBrbWVtOiBwcm9iZSBv
ZiBkYXgwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+ID4NCj4gPiBUaGlzIGZpeGVzIGl0IGJ5
IHVzaW5nIGZhbGxiYWNrIG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgYXMgbmlkLg0KPiA+
DQo+ID4gU3VnZ2VzdGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPg0KPiA+IC0tLQ0K
PiA+IEkgbm90aWNlZCB0aGF0IG9uIHBvd2VycGMgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQg
aXMgbm90IGV4cG9ydGVkIGZvcg0KPiBtb2R1bGUNCj4gPiBkcml2ZXIuIFNldCBpdCB0byBSRkMg
ZHVlIHRvIHRoaXMgY29uY2Vybi4NCj4gPg0KPiA+ICBkcml2ZXJzL2RheC9rbWVtLmMgfCAyMiAr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2tt
ZW0uYyBiL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+IGluZGV4IDI3NWFhNWY4NzM5OS4uNjhlNjkz
Y2E2ZDU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZGF4L2ttZW0uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZGF4L2ttZW0uYw0KPiA+IEBAIC0yOCwyMCArMjgsMjIgQEAgaW50IGRldl9kYXhfa21l
bV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAlyZXNvdXJjZV9zaXplX3Qga21lbV9l
bmQ7DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKm5ld19yZXM7DQo+ID4gIAljb25zdCBjaGFyICpu
ZXdfcmVzX25hbWU7DQo+ID4gLQlpbnQgbnVtYV9ub2RlOw0KPiA+ICsJaW50IG51bWFfbm9kZSwg
bmV3X25vZGU7DQo+ID4gIAlpbnQgcmM7DQo+ID4NCj4gPiAgCS8qDQo+ID4gIAkgKiBFbnN1cmUg
Z29vZCBOVU1BIGluZm9ybWF0aW9uIGZvciB0aGUgcGVyc2lzdGVudCBtZW1vcnkuDQo+ID4gLQkg
KiBXaXRob3V0IHRoaXMgY2hlY2ssIHRoZXJlIGlzIGEgcmlzayB0aGF0IHNsb3cgbWVtb3J5DQo+
ID4gLQkgKiBjb3VsZCBiZSBtaXhlZCBpbiBhIG5vZGUgd2l0aCBmYXN0ZXIgbWVtb3J5LCBjYXVz
aW5nDQo+ID4gLQkgKiB1bmF2b2lkYWJsZSBwZXJmb3JtYW5jZSBpc3N1ZXMuDQo+ID4gKwkgKiBX
aXRob3V0IHRoaXMgY2hlY2ssIHRoZXJlIGlzIGEgcmlzayBidXQgbm90IGZhdGFsIHRoYXQgc2xv
dw0KPiA+ICsJICogbWVtb3J5IGNvdWxkIGJlIG1peGVkIGluIGEgbm9kZSB3aXRoIGZhc3RlciBt
ZW1vcnksIGNhdXNpbmcNCj4gPiArCSAqIHVuYXZvaWRhYmxlIHBlcmZvcm1hbmNlIGlzc3Vlcy4g
RnVydGhlcm1vcmUsIGZhbGxiYWNrIG5vZGUNCj4gPiArCSAqIGlkIGNhbiBiZSB1c2VkIHdoZW4g
bnVtYV9ub2RlIGlzIGludmFsaWQuDQo+ID4gIAkgKi8NCj4gPiAgCW51bWFfbm9kZSA9IGRldl9k
YXgtPnRhcmdldF9ub2RlOw0KPiA+ICAJaWYgKG51bWFfbm9kZSA8IDApIHsNCj4gPiAtCQlkZXZf
d2FybihkZXYsICJyZWplY3RpbmcgREFYIHJlZ2lvbiAlcFIgd2l0aCBpbnZhbGlkDQo+IG5vZGU6
ICVkXG4iLA0KPiA+IC0JCQkgcmVzLCBudW1hX25vZGUpOw0KPiA+IC0JCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsJCW5ld19ub2RlID0gbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQoa21lbV9zdGFy
dCk7DQo+ID4gKwkJZGV2X2luZm8oZGV2LCAiY2hhbmdpbmcgbmlkIGZyb20gJWQgdG8gJWQgZm9y
IERBWA0KPiByZWdpb24gJXBSXG4iLA0KPiA+ICsJCQludW1hX25vZGUsIG5ld19ub2RlLCByZXMp
Ow0KPiA+ICsJCW51bWFfbm9kZSA9IG5ld19ub2RlOw0KPiANCj4gTm93LCB0aGUgd2FybmluZyBk
b2VzIG5vdCByZWFsbHkgbWFrZSBzZW5zZS4gV2UgaGF2ZSBOVU1BX05PX05PREUgKDwgMCksDQo+
IHRoYXQgaXMgbm90IGEgY2hhbmdlIGluIHRoZSBuaWQsIGJ1dCBhIHNlbGVjdGlvbiBvZiBhIG5p
ZC4gUHJpbnRpbmcNCj4gTlVNQV9OT19OT0RFIGRvZXMgbm90IG1ha2UgdG9vIG11Y2ggc2Vuc2Uu
IEkgc3VnZ2VzdCBqdXN0IGdldHRpbmcgcmlkIG9mDQo+IG5ld19ub2RlIGFuZCB0dXJuaW5nIHRo
ZSBkZXZfaW5mbygpIGludG8gc29tZXRoaW5nIGxpa2UNCj4gDQo+IGRldl9pbmZvKGRldiwgInVz
aW5nIG5pZCAlZCBmb3IgREFYIHJlZ2lvbiB3aXRoIHVuZGVmaW5lZCBuaWQgJXBSXG4iLA0KPiAg
ICAgICAgICBudW1hX25vZGUsIHJlcyk7DQo+IA0KT2theSwgSSB3aWxsIHVwZGF0ZSBpdCBhcyB5
b3VyIHN1Z2d1ZXN0aW9uLiBUaGFua3MNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0K
DQoNCg==

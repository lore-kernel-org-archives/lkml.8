Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCC020738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kCQK2Onb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kCQK2Onb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgGHEIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:08:36 -0400
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:19889
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727837AbgGHEIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=kCQK2OnbUTAEw8fTS6CRfloY6muMDn7kWpIfcCN8aty3TDroBB2NYAiY8LcyPtDl/fFqaKuzPcMjj0r0XmLapJ96zsOOhABqrbB553DjBQ1u53xdM0ZF1dZhJhc+zvAzEKupkirO9pJ8QWoSoXHI3mYZN89Mvz5MaIvcN8PbKuY=
Received: from AM0PR05CA0073.eurprd05.prod.outlook.com (2603:10a6:208:136::13)
 by VI1PR0802MB2430.eurprd08.prod.outlook.com (2603:10a6:800:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 04:08:30 +0000
Received: from VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:136:cafe::1e) by AM0PR05CA0073.outlook.office365.com
 (2603:10a6:208:136::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Wed, 8 Jul 2020 04:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT054.mail.protection.outlook.com (10.152.19.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 04:08:29 +0000
Received: ("Tessian outbound 114f46c34313:v62"); Wed, 08 Jul 2020 04:08:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from 9ba354f06351.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 426D5FFC-BCA5-4C63-8ED0-11BEC10B32EB.1;
        Wed, 08 Jul 2020 04:08:24 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9ba354f06351.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 04:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0QCQnNp0tn76sSK3hKl7fXcy2xHlCQYDQcz9Ve69wSwc3/DL0rdPbli2nzEuLeCWBjUdEwoIhPkhdx2YM9UjfYw4gR79Cy+5SMzSF2HcPliItLc+1DuhMk6xzg5ZC/cpxRIiY0N/0dZx7ruoclUNZj/1RNiq3Pe85HISNZ7ZeOpWA0FDRXMFrDfNWNCcsqvCrCwU5lZcoiGsV3sIDOFKZtWEoViOHg9Mc/QJPZdqOQWesiO1TAJXrBpKuSdXUNVuZFTY77CN9iqw4+YsTNwrxzpZ4n3wgoG7gVhq6TXQ/SjfL5zfVZlm/Wmj2NK0ExHX5sIK9FvqgnZ+BePz5fvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=LtJtwpl33vBLm+azO8XwJEQ/gjqa24jqYFMYnjgsBFsYX0/Zhl2iRgpMIoq8UBANribz6DjUbRAmFwJjM3Y72UNAzvPoSfugC42KS6h8ScNctvtdTW7WIpF9ae2IpIC2Ejsrds79AOndYupEfdY1YMpJeA2SFeN68D+ooklGY+SEecW5MD44rqxjM64IKfJyZwBYFuGqV98P/ZSSe2e0LFn+nV1C6s7J1vASPNb2v4f8RItC/vyHRpbrZ+25DrIXKSjA5QzKvHzwNIGiArChfI7vaxw+dG56RUKgI1jFpMLlWfTnIL9nBk/3RCXLX+zHaKbXm2iMhShvopsV+zACtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKL+uC5bE4dFsU5eDWFNN9hq2e7PDF0lqPrghHSrnSg=;
 b=kCQK2OnbUTAEw8fTS6CRfloY6muMDn7kWpIfcCN8aty3TDroBB2NYAiY8LcyPtDl/fFqaKuzPcMjj0r0XmLapJ96zsOOhABqrbB553DjBQ1u53xdM0ZF1dZhJhc+zvAzEKupkirO9pJ8QWoSoXHI3mYZN89Mvz5MaIvcN8PbKuY=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 04:08:22 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 04:08:22 +0000
From:   Justin He <Justin.He@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
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
Subject: RE: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Topic: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Thread-Index: AQHWVCPSGGxRNvjq20KjOcC2mjPWIqj8ApMAgADwVZCAABxdAIAAAVUw
Date:   Wed, 8 Jul 2020 04:08:22 +0000
Message-ID: <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
In-Reply-To: <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 53974128-d14d-4a70-85c9-8bb860a20d6b.1
x-checkrecipientchecked: true
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a7d12aa-ce2b-42d5-da9d-08d822f49279
x-ms-traffictypediagnostic: AM6PR08MB4536:|VI1PR0802MB2430:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB243088613F4A7A1EA4042CDCF7670@VI1PR0802MB2430.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 94B9ujPrF2FPr7Z3xjZUdzaxqz8sZ74G2A9P6iocoYTUDnNoex1dSQOCSB+yErccE/sKv7XYJAfnktU94trd7+zNuOe2MN4cFvzZmn7GPUaWO21hhydIgFAe8n1XaQBO767250/9FtRAaQgRJBg+5baMq+V5NvDB3z5kxuHiS3LFuop5GROpg4MWLtb5x7cvxVrgZquNp4iTTg2YK+wjSXvCJkxF5R0ra7u4xubo5SBCxK1YKIz8peuzPLYRo5ahmhuqTpDblAy2w6veHKDrDhJcWRhtjwVXOM/p4irUDM4SOMJxup2veKnHhOze2aL0Z5mkqrHKpv3OvAemUVNRFg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(55016002)(8936002)(7416002)(478600001)(9686003)(316002)(86362001)(33656002)(8676002)(53546011)(186003)(6506007)(26005)(5660300002)(7696005)(52536014)(71200400001)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(2906002)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yw9lJE8pLGxjwMQln8AO8921NYl/dd66f8k0jfPknRfdT7UqdwEIsihiLSEmPaRwOTh7pvkuyubblwy1+j5o6PyIocnapLmJ2jIhsZMqFGGQpSRefJolNvJuy3M91/muqKyKRTwkAss7C3cgKttBtIAPyDcLABrMhfQ1NwlirL6lgm4TSi9JQLk1idSlvtJV9p+c8BChpmEqD8aJbjN5uFB5bP7D8u8gnVhPWGMxgYnUoWZKt6mut2L1g1hNHD2v64rfWYQAj2rMxk93H2v49WgQRVNQ/bvsoH3NqvcUlDoAsZSPQhwcSnRudBmGqLdpAOYKCD+i9yUhbXcW1YnBBFBjxnCQ4hgQ3Go3GzQquLbVIAaIMbOaXmYKhDf41gG9FGRS7OqgzqybAwNmKl3vkKZ8jNdXmyV4CuqzoJrzyK0jpVI2ej3DsXWI4TShbTVphdpi3bwqf9wyJ7hsn0Ys3OKE2OKI8/yGNdp8gYUgKtA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39850400004)(136003)(46966005)(54906003)(36906005)(47076004)(316002)(82740400003)(33656002)(8676002)(336012)(83380400001)(5660300002)(2906002)(7696005)(70586007)(70206006)(52536014)(6862004)(53546011)(6506007)(4326008)(26005)(186003)(8936002)(478600001)(55016002)(82310400002)(356005)(86362001)(9686003)(81166007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4162fb3f-ccf9-43e9-dfe3-08d822f48e68
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQzfUzgwpdWuRzibKVBCT50Yk7Gp3HLWnC3js+18tvw6PdDLGu4R4LrflygJ7HohBM9msiRi3E2WssOYhFyhnZGyQayl7Q477N0WObTobtDAPAm9vwsS6QxHKLtfl6njS2aexlZvUbV2LqAqVwl4Moop0eju6mT1s/cqTpEjLbZtO+DmltyOaLi1oHTU02Y8EiCSXwg/g5TTVMcX444BBBDtdqWoeW+zJL7Uu8EKRx65aQSimrtGuiiM/j2FAm2VsXdYZ3KgF7FfO9nGZ0AfYhsocYILqb0Xy6KsDcupySOY3/lIzlkuW3/KPKbqDp9ZeukQ8j77oktZvZ7t2coBXVEWn9XNEOillPE8t98XaRDIxfViKCozZDj117GMLdyPWM41y6zoZWqChP0Hc1qOhQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 04:08:29.6616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7d12aa-ce2b-42d5-da9d-08d822f49279
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA4
LCAyMDIwIDExOjU3IEFNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBD
YzogTWljaGFsIEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz47IERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPjsNCj4gQ2F0YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJt
LmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ow0KPiBWaXNoYWwgVmVybWEgPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT47IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29t
PjsNCj4gQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IE1pa2UgUmFw
b3BvcnQNCj4gPHJwcHRAbGludXguaWJtLmNvbT47IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29t
PjsgQ2h1aG9uZyBZdWFuDQo+IDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzsNCj4gS2FseSBY
aW4gPEthbHkuWGluQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBhcm02
NC9udW1hOiBleHBvcnQgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQNCj4gYXMgRVhQT1JUX1NZ
TUJPTF9HUEwNCj4gDQo+IE9uIFR1ZSwgSnVsIDcsIDIwMjAgYXQgNzoyMCBQTSBKdXN0aW4gSGUg
PEp1c3Rpbi5IZUBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIE1pY2hhbCBhbmQgRGF2aWQN
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1pY2hh
bCBIb2NrbyA8bWhvY2tvQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKdWx5IDcs
IDIwMjAgNzo1NSBQTQ0KPiA+ID4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+
ID4gPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IFdpbGwg
RGVhY29uDQo+ID4gPiA8d2lsbEBrZXJuZWwub3JnPjsgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+OyBWaXNoYWwNCj4gVmVybWENCj4gPiA+IDx2aXNoYWwubC52ZXJtYUBp
bnRlbC5jb20+OyBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEFuZHJldw0KPiA+
ID4gTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWlrZSBSYXBvcG9ydCA8cnBw
dEBsaW51eC5pYm0uY29tPjsNCj4gPiA+IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPjsgQ2h1
aG9uZyBZdWFuIDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT47DQo+IGxpbnV4LQ0KPiA+ID4gYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gPiA+IG1tQGt2YWNrLm9yZzsgbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzsgS2Fs
eSBYaW4gPEthbHkuWGluQGFybS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEv
M10gYXJtNjQvbnVtYTogZXhwb3J0DQo+IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkDQo+ID4g
PiBhcyBFWFBPUlRfU1lNQk9MX0dQTA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSAwNy0wNy0yMCAxMzo1
OToxNSwgSmlhIEhlIHdyb3RlOg0KPiA+ID4gPiBUaGlzIGV4cG9ydHMgbWVtb3J5X2FkZF9waHlz
YWRkcl90b19uaWQoKSBmb3IgbW9kdWxlIGRyaXZlciB0byB1c2UuDQo+ID4gPiA+DQo+ID4gPiA+
IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKCkgaXMgYSBmYWxsYmFjayBvcHRpb24gdG8gZ2V0
IHRoZSBuaWQgaW4NCj4gY2FzZQ0KPiA+ID4gPiBOVU1BX05PX05JRCBpcyBkZXRlY3RlZC4NCj4g
PiA+ID4NCj4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L21tL251bWEuYyB8IDUgKysrLS0N
Cj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL251bWEuYyBiL2Fy
Y2gvYXJtNjQvbW0vbnVtYS5jDQo+ID4gPiA+IGluZGV4IGFhZmNlZTNlM2Y3ZS4uN2VlYjMxNzQw
MjQ4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL2FybTY0L21tL251bWEuYw0KPiA+ID4gPiAr
KysgYi9hcmNoL2FybTY0L21tL251bWEuYw0KPiA+ID4gPiBAQCAtNDY0LDEwICs0NjQsMTEgQEAg
dm9pZCBfX2luaXQgYXJtNjRfbnVtYV9pbml0KHZvaWQpDQo+ID4gPiA+DQo+ID4gPiA+ICAvKg0K
PiA+ID4gPiAgICogV2UgaG9wZSB0aGF0IHdlIHdpbGwgYmUgaG90cGx1Z2dpbmcgbWVtb3J5IG9u
IG5vZGVzIHdlIGFscmVhZHkNCj4ga25vdw0KPiA+ID4gYWJvdXQsDQo+ID4gPiA+IC0gKiBzdWNo
IHRoYXQgYWNwaV9nZXRfbm9kZSgpIHN1Y2NlZWRzIGFuZCB3ZSBuZXZlciBmYWxsIGJhY2sgdG8N
Cj4gdGhpcy4uLg0KPiA+ID4gPiArICogc3VjaCB0aGF0IGFjcGlfZ2V0X25vZGUoKSBzdWNjZWVk
cy4gQnV0IHdoZW4gU1JBVCBpcyBub3QgcHJlc2VudCwNCj4gPiA+IHRoZSBub2RlDQo+ID4gPiA+
ICsgKiBpZCBtYXkgYmUgcHJvYmVkIGFzIE5VTUFfTk9fTk9ERSBieSBhY3BpLCBIZXJlIHByb3Zp
ZGUgYQ0KPiBmYWxsYmFjaw0KPiA+ID4gb3B0aW9uLg0KPiA+ID4gPiAgICovDQo+ID4gPiA+ICBp
bnQgbWVtb3J5X2FkZF9waHlzYWRkcl90b19uaWQodTY0IGFkZHIpDQo+ID4gPiA+ICB7DQo+ID4g
PiA+IC0gICBwcl93YXJuKCJVbmtub3duIG5vZGUgZm9yIG1lbW9yeSBhdCAweCVsbHgsIGFzc3Vt
aW5nIG5vZGUgMFxuIiwNCj4gPiA+IGFkZHIpOw0KPiA+ID4gPiAgICAgcmV0dXJuIDA7DQo+ID4g
PiA+ICB9DQo+ID4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChtZW1vcnlfYWRkX3BoeXNhZGRyX3Rv
X25pZCk7DQo+ID4gPg0KPiA+ID4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGV4cG9ydCBhIG5vb3Ag
ZnVuY3Rpb24/IFdvdWxkbid0IG1ha2UgbW9yZSBzZW5zZQ0KPiA+ID4gdG8gc2ltcGx5IG1ha2Ug
aXQgc3RhdGljIGlubGluZSBzb21ld2hlcmUgaW4gYSBoZWFkZXI/IEkgaGF2ZW4ndA0KPiBjaGVj
a2VkDQo+ID4gPiB3aGV0aGVyIHRoZXJlIGlzIGFuIGVhc3kgd2F5IHRvIGRvIHRoYXQgc2FuZWx5
IGJ1IHRoaXMganVzdCBoaXQgbXkNCj4gZXllcy4NCj4gPg0KPiA+IE9rYXksIEkgY2FuIG1ha2Ug
YSBjaGFuZ2UgaW4gbWVtb3J5X2hvdHBsdWcuaCwgc3RoIGxpa2U6DQo+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZW1vcnlf
aG90cGx1Zy5oDQo+ID4gQEAgLTE0OSwxMyArMTQ5LDEzIEBAIGludCBhZGRfcGFnZXMoaW50IG5p
ZCwgdW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+IHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMsDQo+
ID4gICAgICAgICAgICAgICBzdHJ1Y3QgbWhwX3BhcmFtcyAqcGFyYW1zKTsNCj4gPiAgI2VuZGlm
IC8qIEFSQ0hfSEFTX0FERF9QQUdFUyAqLw0KPiA+DQo+ID4gLSNpZmRlZiBDT05GSUdfTlVNQQ0K
PiA+IC1leHRlcm4gaW50IG1lbW9yeV9hZGRfcGh5c2FkZHJfdG9fbmlkKHU2NCBzdGFydCk7DQo+
ID4gLSNlbHNlDQo+ID4gKyNpZiAhZGVmaW5lZChDT05GSUdfTlVNQSkgfHwgIWRlZmluZWQobWVt
b3J5X2FkZF9waHlzYWRkcl90b19uaWQpDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IG1lbW9yeV9h
ZGRfcGh5c2FkZHJfdG9fbmlkKHU2NCBzdGFydCkNCj4gPiAgew0KPiA+ICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPiArI2Vsc2UNCj4gPiArZXh0ZXJuIGludCBtZW1vcnlfYWRkX3BoeXNh
ZGRyX3RvX25pZCh1NjQgc3RhcnQpOw0KPiA+ICAjZW5kaWYNCj4gPg0KPiA+IEFuZCB0aGVuIGNo
ZWNrIHRoZSBtZW1vcnlfYWRkX3BoeXNhZGRyX3RvX25pZCgpIGhlbHBlciBvbiBhbGwgYXJjaGVz
LA0KPiA+IGlmIGl0IGlzIG5vb3AocmV0dXJuIDApLCBJIGNhbiBzaW1wbHkgcmVtb3ZlIGl0Lg0K
PiA+IGlmIGl0IGlzIG5vdCBub29wLCBhZnRlciB0aGUgaGVscGVyLA0KPiA+ICNkZWZpbmUgbWVt
b3J5X2FkZF9waHlzYWRkcl90b19uaWQNCj4gPg0KPiA+IFdoYXQgZG8geW91IHRoaW5rIG9mIHRo
aXMgcHJvcG9zYWw/DQo+IA0KPiBFc3BlY2lhbGx5IGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgdXNl
IG1lbWJsb2NrIGluZm8gZm9yIG51bWEgaW5mbw0KPiAod2hpY2ggc2VlbXMgdG8gYmUgZXZlcnlv
bmUgZXhjZXB0IHg4Nikgd2h5IG5vdCBpbXBsZW1lbnQgYSBnZW5lcmljDQo+IG1lbW9yeV9hZGRf
cGh5c2FkZHJfdG9fbmlkKCkgdGhhdCBkb2VzOg0KPiANCj4gaW50IG1lbW9yeV9hZGRfcGh5c2Fk
ZHJfdG9fbmlkKHU2NCBhZGRyKQ0KPiB7DQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBzdGFydF9w
Zm4sIGVuZF9wZm4sIHBmbiA9IFBIWVNfUEZOKGFkZHIpOw0KPiAgICAgICAgIGludCBuaWQ7DQo+
IA0KPiAgICAgICAgIGZvcl9lYWNoX29ubGluZV9ub2RlKG5pZCkgew0KPiAgICAgICAgICAgICAg
ICAgZ2V0X3Bmbl9yYW5nZV9mb3JfbmlkKG5pZCwgJnN0YXJ0X3BmbiwgJmVuZF9wZm4pOw0KPiAg
ICAgICAgICAgICAgICAgaWYgKHBmbiA+PSBzdGFydF9wZm4gJiYgcGZuIDw9IGVuZF9wZm4pDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBuaWQ7DQo+ICAgICAgICAgfQ0KPiAgICAg
ICAgIHJldHVybiBOVU1BX05PX05PREU7DQo+IH0NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rp
b24sDQpDb3VsZCBJIHdyYXAgdGhlIGNvZGVzIGFuZCBsZXQgbWVtb3J5X2FkZF9waHlzYWRkcl90
b19uaWQgc2ltcGx5IGludm9rZQ0KcGh5c190b190YXJnZXRfbm9kZSgpPyANCg0KDQotLQ0KQ2hl
ZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K

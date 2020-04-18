Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BC4C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37068221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zxJZusx8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zxJZusx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgDRUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:31:16 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:49219
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbgDRUbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f5Lod3OTKgwE11fczhiW98zGne2aQQCpD+EHwSlRds=;
 b=zxJZusx8AToGPrbGiBZkDKg77JQgJ/RUC569tqakCLBi28dlgH8uEXFywAGzbmGvxWL3SbGKQ5QddR1DoukXGLSCgoLX4izNWPxHaJViaNRcOB8wssEZJt/nTdbRfPxBvgppG0bbHfOStJvw9lOZ51wxMsrzFkq/lKtZp8s+gQ4=
Received: from AM6PR10CA0068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::45)
 by AM6PR08MB3352.eurprd08.prod.outlook.com (2603:10a6:209:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sat, 18 Apr
 2020 20:31:10 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::fd) by AM6PR10CA0068.outlook.office365.com
 (2603:10a6:209:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Sat, 18 Apr 2020 20:31:10 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.18 via Frontend Transport; Sat, 18 Apr 2020 20:31:09 +0000
Received: ("Tessian outbound 43fc5cd677c4:v53"); Sat, 18 Apr 2020 20:31:09 +0000
X-CR-MTA-TID: 64aa7808
Received: from 4e7ac3a0e3bb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FB220D39-C960-41F9-BD8D-04B0081FC071.1;
        Sat, 18 Apr 2020 20:31:04 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4e7ac3a0e3bb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 18 Apr 2020 20:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMW/mh0dRn4xG6n5ks0IBw3h8gLP35VTw63fFMH3mOqeIGCwhADeA4Z08A+EF5GKSlBjcATYJyzEByDGuPCQPexWuprpvq0dxaiCK3/ZC3Y4P2V8u3IryULptSyTcsKCycwIKb2R+JqVKxwtPCNHuJzru0HuRjwGNbFmLgWtTpWuV3bLfqE7Cjeuh6cpVrrDBWr6XJ3s0I8/S9dX0rvIRlQ9ztqi4KOBprfVkErQYoG01jbpaBaovutcUYWknvL5sN+YOEg3O7SjW/tdkRk7B13IA5zS/F7M54dQFIGvZn6VWQKka3JfrsvFpAHoqJYHgWPh/SwPPvrAMBqQ+Q18+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f5Lod3OTKgwE11fczhiW98zGne2aQQCpD+EHwSlRds=;
 b=M675FcwmlgDr1WMFEsb9Qcac8Tg40rQdvFUv1PjkUoyYraKwTOaeTkbFyEEJx3FHOR3d8AkB+SBrKanN0jcsAPjLvmvr0jDNRu2RRrDiyFbp+t3eIlEpHmCYNuUd69Ttp3KXgqn1nkIYXiwsfJl2pdQWsusE8bT+uPMbUl/Ukxnfa+xrWQAOVsdj7QZKbVgqeGqDeu2XSkRqahIcO1PQhrrcMsiD7lzISZ/eAJpNzee7bZV2tjPQCpWPyVycDXgAKyKdu8lqtrbvZVsFAlg6xbBCm1WjGLA3E09+ZNd+TrxzNk1ba/mVWXFv1B3V6M/sZiYMD+z34SPH+2+G8u67PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f5Lod3OTKgwE11fczhiW98zGne2aQQCpD+EHwSlRds=;
 b=zxJZusx8AToGPrbGiBZkDKg77JQgJ/RUC569tqakCLBi28dlgH8uEXFywAGzbmGvxWL3SbGKQ5QddR1DoukXGLSCgoLX4izNWPxHaJViaNRcOB8wssEZJt/nTdbRfPxBvgppG0bbHfOStJvw9lOZ51wxMsrzFkq/lKtZp8s+gQ4=
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com (2603:10a6:4:a0::12)
 by DB6PR0802MB2280.eurprd08.prod.outlook.com (2603:10a6:4:80::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sat, 18 Apr
 2020 20:31:01 +0000
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117]) by DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117%8]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 20:31:00 +0000
From:   Hadar Gat <Hadar.Gat@arm.com>
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC:     Ofir Drang <Ofir.Drang@arm.com>,
        Gilad Ben Yossef <Gilad.BenYossef@arm.com>, nd <nd@arm.com>
Subject: RE: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Thread-Topic: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Thread-Index: AQHWFW48sqdeVFxZnkOUS/sdJEIQwah/VA9Q
Date:   Sat, 18 Apr 2020 20:31:00 +0000
Message-ID: <DB6PR0802MB2533670AFC1473E5C5EDAD28E9D60@DB6PR0802MB2533.eurprd08.prod.outlook.com>
References: <20200418104343.GA5132@amd>
In-Reply-To: <20200418104343.GA5132@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 33284bc5-f192-4685-9e2b-7d59072c46b6.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
x-originating-ip: [84.109.179.203]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92e5861b-3b34-484d-72fc-08d7e3d76de4
x-ms-traffictypediagnostic: DB6PR0802MB2280:|DB6PR0802MB2280:|AM6PR08MB3352:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3352A46365AA280AAF274688E9D60@AM6PR08MB3352.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;OLM:1388;
x-forefront-prvs: 0377802854
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2533.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(26005)(71200400001)(53546011)(4744005)(7696005)(6506007)(966005)(478600001)(2906002)(52536014)(316002)(186003)(54906003)(110136005)(8936002)(81156014)(8676002)(76116006)(66946007)(66476007)(55016002)(66446008)(64756008)(66556008)(33656002)(9686003)(86362001)(4326008)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eLkwsFTucosA9bQ1c0I/P0mT5jK1VABMKsZzVd4pTdX/LC7HXLFbNu5O73sSu5MJDJCfX5wSM6p9kGS7SjPOp72I4TGFAx9WSQFyUUENMkMwPXL/JJM6jvoew2wVb/nOYu0nZWcbADq6dHCNQT+IAB4Im8xU23JdZArydpR+BL5/EMu3jjXVShyqIonabsz5h0VkZpWQd+R0F8HbiWdzhQpRHidrqls+B/qoKb/I4gdOTdksrI529bUhRo6eqCiyithizDxR15nWmLdZ/eEPUIrnyKQrOeQ7kXagde3GwN50M6wpsQHjqupbq3yWc7/P2tbss8StqNmo8rJTjjN7VoigsgtJbRuHWMNpIILdTXzjqCUyY784m6EZx18Jz8h+XxlEbtz4ZwHgg0vh4wMKJzFLncFVGGQHYEcTw83/SAi2s2Cq0/5OUyMUxjdWwDpsiUrC3grc0gf2ypfiVYm0UEV/EF3+Rdq6pctxC9uh5LVze83s+tsk8VIPpdKNfrNNhQH+33hL2OEnckpXBqIH9w==
x-ms-exchange-antispam-messagedata: Yxg0H7Mw63wlKxFYKlJFyqmczldwWXcIpXB0ia+tKZsFYR1M7hRFTaNBw6B9XifWCRaGvbi4eD0KmhMFm3ZV0K9Ps7zLTeSaBR9NKox8sbl3A1BvARoJN5HoIuQYN308yJjjAzVISOOdnucNTSyJ0A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2280
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(336012)(53546011)(6506007)(8936002)(26005)(8676002)(81156014)(86362001)(186003)(7696005)(478600001)(4326008)(966005)(316002)(36906005)(81166007)(356005)(82740400003)(47076004)(33656002)(52536014)(55016002)(4744005)(2906002)(110136005)(54906003)(9686003)(70206006)(70586007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ab32c492-82da-4e74-3eb9-08d7e3d768aa
X-Forefront-PRVS: 0377802854
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9ggUrcjG6Z2EN/LtYrwLihCfTjlADBr+pP8r+ZH2EngCAL2n9IK9EZBbjK+6fJaYrsPkA73AkAtuyCUSX1+A2fU6dG0CxCUZtp8AEx5wOSasG3gB931JC/LabBJlAu6YhdRUrXxsfAfJb3MukkRTtYfP0k1silovQLx/C+ugQW1QmExXK2cg9sQwzry8yOxbGxJtpXYAp21Rf+ILkq9i2QxuAnpUSLP1jE7qvFCjcsYJuF2sIwHqQpc4L5jTU8ixCHOSR183SVNbLoEBx5QUm4ELgRK3XOAUvaBW+qAbnhG4SnoCxs3kpqYV6P87tPnahDNXdctsc10OvG83jx50b9Y+XZRSuT3gU/KBizEc0yRK4leM3Ymnoz7mhK91BK+tg656x156tP8YgUb8o/64t/xrubrCzSPGN2stLx9SGYA9fgOgoH1f6oJYR7rqwtXUMcrLYiDNOKg1UPG1WPOF1mEUrp+fxb7eWcwamstrxEtH2r/iINjDhhhjcf4fbZ0mCwpZcUSUH2fK+NrOrzDy6mL9yzHzSLTs1dhelbouJNJ1iK5mLXPuvowalgP7Y7S0Ew1HDnzRkdjIPk25NXs/A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2020 20:31:09.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e5861b-3b34-484d-72fc-08d7e3d76de4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF2ZWwsDQpJIHRoaW5rIHlvdSBnb3QgaXQgcmlnaHQuLg0KSW5kZWVkLCBBcm0gQ3J5cHRv
Q2VsbCBDQ1RSTkcgZHJpdmVyIGNvdWxkbid0IGJlIHVzZWQgYW5kIG9idmlvdXNseSB1c2VsZXNz
IGlmIHRoZSBBcm0gQ3J5cHRvQ2VsbCBIVyBkb2VzIG5vdCBleGlzdCBpbiB0aGUgc3lzdGVtLg0K
QlIsDQpIYWRhcg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVs
IE1hY2hlayA8cGF2ZWxAdWN3LmN6Pg0KPiBTZW50OiBTYXR1cmRheSwgMTggQXByaWwgMjAyMCAx
Mzo0NA0KPiBUbzoga2VybmVsIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBI
YWRhciBHYXQNCj4gPEhhZGFyLkdhdEBhcm0uY29tPjsgaGVyYmVydEBnb25kb3IuYXBhbmEub3Jn
LmF1DQo+IFN1YmplY3Q6IEFybSBDcnlwdG9DZWxsIGRyaXZlciAtLSBkZWZhdWx0IFksIGV2ZW4g
b24gbWFjaGluZXMgd2hlcmUgaXQgaXMNCj4gb2J2aW91c2x5IHVzZWxlc3MNCj4gDQo+IEhpIQ0K
PiANCj4gSSdtIGNvbmZpZ3VyaW5nIGtlcm5lbCBmb3IgeDg2LCBhbmQgSSBnZXQgb2ZmZXJlZCBI
V19SQU5ET01fQ0NUUk5HIHdpdGgNCj4gZGVmYXVsdD1ZLCBhbmQgaGVscCB0ZXh0IHN1Z2dlc3Rp
bmcgSSBzaG91bGQgZW5hYmxlIGl0Lg0KPiANCj4gVGhhdCdzLi4uIHR3byB3cm9uZyBzdWdnZXN0
aW9ucywgcmlnaHQ/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJCVBhdmVsDQo+IC0t
DQo+IChlbmdsaXNoKSBodHRwOi8vd3d3LmxpdmVqb3VybmFsLmNvbS9+cGF2ZWxtYWNoZWsNCj4g
KGNlc2t5LCBwaWN0dXJlcykNCj4gaHR0cDovL2F0cmV5Lmthcmxpbi5tZmYuY3VuaS5jei9+cGF2
ZWwvcGljdHVyZS9ob3JzZXMvYmxvZy5odG1sDQo=

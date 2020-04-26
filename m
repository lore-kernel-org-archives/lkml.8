Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D631C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3750120700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WqJDCwK0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WqJDCwK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDZFej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 01:34:39 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:26894
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgDZFei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 01:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT8xM7TuDYqVUNcAOsMT5tS9oDCeWHXj2KiKZYrJ4Ns=;
 b=WqJDCwK0cnrItllZf8uVmzKiW/oJfIr1jQ3QBaw0PFVPO2QtwKrO9eo8yNtUmY55LuMzB5TACmWJ1FYHzQiXzusXfF/P/5O1JvURAkrErFKmr93h4yhQbF7AgQBedWK0eVgasjdLI9sQEANmYs4ZY07ZWt4kgytyXCNdRGJr1Mo=
Received: from AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) by AM4PR0802MB2371.eurprd08.prod.outlook.com
 (2603:10a6:200:5d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 05:34:34 +0000
Received: from AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:200:89:cafe::42) by AM4PR0202CA0004.outlook.office365.com
 (2603:10a6:200:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 05:34:34 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT033.mail.protection.outlook.com (10.152.16.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.19 via Frontend Transport; Sun, 26 Apr 2020 05:34:34 +0000
Received: ("Tessian outbound 11763d234d54:v54"); Sun, 26 Apr 2020 05:34:34 +0000
X-CR-MTA-TID: 64aa7808
Received: from e29db73a4fc4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C91A35D0-4721-4EF1-A49A-6D38629E106B.1;
        Sun, 26 Apr 2020 05:34:29 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e29db73a4fc4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 26 Apr 2020 05:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGaUDnSfBdDJbKhAHAcrjxOGOc6uj680BiRTG9eU1rmYYWQ3DE0OzdXfIecUB5cO2Xqo+saVpCNHs2+LZ8nVEUwtzsg2kUWPri08oHVhboScg0tc197VkJL9weftJRaav+MIpcLi8Y+sN8KDBrRVRKze3OVAxQGyV42T0lEm3YPSicDWyFGCscHWhf7NhJ9SW2n5m29Xn+19Uz527Hry1Z5+0J8yNcVO8ZQsPu46cax9xovjnn1tNhN+aVRDg6RqvRuVtf/aSnKJTSzEAON8Qcx4cqRK4goaVloRRW2GTvKeZ5gZr4ogQq2MPUTAVUwa5p6e8ksitFJJxBMz6Y+g6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT8xM7TuDYqVUNcAOsMT5tS9oDCeWHXj2KiKZYrJ4Ns=;
 b=l/LeFP7KAsgz87CfvU+T6gY2R3Nyp4b9WVxhgNhRDNR4ckWSPuX+3p2OIjLa2Fl1JQxhxXDv3mzklk3YPhS6O8UR7ClHnpWuCtr7voxOqjjS9XjQzZlcspOfi0WAfk57dJkNgq3PwkbJHQhokyWG5/s0XRKRYDwj/dMj5zOnnMc9k60T4bDROG7sUh8hSQNKg5ltccN/MVEkKV+vB3nzrpltuC218MC79PXdZTUIrUvzM8CPbHb75bRY2IZuiXaYgYovXs8bAN3VHdvBo7RgzclGP/2Y7rFpPzQLcmRJd89Cgm8PogdZDp5QI2QzT54ep1xJQD6GIpNakkWF4jJbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT8xM7TuDYqVUNcAOsMT5tS9oDCeWHXj2KiKZYrJ4Ns=;
 b=WqJDCwK0cnrItllZf8uVmzKiW/oJfIr1jQ3QBaw0PFVPO2QtwKrO9eo8yNtUmY55LuMzB5TACmWJ1FYHzQiXzusXfF/P/5O1JvURAkrErFKmr93h4yhQbF7AgQBedWK0eVgasjdLI9sQEANmYs4ZY07ZWt4kgytyXCNdRGJr1Mo=
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com (2603:10a6:4:a0::12)
 by DB6PR0802MB2456.eurprd08.prod.outlook.com (2603:10a6:4:a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 05:34:27 +0000
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117]) by DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117%8]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 05:34:26 +0000
From:   Hadar Gat <Hadar.Gat@arm.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Gilad Ben Yossef <Gilad.BenYossef@arm.com>, nd <nd@arm.com>
Subject: RE: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Thread-Topic: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Thread-Index: AQHWFW48sqdeVFxZnkOUS/sdJEIQwah/VA9QgAsPKACAAIpqEA==
Date:   Sun, 26 Apr 2020 05:34:26 +0000
Message-ID: <DB6PR0802MB25335509FA5B8EF19736A96AE9AE0@DB6PR0802MB2533.eurprd08.prod.outlook.com>
References: <20200418104343.GA5132@amd>
 <DB6PR0802MB2533670AFC1473E5C5EDAD28E9D60@DB6PR0802MB2533.eurprd08.prod.outlook.com>
 <20200425211818.GB27781@amd>
In-Reply-To: <20200425211818.GB27781@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: a6f58350-9a03-4f83-9c20-2a60193ac274.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
x-originating-ip: [84.109.179.203]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7856cd2-d71c-46a4-73d4-08d7e9a380ad
x-ms-traffictypediagnostic: DB6PR0802MB2456:|DB6PR0802MB2456:|AM4PR0802MB2371:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2371FE60C47E1F9C9659E497E9AE0@AM4PR0802MB2371.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1751;OLM:1751;
x-forefront-prvs: 03853D523D
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2533.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(478600001)(33656002)(316002)(26005)(71200400001)(4744005)(7696005)(186003)(76116006)(64756008)(66946007)(54906003)(86362001)(66446008)(66556008)(66476007)(52536014)(6506007)(55016002)(6916009)(9686003)(4326008)(5660300002)(2906002)(8676002)(81156014)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RMnagF46PGgGPp2ovnWTIgZJbVIwXM9crMvpu5xbPhcpHpCZAtbd429m+XEQYtFwUEVXu0Re7wf0QzGTe7lOYa4rIu3RLH9+7YfhXSQTNKlUVCAUuoa/7a83k3PW9OwAgx+S4fBfOHcMR1XcFvTUI4lBpadRWXy6OiFnD/04ty7qDcFK10J5wMVp1pZj3bt0tS/16fb879Sa1lV4uswi7D14eaQsXyFy7HAWKzTAxGfLlBCeSEsj2byI8RC7VWtAjiiiThbMFBnWr3rIXMvxgpN1HBJSMnJDoXD9Hux6wrPnGHBqAC0yRSA2iS91CGhDDRf+NoN92gbJfrMIS3zC3QkS0lBplYciyrswQerg+mbO6qstrwh+N5yGNZJvqiJjtDcPn5ioUkMHg6ouaiEZIcIRKZeb++mGuDo+couG7rwWLC7jxxQSKyqEdlC8bDeI
x-ms-exchange-antispam-messagedata: 95PSBiA2/KLfHGog58e4uChD3s8TY7nUO4uEhGyQrAYusLvPFEUcA8jy45pHvlRbF35/a8niMMU8a/8U2muUA8T9DqEryppwtRu1+E5kxtI1A2YVuAg+y5mZTmLUpqevjCQoeClsxh9K1RDq5ijZTlGMG2CcVNk5x3Q+xMHnQWLtrfmbfrXkrYFnBGvZM7ztCYtaeJVwewSX3uGY1/W8nv1tPFWQaB6iDaZiwyFbLEzhqdLyYUv7Y7kOxYDDpBq+tRn7bBLuc1a4Rsy5u++5hte1mC7aLYl/15w3MtxlLqZ0kn96szP/NVAjE176cpwP0c3Nwl4OSBIYi9U6hCEc4k1zj2cGKO+GoLiq6uFOVm7HIaQOjiFQnczOYqdj1PLNPtt01GWFaTrYjG2og2OkzYXsaaku5UGRuDm8lFbDfnOROx78NJXHmoRnt97hmSmjV14Oy6vHlV73lpzTBcn0h0dUygB/PSdD+CKGojb8o+zYUNo1fCMZUxsXvNYWbhSrXHsYGmGk0DGpLGNuPQc8aeLOEph6eBkHokBr7Cva+uu89KZ8LEhoxTddsn3IDZdBLApK/IqwPSt0aG05XlpDYkl3s3LJwZWfexJNeWtp1nfr3Ia5qz8TQ5knk0tC5N/EVURRjwfGWJdENhoFn84BUF8feRcDRQ//rGarPBT+VR8dtULqcmuWd2hsCNPMdJ2Qwnbrh2laCN5Vb9iOFvq+8hKar3QCn9Mme8sI2WXJavQmkoqrVFx1zX34cfa2MLMK5n6nmy48khvOgJWylJ7s0now8+ID/4wTOtWfuF+DkS4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2456
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39850400004)(376002)(396003)(46966005)(6862004)(81166007)(36906005)(186003)(52536014)(86362001)(4744005)(316002)(7696005)(5660300002)(70586007)(4326008)(6506007)(336012)(82310400002)(478600001)(26005)(2906002)(70206006)(54906003)(47076004)(81156014)(33656002)(9686003)(8936002)(55016002)(82740400003)(356005)(8676002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b318a9fe-75e2-4e38-971d-08d7e9a37c1c
X-Forefront-PRVS: 03853D523D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtL2N9Db14Ff6ded7b8TetEVpHRMaIKpB+32D0U/x3Jt8L/tt2K1nyyy0Te8LnxV/Qs4yg2S5ilBfTGAOx2HKxH7d09nm/PsmmEPUub1hT/4tGHzEy5716892DOBr22WONcBEfdHAZRyV1XJ0NL8yZfadnhnrxyqi8HDFDui8n3mBo6ui5t8MbOVYUfyTsyXhCx5kDpzTtFihFzWGcjCYUqwXk2x66y+GYIPPW7K/NAS1pS4ht8NujfFQkzGRBQBclOXg+L+vAHJ6SurSuQmAYj6fMP+t7ArvWyyJxqytOPT2aKjN4kqB0141YIGGUaSO6rwGwI1KY/9IdpH38wXlhEJ4xXolU5jsJNlsrXw9Fg5lm+7Ni37RixXZTyBkviwQkMCFqk6F/7ez82FX3kzLA1N6rfLC8JjkeepTMkp/k1YzoPZJfp1mYt8eFq0oF7I+VLnBitMxtbKSdJB5btcOyIiSWqJLu8Jcx9bn8ic2zZYrsGM6CfMBPIpvg7jG84S/iD16kP7k30CD1P+KCXd1Q==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 05:34:34.3173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7856cd2-d71c-46a4-73d4-08d7e9a380ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1hY2hlayA8cGF2
ZWxAdWN3LmN6Pg0KPiBTZW50OiBTdW5kYXksIDI2IEFwcmlsIDIwMjAgMDoxOA0KPiANCj4gT24g
U2F0IDIwMjAtMDQtMTggMjA6MzE6MDAsIEhhZGFyIEdhdCB3cm90ZToNCj4gPiBIaSBQYXZlbCwN
Cj4gPiBJIHRoaW5rIHlvdSBnb3QgaXQgcmlnaHQuLg0KPiA+IEluZGVlZCwgQXJtIENyeXB0b0Nl
bGwgQ0NUUk5HIGRyaXZlciBjb3VsZG4ndCBiZSB1c2VkIGFuZCBvYnZpb3VzbHkNCj4gdXNlbGVz
cyBpZiB0aGUgQXJtIENyeXB0b0NlbGwgSFcgZG9lcyBub3QgZXhpc3QgaW4gdGhlIHN5c3RlbS4N
Cj4gDQo+IFl1cC4uIFNvLi4gY2FuIGF1dGhvcnMgZml4IGl0IHNvbWVob3c/DQo+IA0KDQpZZXMu
IEknbSBvbiBpdC4NCg==

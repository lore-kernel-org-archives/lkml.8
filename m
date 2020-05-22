Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D02C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC572054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jrBq7QyS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jrBq7QyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgEVPXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:23:02 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:2528
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729931AbgEVPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0DW6q0BQj1Al1bcvt7pEjZrHD/WQhU3QwJ6YwpTWNg=;
 b=jrBq7QySEgSXOnJUIx6aXWHOm44ArDO0K+rKY3tyPKwYR4eYCby3VqCrCOUOY5jeX0BwB9rWehuICqJ+iaPcyqUwwcUPZWwt/NmT97mJalxWJnSRCRA9iwKerclc4B+1NwHBTsGKjXeFgRIt+uO4oDlACmDs9Cj0dSnuRJR7cwQ=
Received: from AM0PR03CA0046.eurprd03.prod.outlook.com (2603:10a6:208::23) by
 AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Fri, 22 May 2020 15:22:56 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:0:cafe::92) by AM0PR03CA0046.outlook.office365.com
 (2603:10a6:208::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 15:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 15:22:56 +0000
Received: ("Tessian outbound d078647f4174:v57"); Fri, 22 May 2020 15:22:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ac270bb033927239
X-CR-MTA-TID: 64aa7808
Received: from b9ae6336ec08.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EB87EB3E-DBD1-4082-8075-D5C6AAE5F2FF.1;
        Fri, 22 May 2020 15:22:51 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b9ae6336ec08.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 22 May 2020 15:22:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1FzwZGlZKEks3tusHYrAhXumo9V2kROsuFcG58QEOn4KqqIeIOeVeyyerTpsMc2ASk/hrJFgiZMpNGjzp7YxQYgyL0Qan+joCRDJUhLgs5dHgrxkPf/3DYk29i2wbfAzq21Vy8L49HO/8HGyCuEZrzQxn2WfAsNR9w8vU37dpmhoUPliUp53GnnfHeb3wm3b4r6TbN4cP7L7fdvqu4TubotjqVElSJUdmwjqAIeeVBLDrD4wcaXl++SkAJh3QVli97LaP7j7zbW2R3PeoXnROFSgmf59jCJ3iL7gaoY+C/fpArrTuDUA5Phvzfv7aj7gEDTWf8x6FAvhPDx4GbQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0DW6q0BQj1Al1bcvt7pEjZrHD/WQhU3QwJ6YwpTWNg=;
 b=JNMUjKstBgJb28KFdOzrpZAMZOCG9wuViG1D1vcrUanStTyWHJm/iN/zmPdSRENNJDiISVUiVqI2JtQPenltL9GnKdFrjCQhLtyRL0T6COdF4EWLcW8zeStcvYt6QGmRjLhsfoFeg2SCeZIUTkxOJhwJqOwj1xq0Q1zI4+Si7DpnBmNMSFKNKrTSoeslI1W94TC5arzwlTugEuih2p5ZBmYHfMbuA1NS50957r8ZTC5HZ16GZ+d6iL3yNF4XYF3WsIJIGkfS74ObKm23LyZ+Qjs113BlKmPGJrHClnGqQhQIDp2nqpvi7DeRNNNC3kO5hCSDng2nxv8RJGoghgGaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0DW6q0BQj1Al1bcvt7pEjZrHD/WQhU3QwJ6YwpTWNg=;
 b=jrBq7QySEgSXOnJUIx6aXWHOm44ArDO0K+rKY3tyPKwYR4eYCby3VqCrCOUOY5jeX0BwB9rWehuICqJ+iaPcyqUwwcUPZWwt/NmT97mJalxWJnSRCRA9iwKerclc4B+1NwHBTsGKjXeFgRIt+uO4oDlACmDs9Cj0dSnuRJR7cwQ=
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com (2603:10a6:10:d6::16)
 by DBBPR08MB4630.eurprd08.prod.outlook.com (2603:10a6:10:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 15:22:49 +0000
Received: from DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2]) by DBBPR08MB4661.eurprd08.prod.outlook.com
 ([fe80::3591:2343:3c1e:e9f2%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 15:22:49 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "C. Masloch" <pushbx@ulukai.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] docs: lzo: fix incorrect statement about distance
 zero for EOS
Thread-Topic: [PATCH 2/2] docs: lzo: fix incorrect statement about distance
 zero for EOS
Thread-Index: AQHWMELVEJ9vc13HZ0eHRgw+0ScbE6i0SfKA
Date:   Fri, 22 May 2020 15:22:49 +0000
Message-ID: <C3AF092B-2B39-45C9-8FE5-4069B3B34C11@arm.com>
References: <20200522141040.1353769-1-pushbx@ulukai.org>
 <20200522141040.1353769-2-pushbx@ulukai.org>
In-Reply-To: <20200522141040.1353769-2-pushbx@ulukai.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.37.20051002
Authentication-Results-Original: ulukai.org; dkim=none (message not signed)
 header.d=none;ulukai.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [80.5.131.174]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60491f37-a336-4f56-a001-08d7fe64011c
x-ms-traffictypediagnostic: DBBPR08MB4630:|AM6PR08MB4536:
X-Microsoft-Antispam-PRVS: <AM6PR08MB45368B324699E9395DE2ABCC8FB40@AM6PR08MB4536.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:10000;
x-forefront-prvs: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SelR4x5NgkREQlKNk0Oj3ECrESUcM7ao43rHsKWeEo4nTFUuytzeCT3uZJZWG65qiqI38lQr/3jfsFrUwcxbD5YbOf65lAgn82p6YLeZ0XKgw1CJcOixLhY2sOSt6pBXWXwrzzQvMuQLxKrzabrur9sWJtjIYwtfwE78Y+2Bcz2sUs52ye0JMiPcynqvB8HsXMtosZmYc/L5HiAWvhpsFtJ3pv1kjVAoNF1u/DfsnKMCCbfI2afOjuML0jvoS85zD++kSaommEmGAsawHQil4xZaOOojfijH3RJdRurnTaDUS6juijaFsgpqJJuOrdAVmY0gehPiHJVE3KE4xDwCjohK/6s+5ytiUfF9iz9kPNk+0mfFW+N7QdIcIBzWe0wjPr0/gPR5IE8OA+fx2et1C7Rev/VZp/COohD42/jsV93Lioi1Pk5clwZXrkZi4m8z
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4661.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(110136005)(4326008)(64756008)(478600001)(66446008)(66946007)(91956017)(2616005)(5660300002)(6506007)(6486002)(8676002)(8936002)(76116006)(316002)(36756003)(2906002)(26005)(44832011)(6512007)(33656002)(66476007)(54906003)(66556008)(71200400001)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9okb5M9k2fcv3MpQSBjID0mBkqY5pI8wylGAVxu1L8rPZ8pk5T352JoHB4fz58XvV0sXt1Fb7HFIyFH85Be/ZSid0esWNj0wOxRROFL5tZzEVd/n1V8mTxFIP4mhdEmx29sfKOzwfHqusOGZdKQg4t561DTQCAjqrSuI6vFBbAz+sMwGsxy3jPueVMEI+yjVW0wxUfnndJeoTW1TDsH2+lDxb7bQJAVmcy0iuoNJZ5b8Bd1e2WT7vg/oj5JlA2/ahritl2PmE9RoVLHAfY7exOdU7e652y1fTnVKDlZZPzpaQeRwJHdY7etp2NSk+Tr+JHEitUUI7uOVfgyB6xpRLuG0nWtYv0H6nh03SZLbHNx21XW+j+J4rdW5zkIqRjuE/paf34AnYvR5UyiH7rZXOCps6t8yS5nzxYupH6my76vZH1syXp0l5qbHgkDw5oDjFd88ouj/OdxMA6fALvO4uESUskBib8WE7bCylWhmC54=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFDDC4571103E74BB5801ACB44AE5610@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4630
Original-Authentication-Results: ulukai.org; dkim=none (message not signed)
 header.d=none;ulukai.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(2616005)(6512007)(86362001)(70206006)(54906003)(336012)(107886003)(70586007)(8676002)(110136005)(6486002)(44832011)(450100002)(316002)(47076004)(478600001)(186003)(33656002)(81166007)(26005)(2906002)(36756003)(6506007)(4326008)(5660300002)(82740400003)(8936002)(36906005)(356005)(82310400002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 02bdc718-bc5d-420c-0c68-08d7fe63fd28
X-Forefront-PRVS: 04111BAC64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uaZKoMBrnO4kQ/SaXq6CxECU40DA3I7B5FMiXt1kKJt0R41Yrioqa9tpwDMpKqmNeoZfyi9OO2l4L4P60E4uBboxymYZkDVlzZaIPZ7ZuVu28DRe8cgk7brXf7Iw/AqyhLOlPKW+Yw6YzX6s602W/cHcNrSC/CxYMRxfi1p4+E7qiCdurOhWRTRx0oa3o3NbNtbA8q2yvxq+HMqQQhWXcZ9m6wIW47FHCbwF1/vMhEFTAacRVXGbwxROvvr5aMNtRb577KT4s/SpyaEkllYD+dMro74/l5hVZpXMZjUkONKdZkWHxS9pEtLboBXdEc6cGOR21zW9p9SwsWJ6OFv6uZWRlJXyqmRnLiz9HuC96VrDePUjQ5PGoQdcRZz+yR7HEFq7p0Z4PumRaZe6H2qNA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 15:22:56.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60491f37-a336-4f56-a001-08d7fe64011c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCB0byBtZSwgdGhhbmtzDQoNCkRhdmUNCg0K77u/T24gMjIvMDUvMjAyMCwgMTU6
MTEsICJDLiBNYXNsb2NoIiA8cHVzaGJ4QHVsdWthaS5vcmc+IHdyb3RlOg0KDQogICAgVGhlIGVu
Y29kZWQgZGlzdGFuY2UgYml0cyBhcmUgemVybywgYnV0IHRoZSBkaXN0YW5jZSB0aGF0IGlzDQog
ICAgY2FsY3VsYXRlZCBmcm9tIHRoaXMgaXMgYWN0dWFsbHkgZXF1YWwgdG8gMTYzODQuIFNvIGNv
cnJlY3QNCiAgICB0aGlzIHN0YXRlbWVudCB0byByZWFkIHRoYXQgdGhlIDAwMDFITExMIGluc3Ry
dWN0aW9uIG1lYW5zDQogICAgRU9TIHdoZW4gYSBkaXN0YW5jZSBvZiAxNjM4NCBpcyBzZWVuLiBU
aGlzIG1hdGNoZXMgd2l0aCB0aGUNCiAgICBkZXNjcmlwdGlvbiBvZiB0aGUgaW5zdHJ1Y3Rpb24g
aXRzZWxmIGxhdGVyIG9uLg0KDQogICAgU2lnbmVkLW9mZi1ieTogQy4gTWFzbG9jaCA8cHVzaGJ4
QHVsdWthaS5vcmc+DQogICAgLS0tDQogICAgIERvY3VtZW50YXRpb24vbHpvLnR4dCB8IDYgKysr
LS0tDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQoNCiAgICBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9sem8udHh0IGIvRG9jdW1lbnRhdGlv
bi9sem8udHh0DQogICAgaW5kZXggZjgzOWQxMDRkLi5kYzllODc2Y2IgMTAwNjQ0DQogICAgLS0t
IGEvRG9jdW1lbnRhdGlvbi9sem8udHh0DQogICAgKysrIGIvRG9jdW1lbnRhdGlvbi9sem8udHh0
DQogICAgQEAgLTY1LDkgKzY1LDkgQEAgRGVzY3JpcHRpb24NCiAgICAgICBnZW5lcmFsbHkgZW5j
b2RlZCBpbiB0aGUgbGFzdCB0d28gYml0cyBvZiB0aGUgaW5zdHJ1Y3Rpb24gYnV0IG1heSBhbHNv
IGJlDQogICAgICAgdGFrZW4gZnJvbSB0aGUgbGFzdCB0d28gYml0cyBvZiBhbiBleHRyYSBvcGVy
YW5kIChlZzogZGlzdGFuY2UpLg0KDQogICAgLSAgRW5kIG9mIHN0cmVhbSBpcyBkZWNsYXJlZCB3
aGVuIGEgYmxvY2sgY29weSBvZiBkaXN0YW5jZSAwIGlzIHNlZW4uIE9ubHkgb25lDQogICAgLSAg
aW5zdHJ1Y3Rpb24gbWF5IGVuY29kZSB0aGlzIGRpc3RhbmNlICgwMDAxSExMTCksIGl0IHRha2Vz
IG9uZSBMRTE2IG9wZXJhbmQNCiAgICAtICBmb3IgdGhlIGRpc3RhbmNlLCB0aHVzIHJlcXVpcmlu
ZyAzIGJ5dGVzLg0KICAgICsgIEVuZCBvZiBzdHJlYW0gaXMgZGVjbGFyZWQgd2hlbiBhIGJsb2Nr
IGNvcHkgb2YgZGlzdGFuY2UgMTYzODQgaXMgc2VlbiwNCiAgICArICBlbmNvZGVkIGluIGEgY2Vy
dGFpbiBpbnN0cnVjdGlvbiAoMDAwMUhMTEwpIHdpdGggdGhlIEggYW5kIEQgYml0cyBhbGwgemVy
by4NCiAgICArICBJdCB0YWtlcyBvbmUgTEUxNiBvcGVyYW5kIGZvciB0aGUgZGlzdGFuY2UsIHRo
dXMgcmVxdWlyaW5nIDMgYnl0ZXMuDQoNCiAgICAgICAuLiBpbXBvcnRhbnQ6Og0KDQogICAgLS0N
CiAgICAyLjI2LjINCg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBl
bWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJl
IHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBj
b250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBz
dG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

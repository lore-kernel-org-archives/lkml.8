Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3CD2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0HYSZjV/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0HYSZjV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAONPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:15:54 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:19936
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbgAONPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cBrWXefEToCgbkE5QgnZ/8FmTvZ9miNOxV0D7a/HwI=;
 b=0HYSZjV/U4vL3/861ljUtbu8h6SsfwPfYVhcI0E6Ivkj4mKlOEvOiFtqZr7AfUlFF0AyvUceUnMblKMwULD3zJFfc6UiKvKUa+qNX7ShfkYGBO69X7xIvTjhXvLYZyQtDG0RVR90Qu1eqYZNsJb9ic2J2r4zaJ0B0s9ZvuBCrwg=
Received: from VI1PR0801CA0089.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::33) by DB7PR08MB3146.eurprd08.prod.outlook.com
 (2603:10a6:5:25::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Wed, 15 Jan
 2020 13:15:46 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR0801CA0089.outlook.office365.com
 (2603:10a6:800:7d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 15 Jan 2020 13:15:46 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 13:15:46 +0000
Received: ("Tessian outbound 1da651c29646:v40"); Wed, 15 Jan 2020 13:15:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 12d4b22e16357ced
X-CR-MTA-TID: 64aa7808
Received: from 0f0f0f739085.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4C85DDFE-62F1-4AEA-9A5B-91436F07B816.1;
        Wed, 15 Jan 2020 13:15:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0f0f0f739085.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 15 Jan 2020 13:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US4AuBVZfB/1S3Dme0+H4DPu5cY/JRhHMxtV//8CDm+TxAsxSsVJgcwUI3ecIzbG5yzGPt5M3tsvIFMHVFp5XaAkz7r27y+kkpaWuyG3JR2O3lXwN2hZhnq6d/Lpie9EuU/5DU1359GxbJ79KIdtsxat4gieFeoVREgBt0A08Xh/w0s6Jki5bF3wd6XRyw3yRF+OYRPVlPTYCREcpefHUA7oQmD7l0VZP/1FKB4KyWHrR088HzNvARBv6qQ/06jLSRcGqd7awcuBxDo5KkHCRmLdL+mWOjOx6K66IKwxKzu5iKxDnlhEJHYtPFsRSTxfPc5X9xLhJdAHIgaHSSANpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cBrWXefEToCgbkE5QgnZ/8FmTvZ9miNOxV0D7a/HwI=;
 b=kGSD+bS43Rs2xemOXO01Eh26m21S7lgLYJflKbasCHt+OHXiOquIj/XrfU2GvqFWMeu/9z9aa7KAv1y2/KSzT8xhKst+02eNj1yCoUijOmaM5k5ddUydVhkx9h58gEtRryrVlk/+pFufPqDphkLwzH0vchN5B4YvyA9am6+Zq9JDQCQjSPB9v8o07/C4ALGdX7NtMstJ6vkBp7ZQuPhGnkUfawRscQ78ETCvReLamqf0QYoprcDbX5sb1bpb/5m439+ztOqXwgyOAEVwWopUcFcZK6IQk2GSPHZLoL1NfI8IEWXCIS3AAVUEJ4j4wbaMc+LWIx6iXRZJZOqnHAcl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cBrWXefEToCgbkE5QgnZ/8FmTvZ9miNOxV0D7a/HwI=;
 b=0HYSZjV/U4vL3/861ljUtbu8h6SsfwPfYVhcI0E6Ivkj4mKlOEvOiFtqZr7AfUlFF0AyvUceUnMblKMwULD3zJFfc6UiKvKUa+qNX7ShfkYGBO69X7xIvTjhXvLYZyQtDG0RVR90Qu1eqYZNsJb9ic2J2r4zaJ0B0s9ZvuBCrwg=
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1623.eurprd08.prod.outlook.com (10.169.227.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Wed, 15 Jan 2020 13:15:36 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::f937:8a25:91c6:fe33%8]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 13:15:36 +0000
Received: from [10.32.36.146] (217.140.106.40) by LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 13:15:35 +0000
From:   James Clark <James.Clark@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Thread-Topic: [PATCH] perf tools: Fix bug when recording SPE and non SPE
 events
Thread-Index: AQHVtyVvIt8qdYS9jk64bAWEtkmeEqfHGX0AgCGR5gCAAB7MgIAACzuAgAMICAA=
Date:   Wed, 15 Jan 2020 13:15:36 +0000
Message-ID: <eac2263e-07fb-ecb4-5e9f-3e215f2d4526@arm.com>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
 <fd4f4278-fa43-86dc-1f2f-3439f19fea9e@arm.com>
 <20200113141751.GA10620@leoy-ThinkPad-X240s>
 <20200113145803.GB10620@leoy-ThinkPad-X240s>
In-Reply-To: <20200113145803.GB10620@leoy-ThinkPad-X240s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To DB6PR0801MB1638.eurprd08.prod.outlook.com
 (2603:10a6:4:38::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a8c98a4-bc59-42a2-f863-08d799bd0836
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1623:|DB6PR0801MB1623:|DB7PR08MB3146:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3146900D9239D2D818649A7AE2370@DB7PR08MB3146.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 02830F0362
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(5660300002)(66476007)(66556008)(44832011)(66946007)(54906003)(71200400001)(4744005)(478600001)(81166006)(81156014)(8936002)(110136005)(8676002)(316002)(16576012)(2906002)(64756008)(2616005)(7416002)(52116002)(6636002)(36756003)(66446008)(6486002)(86362001)(4326008)(956004)(26005)(16526019)(186003)(31696002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1623;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pMhpi8ecfCTQL0uDPsOmpuyNa/o7dHEdC8TmA3uw/id0Pd7iTGBk2XioIgYRC5nFzB7FZNFoyUrlQUNTWE2eVLInlz+ibrQ+GZRTa4L8Soar8SXQqEZ/HrkC4XZCimhSJhfOP4B95g0+GofMyyr4nv9b5ca+NKKwpHsmRm9jcW+wts+vNMO2YatrSv4MWMYc0Q2MA54ZXn130j8okEuCfW5NdEMI96fL1HeTwrKLndsPSU+Kag6XFOTRuWFLc1D+ZsBZzMU2qK9ZH1jW8Bfr9j/UVxWN6QI6QJQFnfmvwvLYJJ6w4hE6SEOO5O+RMW4wMZmOQIAzH8LSQtMUhrxtR4N4lHxnrlPLAf2WHf75c2xQcjAphKlJQhrXnYyXmlto141zQ9h2iFA/EVzUdlhGlQQ53LBPMZxia+zgvOAFFtseV65IcXaS7TgLN9EtXp05
Content-Type: text/plain; charset="utf-8"
Content-ID: <534E256C26529C419E12813BBB4B0DF5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1623
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(4744005)(6486002)(8676002)(86362001)(478600001)(5660300002)(356004)(81166006)(26005)(186003)(16526019)(70206006)(54906003)(110136005)(316002)(31696002)(8936002)(16576012)(26826003)(36756003)(336012)(31686004)(2616005)(2906002)(956004)(6636002)(4326008)(450100002)(107886003)(81156014)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3146;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76256454-a637-4588-adc9-08d799bd022f
X-Forefront-PRVS: 02830F0362
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psylgTGSHOWSHxpXqZpnCZcACSdInrt3+pIRG2tbCvDL6thIF9gSCzr1fy+1sCYwMFkJQQKRs/M1tX2Ggqf548lsAc566hYebiL7bZlNiEuPyM5/WIGnc8wRez6ldDf96L627lT/pDDzbyBPIesgxGshfGww7BBd/i7mv4On5R1y6mshYZ0GrBgSa0pRN7f1GeAQsmPwA81/pPB9fhY81JIHCc+74l5To9ntJcEO7KlhVmwsbtSLiy8F5OuRhqQlqhTU+Di2g/yFBVDglOHznJJApuIz83mKm2Sylh9cmwQzt/fdeQADTnKp86vR7UwRwMzEOSL/+iAui6H0Sx2SUxL36n7y+oxGtiKEDIwSFAakWpx4j2+2VPOkM89IjYKtHpiHVXpXOh5/YqkmEUEeMRrcn3KOT2v1uIWqF1jBK/ATjZiqYGKjPBbdDNHAH/J0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 13:15:46.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c98a4-bc59-42a2-f863-08d799bd0836
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQo+IFNpbmNlIFNQRSBpcyBkZWZpbmVkIGluIEFSTXY4IGFyY2hpdGVjdHVyZSBy
ZWZlcmVuY2UgbWFudWFsIChBUk0gRERJDQo+IDA0ODdELmEpOyBzaG91bGQgU1BFIHRyYWNlIGRh
dGEgZm9ybWF0IGlzIHVuaWZpZWQgYW5kIGRlZmluZWQgaW4gQ2hhcHRlcg0KPiBEOSAiU3RhdGlz
dGljYWwgUHJvZmlsaW5nIEV4dGVuc2lvbiBTYW1wbGUgUmVjb3JkIFNwZWNpZmljYXRpb24iPw0K
PiANCkknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGV4YWN0bHksIGJ1dCB0aGUgdHJhY2UgZGF0
YSBmb3JtYXQgaXMgZGVzY3JpYmVkIGluDQpzZWN0aW9uIEQxMC4NCg0KVGhhbmtzDQpKYW1lcw0K

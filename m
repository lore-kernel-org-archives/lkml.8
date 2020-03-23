Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD2EC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D922070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aPWt5OXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCWVPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:15:49 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:36896
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbgCWVPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:15:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5s0XqQD5+pwMG84MzTUMMnDwuU0N1ssVCkIwmhaEGRflgv3zhsF5hnSxEtbYe4d67Ha2JibN0LVPcF9D9l88F2pL9MJVIje8wGFg9YmWiAqyoPRpQWhg0o8k56KGCewFVp7lBfttQpTgfTK3+5AuDpu9/qa9skKM3Js9b1t+NfjxNxw6mg1tp5b8XwaF+eZCdYW4kfatXnBFXKa450nMxQBjRIOaCxZRgcM55hidNtQmx5/Z7IeLozKX0U93kizrcIg7dXvLmOSaA1ItLjVnqQc5xtZT6CQUWaMw0ebD0aqTI7X2YRzMrgZjmtjkLrH20XtZJe3iLb6bGEcgVAVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjr95THHoGP82YF2/lZh6DkmMjbLOFKWMBuxXofPG1o=;
 b=CbXLuTbZcRhhYRVxLdaEXSxypk6rkcMKor+eFfz4uKQM7uhSh61lZtHIyo21tDiscqjqMijuCvz+oXVAATyRuYlTQUMOVg1P97kbf2FktmFK44BY7UZskvNlV2AJWnuXSZd2D2sr4Q9eak1Cweh825ANZO5DFtoMezfshDg1anK9tSRZeF0Y9dv/+0s5pq0TBMukbYcFwwrIkOi6LFXo0SB51oL5VBRstIixhmoP7zJ5/dza0KW+dVVCrIPHhcB57TcAwZqdG/6RYsWquIK9z4IZQvCNCDVjXuPru27Vf4RZQvKNUZy7npEAE7mkGtgCiLCqO2yDw6ePaI9Hxyih9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjr95THHoGP82YF2/lZh6DkmMjbLOFKWMBuxXofPG1o=;
 b=aPWt5OXKqP2JVnA0eNmeFJbTC9Ad+c+PDU/2dK2PezfqLPCV6XXqK4yIBi5Cw6G6gJs46DjaH1S89yR7Sz85cUJ0Yx2Qf4b1xeozKzGHHjBO/QK8LpxpVytUBHOuaINiFTpj7ocmSUHhbd+4Z67G2HcvPNS4OyatMhjJ60Nxhdk=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (2603:10b6:a03:127::16)
 by BYAPR02MB4423.namprd02.prod.outlook.com (2603:10b6:a03:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 21:15:46 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 21:15:46 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Jolly Shah <JOLLYS@xilinx.com>, "olof@lixom.net" <olof@lixom.net>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock check
 from custom type flags
Thread-Topic: [PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock check
 from custom type flags
Thread-Index: AQHV+LWuMSi99kXFg0iLg+o1EIX5fahWSasA
Date:   Mon, 23 Mar 2020 21:15:46 +0000
Message-ID: <70D64AAE-668B-4699-8BDB-41CFC755C373@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
In-Reply-To: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf12a8ca-68b5-479f-2f57-08d7cf6f5aca
x-ms-traffictypediagnostic: BYAPR02MB4423:|BYAPR02MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB44237E670A42A6A33A96B01FB8F00@BYAPR02MB4423.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(54906003)(26005)(2616005)(8676002)(36756003)(76116006)(81166006)(81156014)(478600001)(33656002)(5660300002)(6486002)(66446008)(66556008)(64756008)(66946007)(66476007)(86362001)(6506007)(4744005)(71200400001)(8936002)(15650500001)(110136005)(186003)(4326008)(2906002)(6512007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4423;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JjqoLo0TDclAXRyXPa0TKbQhKhkStgPFf7gcLNEcsLR3XEm4Y/do4+aEHdBQaV+YXA8gol/lU0OzWi+0nFYQLCD9366AYYp/RKZrfoT7srtkgz4q+9hDUiiPx2+n0sYT59Qld+zVnMJ5zhIupTaLzWyS3mLUtAvPnw1ZiF2qIvsSq/WGDjX//ugvdk4BotdsGSmxW3oxO9zBt0uXCDhGJfUy1CiebVAsLLs+QKSUQZIaiYLnf2G/D/m2TKQpJeW2FWIwBg4UttP/kFUJadC2BwghZ+Y5ooH8knNPnxnwl0fyC7UHiSXdrRA50fBU85wxW3TmHH7MUEj4zR2uX9nVAV0UWHPPEUvbRDKQpbxZqG1/jAMc/Z5mOPRNUjGZtJcgct8xYOoQiEiEsJJFnQDualPlkWhXFGPbAbRT5c4OXVlNle7U3CM4lwf/HLQET94H
x-ms-exchange-antispam-messagedata: 869VMjPBXoe1L8B2dPBoZSK/B+V7Kjyb6W1uU7lXsGYZ7bOAAu/aUxDxXligwS9LmIs0N3wR6jeFa9KYjv50Hcx5Gvit1IQqNKGJTJF+soZI73XBpI6LPPNRJfnKsJWnC+wRucZHpXQeE4d/XKGzFw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A9037BF1DB16946B0540F6B6AC8F3CA@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf12a8ca-68b5-479f-2f57-08d7cf6f5aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 21:15:46.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmmJhb5ecw1pDbE5WgA+P2GIgkJOImdMavqeFfDs10U8pkSFbIFJnxsy6JM9OpTfFwOsWy2yFcrXCJTd0eXPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBnZW50bGUgcmVtaW5kZXIgZm9yIHJldmlldy4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQrv
u79PbiAzLzEyLzIwLCAyOjMyIFBNLCAiSm9sbHkgU2hhaCIgPGpvbGx5LnNoYWhAeGlsaW54LmNv
bT4gd3JvdGU6DQoNCiAgICBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGN1c3Rv
bSB0eXBlIGZsYWdzIHBhc3NlZCBmcm9tDQogICAgZmlybXdhcmUuIEl0IGFsc28gdXBkYXRlICBm
cmFjdGlvbiBjbG9jayBjaGVjayBmcm9tIGN1c3RvbSB0eXBlDQogICAgZmxhZ3Mgc2luY2UgbmV3
IGZpcm13YXJlIHBhc3MgQ0xLX0ZSQUMgZmxhZyBhcyBhIHBhcnQgb2YgY3VzdG9tIGZsYWdzDQog
ICAgaW5zdGVhZCBvZiBjbGtmbGFncyBhcyBDTEtfRlJBQyBpcyBub3QgY29tbW9uIGNsb2NrIGZy
YW1ld29yayBmbGFnLg0KICAgIA0KICAgIFRoaXMgcGF0Y2ggc2VyaWVzIG1haW50YWlucyBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIgdmVyc2lvbg0KICAgIG9mIGZpcm13YXJlLg0K
ICAgIHYyOg0KICAgICAtUEFUQ0hbMi8yXSBDb3JyZWN0IEJJVCBpbmRleCBvZiBDTEtfRlJBQyBp
biBjdXN0b21fdHlwZV9mbGFnDQogICAgDQogICAgUmFqYW4gVmFqYSAoMSk6DQogICAgICBkcml2
ZXJzOiBjbGs6IHp5bnFtcDogQWRkIHN1cHBvcnQgZm9yIGN1c3RvbSB0eXBlIGZsYWdzDQogICAg
DQogICAgVGVqYXMgUGF0ZWwgKDEpOg0KICAgICAgZHJpdmVyczogY2xrOiB6eW5xbXA6IFVwZGF0
ZSBmcmFjdGlvbiBjbG9jayBjaGVjayBmcm9tIGN1c3RvbSB0eXBlDQogICAgICAgIGZsYWdzDQog
ICAgDQogICAgIGRyaXZlcnMvY2xrL3p5bnFtcC9jbGstenlucW1wLmggfCAxICsNCiAgICAgZHJp
dmVycy9jbGsvenlucW1wL2Nsa2MuYyAgICAgICB8IDQgKysrKw0KICAgICBkcml2ZXJzL2Nsay96
eW5xbXAvZGl2aWRlci5jICAgIHwgNiArKysrLS0NCiAgICAgMyBmaWxlcyBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQogICAgDQogICAgLS0gDQogICAgMi43LjQNCiAg
ICANCiAgICANCg0K

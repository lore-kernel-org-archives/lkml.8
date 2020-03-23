Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5321C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92863206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qlGTtLzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCWVN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:13:59 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:10401
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgCWVN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpxRbc/oaNw0Dwn8fqf3Pc9YxTu5Sr6P8kwqSEv2XbOpYhkdmgQ4XZL1c2DH7/o5VhbJPI0TOz/Rgx02ziaUa6MkoT5Uc1UwNDEdQahVWv4r/Nxr6VruxFs6oUMLicXqHFjYez9tKOY3e/Imqgy/DIMHXKmMUdTLmtFDbZHxQ88zuI8z3pQFmkgN4QdCblTG0cD4sNM7nJNvxkysJJuJ7BP31JuZzOzqjYJVucT4buUY2Q/P+IWaiJdPMLMrv4L0X3bKZ9dYIbIKYp1/LAGrydA5oWl9aQGfTRHTfgUuK0PM49vBY75N64e9YKxtv9XtJmHHY5Xor5jsSds2bvZ/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZsNde0WGieyvn/spbx9JFQCpMRcaDIUnjLgEba/HyQ=;
 b=BikM7IMXoYiOVwxOWW8GJzhB9Hj+Nj52Pvgmj9HLFSymC0lRq8xIfUf2YoQYj4mQEGZQi60NKWCfbA/u1BS4OJGb9Tx3d8kWKWJ/fGiQ/A9Kc77QCmHWcRgdgoKJEsjW1d51DWRCxy14xTDfLF4eKO7ol58fmyc2AQ7m50vnq/IWrYjrXRXRojxqqaC0kc/FbrkIr/SSy2H04J5KGgBLRh9Frw/IWYPgI/RMc/ZDXmInc2Yy4CsD7EGx4DT3KMlPUzE8uBweFZJAAwH+PCR61TGLdOn/P8RBl9cPTg2qXgF4zxNINoal6pvzegiBeYrCZEs0nzmbv0TsbiIKZVSTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZsNde0WGieyvn/spbx9JFQCpMRcaDIUnjLgEba/HyQ=;
 b=qlGTtLzDdg9Wo9458Ol8xJMuvwO7Nzqx5p8uqFNkGp17iZR1+Z8GNyJfb0slXAFBgj6tppSSW1caSuA3Im0Y4cDBPV9J0Ahgf8GTK9Gu6CptaknbjbqfgPDTLcF/PT0sqG2NFanCJ6CFxU02E/vQSACuzobylxr3zidX/vzIGTg=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (2603:10b6:a03:127::16)
 by BYAPR02MB4423.namprd02.prod.outlook.com (2603:10b6:a03:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 21:13:55 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 21:13:55 +0000
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
Subject: Re: [PATCH 0/4] Clock driver fixes
Thread-Topic: [PATCH 0/4] Clock driver fixes
Thread-Index: AQHV8NuptlXrLfHfkk+i2Lx5IRh3SahWWNoA
Date:   Mon, 23 Mar 2020 21:13:55 +0000
Message-ID: <D2A3DCE1-1514-445D-B58E-E2EA31BAB0C2@xilinx.com>
References: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
In-Reply-To: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
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
x-ms-office365-filtering-correlation-id: 1e9298aa-7012-415f-5856-08d7cf6f1867
x-ms-traffictypediagnostic: BYAPR02MB4423:|BYAPR02MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4423242EA24B792FF7C2637DB8F00@BYAPR02MB4423.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(54906003)(26005)(2616005)(8676002)(36756003)(76116006)(81166006)(81156014)(478600001)(33656002)(5660300002)(6486002)(66446008)(66556008)(64756008)(66946007)(66476007)(86362001)(6506007)(4744005)(71200400001)(8936002)(110136005)(186003)(4326008)(2906002)(6512007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4423;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdMHs6O4NIj/2TS3OBN+cNc1w797eimvt8Vos/H//4xVhTMgmR+pNyJPUrxVaJiksK8ZG9sKcLxCOnw//o/N5M6IreCu0aNsg3dyPjIHwyWtzy21PGmvq9YZ9O/PhsDx4X4Ll6OBZi8ZK+WFCITdUsQkpOhUcBzxOjv5ZoO6ZfZ6LMxuwclg8f0kGBfWRon6qFrz3N5ClTqm2LR8fRenW1DRUzBJEi+vucPs61szpuQSl3LC9Vd01qFNArieeUn7o7FxsJzQ2zIy/ERRUt6x/MoWPIobaHFoRNaGt67nQMlqFTb35GV60VPkDgqWat7+cqWz1ZPW58/lp6Hx+gwBhnU8roWPReiWs/gOxIDvBH+m/0Ll45soDd43Bx2DNSgugOWT+J1ceVKP776MkYozkG8M38yD28MQpp2Y1T1xKil4Mx3k7Te+Hka4me1ud6hO
x-ms-exchange-antispam-messagedata: DU68EgMU9FOVN+nLQN32yz7ZI6u+yJNgZKeoWYZrp1nn2HPMYntEChfUQzc+l65PEXlSpUwlHHK0k1sYjjbOAzqFfJWr4IEP9dwsiBDeedG9lABb5pgbMag6nGy4Qg8Qxc480euVJ5X1zCYhhBMFAw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFC5C5FC00DAF049AAF83A561BD925BD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9298aa-7012-415f-5856-08d7cf6f1867
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 21:13:55.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmQXxPzlhyMDx2+PKgiqPlMACOg4Hn/nJoMEvZ0gdglIugVjUwvBeeNykacUxeRPSTrmHduUBjMtI3UL6AZyPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBnZW50bGUgcmVtaW5kZXIgZm9yIHJldmlldy4NCg0K77u/T24gMy8yLzIwLCAxOjQzIFBNLCAi
Sm9sbHkgU2hhaCIgPGpvbGx5LnNoYWhAeGlsaW54LmNvbT4gd3JvdGU6DQoNCiAgICBUaGlzIHBh
dGNoc2V0IGluY2x1ZGVzIGJlbG93IGZpeGVzIGZvciBjbG9jayBkcml2ZXINCiAgICAxPiBGaXgg
RGl2aWRlcjIgY2FsY3VsYXRpb24gDQogICAgMj4gTWVtb3J5IGxlYWsgaW4gY2xvY2sgcmVnaXN0
cmF0aW9uDQogICAgMz4gRml4IGludmFsaWQgbmFtZSBxdWVyaWVzDQogICAgND4gTGltaXQgYmVz
dGRpdiB3aXRoIG1heGRpdg0KICAgIA0KICAgIFF1YW55YW5nIFdhbmcgKDEpOg0KICAgICAgY2xr
OiB6eW5xbXA6IGZpeCBtZW1vcnkgbGVhayBpbiB6eW5xbXBfcmVnaXN0ZXJfY2xvY2tzDQogICAg
DQogICAgUmFqYW4gVmFqYSAoMik6DQogICAgICBjbGs6IHp5bnFtcDogTGltaXQgYmVzdGRpdiB3
aXRoIG1heGRpdg0KICAgICAgZHJpdmVyczogY2xrOiBGaXggaW52YWxpZCBjbG9jayBuYW1lIHF1
ZXJpZXMNCiAgICANCiAgICBUZWphcyBQYXRlbCAoMSk6DQogICAgICBkcml2ZXJzOiBjbGs6IHp5
bnFtcDogRml4IGRpdmlkZXIyIGNhbGN1bGF0aW9uDQogICAgDQogICAgIGRyaXZlcnMvY2xrL3p5
bnFtcC9jbGtjLmMgICAgfCAyMCArKysrKysrKysrKysrKy0tLS0tLQ0KICAgICBkcml2ZXJzL2Ns
ay96eW5xbXAvZGl2aWRlci5jIHwgMTkgKysrKysrKysrKysrKystLS0tLQ0KICAgICAyIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KICAgIA0KICAgIC0t
IA0KICAgIDIuNy40DQogICAgDQogICAgDQoNCg==

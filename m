Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92878C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5523A2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BmLo16Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCWVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:15:45 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:16800
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgCWVPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npmdDcM5O5OiIY9J+zEySiHXVRKBPY2yAuveNqejO4hQEjXU5xNrX5mbaOq/2Uw0cxVBxDxE+q/I/4YiA/46+LiCx7v1dXvl965+/p8hzNbe3zgNELZtMDDiZT2StZwVNNqla6Kr3L5BPdFWr3dMw+Ch2n8r/urAB+Wj+1A35yBZnzDkhAwzzRc62cAvHDS29YKVi+v2h/iDppSFLq0MyzN3HMBSco/x1DFVmQshOQm3ang4++NtzbgNqSIeJpjzT8ov1y3JnI2XJTmA4ES15M58jWcUGTF7hbo8bMn01w4uFekj1wyk3xbBkBgqOpOg75uJR+OA2QuyFYQP038V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwFmJD2TsBIbXc0P9bHNcQ9o+XCdtiKoZS7HI8u3GFI=;
 b=bpZd3Uky7dmwrKQvSWRXPyiaLwSQ2Js2Y3ezlFRDq++i0Hir3bstB/nyX7todXH/cdkg7oXSgAXjCIytujbdSw1aiBsxjBLRDR1n+Lq2hKLn2IdarOcIgyCOj8LDxe37syJJHxYioLHO072gAtu6lTTzAZU7x3MTetyWjaeoCJtXOrXwnrxffQy0p+d0Pu3mw59HHWLGSjgjPsLxsIMKX8RmS1zPXCNxIKePL+ePnMAiHWQPPUFS0KI4ajl7i5CbKXhqt+49eXNdx5zIZ0XNZtfKAdwqtPdgwNR9DDUwWwJbbVndDagOQ8ofNqbsuw3UItM3IE2u0C7G2PinJD7oNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwFmJD2TsBIbXc0P9bHNcQ9o+XCdtiKoZS7HI8u3GFI=;
 b=BmLo16VlDILBRPF6X/AzPvyDn2Zcind+HJDeL8N6a2muTbvj3JgjyEsWmrQ9sGngtDQzY7QrRuztHZsSUkGe+AhGaMEKphhFs78aGWpehyk4C0Fcq7WUiVhDkChFk/B49Y/Grp4cSisio8uZk7BOlYl95nDcHYnjEpt1u1K8f+s=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (2603:10b6:a03:127::16)
 by BYAPR02MB4423.namprd02.prod.outlook.com (2603:10b6:a03:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 21:15:41 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::653c:fb1e:61b9:8f00%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 21:15:41 +0000
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
Subject: Re: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp
 clock driver
Thread-Topic: [PATCH v2 0/4] drivers: clk: zynqmp: minor bux fixes for zynqmp
 clock driver
Thread-Index: AQHV8Nyr7p4Ho3UidEurpbmFeO/bxahWWVYA
Date:   Mon, 23 Mar 2020 21:15:41 +0000
Message-ID: <4DC8258A-4692-4FFE-BF63-10734516681D@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
In-Reply-To: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com>
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
x-ms-office365-filtering-correlation-id: 4f7cbf6a-ad9f-4c7a-592d-08d7cf6f57b8
x-ms-traffictypediagnostic: BYAPR02MB4423:|BYAPR02MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4423CDDBE68112497455D564B8F00@BYAPR02MB4423.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(54906003)(26005)(2616005)(8676002)(36756003)(76116006)(81166006)(81156014)(478600001)(33656002)(5660300002)(6486002)(66446008)(66556008)(64756008)(66946007)(66476007)(86362001)(6506007)(4744005)(71200400001)(8936002)(110136005)(186003)(4326008)(2906002)(6512007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4423;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpmZJZS/UYwdeB5mP+kfq3AZpnnkP+ihm6fg94zfnxs2g4vrXbSQKhP8ACY24AJhpfOlhejIlUwYiDMq5QP7hVg7GzX8hmLjFqRn/a6+AQv3KE80UxhR9dMxCc1ssLhyBZoaai/aSlM8yBE/u3w3L1FAPscqIRrg9NJr1UV+qrrQUdzIiy5L2xgabG7nNJ/5Ho5/sxcVq9MWu6G/5EidPZJ8wVkeRgpTh6zSbNMkVbndQ/TH8Qnmup+tVFr9gwDEq0P3Ew89qNngHxTGhA37B5Kk/gIXpYd0eaAwhUZGaTav4MiW6W39S5AX1Uz7n56zVeZmdw4K8Ka3fC+kk3eDacf+Jo1W4QI8Pp+Rp6bGcfkW9HIsdjY5YB42EjACkQycyJJEOZ1wG7QEFzuedsh2aW3aeLeZ+h01IvflZ/0CaHN+YHHLjLU+40+bacrBGIyZ
x-ms-exchange-antispam-messagedata: SdV1jtPAW9qKPntV2Yin+O6biXk6WfNxSbBPJ/MShk+iOFpYOkH4jkMFGp9AUH+3T0lcFbgnehpMZkQYSqxz4+GP62ogCT4jsxt6l8Ey11f6z54tuZTKiQ15Q5uFFHjYMh0sHDLITS16jA4OrV2DXA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E87FDE0CECFF44AB43FA95582E298CB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7cbf6a-ad9f-4c7a-592d-08d7cf6f57b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 21:15:41.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhYP7fa+m+3nz9E648zR7R2i1BUXQLTUO3rolVun9pDJseEV1389S8hrmivtBZOOFxZrJE1RB/jkMY3Bxv4NYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBnZW50bGUgcmVtaW5kZXIgZm9yIHJldmlldy4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQrv
u79PbiAzLzIvMjAsIDE6NTEgUE0sICJKb2xseSBTaGFoIiA8am9sbHkuc2hhaEB4aWxpbnguY29t
PiB3cm90ZToNCg0KICAgIFRoaXMgcGF0Y2hzZXQgaW5jbHVkZXMgYmVsb3cgZml4ZXMgZm9yIGNs
b2NrIGRyaXZlcg0KICAgIDE+IEZpeCBEaXZpZGVyMiBjYWxjdWxhdGlvbg0KICAgIDI+IE1lbW9y
eSBsZWFrIGluIGNsb2NrIHJlZ2lzdHJhdGlvbg0KICAgIDM+IEZpeCBpbnZhbGlkIG5hbWUgcXVl
cmllcw0KICAgIDQ+IExpbWl0IGJlc3RkaXYgd2l0aCBtYXhkaXYNCiAgICANCiAgICB2MjoNCiAg
ICAgLSBVcGRhdGVkIHN1YmplY3QgZm9yIGNvdmVyIGxldHRlciBhbmQgcGF0Y2hlcyANCiAgICAg
ICB0byBhZGQgcHJlZml4DQogICAgDQogICAgUXVhbnlhbmcgV2FuZyAoMSk6DQogICAgICBkcml2
ZXJzOiBjbGs6IHp5bnFtcDogZml4IG1lbW9yeSBsZWFrIGluIHp5bnFtcF9yZWdpc3Rlcl9jbG9j
a3MNCiAgICANCiAgICBSYWphbiBWYWphICgyKToNCiAgICAgIGRyaXZlcnM6IGNsazogenlucW1w
OiBMaW1pdCBiZXN0ZGl2IHdpdGggbWF4ZGl2DQogICAgICBkcml2ZXJzOiBjbGs6IHp5bnFtcDog
Rml4IGludmFsaWQgY2xvY2sgbmFtZSBxdWVyaWVzDQogICAgDQogICAgVGVqYXMgUGF0ZWwgKDEp
Og0KICAgICAgZHJpdmVyczogY2xrOiB6eW5xbXA6IEZpeCBkaXZpZGVyMiBjYWxjdWxhdGlvbg0K
ICAgIA0KICAgICBkcml2ZXJzL2Nsay96eW5xbXAvY2xrYy5jICAgIHwgMjAgKysrKysrKysrKysr
KystLS0tLS0NCiAgICAgZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYyB8IDE5ICsrKysrKysr
KysrKysrLS0tLS0NCiAgICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCiAgICANCiAgICAtLSANCiAgICAyLjcuNA0KICAgIA0KICAgIA0KDQo=

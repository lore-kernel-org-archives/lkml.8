Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A6C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E91206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="cueKrrMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBRI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:28:39 -0500
Received: from mail-eopbgr1300040.outbound.protection.outlook.com ([40.107.130.40]:56384
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgBRI2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKeLhr7M0oHUr06pl+D6uJrTNZs5lKt1cVd0yG2mqlUKSBgg7tyhEGU5lNZHRyAyeoAvE0yRYPwTjgHOg+/TSm/navZ7LVqD+mWUArjuFXQQ8udsr311lwHEJs8R+UdepE/40agQVq7RP7zZQjI66GHPe1UAmaLybdettEcKEtgeJDlnc+ZYX6zk/Gl5GkrzTZ1SmvSmp9YZtq0ZMq9n5t3gj0pt01VNvig5vCn0zqGkuzhDbsATFLPualIgJAlQ9niFcI/Hv4k3lSwdW6U2X7MI1rl33h55+qqt21sfC1RYX5hPVfx+KjAQGHyyPmw+vLW6nKK/rgqT3VN/mDAk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDrzbNzN+9vo/i0UPbdVZUUMdZlyK1g7ngRBwNhn8+I=;
 b=DxvJm68t0wq6lqisTgXPj7AOP8diJOKzbUvMSW17L689/dmosEFdAAy97Dv0xcc7LVORVOe9AMCk8Ei6F0noWvxsJyHUO8zGsKOmxGUprGrXZp6HdwpLSKAEt7mgrZc5PzPu46Yj3gDHgnJYgSqzPZetOWcyOJ/n3q0BkV8yKxYRZkjs5TbY/0zrbiiWWjuj6Fdi1FQY6oc393ISk4xU4uzCIT2VfugkgPXUGgTUkBLadIxHdwu3k2lRYFGGt+XjK4ZnDQNN/4J9tAWYyXY9f2EbGsTwasZzxBto1UmBtGY67CFvb/niasXNuchTnGbggnJkdIujIhSuiy6CjBspcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDrzbNzN+9vo/i0UPbdVZUUMdZlyK1g7ngRBwNhn8+I=;
 b=cueKrrMRPa7aKBzp2nOufw7Jmtcyq53lu4DaKZajQH5erNvDwQEGQweoXqeaouwhMjHGQZYuKaSTaf+l+4J2Hue+MXEpjn6XY6mg8JjID/jsoaOhmfEgUYsIawKR8gO85uGPhsS6A0ldX7B9K9HG7iVe3l1OwMDGYBQzYJVgesU=
Received: from TY2PR01MB2266.jpnprd01.prod.outlook.com (52.133.185.19) by
 TY2PR01MB3580.jpnprd01.prod.outlook.com (20.178.142.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 08:28:34 +0000
Received: from TY2PR01MB2266.jpnprd01.prod.outlook.com
 ([fe80::1cfb:388:ba16:3778]) by TY2PR01MB2266.jpnprd01.prod.outlook.com
 ([fe80::1cfb:388:ba16:3778%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:28:34 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     Yian Chen <yian.chen@intel.com>
CC:     "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported as
 reserved
Thread-Topic: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported
 as reserved
Thread-Index: AQHV5jVoNSgznqBn6UOgarRl3H2BRA==
Date:   Tue, 18 Feb 2020 08:28:34 +0000
Message-ID: <64a5843d-850d-e58c-4fc2-0a0eeeb656dc@nec.com>
References: <20191015164932.18185-1-yian.chen@intel.com>
In-Reply-To: <20191015164932.18185-1-yian.chen@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=junichi.nomura@nec.com; 
x-originating-ip: [165.225.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e22ea86-92a2-4cf7-8614-08d7b44c8b57
x-ms-traffictypediagnostic: TY2PR01MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3580B548DCE4C8A2A0CCA97083110@TY2PR01MB3580.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(186003)(66446008)(26005)(81156014)(2616005)(66476007)(8936002)(66946007)(36756003)(76116006)(6486002)(66556008)(64756008)(8676002)(6512007)(31686004)(71200400001)(2906002)(6916009)(478600001)(5660300002)(86362001)(54906003)(31696002)(4326008)(6506007)(85182001)(53546011)(55236004)(316002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB3580;H:TY2PR01MB2266.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nec.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKJ2+QutT+4Pu4XDr0HKTF67JBOQIQ334SqWN1MZEd4WyOeGgSiPL8O8YQl6+WaiuCb7Cu3wTwaXoTANwTp65mdrmBELWJi9na9wuYkS6VH/yOpbc7BMeDpAhIlf18HFnLlP2VceJxgw5uSTRJFT5mn/0t4dor14AvAx/cSmyNKpNm8ahSz1jqKpigyi5y+qFeS6qcT10iQedVReWQ4QyUB0R9yJMYkTNymqffshKHFFTQpHo6iyzV/MPiXiu/vD8PTchotAUr0UkIYjaDP8fC/H4UTk1HlPOvFe+++Pzo38rY1Wfq2/I1GjIXIZMbNUAhnWfgj6GRA86v2XxpebSed59XsZY2M2gLk+R8TzcGtf0MoTmfYwR2DjP/OFUaytrypJOzD4u7A/0Y7kNAfOf9zYIdyXGDciHRoX/MAG5lB20UVEoWLYrrG6Xperp9CX
x-ms-exchange-antispam-messagedata: ANkeLXjqGa+FhmmztiG8lMyJfQRwJoZydHIN5K7XN3tQoUWc+GwJQ9uKnwCaseochdhoTJ2OTbvlp5tlhaQ/NCYjkS6K8l4RuvOrnxnljJYSDx1a8M7QzOdRfO6RD7pFQVdoyE6lpLZsE1BPRdzvHg==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <363C0F397BEAC24DA9D3E4725D40A776@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e22ea86-92a2-4cf7-8614-08d7b44c8b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 08:28:34.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsvfrNMjDfzKdrLZ9sQ/VlftO5OlBpgplC1fyiHl1jl0P1vic4UX3f8VPBwBvjVpXnRMkVmdipjT+3JDTlMuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/19 1:49 AM, Yian Chen wrote:
> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
> for device use only and should not be part of allocable memory pool of OS=
.
>=20
> BIOS e820_table reports complete memory map to OS, including OS usable
> memory ranges and BIOS reserved memory ranges etc.
>=20
> x86 BIOS may not be trusted to include RMRR regions as reserved type
> of memory in its e820 memory map, hence validate every RMRR entry
> with the e820 memory map to make sure the RMRR regions will not be
> used by OS for any other purposes.

I found "bad RMRR" warnings starting to appear on some x86 servers
since v5.5-rc1 and it gets even louder since v5.6-rc1.  The "bad"
RMRR is for the area resides in ACPI NVS memory region.  For example,

# dmesg|grep RMRR
DMAR: RMRR base: 0x000000a2290000 end: 0x000000a2292fff
DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00=
000000a2290000-0x00000000a2292fff], contact BIOS vendor for fixes
Your BIOS is broken; bad RMRR [0x00000000a2290000-0x00000000a2292fff]

# dmesg|grep NVS
BIOS-e820: [mem 0x00000000a067a000-0x00000000a2a79fff] ACPI NVS
reserve setup_data: [mem 0x00000000a067a000-0x00000000a2a79fff] ACPI NVS
PM: Registering ACPI NVS region [mem 0xa067a000-0xa2a79fff] (37748736 bytes=
)

The warnings come from arch_rmrr_sanity_check() since it checks whether
the region is E820_TYPE_RESERVED.  However, if the purpose of the check
is to detect RMRR has regions that may be used by OS as free memory,
isn't E820_TYPE_NVS safe, too?

--=20
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.=

Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28149C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C4721582
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="nIo25OHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIGGNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:13:32 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:59154 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgIGGNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:13:30 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 02:13:28 EDT
IronPort-SDR: heGRpDg7tN0ibMtdOEYZ0TLmGcwTFrzl2Z9MPLgDv5YZ2HuVZNwV5p0Mkn7+BtmP6nkHvbjfRD
 MbFEjlOBeezQjU41Nx6l1/Q70OmiFqhMgD8jl+FVbu3cUeVljX4IHcHsxq7rusjmTHAXHjChSe
 Q3xv3IDDnPZPG849dh8yX65EINclaNhlpmX/MwL62eiEoo/3fKBn5FUxSlsp9JTOpwKUBKgma2
 TmFs5XlLhLGHm5fk/xrXvcfIQ+llFpQUOFSOZrj6zr3YEvm6lmKyQeTwMA0uswNEsNSTrA1UsF
 MWE=
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="17866819"
X-IronPort-AV: E=Sophos;i="5.76,400,1592838000"; 
   d="scan'208";a="17866819"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 15:06:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw4Tur7lmiaMAA+4j+2oCgTcmmC/Mm1rOtZzmwJG0dt4jQeL2TotRt2+c2ePVTDY+Cax+CGLATj2JtSwNLUNKwXZw0a+v77K9+hs0tNS7Y3oOsnTdqlbt/dyI7yKBfQ0IVQ8/RdqevIn3QcjhWkt3ju29cXzqC735KsVASAuC5sAnAaNN6aL+mUjJoWn2pU7ltxkRH6wk/n2Gcb4jaeNTcYxXc6lk+t6JuJ5ELab3mbKmyNgmc7wqQK1i8W/tmUXL5GxvIY8PbmnmPAmWTv2r7We2tUdzKFck9A93tw0Dc4U5MDkd2pFCqipG6KaiPV/lQUyLUIDXiE9hU/gFDERMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbVt/4tJiapsSoBUpfZHsKzSr5F0bBPGFoWI0z4iSFY=;
 b=JEPn3qebN6kVdGGb60Xvm7IcPZDVwBi4JEd4Ig8k/1K9ca+gNb/I5/gKnty8VKbRYqJB8g1djTXyeOdE+BbtmP1bAj1GZ58jTaJvTm292NA9TU3cE4q2Y2idsO9NKmasrF/k+VVumQoqcCJgvtQfBhrm+XcR0QFguf3nTj2lY3kpRI/Jo8NAlVuWXDi0juNbYocZxbb0JW8rDlg7WKW6UH0iFGyxKRpPBDnoi96sbMemGnvc+Sdow/3uaqKDELhYXkHBZJVaiGlEQj+b2DDyxqbfWPssBqbq1JZewkONsaBPlQglpFo5/6vYxO6CFN+fSAEfGNggcGCV1hl8CXorkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbVt/4tJiapsSoBUpfZHsKzSr5F0bBPGFoWI0z4iSFY=;
 b=nIo25OHh7t46bjLSwKPDmPnTFv/913WRthmHQ7bGtvbWwpbvLbqyboKHSyp+qUos4azUT/8wqACvPDmfPShn7WZBUkQCWshZGCLZPsCFYmgqUenemx01BbOHSMXvYOBBTjjYBraOAOPRMbtfh/zTwNUbsMh9qVtwuCOAxqnvvv4=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OSYPR01MB5559.jpnprd01.prod.outlook.com (2603:1096:604:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 06:06:12 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::c073:6d63:dcbc:40fe]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::c073:6d63:dcbc:40fe%3]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 06:06:12 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     'Marc Zyngier' <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sumit Garg <sumit.garg@linaro.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: RE: [PATCH v3 00/16] arm/arm64: Turning IPIs into normal interrupts
Thread-Topic: [PATCH v3 00/16] arm/arm64: Turning IPIs into normal interrupts
Thread-Index: AQHWgG5nUQHY2fXl3km+tUTPdSWZ9qlct92Q
Date:   Mon, 7 Sep 2020 06:06:12 +0000
Message-ID: <OSBPR01MB21837E6EB11163ED58FF6CA1EB280@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <20200901144324.1071694-1-maz@kernel.org>
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: 212ca5c0d500443c8a813c06ecabd5f7
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [118.155.224.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9980ed6e-5bdf-4cb4-29ee-08d852f41f2e
x-ms-traffictypediagnostic: OSYPR01MB5559:
x-microsoft-antispam-prvs: <OSYPR01MB55599F6193AFA67F96C89F98EB280@OSYPR01MB5559.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwSASPrQwdFBP8QHgLN7PPmLa/jcmaRJkVbtqLZU20f06XnOt86lwh+Wdz111XoVbYnQzzYQT4MgwppX+VACdhWSSEXVqCbCukevYjjdt66VVQqJpUOWzHVjll5U++o9UW4BVwKzRX9uMazRVUi2b+XrbKWS+zgEq88oPIaambeLll2iFH3+u2ZcKaCe85twrbpxg4f6SAjxt/wKSswuwSOyfLSHs22T4yfGs3qptU/rRX7KOQpbuFL3XjNvOWnpcK0DWL1T5KpPWTUVqxoCIvENwSPWKz77t5Y11I//8yJG098j9CThqDtG1T5IMAQRiSWtVbPJZpztiTdFfvBgSPSCdoyoheSaDeraeTF+LHRneRilCitjCya/YA8y6o3JMiW38oyyvBB8ofAgONUqgI1zh9GaPIP2pDmNmwAh3zSiu4iCPYRTXH/gpy/OyvN0Snb5AawzXLoBzi6ub9LcJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(26005)(316002)(86362001)(4326008)(6506007)(53546011)(83380400001)(55016002)(52536014)(5660300002)(7416002)(85182001)(9686003)(76116006)(2906002)(71200400001)(66556008)(33656002)(8676002)(186003)(66946007)(66476007)(66446008)(64756008)(110136005)(8936002)(966005)(54906003)(478600001)(7696005)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 71yp0FpPb8HjKGchc7XDrAG9s3dRfAihZ7/bz/fMJxqp0nmnHwfqmpHzPYNCfuPyTukLRPjdTiO6gseImkzyqKfIXRhYiASp68Hv1w38lWjtmMPEJxrwdBiHzahxtFQR9FW0HI9L1mQmOvjCfKV8lrXVLN/aY1yHR8bSMCs4213v+PcCdbkeDR6Iz3cCixMRqlp/e1qU2VjXrYe/1aS0HovaZnmyLfzYYmQ6n1wjQOzn6Xahj4/zgdCiOq05GPsvwBF45k50tMek5cg4cr3v5Pnn1O9kjMMKyRWIvp4XLusBgdi3N07GKm30tVCcrpe5ncWFgkClHMfNg6aPuWfSIPX5v0A8n7XAbIg8f78W76HhfvgiSZbtqLB8bIL94sOoM3l75u9OeRealHPjQFblhoj2yFC/2TAzObQvuHhnbTC6IHyViLy6irsVcJKJTicw7PnYC5oOM3rHsdlofOTvRDDJZ3/eTfviW+i0NA1Ney6gVP8eXa0TsyhiuXiLm7sRKXEBkJCKOFOA4PCeEIfuDsK2do8rqxuwAJd1QZmqIQoLZd86Ypbpnp1AeRgR/Ru4RUrwEryRGqvDouOrpY/yxz5NmeygZqq0LAhZIQsOwPdYURa3vyt0ofvtNQtECrP2spnMxO2zP4KHChd8eeVBSA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9980ed6e-5bdf-4cb4-29ee-08d852f41f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 06:06:12.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfaDlmayjv+W0rawQ9TJvyOPPeTFOhoU1nm06qjO8JAeRiotKwluYoP4P4jPaMK5H8G+JB6yUp+kW2rNgIK150m27oIA8PjN1XFr8KSs08Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc.

I am interested in this feature.
I have confirmed this patch works fine on Fujitsu FX1000. Thanks for creati=
ng it.
I look forward to the day when this patch is merged.
We plan to post a patch that implements IPI for CPU stop Interrupt (for cra=
sh dump) with pseudo NMI.

Tested-by: Hitomi Hasegawa <hasegwa-hitomi@fujitsu.com>
Thanks.

-----Original Message-----
From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On Be=
half Of Marc Zyngier
Sent: Tuesday, September 1, 2020 11:43 PM
To: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
Cc: Sumit Garg <sumit.garg@linaro.org>; kernel-team@android.com; Florian Fa=
inelli <f.fainelli@gmail.com>; Russell King <linux@arm.linux.org.uk>; Jason=
 Cooper <jason@lakedaemon.net>; Saravana Kannan <saravanak@google.com>; And=
rew Lunn <andrew@lunn.ch>; Catalin Marinas <catalin.marinas@arm.com>; Grego=
ry Clement <gregory.clement@bootlin.com>; Thomas Gleixner <tglx@linutronix.=
de>; Will Deacon <will@kernel.org>; Valentin Schneider <Valentin.Schneider@=
arm.com>
Subject: [PATCH v3 00/16] arm/arm64: Turning IPIs into normal interrupts

For as long as SMP ARM has existed, IPIs have been handled as something spe=
cial. The arch code and the interrupt controller exchange a couple of hooks=
 (one to generate an IPI, another to handle it).

Although this is perfectly manageable, it prevents the use of features that=
 we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It also means =
that each interrupt controller driver has to follow an architecture-specifi=
c interface instead of just implementing the base irqchip functionalities. =
The arch code also duplicates a number of things that the core irq code alr=
eady does (such as calling set_irq_regs(), irq_enter()...).

This series tries to remedy this on arm/arm64 by offering a new registratio=
n interface where the irqchip gives the arch code a range of interrupts to =
use for IPIs. The arch code requests these as normal per-cpu interrupts.

The bulk of the work is at the interrupt controller level, where all 5 irqc=
hips used on arm+SMP/arm64 get converted.

Finally, we drop the legacy registration interface as well as the custom st=
atistics accounting.

Note that I have had a look at providing a "generic" interface by expanding=
 the kernel/irq/ipi.c bag of helpers, but so far all irqchips have very dif=
ferent requirements, so there is hardly anything to consolidate for now. Ma=
ybe some as hip04 and the Marvell horror get cleaned up (the latter certain=
ly could do with a good dusting).

This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3), as w=
ell as 64bit bare metal (GICv3). The RPi part has only been tested in QEMU =
as a 64bit guest, while the HiSi and Marvell parts have only been compile-t=
ested.

I'm aiming for 5.10 for this, so any comment would be appreciated.

* From v2:
  - Tidied up the arch code (__read_mostly for the IPI handling data,
    WARN_ON_ONCE on setup and teardown), dropped spurious prototype
    on 32bit
  - Prevent IPIs from being forwarded to VCPUs
  - Merged the GIC affinity fix, hence one less patch
  - Added RBs from Valentin

* From v1:
  - Clarified the effect of nesting irq_enter/exit (Russell)
  - Changed the point where we tear IPIs down on (Valentin)
  - IPIs are no longer accessible from DT
  - HIP04 and Armada 370-XP have been converted, but are untested
  - arch-specific kstat accounting is removed
  - ARM's legacy interface is dropped

Marc Zyngier (16):
  genirq: Add fasteoi IPI flow
  genirq: Allow interrupts to be excluded from /proc/interrupts
  arm64: Allow IPIs to be handled as normal interrupts
  ARM: Allow IPIs to be handled as normal interrupts
  irqchip/gic-v3: Describe the SGI range
  irqchip/gic-v3: Configure SGIs as standard interrupts
  irqchip/gic: Refactor SMP configuration
  irqchip/gic: Configure SGIs as standard interrupts
  irqchip/gic-common: Don't enable SGIs by default
  irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
  irqchip/hip04: Configure IPIs as standard interrupts
  irqchip/armada-370-xp: Configure IPIs as standard interrupts
  arm64: Kill __smp_cross_call and co
  arm64: Remove custom IRQ stat accounting
  ARM: Kill __smp_cross_call and co
  ARM: Remove custom IRQ stat accounting

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/hardirq.h      |  17 --
 arch/arm/include/asm/smp.h          |   5 +-
 arch/arm/kernel/smp.c               | 135 +++++++++-----
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/hardirq.h    |   9 -
 arch/arm64/include/asm/irq_work.h   |   4 +-
 arch/arm64/include/asm/smp.h        |   6 +-
 arch/arm64/kernel/smp.c             | 121 ++++++++-----
 drivers/irqchip/irq-armada-370-xp.c | 262 +++++++++++++++++++---------
 drivers/irqchip/irq-bcm2836.c       | 151 +++++++++++++---
 drivers/irqchip/irq-gic-common.c    |   3 -
 drivers/irqchip/irq-gic-v3.c        | 104 ++++++-----
 drivers/irqchip/irq-gic.c           | 177 +++++++++++--------
 drivers/irqchip/irq-hip04.c         |  89 +++++-----
 include/linux/irq.h                 |   5 +-
 kernel/irq/chip.c                   |  27 +++
 kernel/irq/debugfs.c                |   1 +
 kernel/irq/proc.c                   |   2 +-
 kernel/irq/settings.h               |   7 +
 20 files changed, 720 insertions(+), 407 deletions(-)

--
2.27.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


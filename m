Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C570CC2BB55
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 15:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D192075E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 15:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Vrd59eJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDKPhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 11:37:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:12986 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgDKPhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 11:37:03 -0400
IronPort-SDR: kOcxBF/rCbNDStUn7BW98k6fdJsas7iSDxqxj2ExPj/jQ+Gq22cTIAA9fWIVVIQdkHvRRdAOqH
 0SU7MtJd1UDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 08:37:03 -0700
IronPort-SDR: Dk/t81LTAHvQVQe9ZWDv/2CHfE9HPVuVTkk33fUljfMseBdXdhpHJs5mu+3wxIzZKT0udRNRpn
 sW0mcC/54q3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,371,1580803200"; 
   d="scan'208";a="270668802"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2020 08:37:03 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 11 Apr 2020 08:37:03 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX158.amr.corp.intel.com (10.22.240.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 11 Apr 2020 08:37:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 11 Apr 2020 08:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogX4MO7anW10Hv7rnb4ODaeoFJw9HQnjaRqrP9iHObjkRdb6sUJ06WsVNK+I7SUgXY8tHnWQUz2ZzbH+GCpivPYDf6ZBgQw5hRjZlKAKTBFxpZZmtOYHQBDfxcu1DDHex/atFQ+3/VRmkXr9J/yvdmB+7BcqVsjieWCTjt1GNzrPNAhPRTwxH5ggLuqdDE7o6advSHTD5JaqoFC6qRPQP9mrUJ3Lhr+C+ELbNl1M2vTaDPOk5h0xxLPJ4LPJkKo6T0rkRC9jmPikqMx1MHyGGko8NRX1mYvyfYd4zeOHH/llpnB9Pg14MwAr4kKEg9ji+dXb47CTiqFRtrgWAQyLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkoZuPbFuAfdGdJgs9zvWFqlFdkVIVfy+jIqCS3PnWw=;
 b=KXTtk8xTMXTJUbwG3XWGinTNTtILFdqyxRhkex5LzD2jyIYH9OClXEK/Ywn7twMmQUGPaTYHta0mdOd+AngmEWc3lZOtvwT1FzwKnbiyzLWXWcz61G0/oAGlWDRnbwoCI00kAIih/wcbiJrWdU5OGAPU6s/6nJvRMWZV5S2xJdc7GYRmKyEzp4KbOaEOhA2nGa5nAylrvQuyylrxa7pfZCZUapHliodOjzKS3qGdCpMSSyMZahZccXpD0fmQg+5E7lWpX19zy53tgzvPmNteHZnH93gBiuiTrvkYcnf9tlfT7hBo+UaXQdzvVw8O27jctdeqBQfxAQh2flciqAsEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkoZuPbFuAfdGdJgs9zvWFqlFdkVIVfy+jIqCS3PnWw=;
 b=Vrd59eJ8uiw/fs4Pq46nubDO0K9F6KDZYYvF26YPZGnZ2qXMNDtbsg/NTe1Xy5caGG8C1AzG05qEnFxPBrmtfjqI4tADKYr3QWa6BaNAHA7AFpOe/wn9LBoEamIP2YaSBjuoA5kDqhAFUEyyxXSd3r91VheGv7+TZFVLH3+cjkk=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BY5PR11MB3864.namprd11.prod.outlook.com (2603:10b6:a03:18f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Sat, 11 Apr
 2020 15:37:01 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::65ec:b3c9:7f24:d067]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::65ec:b3c9:7f24:d067%6]) with mapi id 15.20.2900.026; Sat, 11 Apr 2020
 15:37:01 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ley Foon Tan" <lftan.linux@gmail.com>
Subject: [GIT PULL] arch/nios2 update for 5.7-rc1
Thread-Topic: [GIT PULL] arch/nios2 update for 5.7-rc1
Thread-Index: AdYQFvGJKTSDDZIRQZevOfEv8xmvqQ==
Date:   Sat, 11 Apr 2020 15:37:01 +0000
Message-ID: <BY5PR11MB3893C6C552E66D3BCEFADF28CCDF0@BY5PR11MB3893.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmJiNTBhNzAtNDliYi00MWE2LWE2MTctMGFmZDdmZjg4YzExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQUVYb0ZWMTQycWZ2WmV5cjMwSkhhTU5FNVJMcU4yak0rQkFBYlYzWkdcL0NDcW9FN0VOYmtHNXJ6bDJqbml4WjcifQ==
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7adccb0d-e09e-41ad-0717-08d7de2e2dc2
x-ms-traffictypediagnostic: BY5PR11MB3864:
x-microsoft-antispam-prvs: <BY5PR11MB3864670516BF14632924CD09CCDF0@BY5PR11MB3864.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 03706074BC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(76116006)(4326008)(6506007)(64756008)(71200400001)(66556008)(66946007)(2906002)(66446008)(33656002)(15650500001)(7696005)(478600001)(66476007)(26005)(316002)(52536014)(81156014)(8936002)(186003)(86362001)(54906003)(5660300002)(8676002)(55016002)(6916009)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHywHf6OAXL6dOMRLlabfleLybEmoblLkBILRK8tmHYua9gADrI1DMTTQuO7OTPbNehdXto89q60cHZZH0kf66OLjpUygVqsjyUIWONbt/R1oIT0QOuojfj8uqpuhzJqBL4sDywxBBRNBZWk2Xn47ukfS0rmBPj7RZQurdTsd36z1ET+jbw2olP+CS9x3rwbMKqe7/8qqeAcCbPFdeupIyIR7I6c/ccyoAYgLHZuKJXT2onpjjB+aNz4V43euBpp2hHPJQry+T1x4OscLkm+JN7uy64kpQOFK0BI3kQvQq0D/nHCsMIbghxvngrgUk0ORbFRVRulLDEG7bcaaDf25uC4VgIdfkQtazJMZHXtPCXaN4Wam+W78qLvwdgba8RWIowq1iJObMIcA0dzwROEVY3yRsD3l36+44i9rv6AXsVoysNsz5egqM7x3USqBlPC
x-ms-exchange-antispam-messagedata: 2ttgfS0ZcjUtGcwETdlVmVJyhfqAfZFDWjikmrDt/49XSkNbC1txJh13jqnWlYnHQNpZDHt01qqyucEAdsTcxUlHsEMoESjngHEuhCRoxeVfpin9OtGLviGGZ03qBc8iiggQlkW4RhF80xagVNbyuA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adccb0d-e09e-41ad-0717-08d7de2e2dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2020 15:37:01.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4KpnQyWRwnCuj25losnGNbAlshKVDWa0jDhpa2k+oy2YuiCOm+m1wJZIXaaV8ZH1VSloqt5qNC/tvPp5yP+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3864
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus

Please pull the arch/nios2 update for v5.7-rc1.

Regards
Ley Foon

The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b48=
:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-=
v5.7-rc1

for you to fetch changes up to 0ec8a5054d7fc5e31509fed7893358564ede2477:

  MAINTAINERS: Remove nios2-dev@lists.rocketboards.org (2020-04-11 01:46:18=
 +0800)

----------------------------------------------------------------
nios2 update for v5.7-rc1

MAINTAINERS: Remove nios2-dev@lists.rocketboards.org
arch: nios2: remove 'resetvalue' property
arch: nios2: rename 'altr,gpio-bank-width' -> 'altr,ngpio'
arch: nios2: Enable the common clk subsystem on Nios2

----------------------------------------------------------------
Alexandru Ardelean (2):
      arch: nios2: rename 'altr,gpio-bank-width' -> 'altr,ngpio'
      arch: nios2: remove 'resetvalue' property

Dragos Bogdan (1):
      arch: nios2: Enable the common clk subsystem on Nios2

Ley Foon Tan (1):
      MAINTAINERS: Remove nios2-dev@lists.rocketboards.org

 Documentation/devicetree/bindings/fpga/fpga-region.txt | 5 ++---
 MAINTAINERS                                            | 4 ----
 arch/nios2/Kconfig                                     | 1 +
 arch/nios2/boot/dts/10m50_devboard.dts                 | 6 ++----
 arch/nios2/platform/platform.c                         | 8 ++++++++
 5 files changed, 13 insertions(+), 11 deletions(-)

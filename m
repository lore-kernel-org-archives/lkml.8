Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A75C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410B422464
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OAZmuCKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgAPAGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:06:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:25323 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgAPAGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:06:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 16:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="213883162"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 16:06:19 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:06:19 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX156.amr.corp.intel.com (10.22.240.22) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:06:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jan 2020 16:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUGXYMCZSYOWyX0vvcbNXQHkQghQcDhPXGvC54HryMvN1J5yUcviguvDloWkovJyJmMWYoM8z5SX9P/6lX5Yb1j0OII+6a62kv4OylEeQCdZq1/oTKEpu92ILWDRQnF6eWm6TFWU8ccrBQJwI/Yomx5ampFR8feT1QuyfGOOAGV4iE62veTFrqQi061c+GzkxWn+RhjgAClY5yHKj4KnsH77N8BjZ0Fngz24kAJYzMzm+jZqGjurSxEWmfqBctTiBlcYnPgICDnVgAZyPETrJdwddNGkV4xGKEp6i8iUMKdXsaKYapV6vz71M0f3JuW0NaEzS71nKMU5WXdHbdCAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlhkTlf1mZSuP+PZlBpBmR3dZuT6GA5KU/s8p8xXdE=;
 b=at0ZcJn87qDH/rkl6qQQIHRlXFCj4ayv76jwm+hmlffIWyFxH0LiTfoPuhe4g1xcy45rQXOXFHD+koy4CRaBIZnAp+JAei9Hd3xywiy3XMBXisQ8l81ymRqsfhjAnpoGXRl18UDKKA9Yojao7OCPNky84Nh8HVtJqVRekl3pqOVZGrHTCejLg4feASWTuWZWbI1bm6UbOxe3tJTAIqgGTk5Gq8UncF8eOOw0CFUtSwas5XkCIjSfk4kWyD8asDnYwA3Z5FASRJaWIOUqlj+TZ8tsGzxkzo/Gscm2fHuzWngreJKrj3HetWMWQQsCuugHkCsn3jozbgW32Am8F6pKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlhkTlf1mZSuP+PZlBpBmR3dZuT6GA5KU/s8p8xXdE=;
 b=OAZmuCKzWplu0Bqt32hBvE53NR8pBQNTqtE5JDs8gSJVYk6v3/wYnhHZN1Z/PGhUpOC+FfWeib4Y+YpWbS7Op5vG5ErFm7ZDuteODkGdmx+sCKQ8WFGTWUKSD3zhxPQjAgMSbzdoAbdQGBt7NRp17F7FmbcjnPrUqq1zBddVvhc=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB3936.namprd11.prod.outlook.com (10.255.180.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 00:06:17 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:06:17 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "'lftan.linux@gmail.com'" <lftan.linux@gmail.com>
Subject: [GIT PULL][RESEND] arch/nios2 update for 5.5
Thread-Topic: [GIT PULL][RESEND] arch/nios2 update for 5.5
Thread-Index: AdXMACFQFvoIjeFmRG+tETjRj9SIpg==
Date:   Thu, 16 Jan 2020 00:06:16 +0000
Message-ID: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjM1OTRmOTgtYzUzOS00NjhkLWJlNmYtMmU1YTJhODFlMmMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQlVWMXFnYjJCWUQwZ2wyVWdYSmVsVmx6d25kaklGVWJRRUI2MGpaV0kwR091QnZBbG03aStaRGxyaHB0QUs5OCJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ad66f1e-1a80-4426-e9cb-08d79a17e88b
x-ms-traffictypediagnostic: MN2PR11MB3936:
x-microsoft-antispam-prvs: <MN2PR11MB393694B00578A5231E5DE464CC360@MN2PR11MB3936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(4326008)(478600001)(8936002)(33656002)(54906003)(55016002)(9686003)(86362001)(8676002)(81166006)(15650500001)(81156014)(316002)(4744005)(76116006)(186003)(52536014)(26005)(6916009)(6506007)(5660300002)(2906002)(66946007)(7696005)(71200400001)(66476007)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3936;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1XRNb1Q/yjKWxiUZKWsTJAtW8efJmLwPIHI5oNEdvj1xbzap9OG6IfxmActPbMCCvN/hQ3ykQ3n9HKq9MMYXgTzew3VvrdHT6C4oNcek+yxZTTDhrgVf+6eAgtF5g0Utfz9WLPvbFl29hN03ku7CmuUFIPA0uMJmlbwQh+7VzN2WvQgAZ6J3DAeWFm371igUr6yEcL6ugvbdo7/ZeyaI6Bm7arQCKI8qAMMCGlimuEeXUomYuQTqeqR6NkoN/z/Tfmn+0Zck++CZI7xFptXjc1xZu4ne8lj4XDJCO7PWRwUbS7w1PzwUdS3NxFrYVLXTRcFlHYPdEZJgC4VQd1kDzZ882eyQkQwls99mbltYpuwG0mHbVG8GKuut0GlT665YcNTPyanzwGxog0sfcnOoo9/cpTVdyMC4o6i9Z+2rOAovjYtYFT//cv8TCE2+R1i
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad66f1e-1a80-4426-e9cb-08d79a17e88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:06:17.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBXH4PTjnaXF5g9aMhRBCQaTKNa9Q0Bo5L3fSvwITTp6DJW9EAM6mUCL4h+Ahwg7tWNkJKHz2Px2eacXoIkGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3936
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

One update for nios2 maintainer email, please consider pulling.

Note, resend due to linux-kernel mailing list reject html contain email.

Thanks.

Regards
Ley Foon

The following changes since commit 95e20af9fb9ce572129b930967dcb762a318c588=
:

  Merge tag 'nfs-for-5.5-2' of git://git.linux-nfs.org/projects/anna/linux-=
nfs (2020-01-14 13:33:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git for-linus

for you to fetch changes up to 051d75d3bb31d456a41c7dc8cf2b8bd23a96774f:

  MAINTAINERS: Update Ley Foon Tan's email address (2020-01-15 11:11:22 +08=
00)

----------------------------------------------------------------
Ley Foon Tan (1):
      MAINTAINERS: Update Ley Foon Tan's email address

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

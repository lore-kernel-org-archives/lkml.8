Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8227C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8474C207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tKOWZuIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFLINz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:13:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:7593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgFLINy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:13:54 -0400
IronPort-SDR: H4pJazaeSYvNXA5Cbq46SrVpJngD9/KSAfz8Sxegwd3Z/iXILpnhMe5Yx5cL6KotpcTkcLP4Nl
 3ULORRA1zryw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 01:13:54 -0700
IronPort-SDR: oDAk8sxdVbC22xvQzR+McSW6Wns0IoHZABtj+gVFrPbjpHFrZAk+jFZWqdRX8KclfAfDDQ2k1w
 8HdMg6ND5JRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="307237033"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2020 01:13:53 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 12 Jun 2020 01:13:53 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX154.amr.corp.intel.com (10.22.226.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 12 Jun 2020 01:13:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 12 Jun 2020 01:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbxEvsXu9nNuScXQ/KqMoflrP6vsGWmmRq3VVUGNJt8mhoZe6jCO06dS8p7ufUtGJijKxGkMB4z8Gai05JWBoNWbx8A4eSLpZqibK7zm7U7np+sL/OXMEmKmxJ1EtKCZ1f328AeuQOTKWX2FAD1fcq+mlF3FXXHNasf7AaJwrDPjIxm29qwzTc7E8SChKzKk1mttGyJZhmiWNUTfmSyZXjAOD1k4TdWo+7s04saQbd45ndzUM//25yDE7Ru53OIgFmOM9DmkUlGNH0gfLZ0Z2s5jGoJvcen5hx9hszhKojnvy6ksftJOIzFZeKddYKShzFNhf2a26ZIyhzE/8xpgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0H0PWRo5ODemNLa90pwQ0X+aXs9h//WCAMJGy9C3ms=;
 b=jg3Le7uz0+aih2uTfJeq/wN3TDtuyPMC7+X6g5rRmZWj3yUwt6o/nww70sQpOODTyrKElr9QX8P7dpXehVYh4If6BfscELhNs1YEvEu+q3h8GJolNKwBONwB5K7rbhNJUIWla4vUXU8GRBNIBhhjC0P6EU8szeBfFHx2NHhRx5oRDOSXhVXAwypQGv6wD9bC0xQ94acu+GtfLhvrKbz32BfgDM7B+h+souTNZG/q0IyiBn3XrtoWEy+WVU82T2ONLuzS5Gp8zRoHBRGdEtm9mZ2hLs678P1pNnUsBdWWQf93JDzGlG/LQJtOd+48fw1oYLOUaclMxWjbKlhKUIOCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0H0PWRo5ODemNLa90pwQ0X+aXs9h//WCAMJGy9C3ms=;
 b=tKOWZuIK+Nv0y28Z9BVDoLLTFXvlc3CJd+u4gKZfLWM/hgiC3lduMpj4zSXZ/cEAOEHNIFhaMui6WwS750kRv7Tx2gP24eZfx+n950gaTrPJ1xhdJQzvPlUNstvHIivs6Yq1gtZbt4n9+pe8PoIhxYm1ZcaCNwGqXREOO4IFNWQ=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BYASPR01MB0030.namprd11.prod.outlook.com (2603:10b6:a03:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Fri, 12 Jun
 2020 08:13:51 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::c85c:ec78:c650:6ac9%3]) with mapi id 15.20.3088.018; Fri, 12 Jun 2020
 08:13:51 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ley Foon Tan" <lftan.linux@gmail.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Subject: [GIT PULL] arch/nios2 update for 5.8-rc1
Thread-Topic: [GIT PULL] arch/nios2 update for 5.8-rc1
Thread-Index: AdZAkRJcV7VzqaqSTWmKJUzP0xQWUA==
Date:   Fri, 12 Jun 2020 08:13:51 +0000
Message-ID: <BY5PR11MB3893D9118F509981F5612029CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.198.147.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7102aa8e-10dc-41c1-b94e-08d80ea88a99
x-ms-traffictypediagnostic: BYASPR01MB0030:
x-microsoft-antispam-prvs: <BYASPR01MB0030A09E41A4543A2444FBBCCC810@BYASPR01MB0030.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/E4t6bNVZxNrtEoR2Pz2tiiSREASZZTqzBrC+T4L8FFaOEFPVlhP4QMzwkmgLotE8fKUTz/DtdEGhdubVdK84cqmW/Y9JAEaxBs6aIqHhLlgO72GFY9fuE8jMDlnpqQAstvPSgbtc+TO6e5179tBndNfrlWZqrWtT4wWvRPCIHdQWkvQYLTr1QYPKy7GWG4e1CBx1CSzdapw0qLUT6OVPQeeWAeG+bwcyJO8r6k+2wNXVR4+yRol7Z1l3KQK0NyTN5DwLnWbiUPMrRhWIW9VronifkTJSgddbNbeYHFSt0aSlPe9d4W/zG9l/Wwla5So/tDD1hkuBYWj6wnZl20XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(4744005)(26005)(8936002)(6916009)(83380400001)(186003)(4326008)(5660300002)(6506007)(7696005)(2906002)(66946007)(52536014)(316002)(8676002)(54906003)(71200400001)(15650500001)(66476007)(66556008)(64756008)(66446008)(76116006)(478600001)(9686003)(86362001)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pA89zre4HHZAJQI874ignhOQfj05nuXSTDLXYxzWfC5wvu0VJjJi6c9gDQqfqT0/i+QUgQh3tqfTzp/KZ7P4a5J5o6rX+DuHV8f0k7bQPSbiBCOIi2T3SwmwAer0s6MvbNVtQOt9Re4Oz6Ge8MVYLRMhFahjn2FiaVcGadv2dhvvLwmL8073rkVDsJ6YO9pMYIg4/vAVKLF/T97CnGoUqHE6zgIVOg62N7Fx+sPS4Kh6IYSR/00wSofKCGHfTPH04jnRMSoEFfEL/duojxu/sKXnt018GWbW+6VWIn6n5S8EChC8WA846TQARIjSnuA0Sl5ZOLDXnpq5pltXJku1hWRS+w4SyY5yiPpUnokQ6Ucjtz/Q2tpg66DaIwfhAiAafZU4SoWy6E31RbIz1tF2eeJxFGwD4k8RaPxextYn8D2i1KMorxYIHI5XfmUB13864Ld2nIRCCVEzwJ1ix5Ad2LwkF4KbhjYBDyHwF41GujaliF5Oj3Y91quC1Ecle7qe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7102aa8e-10dc-41c1-b94e-08d80ea88a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 08:13:51.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzYfmzUaOvkc9SfUv6U26oMvi140zjTBgVVmavLIrYIvEAtUBJH5bIrqglQXqKc6xaoC9EfGcFwaDlc7Ryenxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0030
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull the arch/nios2 update for v5.8-rc1.

Regards
Ley Foon

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162=
:=20

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-=
v5.8-rc1

for you to fetch changes up to 6b57fa4d374bb8c005dee396c56598c14b9c01a6:

  nios2: signal: Mark expected switch fall-through (2020-06-12 14:04:49 +08=
00)

----------------------------------------------------------------
nios2 update for v5.8-rc1

nios2: signal: Mark expected switch fall-through

----------------------------------------------------------------
Ley Foon Tan (1):
      nios2: signal: Mark expected switch fall-through

 arch/nios2/kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

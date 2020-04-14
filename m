Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E510C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2B206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Rz8QQOBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440930AbgDNPs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:48:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:61125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440880AbgDNPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:48:01 -0400
IronPort-SDR: SG9kIur+NI26DiMe60mZapPsaL0kL48fdA1ZIYQHFkoMw4hMfnT0BL8BshHNRhe0Ozw/fPumDl
 lalO8W6iD8JQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 08:47:58 -0700
IronPort-SDR: xJAHQZ6bYv/SOpJ9uK17KF/OU+SNm4anNVu/kwyrSE2t/aD+JW1+aq2jXUoWxYcsmlOtKQTWo3
 IEB1zgtid4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="253232846"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 08:47:58 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 08:47:58 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX114.amr.corp.intel.com (10.22.240.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 08:47:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 08:47:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgGQ5uYgGSuLkN/Gt5aFnhprVEOGKxe34Cw0gAtNPBHDjdSIXr+qspO2lCXLPe+YK7PBrNone03nXmn0rLv/QFZQRI3+T14iGQDarfmNtPekc9kkG/hChmYqc5Vlp2NDNBJqzTG3+ITrlm0XvRFCgcJLtAdYSH6uaZ5YZAO7bZxS0bd05QSvYT+xrDrUPCYLxsg9zMQvRz76j7udKLaRG8wDdzsflYO4gV6olw759Rie3huA/pSylk4sc+GAjrWiQfHint5YEgp2kCfJE3Wa5FFd9NVBshRXO1Yhz+fmhXQdlJzps91vdXFwkE4HTD5yOYekfs05NDg7p05fqOcCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKHpKbDTokhP6ZTmVLa5MgqdCkaDCgaCGRP53P4itks=;
 b=a852Xco9qu3mpdmUHwaklaQ9vRSoPlJFLKLUfAan8UisjRs6k8LwRbrug5OXMcAa2ofRSIfgRNDz9b622B86wqi+kRI+nZZe9KIosUX30jJVQ+ujkU/A/rBA3XZiaX9xqcXjCefSh5BeYvgdN4JGp881aEqmsWcFvFmF7H181NWDnsgEEWJHVeVImXQKBSVBDSdVNysByFOz3OQF2QJUrnUpTmOjn/ywLa5vemA6WqKSDkCjV4cbB/+LYvrx2+u9tCSAXOzPIHM9S1prVrmNgyThBVcqgMsJpB604S2o6FSF+LNyIJrL1Nwfd2UWgLEt9BLSmV0q4xtGJEjDD5lotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKHpKbDTokhP6ZTmVLa5MgqdCkaDCgaCGRP53P4itks=;
 b=Rz8QQOBQUTXoe9bdJyAJ6DpdJYiZNoB2kCQgbhe7JKR+WAIDajQlG9cZ5rLpGKbaQpvqlxHoyexwyN6e/OFzf5Xc8c7uOaO/yagWaoTaKvXDNiUFrD6t/qQDtnCI89OwozV7/b+ntUk5MrAYafrWlom7Z/UuyOO0R++v3O2m718=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Tue, 14 Apr
 2020 15:47:56 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::34fb:3d67:65f8:d0b3]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::34fb:3d67:65f8:d0b3%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 15:47:56 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        "Simon Marchi" <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Topic: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Index: AQHVet/uukAR+D18mEydsD8sMzHMMqeNNAKAgAAL8ACAFbkggIAAIFiAgAQpEQCAA+z5AICAuHaAgEy/kQCAAUrjgA==
Date:   Tue, 14 Apr 2020 15:47:55 +0000
Message-ID: <F9FEC739-62A5-4FBB-9959-D0A6EA10E80A@intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
In-Reply-To: <20200413200336.GA11216@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chang.seok.bae@intel.com; 
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54c5e3bc-b0f3-4cce-f46d-08d7e08b3338
x-ms-traffictypediagnostic: BY5PR11MB4242:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB424200FD5AEE95683753FA5BD8DA0@BY5PR11MB4242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(8676002)(316002)(5660300002)(54906003)(6506007)(4326008)(71200400001)(36756003)(53546011)(26005)(478600001)(2616005)(558084003)(66946007)(66476007)(66556008)(6486002)(33656002)(81156014)(64756008)(66446008)(186003)(8936002)(6916009)(6512007)(2906002)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u91aaTw+1z3GfeAviBo9Voq+M620qQywYzVnZsuSI93XxqB5A2OMOj5Xok6q54n/aawcQlhLuaiBfY0VvB6PfMozWJ1PcTQ0C+ueWBGl4XVFjoPAFXhiWN7EMjRbkGGSRXzdzvHlC0ZU3pZANtbHRSSIQLchB9JOyQaDzljUez2iv6hA8Dh5IcTbvRtsDQs4ZR+fbhl0NpPwgytB1+hXQWeAAhCBJnv+po+iRVOOOF4h53ONNvpOgKSB3WL2H7fz/KDHgh4tlvBg2B50FhRgaXLRKuCTYU8Nc0nM7D+uUvBqCb/Fzi918YznhPPEHUcUI+QcB5hM4HEuNRj45ZCDbl6hMvLZlPGcGJb8Q0hjbXAUnb/EYluO2RYBWu9xD+sTVeA0LS9utTNDwBG6swXZl5Ox1x6BwKgTgezAek/6HYSGpEMeypsl5K9mXuG94idx
x-ms-exchange-antispam-messagedata: 2BnGzNkI/kwaExF4+AEkVCQXbbfTvVumJ9vPeoentu5LCwz3I6Lwt4YJLHxZXGICh8vbl5zbz+v+bTch4h7Ckg80OIyxHTlY9C9rn4eC4+PcsVYNZBk9OUo9QYXSkGkAIX/7z/aJ5WOAHFobGs0qsw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <527CC5730488CF4FABF518BF8565246D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c5e3bc-b0f3-4cce-f46d-08d7e08b3338
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 15:47:55.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gduhJah3v5y22ZIWfM9fUSs8ityXWx0iOSPGU50kqfHtIDqZXIXUL43qoNw+teYOc3hZM29MIeoQMCAHafFn32ihAxbhBnz8Le6M/pAZrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 13, 2020, at 13:03, Sasha Levin <sashal@kernel.org> wrote:
>=20
> What I gather from the Intel folks is that the GDB folks are okay with
> the change as is and don't expect to be doing any changes on their end.

As far as I know, we never get any comments from GDB maintainers for this i=
n
public.

Thanks,
Chang

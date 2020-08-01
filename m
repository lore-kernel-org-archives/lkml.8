Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7882FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCEE2076C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yw+39nx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHAI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 04:58:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:48178 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgHAI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 04:58:20 -0400
IronPort-SDR: DiuoB3ZjoPj1We2KVIlMeL8JucjMxPuvvc3nIRvxb+D+23ODPnrgaiiQAIsnpt+ofNxU+nH9r4
 4RrzwHWWdQEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="131978381"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="131978381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 01:58:19 -0700
IronPort-SDR: Bq/5FFeCtgpkrSiielD72BD16DLr3BiLC6FsHOZ/gUen7bpv0bavhTrz+ZvFx0H5gS2AfTzIwM
 c1JPLrKZIKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="287498247"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2020 01:58:19 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 1 Aug 2020 01:58:19 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 1 Aug 2020 01:58:19 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 1 Aug 2020 01:58:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 1 Aug 2020 01:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXRoeiRUM80SdTRAw3OrqhxolcSuOEV5CMZq9l6KoNX8xfff/5Chql/tOw00a5yDbw1sNVCZAbc1h+WvMJ53x/xitpkEWpu7OjjgNX5hWSombLSu1ctWkx7s0aveN3QIVq7w0JMnMphdW8OKNSVW02GAaJSanQNU7H7LYvRBIVgLXRGEP/XfSx0rleF7l4QMhMvCZzK2LK62N5CHtWeLOnt2rBKdjgpZQ7Bgehn9Y0E5vdj8mKBHkXRrKZo42uZLmTnbtckOl7reUBOBjQ5aVS4N4HW1xV390X44pakBxrjdDFwAb1pBsZ5bZxGa4pyN3xqI6bbF/5Xlf+zbs2XZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6lklfolHyhT+cYxuvUaUD1emNRxlZNXvl/I82Ckcyo=;
 b=MSob27Dh4tU3Bj76ANsOWQ35oMUqaBgsr9piH6sXPIYGq1ntYCJGdcGknsqLse/L1yhSWET3/Hp/bT37cT0pQspcVyDbY72amBGKOzB4k1Jsv0dgX+ijiisUHvqPqjxqozfB/7Bz3qTh2mvQWl9K9rYlt5LCh2PRMCnvLc/+qOER0uHUepQlMp7M1+VPaSR2FIVt1if5EdtWHjkSDBfg6Bg/EPMnUUm2b4dA/hs/p3ymQXqt+oyHti4Gpn/k05lQVbKbo0znwK4nzT/h7C3PPQSH+1Fs5moiasf4qZYMCn5Hf3nDWbC42eXkE+N2s6/BpZxxVlwrohXcgju4waA5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6lklfolHyhT+cYxuvUaUD1emNRxlZNXvl/I82Ckcyo=;
 b=yw+39nx1Iiymi+otkZAxxO4WjYtc0Y84BSUI7fKiFggZRrdVb3atSUoxbvmB3YQ/HVpoDDpdKm6jGR6h0J5ggwXaO1uZ+b7cMF1IaChCfM1d3BmUqnedYlIV+xKdUJAHPZuoQ/Z0mmUZAzafmJ9+ZvDgrY/kUe+OPjvv40egg+Y=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB2699.namprd11.prod.outlook.com (2603:10b6:5:ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Sat, 1 Aug
 2020 08:58:16 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41%5]) with mapi id 15.20.3239.019; Sat, 1 Aug 2020
 08:58:16 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "Mark Brown" <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: RE: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Topic: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Index: AQHWZzZzIgMFwAI7HkKT1/DPVspAl6khsDgAgAFDasA=
Date:   Sat, 1 Aug 2020 08:58:16 +0000
Message-ID: <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
        <1596198365-10105-1-git-send-email-brent.lu@intel.com>
        <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de>
In-Reply-To: <s5h5za3ajvb.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [36.230.210.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc152a43-5278-409d-c746-08d835f907df
x-ms-traffictypediagnostic: DM6PR11MB2699:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB269903EA62777B9973744663974F0@DM6PR11MB2699.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wcrwfa33xbkON1R1JV9TZBl3H35u8O/pX+Ws4fFsr/kSOkJcL1uIjhkpHniR0r1Fv3KRwI+6TRV10NJMnDc3gqyIQIWiQdoSchiyFaguykS327/gp+YB/c0+82k+luq7oSBEDJVBbGjDGpCfya6XVwNqPWjgAfU9dmMB5+oXzZ3piW6xzOD80FAMUiYUCGptz8MS4OsiPSXIT0wKpOMEJZYK9UtUWqrrD0k/RhI+J4q5MZN7aDf37jNfXCjEz4Kog33pXjT/T/Ez6rpbk/ERFx83QMJJTVpvitQfJeUTfWRonthUudsI7SB1t8DObUZ3KiXNtqnUzcqbeGJ8FQW/pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(9686003)(316002)(55016002)(7696005)(26005)(71200400001)(54906003)(478600001)(186003)(6506007)(33656002)(4326008)(86362001)(558084003)(76116006)(66946007)(66476007)(66446008)(6916009)(5660300002)(7416002)(8676002)(8936002)(2906002)(66556008)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Jbn0exO+KPKfBPRmLwCRWjnabZW50+srIp6c/XkeyVp9SY9jVlcFURni2Hv2/l+6Vk/NdzytdbMfjofsVmLaAiuVjjuWwkxCGFUKedfMJ8ZJJEedOmDrjlRmZ4T5ltnxwg3Ad6Z/+3vdCUpKZAz5cXa1Jo2vw1+MFPchLQlBNbsNV42sGGXww7HZn94PkG4Fwr1mSvB4CWg1G4/rHjwfgS4WpTzTSB0fJhEvIwVJBZG4bcZXQc6vgFZv1XYI2d4Z/KXNJnBrzFrWu4XzTfXHD793X6q3izItfgaM9/yqzfG50uSLN40tmRJJgjSAVIvfAcOLTFRovwXYXdINlcp8d7qp76HF/O4slhx4kxBu+jAXuDCbWGFUy++ioO9p6eQztXy9lCY4QmtGt/fn188qM2p1B8yPGKmIni1SQNU0/b9iAZwNMNllO0sJ6PIZuGrDri3+EaFMKTH02ZpnzsdKwPcF3/8wpAQzEGAvqKgaVeyoFbZr5UEppgfjdxRutilYGKdK4rP1qTtS2OHFkscL5TjXdj0fslUtQh3rasYMCsD/irZhAsGTXvHDqtMh54OQ5S26iD5RTbNY97Mye6U8JZr0tgKR1a3bU+99InS9GTut7Njd/2CBNcjapTpPzqCqKtpVrOfzw4LPbeenMesfdg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc152a43-5278-409d-c746-08d835f907df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2020 08:58:16.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+lQwdVlRhjswY/Bk8my5Rx6JEMjTopD7aZyvx1pzBLIZ9mwebH6PF7yKSgI+8qitLX7EaU0Io/JOEeksybyJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2699
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Again, is this fixed 240 is a must?  Or is this also an alignment issue?
Hi Takashi,

I think it's a must for Chromebooks. Google found this value works best
with their CRAS server running on their BSW products. They offered this
patch for their own Chromebooks.

>=20
>=20
> thanks,
>=20
> Takashi

Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D7BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A5720722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vxoUCCtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHCQpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:45:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:50179 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCQpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:45:53 -0400
IronPort-SDR: KTYjsG1y31nb4nuX3VkON2Huoi7bupHFHxfv9eBfyX7foo6StAc9tLPNu1h3s2IphHJintpyxc
 rbtguGgCX9ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170244658"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="170244658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 09:45:34 -0700
IronPort-SDR: M6k6Bv0HwMwrud6vXVjVsSVrKdoQMAfBm6g6ayOeKhrhRstsBh8MVVPorcysdHXf401ZJ5zxvL
 mDvV4VITHROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="492456721"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2020 09:45:34 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Aug 2020 09:45:33 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 3 Aug 2020 09:45:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 3 Aug 2020 09:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8Ksug6jFRn8UlN5D7+2jmgxHcQa6c+IWB/dIA0Jys+jyECBdj0Qzq/BflnzsXUlslIhwy4OZMnJWnYlT/5K5Xb7SvIHAuNVRGnxwPUWUOglbY//m3wtXGTiAe3mzlSV8keSutViGWx55Aj8tc/yOYzEPmcYijarU3+yGZrciRbmM2D8Lx/jSK1GvYddwvBN6JGzDHzV4NcGShnlo68bFzLHAuzcHXkxq5YVix7W2Ue8lpiEGbQAsjhCZ7/Gb76+ZpJIW2ylyvQ1D+x+sLQrcOvFzKNPndwyNOoAyA1zdhE1M+wgDhRd5GLLIOKKUTu34l648wkZfc98/OapeSykzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHE5DXY6YRgEB+n8oyPufxwgDCChOC6fF0iqIfrn5W4=;
 b=lKtsbtB4Bn0Fh8tNOx6pelH85DAYjswfM4isxph3kmwuciRIvjETJ8C1OzpsZCJSwU8DV2gwKIW76XFq0TFE6jGZ3nce1mnqrpxZX99jxwdUrTOuiuSbrZRp78uD/nDLMGX4r/nF91CwbGbhVrwW9QcpT85894H38yr06Yt59JkxK1J9WpYPgI8C4PfcAkBMw155/TjuAb+CqTooLBpmkz8wL2Vmorq7D9YXJAAU1T8webPru1q3r/lpzT63Ug7OdRheKqTBJRIP/Zp6NMKBKuhuw4u/FafKXtqYOA7G13HTy3cuoPsvRYUWwNbrKtWMK/yBxkWJoU0VUp63TZMfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHE5DXY6YRgEB+n8oyPufxwgDCChOC6fF0iqIfrn5W4=;
 b=vxoUCCtfWLQUPp0FbpFBqL7zPxxXectr/bCqRFsMZgrUJgSFogPEVJj5qwsb7EXrqS++L62s5labqwVkOy9p0Zg+OuiSx8J7lXP1pC51v8jVi9ubRifTRuR9fHe/Pj4EDSwEL3LFeTt3LKbiI26KxfRa6BkBV2s1/oCfWaMQaEw=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Mon, 3 Aug
 2020 16:45:29 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 16:45:29 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
CC:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Sam McNally" <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>
Subject: RE: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Topic: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Index: AQHWZzZzIgMFwAI7HkKT1/DPVspAl6khsDgAgAFDasCAAAm3gIADX8DAgAAlz4CAABcIUA==
Date:   Mon, 3 Aug 2020 16:45:29 +0000
Message-ID: <DM6PR11MB3642D9BE1E5DAAB8B78B84B0974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de>
 <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hd04a90o4.wl-tiwai@suse.de>
 <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
In-Reply-To: <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [220.136.119.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f30eade-9a0e-44ef-9e92-08d837cca14e
x-ms-traffictypediagnostic: DM6PR11MB4529:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4529533D4C3A19853B03A55C974D0@DM6PR11MB4529.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+WYmxNf4HA+qhMhl1vSb66OfgP85xFVZUOA4JzQxTARK/POQ/1nq4GVWtIXcEbYveBfupH05UI3zUq0XNJbPRdYc8M0ylxO7J3TeimCEtPhZDveUoFKikDy23ZouiP5t/RxxO6ga6xaqa3C4jXIsX+JsG5wx27eZx7VAj/nQi2/7ZIBC/DFH8I12c2k9PjfaAgZw67FRT8TGChj0fA/7fxXfaEoNOcjJyOoU/7iw0tFUT5I6GKburTk0W9lktoepN1F9EPzFRlKNG3VeTKTB2P0c4Z34igtCz4+CdVm1q1VZcHgYVaIbj73xFnLRhqb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(316002)(110136005)(478600001)(6506007)(52536014)(7696005)(64756008)(186003)(8676002)(86362001)(4326008)(8936002)(66446008)(66556008)(66946007)(26005)(4744005)(76116006)(5660300002)(54906003)(71200400001)(33656002)(7416002)(2906002)(55016002)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oXeUbIbYir9g3U1lXf5RoMVXT4LEER7jliwRtGcAJGbo4OtyFjFDPdK1dHOvbW07ZtDWWr1fV4sFahbhWynDcPiI4tQ1SVJOwpW4moonSh0i8zpYPTb/BN0jG99CjtMJohxnrhjxHNpNymZLTUPAITiAstH8cOgmGfGG6wjW9AWlhcDRCEwhMhFHM52vV5HomMlm9TB437rmU+WHkh9Tgn5T94QMc209xczxGHAg4SXFmXyoTFSNc6VwpJwYBQBj46/jpjzejcmCTgU7nEYn5ad6S3My/oqjsualMyXUeecCCyj5JeoJpzfkLHugsE20i1tDeMiUcpZgW8GsoQ5e2gHedKzU7Hchg7JVXiL2TcjkU5reQcXmwZCFBAWngALCUqL2CtyZaHDNdcTytA+q5hnIXHeQ9q/hgcJfKbIINrcflFJmkl+R4TSmp20cqNqEV5E+OvivH3PBy58qUNUSyhSnWa/TAWu8i6MFJcaV1EeIBJH9DcRZM0lCQIYK1xXLeNiWCrRFCnqAt6+ZypyfW/ncdju91N8VbWR+3l20NPCEVB6DcStw4Ux8jBL0Tz+nF0V2rhxmDnejesApCs2qiHm4GicW0M/P2FtOGmiuzw+UYX88UhH5EuT5VIg43GH14I0HXy0Fz4gJxhQxRHhfcA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f30eade-9a0e-44ef-9e92-08d837cca14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 16:45:29.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20kgk/xckCrEOzD4mwZN+0o1t8h+6NKawFwn1066aVIimSb3oB/K6nKwuWcrDsO0DtANEmGyr59UFHnB9Bn7eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEhpIFRha2FzaGksDQo+ID4NCj4gPiBJJ3ZlIGRvdWJsZSBjaGVja2VkIHdpdGggZ29vZ2xl
LiBJdCdzIGEgbXVzdCBmb3IgQ2hyb21lYm9va3MgZHVlIHRvDQo+ID4gbG93IGxhdGVuY3kgdXNl
IGNhc2UuDQo+IA0KPiBJIHdvbmRlciBpZiB0aGVyZSdzIGEgbWlzdW5kZXJzdGFuZGluZyBoZXJl
Pw0KPiANCj4gSSBiZWxpZXZlIFRha2FzaGkncyBxdWVzdGlvbiB3YXMgImlzIHRoaXMgYSBtdXN0
IHRvIE9OTFkgYWNjZXB0IDI0MCBzYW1wbGVzDQo+IGZvciB0aGUgcGVyaW9kIHNpemUiLCB0aGVy
ZSB3YXMgbm8gcHVzaGJhY2sgb24gdGhlIHZhbHVlIGl0c2VsZi4NCj4gQXJlIHRob3NlIGJvYXJk
cyBicm9rZW4gd2l0aCBlLmcuIDk2MCBzYW1wbGVzPw0KDQpJJ3ZlIGFkZGVkIGdvb2dsZSBwZW9w
bGUgdG8gZGlzY3VzcyBkaXJlY3RseS4NCg0KSGkgWXVoc3VhbiwNCldvdWxkIHlvdSBleHBsYWlu
IHdoeSBDUkFTIG5lZWRzIHRvIHVzZSBzdWNoIHNob3J0IHBlcmlvZCBzaXplPyBUaGFua3MuDQoN
Cg0KUmVnYXJkcywNCkJyZW50DQo=

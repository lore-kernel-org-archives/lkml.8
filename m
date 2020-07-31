Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA531C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82CC21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Yuu+TKKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgGaM27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:28:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:59325 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732916AbgGaM26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:28:58 -0400
IronPort-SDR: K2wOMEsgz2XMbKX1IYOlBTdpI5pn9mYRihKTVJ9o12YDz6DTEeWb8DDb5dA9wbjastKvUNJ2VB
 NJ9vli6XEHBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="151735435"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="151735435"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:28:57 -0700
IronPort-SDR: j9GBagD5ZhUBg6kPFWqy08KLtR7Ch/ZWSsxU2t3me4CoJbpTXTsOtYAzqW5W43D5Nhd4AlhWpW
 f57s2ZjT3r2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="321387833"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2020 05:28:57 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jul 2020 05:28:57 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 31 Jul 2020 05:28:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 31 Jul 2020 05:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2bMMiDXPYsiKKV0iGiBaNJYi13Piq6YCQxv0pcafpwcTGzDmTYKnDKZ8XVB7IAFn/kURfbuSaiUshyuzgGUtnHQ7OxfuAGVDN9t/5LWSMnqnSo+pcbmcX2YB+S2U38+OWJHl16AfEpht8REDLpmkL7zIFqz0xwAnIyjM6uiFdnFe4Xn+EXqM++Xc1iwM5vyJdsjM3cUkoBx1rDmE7WoTHncELnj6N6I4a6IDxsqku/uqcYD2c6Y+n4aPAHhWO37/vj1DrzhaKzUNNBvgDh7rHfG+Egteyte0ujSQncO4MTt4w4eI6anfI67bxAKVMR2cdw/f3A01z3+Iknw7Crr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0pjH/SJ0xfooYs+lJx0kg46sN9GlD2gLHq4CXpbso4=;
 b=EzXeNfmA37BcWY/9t+nWeGnnXikPA8wbsO2nmi+NlQTW5s6zA3eZFNzG5zVY7PIrNcqJ9Z22fah+jARlAXNZjB0489nFvJxzhbQOU9wBOs4e9wa20+iMuYgwAPqLP+VBTSpQPrqLx5wpRadSqqxweAJJm49kE7TbSJA0atmR3JAvcQ6Tfx29d/EOtFZOtYjKi5DUkaCI7J2PTt/MXgLk8MmUK/Jc5uSSmG8DCtj6xWPGcYXPRnextVtNQYGQpDHjrpAaA+F3qLqMnXMYsSgcBCosgQOXNYJSibx6scGU4aKlg0+qdWeZ5GBHmNvyZLa0S3mx0m3jXflF7odAG1A/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0pjH/SJ0xfooYs+lJx0kg46sN9GlD2gLHq4CXpbso4=;
 b=Yuu+TKKTSoxzZfCTljQhAqXkHGA6og0sBwgoPn7k+p9b9ar8jGXvMnM08tBTXjJede/MbA24l2mwvdqzYhNHerjxNPKWt81ia1+K/t2L4QMqk/7DqGjAGFeNY7fKKX4WrmhcRb7VNxoMUAkMXAoz57a1GJ0Bu3Mhy2o0tGdyjMQ=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB3785.namprd11.prod.outlook.com (2603:10b6:5:13f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 31 Jul
 2020 12:28:53 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41%5]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 12:28:53 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Guennadi Liakhovetski" <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "Mark Brown" <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: RE: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Topic: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Index: AQHWZZiWhH0ib4T+aUeOy2BFXbTqlKkemFEAgAErLkCAAH1RAIAAGJyAgAFHf7A=
Date:   Fri, 31 Jul 2020 12:28:53 +0000
Message-ID: <DM6PR11MB364247C4C6F5B310F3E1E652974E0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
        <1596020585-11517-3-git-send-email-brent.lu@intel.com>
        <4fe97f63-e552-3b2f-803c-53894b196bfd@linux.intel.com>
        <DM6PR11MB36421D9A808D401416B72D2D97710@DM6PR11MB3642.namprd11.prod.outlook.com>
        <f1386a05-8866-9251-c751-21c9109aa35f@linux.intel.com>
 <s5hy2n1aqn0.wl-tiwai@suse.de>
In-Reply-To: <s5hy2n1aqn0.wl-tiwai@suse.de>
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
x-ms-office365-filtering-correlation-id: 8acd0fd9-ca6b-4be5-2274-08d8354d4972
x-ms-traffictypediagnostic: DM6PR11MB3785:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB37855D66CF86418D0905E788974E0@DM6PR11MB3785.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTeQdnGYSEgixG0qF2emqehrZ2GKjVFmdX5jwxTilD5Rcw3Ic4ajramDDVN5Bi0HA6D3cHpkvG/YCOZXFSjqYh0+V8UV2aau/9ZLpR4trsjy6zH9p/5e44xXUXzS3SFlUu3NY+B+lDn8cQ9uzCx1lonU8ooKotFw9h4E63JKFa2U3r1m6x+GsP986xbQJMflfOH+YGsx1hWLGLNlC3mkz6DccdNqk/z8dK0T+AwuSek4DllnyRsLKf/TOcLCf8uEFI7XhZn8nJXK7DlpHv8TjlrzsltMmiHC3Wc64EQxgAUtNxzNv7+taS5iEmrjImDZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(26005)(33656002)(76116006)(186003)(2906002)(54906003)(66946007)(8676002)(55016002)(558084003)(9686003)(8936002)(5660300002)(86362001)(4326008)(478600001)(52536014)(316002)(66556008)(71200400001)(66476007)(66446008)(7696005)(6506007)(7416002)(64756008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 104KWf4as863x57Jj4ol0LqNulyEKiXoPNf+0r0i1WGTOgbrnGizmJavGsWSOjyteZ3ZL6PFQhHfGPMsnlgfQ5F4Sb0CXcKdXeSwqn1KOMT2Yi2ehp8teqCamcOAfddMbLUFKh01AARhgHJ8BtrUIo4iEuaAnrcWhOSqDM8rvhSPAgPMgB7m6Up60Y9wDr6TiXl+7ts458Jym/PmxPtBZpd+4YA49sdJnrXugBoSyRezLqQHCTj85YtQTyaLI5iDCd46SCuqJCn6CeUN/do167uVGgznAe5PBYaXr9Pyk3epgmtQ1dNh3+EsnjQuBTEULqcP/ATq2O50lkO7wBk748Iks1UL2KFCGDgdgwqENvMdmHMGZoY2QfTsCgOVZDv4CH9Ffsjg8npNXAqxdrBA2L68UvLE0X2QPLag+scY9wjb+fhuPSzUwADKEoNAyOyPD1sQfXxbU1SyvHKQ3MGToJZlkFNdFq6Tv2sS56hi5cOtK8x1MpxqYwK4QIvz3dgmJKZgbBOg1llFxHL/9sXNCu5LE4Gmxg9JZWWB+6yHwOB9n8ij2ABKDlF/ZwIOITG9s5D8G8ivNrM1EvgrsPFx4Bgde0XflHpexWFHKvq3/keM39LocJHY9bcJLSIOC2A2WRYj8MSNReAt3nSueARiyA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd0fd9-ca6b-4be5-2274-08d8354d4972
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 12:28:53.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSJv6TuYtVE15VCpdceesGNZ4aVDGbB/pteWxre+43B3j5QQkvqvL2eThsE+HH0D6aHaC9+rRwgeBp90Nxvhfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3785
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> If the 1ms alignment is the condition, it can be better with a different
> hw_params constraint.  We can use
> snd_pcm_hw_constraint_step() for such a purpose.
Will fix. Thanks.

Regards,
Brent
>=20
>=20
> thanks,
>=20
> Takashi

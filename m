Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE93D206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="o9C6tWsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLK5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:57:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:7287 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgFLK5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:57:42 -0400
IronPort-SDR: xidQWwqtOQ+qCgJly1BH5GjP3F5tcVnt7grj59skctD8izJHHW9eNyyBlG48QdqKpqFMzoECzD
 68XUxcFBoWWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 03:57:42 -0700
IronPort-SDR: twrA/jP9DJwU9Q+jLfETBVrMaKae2thN4nIbTK5K7uiZoIgCqg7ADvqKtC4kcRTDJmUth9t+UA
 5IF3WuUio8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="296912429"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2020 03:57:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 12 Jun 2020 03:57:41 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 12 Jun 2020 03:57:41 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 12 Jun 2020 03:57:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 12 Jun 2020 03:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1dK8ArKVTSMX/cDS7hIRDK56Bi//JsRQqdgnp2YhL3ojklwkpiphGRWRhKZ70b09VJH3lM2wRQNG3/agqUvz6o0akr6g3iPkNDgntFI0Gfxnqh704dyYAcz+40H/TN6B4Wdl5EXnoYKmL7WlZzqeZLT4I4qtbvJhmxcft3bGiz2rYucOEtxGhMjeCtAFJcrZdx98hPzblxOI83iqudofn0wmGlVq5ZN0OhXVSSdQicQCdoJajykDwYkob6Yu4FBvzkBAh+n9DmQ6zS2VssuXbHnSO01oh1u+QizEw92qDOL5LkLsui+Lpq6C+3BnzGTMmN1/nPg1TBI5NnqxG9PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2iAwK4V6qP42jcN6dzmHfWFDMr72X2tcnWcxu1lfNQ=;
 b=E/GyLLZUzJK1352T0OVRMUhmkYUqRHXGzVKO7UJSGymwvdrUQCCKjwg3KRG/7XXVBK+eB9/MJHeQ1mKAjfDGpprv2T2Lev5iwI5jzEO9qG0NnxN7w2NOL95amrHfujbUiYGNPNkWTIb2i4dzeMAmGlFOZcPBpybeTizP94N83baHzteL5MPGN8qW+CznZkxFQeNcUKYNvzO2dr4AmTaq3R4aOeihVwx6ODOdPQKBMxl+prQZluhhbHVnqqH5uWNypDKe0NgbouTGTu3GDpSYvOITpq2wK3x8Ao7rexdkrNTC+9s+CtWwoSgYN2vHdTKhnNs5DEvFL526eL2PA8jKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2iAwK4V6qP42jcN6dzmHfWFDMr72X2tcnWcxu1lfNQ=;
 b=o9C6tWsZ29+ob8+fzm4WZd2ohDGnhaDRQ9Tc1CTtCh1NlpEVUefPqA/G7vJtwrzGqpvXQXsdOcxREmdeoUyJS5MUkTWcRrLjSYKfJunt4xDxbaGeJZX/ov5EBwq90MAnssna77Sfd+haUG19VosUUZjQDFfSSYqx2X33lf+64do=
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DM6PR11MB3931.namprd11.prod.outlook.com (2603:10b6:5:6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.24; Fri, 12 Jun 2020 10:57:39 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::b4fa:727e:34a9:b1a4]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::b4fa:727e:34a9:b1a4%5]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 10:57:39 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: SOF: Intel: hda: unsolicited RIRB response
Thread-Topic: [PATCH v2] ASoC: SOF: Intel: hda: unsolicited RIRB response
Thread-Index: AQHWQKR6H3CqYb3gJ0KldoHkwPAnUKjUzw6Q
Date:   Fri, 12 Jun 2020 10:57:39 +0000
Message-ID: <DM6PR11MB43160B41DE1EBCD38A4D7A3097810@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <alpine.DEB.2.22.394.2006121325470.3186@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2006121325470.3186@eliteleevi.tm.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c689e646-bbc2-4dbd-b651-08d80ebf6c80
x-ms-traffictypediagnostic: DM6PR11MB3931:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB393114C06BCF6AFB9F29EC7D97810@DM6PR11MB3931.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TASbg1uQWxd3HZ4pRHGj/v3LJrJnI1hLkykDnUzuFHT8IWpOO/5Wi5sPDXBn4856BAO6Iq3k4w6Dd5NY3YkATVAL3WxNkvoUObH42RbgPIMJx8Z1RmecRiLmuhAm7i9WBZOjB5oHKkVpoNe1SXm9IzeC27K1J1mdKb5zBNlxHIjpuepoqeTVg45vRu7cIGx4aWsC1GxmGXOJ/ClDKAgv0+18PHSSgCS8xTv0NpSt8flLCd3VBRFR3CFCsrxoB014eFTXNwASZ/lq5dz2m2SRfvhppus0b+KrEhaLlfg24A88SQ3b/w6u/Vlr1U2L6wBV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(33656002)(55016002)(86362001)(6506007)(6916009)(4326008)(52536014)(8676002)(7696005)(76116006)(26005)(7416002)(71200400001)(186003)(9686003)(5660300002)(66556008)(64756008)(66446008)(66476007)(66946007)(8936002)(478600001)(2906002)(558084003)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JHMVQwMnhDQ6SmQ7iuUodTDmuNxWbgyHCZjDc7lc7zGqemzEneSljIarFLgwCtIAgLUBE5UB+8mgJxMCkw4KbvlyaY86c+w2KI2RFKJ3S59aiHH3wC4L2m/+L54Oqg3rB9LATXztQc/6zAPhdTFIyu+QensPXalA+LadRgpaZcp6N2dBMFnPtVb+TiUFns/SZaPW3r0SruO3Zs3avgGnNLUqIFVY37pTUCTTm004rYyCsEOXlnIVzngWoDQ/WhAZfkcpCUHaSCYkheBghNpFxrpyZqdvlHT36OjMQy6t0u0YDtRoFAyq48ey2DzLHrOzu1g3hLGji6VTdyVtjpgbELcyV/9bsWgMSHyz3o70F3Echag/RYOqvlgdFoT7BRWg5S5r5x9+2E20M4uZ1R6uP4Skc34Bwj0lZIEqcL0hj6hYgwNOSwCXA4n/r5hP/TtdBV7zAWBO1HaKWIBit/Mx4KL1ncpqRucaG8TmnTV+9OJSCZqD6232yet9YrtiOncc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c689e646-bbc2-4dbd-b651-08d80ebf6c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 10:57:39.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qb5xmiQRdcjomOQ/rtyep1Fgs6qj24Vofqa2pPqjhNCbQBbQt/PWf5LyGyzCszGo1nITtVfMQrebRDng86frcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3931
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> better to align the logic, so I'm ok to take this patch to SOF.
> Can you fix the summary though:
>=20
> - ASoC: SOF: Intel: hda: unsolicited RIRB response
> + ASoC: SOF: Intel: hda: Clear RIRB status before reading WP
>=20
> Br, Kai

A v3 patch is uploaded. Thanks for review.


Regards,
Brent


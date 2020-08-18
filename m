Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8183920789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VQg2GOOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHRAxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:53:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:52267 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgHRAxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:53:43 -0400
IronPort-SDR: wwvtp8RGHR0bPs+Lo2S3apx7O5jcd86uoRLnvxF3xS8HeMYRjFNc78vWQWgEHpdZv94ff3tmyp
 w82W9JAPPEYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154790858"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="154790858"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 17:53:42 -0700
IronPort-SDR: Tt0L9RBpJXdehq5/B7Z+OHcBeBKvyulQkQw9OfjGfvIXfU1ceyZ/ET8o/YLyZ4J9Z1fR0YMRQv
 bYXlremJsdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="441052508"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2020 17:53:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 17:53:41 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 17:53:41 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 17:53:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 17:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyUpf1HkHmEXrg0Y4GIb0JSqlWVWT6dXxaKU+Gk7RARt6P0t2P8ttzZ/IX8xewlNUZl2FvmPB14ClCjrBU9RLmx82hFjC35cXTsdTfwjUUzPBQoWQKEF/5ljzOadrRRp34YpdACL7oa0gGkE7ZQeIZdXCpuNTKV2UmwdeMJHh9ZerxGF4NNpYAujXY37WrPBTwycOiJ6QFr09/ER7pfyaviuDQ+AAv9i4Y5ncdtOr7fYerelZTJ+78BUV/ScrpB+PYJMXzSwByyXpkwFE3ZxK0SDl246NWRMUFTwthpq63zxNVecvhNeO7HkS0r8fpb3ESkmWiuU1G9A9zMGtdnr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g98zpgCBElH86aoOJl9f8TqFPofdYrhW7WHsamcU80=;
 b=KmrDX/M4rz23MPSbHqoWmhcoJGP7zOhpA520iikQEGS7PzXCj3O/b/yjer0LXuetuf3LnWDo38Gd+dYxRdPXM83xfonW7JJIakSzBDcrNcLAlqAukSEeWlPhRtCzakgv3/LV+kc6JFbAOuMFmZASBVIC6Tu6DORCpMF6erd0wAi2BdGYQCxQ87+lQkij7TjujAC4O7DOSx1p0yTvdpZ2NjGh3Pxkvuoti8Q1ECoCoHK5yQiu9ed//LKGTrOAgU0htR7J+4AhNuBqFVyZOP/SHwL8SBJoZ6q/Szsmvm4/WBSoJtLqGNq+yu68/xzCSKSBRvggp5q7AUfabWa1+APqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g98zpgCBElH86aoOJl9f8TqFPofdYrhW7WHsamcU80=;
 b=VQg2GOOvfVwQqHM6lXMzi4gqlEZA4YhaD9BQnE3KZkCAfM5WizBgb3dOYjJg9s9nqyf3Wmwba8dmqoiT4Hp2RoCGD4myPJ+cFuk8TgRcFsuUnOxdoNcsI+qXlWIw6GvpsCuZcc3vUq23ccCArUJPm/HWeaAOBol/JErRk7keysM=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM5PR11MB1883.namprd11.prod.outlook.com (2603:10b6:3:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 00:53:39 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::70a3:595c:6217:49c9]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::70a3:595c:6217:49c9%7]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 00:53:39 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?iso-8859-2?Q?Amadeusz_S=B3awi=F1ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: hdac_hdmi: support 'ELD' mixer
Thread-Topic: [PATCH] ASoC: hdac_hdmi: support 'ELD' mixer
Thread-Index: AQHWchd0wtLZqwnntUa3JdfJp7hiz6k6X7iAgAKv72A=
Date:   Tue, 18 Aug 2020 00:53:39 +0000
Message-ID: <DM6PR11MB36421D93BA72DFCC14F899AD975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20200814083436.19845-1-brent.lu@intel.com>
 <s5hh7t3qbag.wl-tiwai@suse.de>
In-Reply-To: <s5hh7t3qbag.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [1.164.110.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe66558f-70d1-41ba-e6fc-08d843112592
x-ms-traffictypediagnostic: DM5PR11MB1883:
x-microsoft-antispam-prvs: <DM5PR11MB18838ADF0DB1EA11E182C93C975C0@DM5PR11MB1883.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkNrrNX0CAhI5UKxnYdyIEBX1kHnYYGfov7/roHhnEbY8g1AY/4a7PdCFNDKRfpNQrZyjKDNx7vW8rZpCttWGiImO0tZ2BnPWl3BNzrt4wFS8McjRHh5lHoFuvr8gA+lNDtwUc0MORQr4blbFfkmXEkuUHqSoCkwN3jf+2SFGizXyxxqcW4oV2EcaRUBAdcx1/mgC+zBqqG/ktPVirh21gmJl2ZFtazaxNJGDUnErZNqGw90rB1oUX/WysgSNnk9pehFJzJ44ywgEytbKsoGbEoT2WvenvNfrwlyktXGjEDiIUYsehipn03OeUwxO9CGODEgxRkd4PX0cHSzwg2GKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(54906003)(52536014)(55016002)(5660300002)(76116006)(2906002)(316002)(66556008)(66446008)(478600001)(64756008)(66476007)(9686003)(66946007)(4744005)(7696005)(26005)(6916009)(6506007)(71200400001)(8936002)(33656002)(86362001)(4326008)(186003)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ziVuR4pBh6KCawf63cdSBnNB9YeVJd2GKxQ7KAs/xZqNmSyzJa9qB81qm940eU/5sIhCJn3xgTJy8fXSlzSxuCMUI31SMVceM8apvyqLd2nCUD9mtqio8oQNNHpCTH3tdYAEhZxvtCr2aOketxptVRWaM6y56VtxNoicbbK8XLKoiZsU6If9Ql973zfi/yMS7zGIgHzluWdU5/yZurGAPHwHslOt20gRzttFEhFj6rW3z2OLlQNalN3zj9XHeQgun9H2Il5QWT1nnNcyX+SK5TBD2LSSk3rr4zMAvdbg4BAU80MdUbYaGkMcIufChhIjl0k4lJlH1pohCQf9DzeongNeiMu8raOjcqP6FKmD94zhOYSoxybXrG8HRX+sUkTo3N6zYl2Fxgz1S97IAhiaV/zdx1A6xXctSM6Ul+RH2ISu/8SAhePpfZahGk5yEhWH2qne1j6beEY/FrNkCo3kJKIGfCCJGans40HLg3n9k9Gr9Xgpp6tpdMA+68b2lS5CM1WyQcbq6p0NxU/1lEQ1B2J72vOJ6hzpu0TJhKZAp7IrSgnrqVfa1LHR+6b4dkuMX3ei/NK9Lpd1jzLbdAchsazzaD6VvGorVHIF0nIBTN/c/5jMnQ0M6opkpKcJtVIrNkh7HE6S8P23TzOrx4UiNA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe66558f-70d1-41ba-e6fc-08d843112592
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 00:53:39.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/cp1tDuOWLXzV9MPc/jEHwdOvoiLRrKt7D+HEeXkRq8sYiIwBkH0kIrqZ9OWocSIKN46jVXXNMMGuTmOryaJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1883
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/* add control for ELD Bytes */
> > +	err =3D hdac_hdmi_create_eld_ctl(component, pcm);
> > +	if (err < 0) {
> > +		dev_err(&hdev->dev,
> > +			"eld control add failed with err: %d for pcm: %d\n",
> > +			err, device);
> > +		kfree(pcm);
>=20
> pcm is allocated vida devm_kzalloc(), hence you shoudn't free it explicit=
ly.
Will fix it in v2. Thanks.

Brent
>=20
>=20
> thanks,
>=20
> Takashi

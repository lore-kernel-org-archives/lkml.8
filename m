Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7275FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D0C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zB/f/2N2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgG3ICU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:02:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:46003 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgG3ICR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:02:17 -0400
IronPort-SDR: +Nm96pxeKleJoqWCDzQoeScF2AGG1cXeKgcU7h2KM+uMxSD2kphcJwgZ9d+mQs3R9R05Ar7aHt
 Y7jkOdUxu1gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="216036797"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="216036797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:02:15 -0700
IronPort-SDR: xy+QGq28c/i+IC0ugJrL9tHe5/Uk51QyzrwTOHmz+QMizI55mpkxl8Q1En9ySRPaqWKYB+azvZ
 Ir6SKDPq/FJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="490578032"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2020 01:02:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 01:02:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jul 2020 01:02:12 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jul 2020 01:02:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Jul 2020 01:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUkMSr+rqKUipXSNyAGV7ZRI7lZvlxNaaTrQufTshwZVRYN+3zNkeYuo+cCXCAYEoup8fkRxDj5153QQoM6cBXYwEpH/AdxIu7QHNBl17PbRtsgNkJXfMdyyW25A9UgTJMiEVMoHBrKak4ZcHdX/BBptwlHs+TN7JGRQHcRUt/goDnqWmRs7iN4vsFED3BbOWGduCSOsX7vGmTSxtNsLEJHEcYaS/ottQOYkBkrLT6g5hiD0fmZIhLQKlrX/eYtn7Xys0DWuLHe5qy3uBnE71WM69yqIQ3ncJ06uMa2RcJctvjOwe42fTAZckS9IBDBzrwAL4xfz/P/CHHHcCyToBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OytoeSxkISSPclirR+yJoRs9m+xvNaTmp6C7p1cA0jk=;
 b=lAGe1efjFlNONdRxok9MULQvZsJaeGna9bYZyrkHhtnz3n9WQnR+Fje9W5DtFi+xxkKMbKpMABLnHIJbaiBIHQoEc71u4L+khxg1e5fKOfupHus9xFjLZO+C5hdgAUgskgBU2nL5Bt8R4WaB7bG+o6HDdd2eHxbRCCxFrhrFffmwwuvBAVT4D6oBSP5PmEJEwXBIeFQc3YEJBBIVoDsyKMfjupHuj6gDtw4SSLkljDb/5CQwEp08yZjNPJ1V0CSHxsyl03S1C4Rv0InVqjriToRfxsauuJjmjEqiOEkc8dHsqjvv/+emeECzzuBxxQtaWBk0xNg8U6MEh6NAANoQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OytoeSxkISSPclirR+yJoRs9m+xvNaTmp6C7p1cA0jk=;
 b=zB/f/2N28FIm3w6fAXjRorSdDCpwbu0KO+f9bqxGZQvH0vKtpp1EtEeGMVYquSfakA7dGgoVLVx5bvzzg5OJAddTyYuXQrUQ0XTDcEqPaQ2NVpaZg7lp48rF2FIl3Agwte3a5t6LaVCuMLEpt4a03KnPtx0ZxuHLDKNBWAk5fuc=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB3739.namprd11.prod.outlook.com (2603:10b6:5:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 08:02:09 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::f043:4bdc:ef57:1b41%5]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 08:02:09 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: RE: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Topic: [PATCH 2/2] ASoC: Intel: Add period size constraint on strago
 board
Thread-Index: AQHWZZiWhH0ib4T+aUeOy2BFXbTqlKkemFEAgAErLkA=
Date:   Thu, 30 Jul 2020 08:02:09 +0000
Message-ID: <DM6PR11MB36421D9A808D401416B72D2D97710@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596020585-11517-3-git-send-email-brent.lu@intel.com>
 <4fe97f63-e552-3b2f-803c-53894b196bfd@linux.intel.com>
In-Reply-To: <4fe97f63-e552-3b2f-803c-53894b196bfd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [114.25.81.97]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c5c899-84a2-4ac7-c312-08d8345edc2f
x-ms-traffictypediagnostic: DM6PR11MB3739:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3739ECA45067A2968F0E934D97710@DM6PR11MB3739.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5PdFy3vttVZfIe1Stz19KgSHZIwWUg3GrIRMN7cGONcVSXhdZs2+fJloogyPKDxYsQIYMMBiR1S3wkMKAbdaMAx5E41V1ZLlZU07u7SKXjtn22dXaNRlTjP1pZ7TJ2/VL0aYSNn7tsMyI0EMRyy06lp38DIkbLMFsucwYYJZhgJe/6ut+sUKe0hlG7+AFNUXtGUbCGDt1l9GqK9/SV8jxntkTgs+BmReWG53AVqNkMDmhgmrKcvFQyDI5Tev+scd2VPySmjytKRJNrtPJefQFQCto3snNrF80WvZ8cRxpaiE4nW6iiIuCq7M9jUdNFIZS8RuGuYw6qurHPrk5bvbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(5660300002)(52536014)(186003)(7696005)(26005)(76116006)(64756008)(66946007)(86362001)(6506007)(71200400001)(66476007)(66446008)(558084003)(66556008)(110136005)(55016002)(8936002)(7416002)(4326008)(33656002)(2906002)(9686003)(316002)(54906003)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YG3uKJc69C8GwRe4Kt5S2ptUBG1J9+ZjARDMCTcAhbABYN5dcWmMM6tu1ap+POWgCl02CnH28IyQ4T1tuT+vuSdiNEckWWfgd22RFUjTk/QbOR3aL/JTDy38abxfe284wsaXf7lla98pStxyqIfZ3l48qa7swEnKz1xYBuNZsZ+p1jv//DSmgoXXy8nXXoBuUDdN0iAVKR43QO4RT8ZKhUDKZc9KLWDduaejzfU7/JuuJrD7NPeW6gscxs4W7DesHfDtYLAZsvUnHbfw8jya4xw34Upm/Lmz6zqUI7Qr5LetTYpiL3tnWzQcX4XdvGOn5xnPfLnt+/ztn/nhQJiNlkOOC9ds0DkqyC1ruj8SfUn1GUqgIs5HCv4R/yAA7eumKZtImNctcLSQ0ETI/MiLIQ2p2OWJtyS1cFCRk2IijBF1QmVGBYganKMnCZk6wnVBZoPxcAFqDuTyQsGYZI2umFE34xbkp6wv0/GBN4PFdhvAlzo4phaFNlmJTJrKhFXEYHRfbzONRNIOxJw+hv8BBJL1b6lxpSUgx3cY5+7jeFpOJ61M6JD8PZ2j7tTNc0bm3USRQKeEQj91Km2tCJfRlAb+5o0/UQBV+bd1SMXJQKzMLCFWgolMeGEvqrpVeJBiqunKiLU+SCgKpAkuhMpikw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c5c899-84a2-4ac7-c312-08d8345edc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 08:02:09.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrCpbk6CqgxpwP8FDB4QlqzljZPp3Rt7drOBANYHsJ2X14QEGy49z9GfkTE0e3wgxxA6GcKYm2pGd0vhm7oYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3739
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBJcyB0aGlzIHBhdGNoIHJlcXVpcmVkIGlmIHlvdSd2ZSBhbHJlYWR5IGNvbnN0cmFp
bmVkIHRoZSBwZXJpb2Qgc2l6ZXMgZm9yIHRoZQ0KPiBwbGF0Zm9ybSBkcml2ZXIgaW4gcGF0Y2gx
Pw0KDQpZZXMgb3IgYWxzYSB3aWxsIHNlbGVjdCAzMjAgYXMgZGVmYXVsdCBwZXJpb2Qgc2l6ZSBm
b3IgaXQuDQoNCg0KUmVnYXJkcywNCkJyZW50DQo=

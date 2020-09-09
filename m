Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB724C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED94216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pcACnmsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIIAkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:40:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:32234 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgIIAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:40:06 -0400
IronPort-SDR: KmX75NNjDyn/emP9PnRNfxUNTJ0XfFsyK/gXuH99jTRHR6vhhdbWefy8kkVo459Tv1k4zPhrKN
 wo6X2wZbg3Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145963507"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="145963507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 17:40:06 -0700
IronPort-SDR: 5E9WSosBQzK8iHSRfhgvHNS77AYJPr9JeuheVkp2rui5VZc5TD1HezdqQIvCiEQytM8wCdtTwL
 mA4ztDvplldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="407304375"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 17:40:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 17:40:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Sep 2020 17:40:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Sep 2020 17:40:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Sep 2020 17:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REVVnTeHasU/NXm0k7SH+LjySbnC21ws6+wT58hykeQlrSPjYBGuFk2lM1Cbn6uzx7C46/ou7SjPBdwGIjPUA64GbkHe6w+75pEon/k+f1JxKJk10Hq/c1Ph1SHyW6drCizYitsV+U5e8hAN5UXk8eluEBM+/ZYeXJR4yXAR2RrRFtMkq4YrEtIYGt8Nqryk2pQkO+RpIMhtr1048Ea9dz9c3JHHBVY6mDwqce+bDY2S8amhnd3MxARxaKp5FFbkRuvFISJJ3mZKOrzPcnmFA6rUW2SO0/7c/9dKm9diGxZv0yED8LFgt7TYrXzZ9ZBlyzW8GUjgRsnHXmghXsYXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0D0tmSrOIwpMWjNM/kHtSuGc/8m8jHL2YTwjeKpVlk=;
 b=Iuw8iy/KI2gAJLhM12ORXZMyfipH4M55qPxzYhbK0+9JicxIj3XX3CBldyss2CW/a71OWLeGRa50G0dGwyhuMX0/7cCy6fKXTHt0qHXfscsJd27tNVoSJjYIkJ8+JkfzWk4Nh8oBxg7OTnVULcxRUr1CWd7PWN5+O/BAHhyLHQSBH/Q4jhjWLHEuFdGwSGP026TsPkQp4amiOwYSE+PC/kUlwWGs4tCGCVEU9RkDNpuu0GyjflgXTVrosE3dmeFvVb/OSdWRcGyBfZkWORTlvPN7fMDopfcYDgbnfcULdqS0JUTGA5ooKRwSEZsuhksolfo3YhdSzIzYFc+WMrRABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0D0tmSrOIwpMWjNM/kHtSuGc/8m8jHL2YTwjeKpVlk=;
 b=pcACnmsYvooAJ/bWi6/3EDGDLxaar58xQ12gQIWodxnhFLdStXn3f0Ah5FSpJUyZWJ8N1GU7helKxHY2J3ZseGxOE7PZPmhKQj9Xki7s+/tHOESQUJQLZmvF6ZbeGzLbcPrjSjnqQFJyjccjSmWUmGr3fsJR5UxCl0HBnekESok=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 00:39:59 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::7883:72bf:ad85:5166%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 00:39:59 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Thread-Topic: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Thread-Index: AQHWf3dxw/rzA2qt3kKkXMMhVhHoqqlTN6sAgAARTICADDstAA==
Date:   Wed, 9 Sep 2020 00:39:59 +0000
Message-ID: <DM6PR11MB3721B821FA9C985C8C386D38DD260@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200831091013.GL2639@vkoul-mobl>
 <DM6PR11MB37210C56315013E4995DE2A3DD2E0@DM6PR11MB3721.namprd11.prod.outlook.com>
 <20200901055135.GY2639@vkoul-mobl>
In-Reply-To: <20200901055135.GY2639@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ac96cbb-ab0e-45f4-c86f-08d85458e208
x-ms-traffictypediagnostic: DM6PR11MB4644:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46449F2B84C2638396680158DD260@DM6PR11MB4644.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: argZK0Fn1QSI11OB9cyMQduB5a3Yzv9XxFNskW/7DxsImAwGq/zSovHqs6oYM3HzaxwBzAa2uuq02RS7dIKWsM3BayvB8j8aPAQmOyrmFg/Klzqf4/SwDPCGWFcYCiqNMUdERSeFqwmwEnscVJIEASFnFqkPEQ236656p4fTMntttDvI2oA6uK0kjaK6RRVb9AuLH59rvOZlu/fyyfH0FuaTByiN5vC61C0F0EcK7AWkkIP3z9pQvHoMX0ybAAaDE9KS9dcXz7eEcHAg8T42Dvq2kzekEOrVhTUwmsqlw8Hj7ZAf0PDdTMoIfaFXmfsuk3cLdGZ4dwniGW/Pd3Su4nSJ07axny45/oGEQHL4OWd6EGVaNqTyPB5nUWnPJNW/rpWlr+4/Q73KmtY4ig/4Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(33656002)(186003)(83380400001)(55016002)(26005)(478600001)(7696005)(316002)(53546011)(2906002)(4326008)(6506007)(64756008)(66446008)(66556008)(66476007)(66946007)(54906003)(76116006)(8676002)(71200400001)(9686003)(86362001)(6916009)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CkSOOlBIQnSvqJEDL7OEIltTvRWwyvQ1HBlS5jEkFAcBVY/qngWcAZsjfFWP6VOgfTzrjeRVfVoFgcOSIuGNxnVKQWWQX6XKAhhaphMF3A54IdNNhaUdieC+qOAvJT4igPgDjzbUSNHENb4YBjqYdeYkqrc4nKkIK3LUYXoQrCh8K1TUX0ZV6GaJXSq5iUXa4PKHlTokzHSDMi19wrdDuEMPJkfNLRnhwjewHJkyW9RAN1RYSbTlBJKXTM6fTIor9nxYMgm0H6CtoFLtMSaGkSiyXEiOfU/V9d2l0cNNJr62CHaGjpxTIsyyOA24BryviGoS5uAi+1TRl0d0PDVzl8xlMpaZDOuJD5a0eevHWxbAmBqGDqqN9awnMDVNbSN6OSOGays2LMfqwhEYj0boD0fdyoocIiex8MhYbqUz7aeWRc7QybpkMa+q5TEK4sdcHjqEHHrBOHDKmQzo6txddNGlXluGgF3irCp1d3qOi6Gp7J9qQ+OL7mUMeDjlgFDXo9mKhGPoIiAWSUt9Xj5VPCs1EGNw3LMco+GOYsCMVDg5p9sFgHN5Az/LXNJqW9Jak5J365gHwM5kfFIJFWcn997QUSCJ4XqRcIsbipdzC3pV4UXXjB/LYFUYmHYmkI3BBLDKV+C3c6AV39fxyyfBrQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac96cbb-ab0e-45f4-c86f-08d85458e208
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 00:39:59.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVOj6jxcixWSzhMgtfepcwrmuKfBO+LU2CPk1acLRgvam9lfTyfO8cEBl1PvjvG+3tzo8gXw3FTsgWRE3CwqTxu7r+Pii9lrXU5UETxwfZ+DXc0h+/F4d+BffNxhdExA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend the reply.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, September 1, 2020 1:52 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; eswara.kota@linux.intel.com;
> vadivel.muruganx.ramuthevar@linux.intel.com; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC
> PHY bindings
>=20
> On 01-09-20, 04:58, Wan Mohamad, Wan Ahmad Zainie wrote:
>=20
> > > > @@ -0,0 +1,44 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > > +---
> > > > +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-
> > > phy.yaml#"
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: Intel Keem Bay eMMC PHY bindings
> > >
> > > This seems same as
> > > Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml,
> why
> > > not add a new compatible in lgm binding, or did I miss a difference?
> >
> > AFAIK, LGM make use of syscon node, whilst KMB does not.
> > And LGM and KMB belongs to different SoC family. So, I prefer them to
> > be in separate file.
> >
> > Having said that, with few changes in wordings in title and
> > description, I think we can make it generic and can be used across few
> products.
>=20
> The bindings seems quite similar. We can have two drivers loaded using tw=
o
> compatible but binding description can be made same

Noted. I can make the change i.e. add Keem Bay compatible string in lgm
binding document and drop Keem Bay binding document.

Rob and Vadivel, is there any objection? If not, I will proceed with v9 in =
the
next one or two days.

>=20
> --
> ~Vinod

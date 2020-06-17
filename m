Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1407C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD4D2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="woQv3CqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQGUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:20:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:64575 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgFQGUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:20:12 -0400
IronPort-SDR: iq5xu5h1ERmvk9CSMCnaZDccMNAW+A03VLysRxq4tGUWjb0MxSct4a0vjoWX297KKFPGrlQumV
 7MjnM2zsA6iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 23:20:11 -0700
IronPort-SDR: E3djOXlMJuiS0FW6yIg3Jv1GUJd0AT/+V7wDbWoUUzJRKuPl7kb6aIFXI9dSqRUJkKPyJzWfJP
 EkF2ECK4nGQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,521,1583222400"; 
   d="scan'208";a="261651842"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2020 23:20:10 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 23:20:09 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 23:20:09 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jun 2020 23:20:09 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Jun 2020 23:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZX9d8JIXn6kvUhQ8H771NLyVUahttHK6OpOdS+7JV3caPyN7PJc1WH/URIYCLXghDcnkVHwh7YfnqHJrOVJYorzzykZgsrmrDH5X0aZIxuFZ2T3wNMGWkHhynxv9/Hmma26oQgwZ1R/QPLYK9G8FgIbU5S4ajitBsGstUrbIQr8a56RhaupqRcyP6Tmi3RjZN13dQlcrI1dpnE4m5ug2KfDjkGcl0EuxW4VWLaqCz90NZzp+r/ERynUMcRy7dIax2o8P616A0gSVsh6In+IFCmKmT7l5Iy9X+9dmMucJ5mb3qtOgxN3LahHvqQg9qMwAzztGTN6ktEQTYDbcunUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM6L+V7NUoXojsv8Q2UDdD+OmL9oAR2YGJgq68CkPNs=;
 b=OezTqIelIWFufsL/e79loMDTX4DBxFgwZ7aDbvd5fdws4YJfLRg4H1pUeMZqB1r0PAHdcIOKHSnUqwJF/JGdVm1PE0E748+ZkxKXdNUjw2lP4bVHTuGZ+7+rXzZ5DZiGRJsexCAv8KnPTOwE/aJdo6YDtNpwhaX5RXVg8rBlSfAzmJeyjxr71RpiGhGZBhnv3+M7zKQn0SLEOPtSjOzo1s+l51RwVamsYd7lRjzsKscPmrC49jFNr9iCcQoyuVwIDmbokTk92Q3wiiCjIkz7UKdHhGNa4tzoAsOZFltd7thoPb5Bog+gr5a+Gc03i2Tlpv7mm4orRoxQk1PgqSwuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM6L+V7NUoXojsv8Q2UDdD+OmL9oAR2YGJgq68CkPNs=;
 b=woQv3CqS8qHMlqD09TrHcKZSEpYR3sPFsSpDIe1293wkBUTmSAjR68JksTjSTrpzpb4i8Q1okAARLxh1WbsbPDK1ZoPv77cgW2vQDDIgvQdFYvfZJAhIQFaoCXQhxJglslQEOIqra/TLsnPZxPFjLlABUccppO9TpLVQOKAXgDg=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2986.namprd11.prod.outlook.com (2603:10b6:5:61::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Wed, 17 Jun 2020 06:20:07 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 06:20:07 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>
Subject: RE: [PATCH v2 1/3] docs: IOMMU user API
Thread-Topic: [PATCH v2 1/3] docs: IOMMU user API
Thread-Index: AQHWP6WkhOQLPQDE2EquIdJoSq1UYKjTj/yAgABESYCAAA2bgIAAP1SAgAdDUQCAAPjyYA==
Date:   Wed, 17 Jun 2020 06:20:07 +0000
Message-ID: <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611094741.6d118fa8@w520.home>     <20200611125205.1e0280d3@jacob-builder>
        <20200611144047.79613c32@x1.home>       <20200611172727.78dbb822@jacob-builder>
 <20200616082212.0c1611dd@jacob-builder>
In-Reply-To: <20200616082212.0c1611dd@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4751b5e2-4953-46bd-6dee-08d812867b2e
x-ms-traffictypediagnostic: DM6PR11MB2986:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2986A2C36323999114E44655C39A0@DM6PR11MB2986.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxSRuU9FmgA6h8RjwYcxnWqJVXxxu1XSxJ/dRent0sb3LErJ13HxlbiBbt5TAgARqDIJ6iGjxRS/3bTbfXp5VaYR+8HwIB2GDcSlDHg9jl24CSzJwtZR0JdcOa4YVs5WzIisqijBmsRRkFccxOtCN7RqHAuWaZrmPRVHcC0dArWEbZY64LlFoHZYYBl1bUGXmMLpCpPSnz8+RHrQiVPN8FueQzCL6Bv7+4fbOSIhTmuJk5D2PbKIGBIsS9FnTqMlDAs6gq5pHQa5IzlJdBiUhGsLbYA04BaBWzy3ZJkdwqxpK+RCm018z5f1jEhyvl7T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(86362001)(66946007)(186003)(8936002)(52536014)(26005)(5660300002)(76116006)(4326008)(7696005)(8676002)(33656002)(6506007)(66556008)(66446008)(64756008)(66476007)(316002)(71200400001)(7416002)(110136005)(54906003)(2906002)(9686003)(83380400001)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LkkuNl146gSOEJ6uWZkX8S1Vj3gFmp4xbSKuQ8FQI0sB629HRneVxh9GAnL42dejZ8y+dFNPp154F8fDm0W26w2lRTHbYz4lTm4fr8CJzfMhPz0/xkb+/BXhP4zZGlpj92s9fu3LASlYf/bK2iR1CVt5T0Qnp0DKY3ZpVtfB8NewohRe6wl/9PidEw+2y5YTkv3dcr6E72aOLiT4truUWF0EnATGX0rSpJbNl5gt/kCR3bBy9XjW0YDUUKMwMIgM455QJZeopl+fjP9Zj0rtcgcMsNaw2OZojxrSDdAcaTLrr0RT/q20X6dxHxViXy6c4pXEzGDh2OrYYLLsRhY6k+ZAd+SZDN0VCksCeTM1gPUVj8bQYQdjm8MWsIxe5uUtmO/oPyBWPz3mo026+Eet9CuUMlaqo5qHgU/wgFhB2hh4YvuZtP6dOIJiRWc2Snf5SQhfJRJhvVMqGQA1730XG8yZ1j6QqWFRHbXMTxCYkQ8spGdbcEQHQg+hQSRb6xR2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4751b5e2-4953-46bd-6dee-08d812867b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 06:20:07.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wLnhyZeV7j/opHG+zQpnhnKoZhd8nBHL4xMcgDsiKdhRp+mYJOlcLjqUKEJ7MB0rN7xK8uCdqZs2hiajCGRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2986
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, June 16, 2020 11:22 PM
>=20
> On Thu, 11 Jun 2020 17:27:27 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>=20
> > >
> > > But then I thought it even better if VFIO leaves the entire
> > > copy_from_user() to the layer consuming it.
> > >
> > OK. Sounds good, that was what Kevin suggested also. I just wasn't
> > sure how much VFIO wants to inspect, I thought VFIO layer wanted to do
> > a sanity check.
> >
> > Anyway, I will move copy_from_user to iommu uapi layer.
>=20
> Just one more point brought up by Yi when we discuss this offline.
>=20
> If we move copy_from_user to iommu uapi layer, then there will be multipl=
e
> copy_from_user calls for the same data when a VFIO container has multiple=
 domains,
> devices. For bind, it might be OK. But might be additional overhead for T=
LB flush
> request from the guest.

I think it is the same with bind and TLB flush path. will be multiple
copy_from_user.

BTW. for moving data copy to iommy layer, there is another point which
need to consider. VFIO needs to do unbind in bind path if bind failed,
so it will assemble unbind_data and pass to iommu layer. If iommu layer
do the copy_from_user, I think it will be failed. any idea?

Regards,
Yi Liu

> Thoughts?
>=20
> Jacob

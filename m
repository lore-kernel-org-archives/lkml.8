Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D31C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57B72253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="UnLwaj/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgAVGt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:49:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:1155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVGt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:49:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 22:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; 
   d="scan'208";a="229197324"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2020 22:49:27 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 22:49:26 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 22:49:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jan 2020 22:49:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoJKwhBt3O+5KXcLNFF849A9mRxACOO5pJAuZufWiRmPzu3Tt/c50ZickfHM0s4SNERr2xEIR9jwzaZkTRxMLgzEeJrknSFkwMDYL4BtVfdk+P6gDbWkf9dp4aGon4Ej4f8zKPg7BokTKz57zzLPnNvau9UBZBsF5qDs0OfDzAlrFhdERCAmOS2k1UGaC5siwrhh4TGZIC8dHoG6IeCzkbsqQr+knV5waMcM5YOFWX7ZXFyXMgZsg4P5WeudR5WBcBc+nV4q9xywaTTbV/udLoBRisVGq3kTK9yIJW1mOjScRnAym7Ql6JhBe7b7YQmuh5SRuwWPh2ac6WqK572j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaU6D3e4rq1Wnzn9uhjHhYaZQQ3cSFHaCzt57Gx+wyM=;
 b=eNb6mjFQr8Namq48RaJJUea+0joe6kT3moz7Pslo149R2h8B94skLox6XDZjPIDNDDDahiPTBNbW7uqwKhEmODFKsP0siFp4XQsKwtqDrz2Yus+nPgrzYjuAI2CqPFmainYwCvocbfEnBO9QOFQ60EUIMzFu107C3/3fZ7uu9WkHcfX8HXHk73dbWU5E/rRNIJcqnZ0xlG28P88v2ncCnylokZuK2Bz0ydKCuqyEHp++6sNhe3ns02yuHfB9k7UMPeMIpgjNvd3aUwlGi2eSYNp10ytL+gRu9suZO5ZfY25g8YyednSDc1eYud6ko9Djb5ugkvhQIM7uNV5fsf+8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaU6D3e4rq1Wnzn9uhjHhYaZQQ3cSFHaCzt57Gx+wyM=;
 b=UnLwaj/6sWBaM4SUMVbf9iBZneIjnVU78HVTNXsxfeCc7Qy2blRzTwhCG26ODQPwA8iFcHwwgT3lPr2PlMqUyJx8ZJgnVzng7Nk5JODnIG0+9sv97zQ4sgQOOma8yWZdlXPc1U6kNsyRVKWioBovRQxQ4ru8cT4qyp7f1sAJfm0=
Received: from BL0PR11MB2898.namprd11.prod.outlook.com (20.177.146.211) by
 BL0PR11MB3345.namprd11.prod.outlook.com (10.167.240.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 06:49:25 +0000
Received: from BL0PR11MB2898.namprd11.prod.outlook.com
 ([fe80::806e:e80a:edd9:ec51]) by BL0PR11MB2898.namprd11.prod.outlook.com
 ([fe80::806e:e80a:edd9:ec51%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 06:49:25 +0000
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Loh, Tien Hock" <tien.hock.loh@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Topic: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Index: AQHVwleyiG3Rz6znwEyi6iEOYBxM06fiIPYAgBK8nOCAAIBJgIAA/TlA
Date:   Wed, 22 Jan 2020 06:49:24 +0000
Message-ID: <BL0PR11MB2898F670360C205169382928F20C0@BL0PR11MB2898.namprd11.prod.outlook.com>
References: <20200103170155.100743-1-joyce.ooi@intel.com>
 <SN6PR11MB2750CD8233FF8F14B006B343BD390@SN6PR11MB2750.namprd11.prod.outlook.com>
 <BL0PR11MB289899043DC031AE4DB21AA8F20D0@BL0PR11MB2898.namprd11.prod.outlook.com>
 <20200121154139.GA588670@kroah.com>
In-Reply-To: <20200121154139.GA588670@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joyce.ooi@intel.com; 
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30262fb3-fbc5-4b95-ac18-08d79f073831
x-ms-traffictypediagnostic: BL0PR11MB3345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3345CB4B33806745F0730CA4F20C0@BL0PR11MB3345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(7696005)(71200400001)(53546011)(478600001)(6506007)(5660300002)(66476007)(52536014)(66946007)(54906003)(76116006)(4326008)(26005)(186003)(4744005)(9686003)(55016002)(33656002)(81166006)(66446008)(64756008)(107886003)(2906002)(86362001)(6916009)(81156014)(66556008)(8936002)(8676002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3345;H:BL0PR11MB2898.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq+YnQt09Ih392JSDzM5AepStI8VVtPeHt6fJuML5q/MR/5BCdxUUQQCFnRvSaqg1vIdIgRN8bAvCgKw2ud/2zfd5Gzq1QlUdUTzephY3X5V7x7EcJEOSWdHKw14gvf/BSNaYwDgZCCdxL/W+Q57Z/L8pbwZQyY8IRheSdFBWiR1r7EoBXSB00uJrU9yArrwCmG3/ToCHgFaQ8DwM3EYzeSLA4A3imxmUwe3ILTZ9cwXzJEmcL07/vV+s1qXc+8RFkHpGZS8ZXdMPFzhA7wBaqwde8sh45xCarvlRFhrg4duQqR5DWckQsWh2iAZ6nq3JHyezAch0nE/E/iPpmfK1s9z7uD7YmmzKrBbNVX2dFcPzg9a6BylPVUqYf7wfXHgxbnoiFesnfTfsEI8NunF0HNbZTxOuEmPTuxBpoeHvLkH+7oE5iwHfFZkcD9cY4xn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30262fb3-fbc5-4b95-ac18-08d79f073831
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 06:49:25.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYJ2Py93aIT8TWwNijG8cCYamSggkZj0ETYPMfomHt1PpEcpkA04jBaarBvFH6f6PJwz2eVFG2c5UZen5mw4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3345
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 21, 2020 11:42 PM
> To: Ooi, Joyce <joyce.ooi@intel.com>
> Cc: Loh, Tien Hock <tien.hock.loh@intel.com>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh@kernel.org>; Jonathan
> Cameron <Jonathan.Cameron@huawei.com>; linux-kernel@vger.kernel.org;
> See, Chin Liang <chin.liang.see@intel.com>; Tan, Ley Foon
> <ley.foon.tan@intel.com>
> Subject: Re: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
> maintainer
>=20
> On Tue, Jan 21, 2020 at 08:06:23AM +0000, Ooi, Joyce wrote:
> > Hi Greg,
> >
> > Can you please add my name to the maintainer list if there is no concer=
n?
> Thanks.
>=20
> Why me?  I am not the gpio maintainer...
Sorry, my bad. I'll email the gpio maintainer. Thanks.


Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA883C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B66A20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Jpv+Uwiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgHXQv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:51:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:26297 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgHXQvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:51:07 -0400
IronPort-SDR: 3EdD2ZhbLA0JAsLSsfA4RK+l+Ki68edTSI50JSZZ36M9cLVmdFXcSpiCGHQEEpvK1MPOtix6lA
 lm4rcLNicaUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156996339"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="156996339"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 09:51:04 -0700
IronPort-SDR: lAZ9fGPPdbLsFcRHy5tNux+wc7oSpcm9yFwXivDC+0oVOpdKCbP/A2+5hfuQlFe7zFfxmlw7bM
 DX4o81ju9qxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="402441452"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2020 09:51:04 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 09:51:01 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 09:51:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 09:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEBNhWvwWLrYoBa6peZeDb0iJv1eSqcD9gcbvKd1OlOvnmkPQUkMEMFal13vDrhJUxMkWohmfHjpSZg3UNsTapHwqFyVMKfg4fNXPvViKxMB1qXUVsyIpxR0WTAqMw0rRL4MGl8KAOjNt0BlPoGInzyX4px4AfsFKIx4Pfu6F98dfkYWnU2Yyq0IdkI5ruzYA9sXfqs8ZnrR7TLwnm6LRPXYZ7uT1p/fX6fqfWUmLAsXZOMXJxxW1rBOjdLdil9q3Nphx6h8+UukvccQ5V0K0KSExxpgY5azxusT62Wdxl1c7uqRFQ0Y7hvZnuQ64K/A96GWKA+ilLJOptwVuhH26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poPEqJQJzgxu5ZW39+yMxTmTnJ+GT+Hg6Wi0uI5wljM=;
 b=GDsEtH6Ts57OLjONi3W2TeKY17LzgkcaPQoIprNHYm6u8M7XyLkQj3YviwOoZJmU7hVeNaZCEuh0ZaU2/jRTt7xb4PHSZFijUDQrd4RZbmX3pRr23P7lWeUEC247LzdJi7yhgxExZPBn9ldbZehc3hpPlIezJ/4KTXXmQ5pwIGUPVqXfXGLFCkne+tvLKoWVwX9FHiyqv4/J3kHXYwrmayQ4IH/X24N5E5y+TsDKgWEYJVbKtzfPj3eCFOQu7iUl4mgSpDTOAxMQJ9lKWxERbGHMOily/rd2GJnVIaJrh54/ihF5OYwO1oBYmDA69XY+BGtyEo4lmEC49r8zN3RRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poPEqJQJzgxu5ZW39+yMxTmTnJ+GT+Hg6Wi0uI5wljM=;
 b=Jpv+Uwiv0/52zD9jclnJiFu6Kf4o7agGIvJwr20CVRdvveu4uqUKEgWX+HTQhDwfFf40S1u2vj2QuDz95kI7sy/dPyVHO+B06lyWl+xhlzb3oMnymOslNhR5P0LCMXjN5ZKBAiFXd8pLdpOfA5OIvAHPH42+MTR6wuhSCgfjYWA=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3341.namprd11.prod.outlook.com (2603:10b6:805:bc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 16:50:58 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:50:58 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH v2 02/19] dlb2: initialize PF device
Thread-Topic: [PATCH v2 02/19] dlb2: initialize PF device
Thread-Index: AQHWcAHJb5iuglkRNE2TgJ9JercuyqlHjFjw
Date:   Mon, 24 Aug 2020 16:50:58 +0000
Message-ID: <SN6PR11MB2574E804F9AA4206A6B6AC2EF6560@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200811162732.1369-1-gage.eads@intel.com>
 <20200811162732.1369-3-gage.eads@intel.com>
 <20200811170627.GB765993@kroah.com>
In-Reply-To: <20200811170627.GB765993@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd1b7915-a490-4b27-8cea-08d8484de048
x-ms-traffictypediagnostic: SN6PR11MB3341:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3341C1CF80EC773F62C303F9F6560@SN6PR11MB3341.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgmhLh7gtCyMNy0gsowTwrkltS2l4LtGEh+ptiiNH2aX5VjPQ6jDNxXQi2TkbXj4XyRf3VZHR8ltOBc0FDkScqaBdrcyZL+9Z6AcyaHoKNu05YDLXGkgwauhuo52YCi5KrUt2g5gNZUmZRg979vCPX57HCcu5Ylw6Y2NRxwTAUE/QfBthFrjXWebMTaK3a0BMparvEF/oRqVUdVqcLhichZ9YWLXQitNDyM3byXV0Tlc17+zuyYgnJRMO6OjDKe/d7j5nzBDT9MKDk8DUyglpcNIlK0k5CNZ+SCPww9QYfuN7mJTJhuSIcXiAkLz/6536EpYBnTY8A1qs15qEXjdEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(5660300002)(66446008)(478600001)(2906002)(86362001)(107886003)(66476007)(64756008)(4744005)(66556008)(26005)(33656002)(8676002)(7696005)(71200400001)(52536014)(76116006)(66946007)(9686003)(316002)(4326008)(55016002)(54906003)(6916009)(186003)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nKfvAhGNdKvhhDBX23Dgi43Glu+TrKTcvM6zZgklqU9GhzJOw558mTMkw39Z/y1kTut6WpcbBbQGOnjTEZwO6LuvxhbWto+j7NyThAnFGNLm6EmvARKv42H3zoqjNi4Z/NP8AJdph8JgEqPqoof4X913Y0GyzD7hQhok+qph3ddRHVzQn/osDyv3RXYP+sXuD3DOZI9Y/fI1Y1Edgvx6sxg7zBuC4oYgA27xVYZ/c46Y4XV4dDxUWMclt7UVpvImnk5ZTtii3KPwOlaW10qwu3hUDriUbUhuLSITa3z12Zcy+wCYmtUNgssKj7KJ/PiFDWW1f6rLckXHoGlzBURjfmtkYFb3ESIYbTyd0ajjSp1/Yz9Uc469CVE0uBkwz7mQhJqfDxjcL9wGiLDEIxIBA7RXxkrrtYaSAiw8vsEZimE7fbPCuZWHhKPcFIzfRyoIL82NsWxqJ99mA8RFnlxrwWDEWyMAn8L2xWyeVVUorv+vbRlk28/fMQkjCoQDn8jQpBmDsZ4YdLUHGjl6J7z5/SdCEGVI8ErL9iBhhBG21YEAPoUjXjep2A5P6hWEOZUd5f2lPoTfIdWYEnECi3b1O0hcP0H+D0W1NjdKzPBStsaNDlUEv/iczcG8f37Chyg6ko78CRqGKxV61zyIxb9onQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1b7915-a490-4b27-8cea-08d8484de048
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 16:50:58.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntVs/vys6B7cLsw4GeiUDoGaB9pCCMarN2h47G9z2x70Z982qJ3lqfXNtCeVlvXIkRNY27Ri+CVrZtFfAbrKyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3341
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#include <linux/io.h>
> > +
> > +#define DLB2_PCI_REG_READ(addr)        ioread32(addr)
> > +#define DLB2_PCI_REG_WRITE(reg, value) iowrite32(value, reg)
>=20
> Why create a macro that is larger than the native call, this saves
> nothing except make the reviewer wonder what in the world is happening.
>=20
> Just use the real call.

Sure, I'll change this in v3. I'll wait for more reviews before re-submitti=
ng.

Thanks,
Gage

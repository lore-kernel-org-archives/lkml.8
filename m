Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB14E20774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QApIdbIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHKTjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:39:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:11007 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgHKTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:39:13 -0400
IronPort-SDR: 2E8aZOqhO523A3qmMt1BTyYIfEuPb6l73/JVrpM1mfLvjKWZnltsGCLOjF+J6XYHGTnGxpwt0v
 L5ldSKGJxAoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="151249085"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="151249085"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 12:39:12 -0700
IronPort-SDR: FHFc7lrz5d5JddlrxdM2BUr8YaYECcXm/ydmtlIXxIajm9YjfINPvUlVoBoncVGoLdPrNiPncG
 sCx09yxdfXdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="317840865"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 12:39:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 12:39:11 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 12:39:11 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Aug 2020 12:39:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Aug 2020 12:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJD49l3CjMh+bOZtA0v9vYg0p1yH0vDdAeL8wh19M1LD3ufWk9KGGusurj7rE8nfBVh9Xrb04n+XhQhJs73g3nTSW2ERDLC+8AAiJPttbkGCtvHHWRYYmr6PHae9MJhIHSMNM97pmf/6nxnPyrVraXeydD4FjtY/9//6pLFBpo19y4pRgw5PLbhfOfWFNE2GqTiIKnXU7DJFQ5+QeJMWFl4ax+cfpExEkJuzSkrj9vra3hGs0y1E5im+9EABYQ91GzdJmEeY83fV938khU1r31On0USTJq7O88D8m7bXubD1+57tCn8b0i440LxO8cmlbfOcmsB/rz11vy2Jf5PKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1qJRpu62JCpl9tBsP+RR1GfsRg6kVlxgi+kmYdtv8c=;
 b=HLiooeDIJh3egUhqOmv2ls81O/0EKnNb+C4ZbH/91Ytr6ZBCyRqv4kckoHhvkueU32ltooZOfG0dM4IQpILiCNISGrG1CelSWPKKigjRnoZPQewR+oohXvC8uuiu9dagCd5uzFzDGcKdJ73CHGC+EHgTn9nhmXFBmOU0mQ3SwzMTCIlYckW0P2qRBESl+IxhEQMYLoKaZN0apq8AoPRVDhtBicBxzUi8ljcm4q85aVHuSJF+fA++ZW25L9raUQOVAJCyfLzcHJtoULv4Q6x9PvmqkzLV+cshK4Nn7IqfKoyjxP7G6VROPyIHNY2IyEAm6jt8RE5wALaaxIEKUK+McA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1qJRpu62JCpl9tBsP+RR1GfsRg6kVlxgi+kmYdtv8c=;
 b=QApIdbIk3gyQgnowH3Ni5TuQjIgB8cmtvMz0yUMVaVB1e8ZbEk88NM6j0AcFCI4INRVvfJkEywfuphStUdhMd4748dSky4Gc8VWiFdUR3L9Y/xXegMpluLce9JoC4Ev4ohKiAQAgz7ed87I9IzoiV9FMzo7l460nWiYipF9eKzw=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB1998.namprd11.prod.outlook.com (2603:10b6:300:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 19:39:05 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 19:39:05 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Topic: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Index: AQHWZsWN7jOrHrKgC0yTlu91mzQVjakgvc/QgAAF9ACACSlQYIAABQUAgAEMv4CAAHVaAIAHfuCAgABtRvA=
Date:   Tue, 11 Aug 2020 19:39:04 +0000
Message-ID: <MWHPR11MB1518201647DEDE4F67E602B791450@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
 <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
 <20200806113907.GX883641@kuha.fi.intel.com>
 <CACeCKaeLmVudhssvnYrQGmnJiD-byW8jOas1QKyQj4gg0=sC4A@mail.gmail.com>
 <20200811130703.GA627773@kuha.fi.intel.com>
In-Reply-To: <20200811130703.GA627773@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.236.160.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f62ea4b5-ea32-4709-f708-08d83e2e34f7
x-ms-traffictypediagnostic: MWHPR11MB1998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1998FEEBEAA837AB6FC9404791450@MWHPR11MB1998.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ExHzu9+MzelK878Oso7QPoErIrFZTqpK7qV0F5xLVOxXJMVzUcCZKhHc529auv6JvGhA3lICKqSYpksG8rigwkY/HCxjei/tkCl2uTc+8IWllXnCnLwjLl94BIMp55IA791gIvIaZf70oxiXZrimhg3ItXDXRqBKvcao9S4wAFc0dGIfckzl+MD6hBV4EIYaGXVLNuK+CKUGlJfr4MdLMDLFtadXzDeH9LIbwDjLOTHNqhinggv5hx5hWuJEXLvk4JUkryz378XMD7z2cbZpIcLcKJhWvk5bW6F30l6SKKkmeA9GcbmFsA71ZOzCAymgBeL5la+sj3S+ugVfRDj6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39850400004)(346002)(9686003)(478600001)(5660300002)(26005)(53546011)(4326008)(7696005)(316002)(186003)(6506007)(55016002)(33656002)(86362001)(8676002)(71200400001)(2906002)(76116006)(64756008)(52536014)(8936002)(66476007)(66446008)(110136005)(66556008)(83380400001)(54906003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i7DYHHQ4qQNIRfQmUDvsX6bqVHiOoVgXOPtqnFKhx2RuLgcLjfIRWxJZ/LRCvSB6Rt7V1igEnBoz1MoqdNC5DOLAb7+LfLb+x0arlA6VP2fM2IN+wqce6qVXCO+4zMY0/UNg/ty/aqio5IP0l8oN3VlXsXHSaqdWXHPUXiq5s/co3dCjWeKOa6BVUUOD0Sl/Rbeu0ym+TncLQbo9g6j5wZZrCBQRDGRM1VT9xWDx3HFVkraFIvJd0kzdYQHTYgBTV4VKKpm9U5pVcfJeRSADceAWkIudOzQwYpxmjXbfgo3fuZYiJ+KE6B8Com5e+3JIl/JHVM076PdP7gNaE7w/0MyzHOqPbX/4+3b72wXNGhogpJ3/JhJX41DzF23zPD4T9WGXWdiP0eXElq3alRiXtkZHKAb1g8Y8cRVHrk1AtWVXEnpaJymGLwEgLmOEUN/eBGhXLFbdYMWMKG1rip7ws+Hp7RHlN0xC2SIXzhCm1phjsgvkiR4OHlC5hACsUp8SBFOdq9C198QNoXm1otQBXL4baC9UCuh9f5ZJDUogU+yD8EELIkvFpC7UVdA7MkdgAYVmZgQy7ZUGBkmSGciF4WthzxRB+VPLnBkiYMN0ZuQdcLl8jMgvL9mC+k0iGTeiu7w5g3h0anO1OjDduRYBBA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62ea4b5-ea32-4709-f708-08d83e2e34f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 19:39:05.0249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmZdT+KT6Tc1xAMzsHAWLSzR80QpWUqS93Nl8W0cmHVHaBJ5ewu7ZKQT2rgriujZ7T4qI0bXvn1xtaJo1TE11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1998
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, August 11, 2020 6:07 AM
> To: Prashant Malani <pmalani@chromium.org>; Shaikh, Azhar
> <azhar.shaikh@intel.com>
> Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> groeck@chromium.org; linux-kernel@vger.kernel.org; Patel, Utkarsh H
> <utkarsh.h.patel@intel.com>; Bowman, Casey G
> <casey.g.bowman@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting
> usb role during disconnect
>=20
> Hi,
>=20
> On Thu, Aug 06, 2020 at 11:39:08AM -0700, Prashant Malani wrote:
> > I would suggest:
> > - Merging Patch 1 (role set correction) and Patch 2 (moving the
> > usb_role_switch_set_role() inside cros_typec_configure_mux()
> > *but* keep it at the end to preserve existing ordering) into 1 patch.
> > - Add another patch which re-orders the calls and which in the commit
> > message lists out all the reasons why this re-ordering needs to be
> > done.
> >
> > Doing the above will help keep better track of why the changes were
> made.
>=20
> So Azhar can you please prepare v3?
>=20

Sure, sent v3.

>=20
> thanks,
>=20
> --
> Heikki

Regards,
Azhar

Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A35C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A8B22CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tvVxGCgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgHET6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:34508 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgHEQnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:24 -0400
IronPort-SDR: QHWM3mZp2cFbSqFR5OQG0D7APYFJ8jPkz8wY1LQ1M7YBsBb0Y4d3Qbf+hxrt2PLrPOG8NHQZg4
 O9f2mRMHDzyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="237426245"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="237426245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 08:39:33 -0700
IronPort-SDR: yLfjaykiAzRDjge9SfLeQgda3TNDDalC9ngpUZVuw3g0Uc+AvRJZTH3dObBDBLHicmKCrAbnOB
 sDHkU0Ak7y/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="292976799"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2020 08:39:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 08:39:33 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 08:39:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 08:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsj30xMKeb+KUlCcZIrLDuMK5I3djCz//jg1DjB1bsOejK8YqjaPur+NMcBt7X0+ws6XQXwHWvqjqYE3DCy6MKbcF2AIZQ3048xxrTbGUhFDoaHB5NYJ3mARgUZ5LIr44NUHV8nqwuNjD6XzvKZRfom/nDHuPi7i1sdWFFf/G5lhn7OO0wXFNhtexsEYW5ih7fOuE+eGr3hPanOY18xGaae+BMh3V0YX6gowXroDB39JVfdzw7+784vm6g5fnF36W9MHCjxcxKh5fO6SA+p3YXigKMaUTdNE2tX7bu/y/1+l2pl1Pt2B4MWCZb+PN+SO4EXq5jYDt1SrI7KyMldkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQieyJimN3vVTkOvvWWIiKhsO/yxalMJFflegv77Ctc=;
 b=iQYhb5IeLz3hOUhn6m5+lWCWRlfMEE9kgbuR05YK1x0IsbB2/C0ARaKEZRV5sJvOi9smSQMUoc3dmenGZ6QExDfAoSHx3cUSX0hhGCrDKYuYHF9F7LavcBrcm7UwxAc53BNVlUd2OK0B0CRTKmcquRiVIHf2KcaAs79F6shObegRL5vKSloBIlaTsDrqPI7g4gERbq0Fs4ARTMaCMYFNMb3fmogG4Mwe8RSFV2xU21AGFxOnGs6ml8Ogc1cNG2q+fZ2yXVp8M5H4GZMGwj3x493FFANzOk0MxggheADxsX+zNSJ42Fo2eorfR3tFnzI0FSinS1PjFhEx/mgrXjOsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQieyJimN3vVTkOvvWWIiKhsO/yxalMJFflegv77Ctc=;
 b=tvVxGCgBsWuxSm5tddRgQ0WVU9Ume+vCNn6G0RzNqUjH+ViUFL/sZmOnZOw22bJEhUfF3un51IMUsm57ECph5RPnceqUEjwkhdfMk3pmpltN+LKvq6AKqEy3F6g8rDqwrUhRRwgXev+hDVHwz5uAUXTj3sFY1YvnRovzHBVSKUA=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 5 Aug
 2020 15:39:26 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd%7]) with mapi id 15.20.3261.015; Wed, 5 Aug 2020
 15:39:26 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Topic: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Thread-Index: AQHWWGERiGLMQx7oL0apZ2u4U144JKkooA3AgACXcwCAAIoQsIAABNcAgAABGXA=
Date:   Wed, 5 Aug 2020 15:39:25 +0000
Message-ID: <SN6PR11MB2574B45613993A52DF40E76BF64B0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200805064622.GA608152@kroah.com>
 <SN6PR11MB2574EE40D3120F92F1BFEEAAF64B0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200805151750.GB2403607@kroah.com>
In-Reply-To: <20200805151750.GB2403607@kroah.com>
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
x-ms-office365-filtering-correlation-id: 7f45ec8e-0792-40e0-44e9-08d83955bbeb
x-ms-traffictypediagnostic: SA0PR11MB4559:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4559AF55B007B2BBC8A4A8B6F64B0@SA0PR11MB4559.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MXYceo8sRWm/j1EBYTvTjg4y08EfFaioCFV7iySWHD/cy0jdZFb64fF8Ob3y1QnG455bWYpOnPSpZ8dztPQmpdcU+fV0YiqnNjkQ4fxyT+VNy8DHnIkA44nElj+QL0XXjkkV2enyBxqaMhHGEYK6Ipqb18cCx1tsOouQQWl6xzYXI45VIWvdV+rvwcwzX81/5VRBOwtW/vFuTP6djmI5Sxn7xokgEAxZDretpKWfppM8xdoie2iOcDM/XaeBI6Okt92MdprAVGuJZmtVSvAty/y6zLn9O+jPpTMm+0jLlOb6VCJFKA8XSPzA+jvZQ9NeQ9Me6cY8atdG2LjRr5a4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(316002)(6506007)(66446008)(64756008)(66476007)(26005)(33656002)(52536014)(4326008)(55016002)(66556008)(2906002)(186003)(8936002)(76116006)(66946007)(6916009)(53546011)(9686003)(478600001)(54906003)(86362001)(5660300002)(107886003)(71200400001)(8676002)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g9CJAIrAaxi4yBGAhjQOzH1iQ0ePaNQ+HTldaJcBIGyJlfppMfAkhgAbzXVmE3RjmVoJILz1vyThMwwWD0I54X3X6xEZ1oJxzn4G7uhgJxAZImXstZX8U1p1oDB1OTqJGSza942IK34qxx49/ZAnUPqcLFcV76VbLNnaXfm+rPAAlpv1OrAEiZ3YRFtlzu4teH5s7wL/aa9GA7nqUrOnpQ9ihqWU1eOAj3llLcMr9mparSrOkt2LrFmyIxBWnoPEOSqvZwS791Yka5X+3W+tX0SEyhhGJdFpI/Gg2SWZLx343gyd3iCWwSL/3kqGReGdTrdQbu+XW9kvGMJeVQu1y7P6/y3E8NJSiiu6V+OTWm8lei7wbn/my8G/kvaV7PECunp/MrDCyxAaI5Nuw7koga34/FgIZngD3Z/Wl9JbdCcsePrW+0pqwXjGF1ydXiGj6tiB93VByKFd126lOg7j57RzDNlCu0FnHJVzWdYEPxgQdQIPN3Imc9xT8LMNm1FfEdTejDVmLBD/OsBOjNEe5h5fNyW1VyuW/dzOMHiOMPPsgZ5dGYVLm2bjjM/cLo1YCNbw8TWWbE6eQgxpChc9fQAtUKvgLMEbisXza7rgu8/R/aKW/56zNsPJUy1PCtnzNHQIVrkPt3/pQgQB6zyLJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f45ec8e-0792-40e0-44e9-08d83955bbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 15:39:25.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxbBaCeKkfWNaTQRYD/XGiZzRbMLk1NNSuHcza+aejKBa2hvdC6tCu8I3k1BgZhv3mtPXi74Difwe2GEDzd4bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: gregkh <gregkh@linuxfoundation.org>
> Sent: Wednesday, August 5, 2020 10:18 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel@vger.kernel.org;
> Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>
> Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctl=
s
>=20
> On Wed, Aug 05, 2020 at 03:07:50PM +0000, Eads, Gage wrote:
> >
> >
> > > -----Original Message-----
> > > From: gregkh <gregkh@linuxfoundation.org>
> > > Sent: Wednesday, August 5, 2020 1:46 AM
> > > To: Eads, Gage <gage.eads@intel.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel@vger.kernel.org;
> > > Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> > > <bjorn.topel@intel.com>
> > > Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 i=
octls
> > >
> > > On Tue, Aug 04, 2020 at 10:20:47PM +0000, Eads, Gage wrote:
> > > > > > +/* [7:0]: device revision, [15:8]: device version */
> > > > > > +#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) |
> (rev))
> > > > > > +
> > > > > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > > > > +                                        unsigned long user_arg=
,
> > > > > > +                                        u16 size)
> > > > > > +{
> > > > > > +       struct dlb2_get_device_version_args arg;
> > > > > > +       struct dlb2_cmd_response response;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > > > > +
> > > > > > +       response.status =3D 0;
> > > > > > +       response.id =3D DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0)=
;
> > > > > > +
> > > > > > +       ret =3D dlb2_copy_from_user(dev, user_arg, size, &arg,
> > > sizeof(arg));
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +
> > > > > > +       ret =3D dlb2_copy_resp_to_user(dev, arg.response,
> &response);
> > > > >
> > > > > Better avoid any indirect pointers. As you always return a consta=
nt
> > > > > here, I think the entire ioctl command can be removed until you
> > > > > actually need it. If you have an ioctl command that needs both
> > > > > input and output, use _IOWR() to define it and put all arguments
> > > > > into the same structure.
> > > >
> > > > I should've caught this in my earlier response, sorry. The device
> version
> > > > command is intentionally the first in the user interface enum. My
> > > > goal is for all device versions (e.g. DLB 1.0 in the future) to be
> accessible
> > > > through a /dev/dlb%d node. To allow this, all drivers would support
> the
> > > same
> > > > device-version command as command 0, then the subsequent
> commands
> > > can be
> > > > tailored to that particular device. User-space would query the vers=
ion
> first
> > > > to determine which set of ioctl commands it needs to use.
> > > >
> > > > So even though the response is constant (for now), it must occupy
> > > command 0 for
> > > > this design to work.
> > >
> > > "versions" for ioctls just do not work, please don't go down that pat=
h,
> > > they should not be needed.  See the many different discussions about
> > > this topic on lkml for other subsystem submissions if you are curious=
.
> > >
> >
> > This approach is based on VFIO's modular ioctl design, which has a
> different
> > API for Type1 vs. SPAPR IOMMUs. Similarly a DLB driver could have a
> different
> > API for each device version (but each API would be fixed, not versioned=
). I
> > didn't see any concerns on lkml over VFIO when it was originally submit=
ted
> -- though
> > that was 8 years ago, perhaps the community's feelings have changed
> since then.
>=20
> Fixed apis for device types is usually the better way to go.  See the
> review comments on the nitro_enclaves driver submission a few weeks ago
> for the full details.

Thanks for the pointer -- I think we're on the same page regarding fixed AP=
Is.
I'll clarify the documentation for this ioctl in v2 so it's clear that its
purpose is to support fixed APIs for different hardware versions/types.

Thanks,
Gage

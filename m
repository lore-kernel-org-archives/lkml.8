Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F72C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE4120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dWczkWlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgG3XCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:02:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:25191 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgG3XCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:02:33 -0400
IronPort-SDR: B06KIO2DwcIMtzI9TORgMzESrAjQ/eBwRhRkqxgqDcKRCnrp0UySiEOPdyUutcJU/vpw3SmlMV
 HTH9tgiER/uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131271970"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="131271970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 16:02:32 -0700
IronPort-SDR: 1BXeI0/UzQv14hbbHM72hfUFOPOvTJs9opYoPfMEwvo/1aeo7KfcHkboD4toFafNVRk9qVkquX
 OAPXGtIz4mJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="304752996"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 30 Jul 2020 16:02:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jul 2020 16:02:31 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jul 2020 16:02:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Jul 2020 16:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/A3JY7clPsNdAWjHhljLpWL4SkBHqgGpt9+dGJPyuQ6HFps/elSOfkAYltn3aMiCWKA8scD1y7gQQVbCDdFVP4E+ZfzxfjrSP4CdKrYGfNL4vBVirbhG9DNupdH12ScP7RsOKN7yFu+axhy5WEwU5h/hEsbp24w/px7OpQhIk6eb78PWIQbFmGFJkjC0R9VbOf0+lBCudZ5agkBWW6kVZ+Ns1XYPnOkNo+j6vKmOK4JNfLGG5Ur8qAfuO52qJDHLM1hvsKjXOFkrHXG7arUA92Q3YVqajpcRn47wvnKWJcMerBtieqlTNI3VfJ6yoqxcFn6W2XJY3vIeGIj0rvIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjOPW9py0N7fsw9Kw/pCMuwbpk4ZHEdVblVBBIbxGgc=;
 b=GilApDuUPkvDqSC+uw5hcSCVn245Z7MrWDRzrCOaxymwvkOSvWbPWFnSskteR47DdkimM7Kn6YX1Daq3w4Wj92G69q0o0Uzqj5+e4MBEtf2CIuUwqFTyVFVg4goWC1PoI5xoFYJ0/Cax8WmyAGsTbJEM5RrpvolTUxXNPxckk/wQwJ9CdMZKvcHhUoi/QL+HR7rx9kqMsIP3C7wTGj8zmsUZeuD0Tyhbh8KrOuKDUBiJMk97tGauF/swH2RDxTvHd1vFaNujBFVlsApFUFDtUwKI8JgJ2W3qBZ258iOuZpTbdZEnx35UnNE1EJOAPBn3ai486RYbaT2ostZrp+IZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjOPW9py0N7fsw9Kw/pCMuwbpk4ZHEdVblVBBIbxGgc=;
 b=dWczkWlfBoQ1WpszrtISNiF2K7vGd/cAj/5fB1JV7wE8ZFonY3zxi8mS0nzJFCjgGqXjvYAAPDDtM/t4bNyAQEbwBr+xoTgzYW16VHVlkP67Ekypdhbzn7F9ILpsUPYLIWobExEoGSoWUnJ/OAaea/fneIuFuMuw1GdY69TBoZo=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR1101MB2174.namprd11.prod.outlook.com (2603:10b6:301:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 30 Jul
 2020 23:02:28 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595%10]) with mapi id 15.20.3216.034; Thu, 30 Jul
 2020 23:02:28 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Topic: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Index: AQHWZsSZvlUsJzdXqkqf6LtgMiR0NqkgvJWAgAAAwwA=
Date:   Thu, 30 Jul 2020 23:02:28 +0000
Message-ID: <MWHPR11MB15189A9180898261A92DD7C091710@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-2-azhar.shaikh@intel.com>
 <20200730225921.GC3145664@google.com>
In-Reply-To: <20200730225921.GC3145664@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.236.160.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 640bc0f8-ca15-42b6-70e7-08d834dca205
x-ms-traffictypediagnostic: MWHPR1101MB2174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2174FF8325942F3816A82B0A91710@MWHPR1101MB2174.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mp7WBZA4mkcvSTW//Ihik7IMNVbvRCWNq2wprxFxY0fGXKK2gAaVu9sTWZyl2vmJBiqUcsnI5xHX4GHw39DFpyQvmBVOEkCTBjhlaTHUwq+6CEXN1EH7CmMveseeolmXi5J9u9TjMovDmaZBTvtu6MHm/k7g2jfRl2V2KCo/ZEmua/yyJmgHihJC92vNt2e2YtFJatXR0fKhEAj4nL0c2EuWkaKmkK0LVG9NW9gcTorQShljp0JPrP7f5Vw3weDNN369pS9CJMFl/yE9g0OzeZEidj+lJ9C/QPUYRUu8zqJ4a7+4tPxZfWpQZhYmtx7N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(66556008)(64756008)(66446008)(66946007)(76116006)(8676002)(33656002)(55016002)(9686003)(52536014)(6506007)(4326008)(2906002)(5660300002)(478600001)(26005)(53546011)(86362001)(66476007)(316002)(186003)(71200400001)(7696005)(54906003)(8936002)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gP+QMEXFrQ7g3YeMnqzIWJErymXxskakYfLn7Tr0Lpr4yaeAXM+TsFlhlQFzTgtCPdDF3MsViXnmJBMwOY3rqq3vgEun2UZ0sCUJJQ5RMgvJ1arW3dEcsx3Gg/IvYB7Fut/fz0yU6FtQ5w5kDX5Ar1RfVJfjVjhrw4BiTPfQieWnXn2Em8gLZD4ZGHQ8It1Vfvp6tKlpEYEdCWH4XpduEn7NKBmwQF9m2i00oiZ/Zz7HTDs/KLCNtMrEvJviRl/9xNZNwOoOXclrk8HGZ65DyG3HzAWOdQafhp5UclHks6JAwdGgTo+EHyI2L65GY5g1jtGmy6bcFb48mL0TdAE/dCxOVILlOiShmxpuwHIse5DllvqXguqY6slIFz4zevcyWAriyM2Ik+S1uA61W5jADRkgXSQ1H5iDl9yF7qdJhRHIfZnlEnu6S/Nh+7fAELD1J4PlmQhpVNvLGnC1SdiEdzfNRVNRuNvr/umu21rVPL1NiRwJvJAg/ldF7Sw6MpkP17g3qexM8BJBHVKDHTsk95TVZRecapNRwLDxXEKfub/4gA9tpM59Xd+ZzrFrZFfITEfoEpujDdZK26BJHGqWoaZOWdkgOVvRROyfiBJ60CimL72tTvGcHFP32pJoRly6BJG6OKNPFLNAlxMmBx8jFw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640bc0f8-ca15-42b6-70e7-08d834dca205
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 23:02:28.6321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOkY1xKMP4oP/iRV/Yco4E6qrqMrK25zZ5fkM/1gtb+UrSPoIjcyxRqvmjQGZyLuIBvTzZs9BY1+TN27j5lodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2174
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,


> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Thursday, July 30, 2020 3:59 PM
> To: Shaikh, Azhar <azhar.shaikh@intel.com>
> Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> groeck@chromium.org; linux-kernel@vger.kernel.org;
> heikki.krogerus@linux.intel.com; Patel, Utkarsh H
> <utkarsh.h.patel@intel.com>; Bowman, Casey G
> <casey.g.bowman@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum
> values to usb_role_switch_set_role()
>=20
> Hi Azhar,
>=20
> On Thu, Jul 30, 2020 at 03:56:08PM -0700, Azhar Shaikh wrote:
> > usb_role_switch_set_role() has the second argument as enum for
> usb_role.
> > Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
> > This eventually translates to USB_ROLE_NONE in case of UFP and
> > USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
> > values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
> > DFP.
> >
> > Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux
> > control")
> >
> > Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > Cc: Prashant Malani <pmalani@chromium.org>
> > Reviewed-by: Prashant Malani <pmalani@chromium.org>
> > ---
>=20
> Please add the list of changes in each version after the "---" line.

I have added those in the cover letter.
>=20
> >  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index 3eae01f4c9f7..eb4713b7ae14 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -590,7 +590,8 @@ static int cros_typec_port_update(struct
> cros_typec_data *typec, int port_num)
> >  		dev_warn(typec->dev, "Configure muxes failed, err =3D %d\n",
> ret);
> >
> >  	return usb_role_switch_set_role(typec->ports[port_num]-
> >role_sw,
> > -					!!(resp.role &
> PD_CTRL_RESP_ROLE_DATA));
> > +				       resp.role & PD_CTRL_RESP_ROLE_DATA
> > +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> >  }
> >
> >  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> > --
> > 2.17.1
> >

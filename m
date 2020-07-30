Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F022083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="e3ekTPYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgG3XGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:06:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:51541 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG3XGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:06:17 -0400
IronPort-SDR: s9cnaIzJKX+mIzffYkONItjUSwXP1fEwiM6C4Tydpi7Jce4xQJg0fHCP2SjO2LEKPo3eviqix4
 AWdNIWB9vDzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="236571391"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="236571391"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 16:06:16 -0700
IronPort-SDR: CEWREfC08rHyhV31woUmKNBCLH4jk2iQ4YAxtNlU1wf9kyzwT5xMnQ3RzUllMEPET5T0qkco4y
 Rz52sLigUT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="274356372"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2020 16:06:15 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 16:06:15 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jul 2020 16:06:15 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jul 2020 16:06:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 16:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC96Dkn1hLbnOvU4gjMa1E7bUevjSvPrlOUMeof6/igyrCJAqctqKtphLx74b0IKFi0sD40Oiy81KEP5CMMUWAgAgF3SViY3h+q7+5P6MF1+weXtckQear9eQHr+Ij5oCiRMLtXO23ssqR7dnFv2gP3fRC/QiaYog1ATHXjPJ2lwaq04Vh/pfr8AUDqxxjqsw8R5U1REcyy6RLvH5hT1xeCii3vZ4VTif4LQHGL1sXG0/sVw1o+jRIE//yRZgHF41RF/8JqNClIys5mK1EMF7emTM94SPVSN34Ti4WCt16c9c/8muzMIVpHvWGMbv4g/EhfQrNVnNLEY+1tYHjpm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJNNXNdJrGZjH3H9GacnKRdE5gLCHU6yQfDzO6OSs+I=;
 b=MqwkV2SylWgsDklaTg6sDQHRQqaNUiHoCwLlbb327RoFxskG1MqOKDAgXkjYLFdCUtMmByloGmAZvD0Exfh0GbZ3vkg9fwH0oZB8T21lGsY7RLmKzMJ6lsP0adpAANHOCrrGZtQDEUtAAMiu/s5/OAVqym8Z13ZHbWdAVQiMVZzde8l2HU5oWXq4jEbkv+w4rdPJtWe4qBsB0UnGzE0WTCuOAzGTZdsa74/KmgezFjN60zv6p13hVul8hDNqoHffpbmWKrVx4KryKNN9umxtNJhgZnFvbyjjxjtr1NtrV9ghevQpTfBo/vfpn6AH+WhNvts9rLMMxab1gR5h7Lc7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJNNXNdJrGZjH3H9GacnKRdE5gLCHU6yQfDzO6OSs+I=;
 b=e3ekTPYk6UIipamXvE2VkAF+wa/9NvSsDaNOGzGj/NP+5jwP/j+DYF7rwy/+K/t/hIauxjjQUi5mMjr393PGCYoUKQ9VylcqvZM3jY54bSxPy7NR6Mv0MIGnITMBjvkpeNBqn/5xdXZRFD3CQ18C/XD4e3PhGPp05JEEAY/LOnY=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR1101MB2174.namprd11.prod.outlook.com (2603:10b6:301:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 30 Jul
 2020 23:06:12 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595%10]) with mapi id 15.20.3216.034; Thu, 30 Jul
 2020 23:06:12 +0000
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
Subject: RE: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Topic: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Thread-Index: AQHWZsWN7jOrHrKgC0yTlu91mzQVjakgvc/Q
Date:   Thu, 30 Jul 2020 23:06:12 +0000
Message-ID: <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
In-Reply-To: <20200730230238.GD3145664@google.com>
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
x-ms-office365-filtering-correlation-id: 4cdf258e-81c4-486e-4e8f-08d834dd2743
x-ms-traffictypediagnostic: MWHPR1101MB2174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21747086A8A1E25EA72C6EEA91710@MWHPR1101MB2174.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0M+sqRzObBjsOninLBlS6Ljk6viuu/v0sZuM3f25fr7RNCoLUjEWuXDxmN7PiaoqH4GomUm9D0cyUqqe+eX5+zT9zq2DEwhvbXCAUXuH3g2mKSrZwJHaNVTHKosc8QYh8JF/soh6Tvq0SVNy8+HQ74lIZJXXzwCx9jmK7JXfhVxJKj6LrzMY7ynW6ERQKQI20X1LY3M/LNTSWG6OtwpgUjTlIsiG3RFWBJWeB751CBTvmnxOkIFEzXdJkEHuwrz1ijP/V+NxQ4CRv7fKHkMtQAp829mac7+FaWhLamO6EGy72HKzBCTGbPiE5FPQ7xmG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(66556008)(64756008)(66446008)(66946007)(76116006)(8676002)(33656002)(55016002)(9686003)(52536014)(6506007)(4326008)(2906002)(5660300002)(478600001)(26005)(53546011)(86362001)(66476007)(316002)(186003)(71200400001)(7696005)(54906003)(8936002)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IsdQ+H+cz9mMrnpURTpGrWY/oX4KBvmr4i9AHuli5MhZavNS9OEBgArmVAwEVzQtfiThNkHuZ8jLhaZOZp3jyR6Qvhz/CMW1NOI9UPXBA+cerEZlBNZZr3fzVx52gv48u8gInXShXB63CBy4S1yyxanaKCqNNtK8mmdr5rhvD6qGlBFu3Dyn+hrWhDjj9WTlAYQjGLO+PHWQ1o2ayKeXrOD867jX4PgwwK9A1EuLDNPaZjjhgpyiTwj+3SZSxcPJKy9cCqDfHYyaU/aP7YUB4o13ABbR/zQ+ITyfrYfU1fh9RrS7QwO1RGFCiXJ0vmv9tEg0WMy33TOoBVPQQK34OMeA7WeplCy3cpN15W1I+sd2W3lD36Cqcwr01fhj6UD7lnjPOqKRvYRnPdtzFopMDOoxtp5GIcBKH2G5J6yWxX2KDvS7cYiwoF16TjihdT1sQNpQZmNXMeuXGiNBzKvRIY1nhQOiV3fI4L0CLe/RE1MPyk7Dt5OEd66id7mQUCW+HQLlJjWgl7J6+r8PGb4MAF6d6oMxuW1AaTJEaVk4NH0lUPnWQoIhyELtTDYlMYGC7i67X7WFDTlJVu4f9+4h0CGHRHAvMtBX93peSi5jrZwyVGnvGRO4a1kPlfAXdj5Dt+BahSzqnM5gLgleDG4V9g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdf258e-81c4-486e-4e8f-08d834dd2743
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 23:06:12.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vRLkZNrHFG+OElTbgu5kxZ9lCNCMcgRIx4p5E5O6mUHiJiIDF58GOjxGq9j6LdnD0SugxwNAzkrbWDS3Xufqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2174
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,


> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Thursday, July 30, 2020 4:03 PM
> To: Shaikh, Azhar <azhar.shaikh@intel.com>
> Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> groeck@chromium.org; linux-kernel@vger.kernel.org;
> heikki.krogerus@linux.intel.com; Patel, Utkarsh H
> <utkarsh.h.patel@intel.com>; Bowman, Casey G
> <casey.g.bowman@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting
> usb role during disconnect
>=20
> Hi Azhar,
>=20
> On Thu, Jul 30, 2020 at 03:56:09PM -0700, Azhar Shaikh wrote:
> > On disconnect port partner is removed and usb role is set to NONE.
> > But then in cros_typec_port_update() the role is set again.
> > Avoid this by moving usb_role_switch_set_role() to
> > cros_typec_configure_mux().
> >
> > Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > Suggested-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index eb4713b7ae14..df97431b2275 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -515,6 +515,12 @@ static int cros_typec_configure_mux(struct
> cros_typec_data *typec, int port_num,
> >  	if (ret)
> >  		return ret;
> >
> > +	ret =3D usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> > +				       pd_ctrl->role &
> PD_CTRL_RESP_ROLE_DATA
> > +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> > +	if (ret)
> > +		return ret;
>=20
> Since this was the last switch being configured, please maintain the same
> order and add this at the end of the function, after the if-else if block=
.
>=20

Please correct if my understanding is not correct here:
Set the orientation , set the role, then configure the mux. Shouldn't this =
be the order?


> Best regards,
>=20
> -Prashant

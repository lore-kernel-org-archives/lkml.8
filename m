Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CCBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ED12072A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Rmax7wfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHCP5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:57:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:18570 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCP5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:57:41 -0400
IronPort-SDR: mGGzWiON7NxEWJFj9iaTIxpJG+aVKcMo8sdP0ZPlD5SNjXgXs/aRiY3Jt2o7J7c07KwsteE3n0
 q42xwwpudaTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="152098309"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="152098309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 08:57:40 -0700
IronPort-SDR: t/lvunXmugcq98mxUNjyaITB250eyQ2tdB6Kn9RqUSernPPqsBPqWLE30ttQXgg8xCqDCkoXB6
 lVHOC/SUx+cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="330111140"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2020 08:57:39 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Aug 2020 08:57:39 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 3 Aug 2020 08:57:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 3 Aug 2020 08:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZPZguAM1sSLDGgsfwH+cKV7YeNm2MsXGPA8Aiwqyh+Jl1U1TV4nvPx++5uH2NtHHfAIX+ki1hBt4oxamZvjueykTzO8n/Zz/v6Kh2pdIoWV2GYP5Ap1thUiQOxu8d34gjL0mmhsuQMYQbG7cGdOp5EUQXXjqk22N6GteEsrzoVlCAcwNnAH9v0ObFM7LU1ir9m2W+Udh9jZlIn1402B1g7Vdu5b28A96A3MAKTYkyivm3eVod3wOyHHe0u/iFDIqZ2ioniFfD0RYKSupsGkoHDWnShW7yVTfylO0iM4wFrvnZ9zOJSqmNyFLcmIkPKWSv18VdGFtCxJR94XH/5jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+isKOqLBayHMP6S34gn6Hj8wn7Ksz9QO04R+hk+TmY=;
 b=hFxmddkf5diYAAoSx8ujB4eG67xwTJBRW/PVEDfz8eKxEALrsk0xrjeBK2rFjhqq/nySuztvLucxr+CYbHIuqSNFl6nmNCdpK99cjfczSJDrmqFSW81bzbtRuo7H6qOYBi65A0a9ZSCm/mEFRJXPCKCE9h9UquYHi/MNlYbkyEImz9JCVaEmoiDwN79Rx9oDXQ5+2/Bc4Qpo7mbcWEfqcKI4nKGXHWixX/OkeX4b5cNzq22vLu2YjAL/wv2QCOFRyHdwvNtVf9sXAGChUHNPu7yhjCOPQTCaJ8gbfjZZuTS524blmAfBAxTe2v5HkirSqrgpBmWtXNuVOoFA+iLZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+isKOqLBayHMP6S34gn6Hj8wn7Ksz9QO04R+hk+TmY=;
 b=Rmax7wfvRt00l+Tw7IQ8JbT9pc57ZFJAX2lWanOjJWo8rQz0pSwEf5wjEbxcFsaPaSPl8+9ceLT1LXH+1QV6dw+NNMQQ3mJL0KbUBs1CAuE/3odxpQhESuiSvq8aENFER/+vppVyWVObWVfjAzzYMLg4IN+AotPmtqrf4h616qU=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 15:57:37 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 15:57:37 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH] platform/chrome: cros_ec_typec: Avoid setting usb role
 twice during disconnect
Thread-Topic: [PATCH] platform/chrome: cros_ec_typec: Avoid setting usb role
 twice during disconnect
Thread-Index: AQHWZsQghvySp8GNL0i9UqtWE0sIx6khsakAgATeCrA=
Date:   Mon, 3 Aug 2020 15:57:36 +0000
Message-ID: <MWHPR11MB1518D768D3A6DE7F1FE4AD95914D0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225257.7208-1-azhar.shaikh@intel.com>
 <20200730225257.7208-3-azhar.shaikh@intel.com>
 <20200731133630.GR883641@kuha.fi.intel.com>
In-Reply-To: <20200731133630.GR883641@kuha.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 676d5f99-6de6-4f1b-3968-08d837c5f161
x-ms-traffictypediagnostic: MW3PR11MB4585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4585558268A887F285EF2E63914D0@MW3PR11MB4585.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6oI1PWXu2etgzSIMNj+xmmgGc3x+4vbQw841lhP7dIZ71WIb1zXj7rpuAfqZCk/jXaidEexwZWI5hd6j4IEr3yDbkX9DPI4vPW6Z7TF8+gTwcThMvCykjj61VXQxUq7KqgE7uAm/aQ8YkUrfsLEDQUimcSCq4+lWdeHndomesyGhNBhYo1pledwOBskbVG6oR3NFTcmW3JqmPp0AlHZfC+7bvArHupFoAiw63o282rS2bNTArP685JllyrgLwvz4mwn9WK+WeNZdDoQd/Gr0fWmTkOnMt1kKTW7N9D59lHEsJJLKRRx6uvL53JniOBC4E8bNf3M72yziwYkKw1Qkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(9686003)(8676002)(76116006)(6506007)(7696005)(316002)(5660300002)(83380400001)(66946007)(6916009)(478600001)(54906003)(86362001)(53546011)(26005)(186003)(4326008)(55016002)(66556008)(8936002)(66476007)(64756008)(66446008)(33656002)(2906002)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fWYlb9RFjEumrG9bmuUnBimWdx4R39ir40vw4czm/OwLeuky1fQk6HFJPtbxXiLcxT/K84QVeQW7syr+LuXVDIHV2QPRoZIuQGR5DJEqQKhhqGnw2DgMpEfcBcOH8Kp5VAvMhqTQipDsvMayx8YYdZAq4nEFwakneM0gvXFabWPZXbKQliJim++XCCe6OVouuEDeZK8+h7w6Bx3ihcyK4o7lqPF37D/lsHEyc5hDZHf2heu9qyb0PDIv4ICWMSzVij5NPQLBc2JHm/MhkC9GrkcdIGj7rHXNxCLrvRKZ9cnvnVxuu/S2OyV/C3xZ6UPFaiUyB2BCd2ftny7awCqXjvIJp1jhuhZL6eCqN3MlZ0ttG9JtfwBhHw1GSMoknt3o/kMxY9OTnUSB174iMvk6EqyvKGQXrJxxpFfW6kRCvRyyFsJNz+ztqs2cz0hF8rpyVhtKZnYcu10bhpbY2bLaKELkC6tcj5x3A6/GfikeHoxEg6nyzoErsRVD0NDIQGfkANlvU7Zj3/snDYnwczAyzEJKDcdxXJ3/2CapFZ1UJaX7oEqlG1JRIuAdLAuja0GDOirX05hc2YemvDP7t690Hunc3Sk8TFUbm8+D24fEeaW6tjzqZc5RPmgkGnYnRzrsOjXulgC8hu6ZsTHsz8rUwQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676d5f99-6de6-4f1b-3968-08d837c5f161
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 15:57:36.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ra5R2Sy3BnxoAG2VJ8UgezsyL+7i+AhZlzD7RJQvgIueZbUvFmMXwS1Dojqfish1mlLugi3zfewTIf2Z1wWjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Friday, July 31, 2020 6:37 AM
> To: Shaikh, Azhar <azhar.shaikh@intel.com>
> Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> groeck@chromium.org; pmalani@chromium.org; linux-
> kernel@vger.kernel.org; Patel, Utkarsh H <utkarsh.h.patel@intel.com>;
> Bowman, Casey G <casey.g.bowman@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Avoid setting usb
> role twice during disconnect
>=20
> Hi,
>=20
> I guess this is was supposed to be PATCH v2 2/2, right?
>=20

That is correct.

> On Thu, Jul 30, 2020 at 03:52:57PM -0700, Azhar Shaikh wrote:
> > On disconnect port partner is removed and usb role is set to NONE.
> > But then in cros_typec_port_update() the role is set again.
> > Avoid this by moving usb_role_switch_set_role() to
> > cros_typec_configure_mux().
> >
> > Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > Suggested-by: Prashant Malani <pmalani@chromium.org>
>=20
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
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
> > +
> >  	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
> >  		ret =3D cros_typec_enable_tbt(typec, port_num, pd_ctrl);
> >  	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) { @@ -589,9
> +595,7 @@
> > static int cros_typec_port_update(struct cros_typec_data *typec, int
> port_num)
> >  	if (ret)
> >  		dev_warn(typec->dev, "Configure muxes failed, err =3D %d\n",
> ret);
> >
> > -	return usb_role_switch_set_role(typec->ports[port_num]-
> >role_sw,
> > -				       resp.role & PD_CTRL_RESP_ROLE_DATA
> > -				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
> > +	return ret;
> >  }
> >
> >  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> > --
> > 2.17.1
>=20
> thanks,
>=20
> --
> heikki

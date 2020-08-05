Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E1A206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SYRrPB7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHETXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:23:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:56818 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgHETWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:22:48 -0400
IronPort-SDR: QXsYcvlnddv38Qe/gpItgCcG/v+69QD7Ui2WKVYP1oabspXz3xQzre0wfk42rx+N8wBvNakzDX
 g8+vszfolvnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132200351"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="132200351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 12:22:47 -0700
IronPort-SDR: HXWh08O+eJuq1PoXY9uy78mEOdk/xl0MZVFtguxYaoXsGRv9fW0Mg+ehFT63Z9oSnuWFP7oV/k
 ZmeiwxWFCatA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="367334163"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2020 12:22:46 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 12:22:43 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 12:22:43 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Aug 2020 12:22:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Aug 2020 12:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqQ5luzMOQCduwwmwaP+Ms8Q5IGbp7bb6KGFEvn5C3yhUCakrp64qwS5LGKhFTCUNvbTCPkUrBXxpLAXVfGqIW/IqjoqoPuBR+r+9OIm7EYX7/9Smnb2rKopjzu3IyzDUhzIZlgCBgf3r0ecwrfcBI/ksRg4Ki4UGcsSw+iGkccIlamKihDE2O1i13hMkK3UsFNBNUNKA/FvNZWsEVbe+GVxCQS5Gl1SPso0Bem0RRb1D4+ffMgX+y2GPO4ao87qXYgGIrkW0RV3giUISJm2R3F15FCsZzoqY79136BZ3wCBx+PIgBKwXqkN7Cm2N/YZ3j9PSg5IKzgPBq4v1vmSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+Of4PbeAk9Z6vjCo+R39IET6hFrjRP3j/Wnf0QsYFw=;
 b=eaA5AmPIp/gKOR3sQhMCjGTiXbiDle4n4fjnlcTgiTWh48cEMqCXL4kh9rcHjAdJJIVbJzS4qNvTuwgdix6Ss5HmkvF9YVcB0BtmXAYzqnOBfJwBHwga1mSIeN/Z8NQ4GgxRfJOwA25RWeQiEw/yh21yb2gcHAPBCtErjFAphx5fn0mJL76274YzCrSrLbtdwwhpkfZN1GZj0m9V+PCM6Nzi/91UKaHI34FAu16zwyb2HzC5EclIEQnAZ/zk964D1p5Xevhw0+Bj/xKeJWl8D1sJeueRqi4yp0ZkDUjAgUU2csJIAMxs7oCWm4mfWqCU9RnMJB5dd+FayZU5e/rEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+Of4PbeAk9Z6vjCo+R39IET6hFrjRP3j/Wnf0QsYFw=;
 b=SYRrPB7xrkHo16cf6iKdnkG3kLLL4N6YXd//9IRa/PbqF2VqXZGeI/OHsercVamsgEKqfbX2N3h9T34BXF71NEgkSk+Tb5GBiWLyMz3h7NdMGngyX8oJQawOiNQCKzYM/sxvKYAQDPVL7GW1lEPQsj/+0lnhm05WnhEULXPjhvM=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB1408.namprd11.prod.outlook.com (2603:10b6:300:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 19:22:41 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 19:22:40 +0000
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
Thread-Index: AQHWZsWN7jOrHrKgC0yTlu91mzQVjakgvc/QgAAF9ACACSlQYA==
Date:   Wed, 5 Aug 2020 19:22:39 +0000
Message-ID: <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
In-Reply-To: <20200730232504.GG3145664@google.com>
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
x-ms-office365-filtering-correlation-id: 1cc44918-ab6d-408a-08c7-08d83974eb54
x-ms-traffictypediagnostic: MWHPR11MB1408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1408A2889DFAF2B84C097E1F914B0@MWHPR11MB1408.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Bg8b+5ADqLsHQIif9EMiE0jRgMN0vYyXj9YjOE+vHZbQ11wbPSoVV+l0/AuNetAgwoeAynAoIHUNLSiCBzrTdaL92+0s9rwckfUQCpVz5KJSYhOH75F6xitkTfmMsoBVTo7VqKo/gyb03+pyOlRp8FljroBXgJXQu+8vsRtJv+BypfvjB38u0tWrons5MGSl1LLsilf1uz9oJwh+UjwVBPcpMWWmpJE2t/F1PmxryOJciLyhew12jRLuGEjzH4q0lQAzdJawIjWr2JQ3CF6etlYOGxZr8/BUI5XaQ25fL6JBfWX4MuIwU81rAe0378Rz6pFyKUvLpibEQ3YQPXzpPY5ThBLLYrMdBD7nk+RLs5Hyw0aRPWEF3Gy40r+0qp1U5HrHGoAIzjtHh8F/DIbQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(186003)(54906003)(66476007)(66446008)(71200400001)(66946007)(8676002)(64756008)(76116006)(66556008)(316002)(8936002)(4326008)(2906002)(966005)(6506007)(5660300002)(26005)(86362001)(83380400001)(52536014)(55016002)(6916009)(478600001)(9686003)(33656002)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NotLv2uLz4bvGrX98DBb+xh1FoPoa+IJtvTp9uRyaXqsUwB0S13nk4sTd8hN+k6eJ7D1YxUtdqB8PqzrP98OGi5WkO7XPjY6UNp7lP2xiU0/1T4FToA28nC6AydTFpl+hPvTVZTmzzOSdhLE364fQgcErcMRB9UReUMmqt6wfxv16uTmOb/OYp+Vx7qA92u/bys61qEXqVjtsU1wtIuNQqp7eav14yDAl+DuWWhqgGDoc+NVH1IZ8z+oXqWIUtib5Dqin9RvEdKOo2KsCDybbS+krNJSKeh45xGZPzz6ASF6wfzZHt1Z9e+ByrnsvPbTufR1zgwfTk0qSnmuSeKYD0iphrj6WJw4ocKTDEgkbRdOadtPLTGeFcPkVhu8ltC/3obx2BjD4bVMX6buyZaytLdxfQ1Ms9PFlSSIFLkctRocq2jCf6xFJOOQdRvzABTVNOQ0xpTrZKBJb8QBL+GcCYuIHEI6e8LLvaskYuuq8rCV4TBg0YC0TvplyAWHy53SRbTsqWlV0YS0x3x9bQm+xLR7oazGo3j/AfcLLYJ4jjhoJwQvV6rKsDS8NAGYKHWwB583dBZMeysi3I8AbY1/RXe2YVaI2Jn3bw3vp7BwPCABktNl0MUt1pL8NXqyUGLmwnbbM36rYh/n3cZd2Ecn2g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc44918-ab6d-408a-08c7-08d83974eb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 19:22:39.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJtYHQ5YPEXYxncPOJn6TN6Im8rnUhVJSSsh59gNwBdpniq2N7gDCoU/yjLjVq1IKEHkYebQAY1zm8g7GAgZHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1408
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,


> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Thursday, July 30, 2020 4:25 PM
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
> Hey Azhar,
>=20
> On Thu, Jul 30, 2020 at 11:06:12PM +0000, Shaikh, Azhar wrote:
> > Hi Prashant,
> > >
> > > Since this was the last switch being configured, please maintain the
> > > same order and add this at the end of the function, after the if-else=
 if
> block.
> > >
> >
> > Please correct if my understanding is not correct here:
> > Set the orientation , set the role, then configure the mux. Shouldn't t=
his be
> the order?
>=20
> Is this documented anywhere? Kindly provide the links to that if so. I wa=
sn't
> aware of any ordering requirements (but I may be missing something).

The configuration of the connector should always happen in the order define=
d in the=20
USB Type-C specification. Check ch. 2.3 (USB Type-C Spec R2.0). So that wil=
l basically give you:

1. orientation
2. role(s)
3. the rest.

Also I see in USB Type-C Port Manager driver the above mentioned sequence b=
eing followed
https://elixir.bootlin.com/linux/latest/source/drivers/usb/typec/tcpm/tcpm.=
c#L664


>=20
> Please keep in mind that each of these switches (orientation, data-role,
> mode-switch, or what is referred to here as "mux") can theoretically be
> different switches, controlled independently by distinct drivers and
> hardware.
>=20
> We should not change what ordering is already present unless there is a
> requirement to do so. The existing ordering was orientation switch, "mux"=
 or
> role switch, then the data-role switch, so let us stick to that.
>=20
> Best regards,
>=20
> >
> >
> > > Best regards,
> > >
> > > -Prashant

Regards,
Azhar

Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D0CC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D2620936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JHYRvqeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgDQPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:51:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:44436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDQPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:51:14 -0400
IronPort-SDR: oVU4T1XGTcg0vgwKph79JuCgPiCQAsFzDn2ur2BMgdduAWj0+/gXkLBdwh6miFGCjQoMBTKXCr
 mL2dKwFyo/PQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 08:51:12 -0700
IronPort-SDR: ZB1qINnf4HChrZ7AeBEPumiTQfl9AXZjoCFSgxFZTk4/9+pjxuMJexXz+HEb2aqKt7nAfjetdu
 vDeEIYCZ0aUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="279943163"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2020 08:51:11 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 08:51:11 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 08:51:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 08:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbaXSS3pdjjTkORI0XIaVO/bQo4URkAg/GT1rzSNn9MrP2qEv5CU3Qds+slEWxHsMcGWE+ibmu6AX/+Ie0nCUjThZ4h9x8BcGzhP1w10E33wTK8j6i3MYlRngY6i4irxoVVqnLFQ+3P4eIhTmowEDKbYXJ26VM7fNGkWEQcudav9sHwkJrdDHJQA9yULy71h9bDg3HyxDlaNbNmQWwpu3B7jCATu4oP7BOsT/tU80Ei/5Ksbow7U3u9kVZLtZkiQAeickAd7sn2uggYU7N9V8kYLFmOUyQ5aHS81bHPhMX5WJy5XFUsxh6nyXd/av70mL8/3pcCp6CxO042uTC1UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il0QUjMjgKeajCeyVjWAtpKDQMPmjZgbOtC8vj2af+s=;
 b=RSXTloUqc3F9Za83QaXyTnwuFgZw6cMJaKpYxi7oenntGU1CSfa6HUQclajBxVSRUq7K4jah7t1BNGqYxxCzRS8X5xQvtKTsU/vhdu1L4rEXS2VWy+QsSxKwneCS2HbS1qrDGoUuIiXWvP+riEuYZALDey7dx3AmnzoHO7irkMDkWh6c4+uj7Jlv9QMCC7IuAbX0Qmr4HVd54aNzpMOy+FtmLAF86lLb3gjbq0HX6qbjuBuijAlgXfXyutQQ6fFKgCKM/Us0+ElEdGuauGk1g2rHW9Jfn+zOvTTXKnwbC0csQ3ShLH0Cnrq2gDZ0eF2xAo9h+iNGq24gqCLW0p5rQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il0QUjMjgKeajCeyVjWAtpKDQMPmjZgbOtC8vj2af+s=;
 b=JHYRvqeAwbScLZcwB31TF8BGDw/FZjH1vXI3lrBruKUvuh6uzqCx4ksFPFq9XFHWFjOxAwufJVpZFtTVBn4ujAe9hFdhCJwJG6PUv+jPEO8QSuWX6EQEUA6hKH7Fieu7RkmyX4UAHEERYuTKRSJ1dFYUI8hAaMS1cwJSva9Fwl8=
Received: from MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 15:51:08 +0000
Received: from MW3PR11MB4745.namprd11.prod.outlook.com
 ([fe80::3491:5d17:7ab5:a099]) by MW3PR11MB4745.namprd11.prod.outlook.com
 ([fe80::3491:5d17:7ab5:a099%9]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 15:51:08 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     "madhuparnabhowmik10@gmail.com" <madhuparnabhowmik10@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrianov@ispras.ru" <andrianov@ispras.ru>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: RE: [PATCH] drivers: char: tlclk.c: Avoid data race between init and
 interrupt handler
Thread-Topic: [PATCH] drivers: char: tlclk.c: Avoid data race between init and
 interrupt handler
Thread-Index: AQHWFM3h1p9Jv8e1vE+gEoGsQuceyqh9dRzw
Date:   Fri, 17 Apr 2020 15:51:08 +0000
Message-ID: <MW3PR11MB474563294D1D37DCAA9910798ED90@MW3PR11MB4745.namprd11.prod.outlook.com>
References: <20200417153451.1551-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200417153451.1551-1-madhuparnabhowmik10@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.gross@intel.com; 
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b5f242f-d83f-437a-67b0-08d7e2e72550
x-ms-traffictypediagnostic: MW3PR11MB4652:
x-microsoft-antispam-prvs: <MW3PR11MB4652D9E41BFA9BB0DE1A31278ED90@MW3PR11MB4652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4745.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(33656002)(110136005)(55016002)(8936002)(53546011)(6506007)(316002)(7696005)(54906003)(2906002)(26005)(5660300002)(81156014)(8676002)(478600001)(71200400001)(4326008)(76116006)(186003)(86362001)(66446008)(64756008)(9686003)(66556008)(66476007)(52536014)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3lA7bFc3zokCU7SJeTvVrUz6luIEsa8ILYFettvCmqk6yrZpCdmBi+Z1aBBNYjmn+cBKVqHOG+XCT+pW+3PDaXZ3s7foES1HVzKydahQuk4NGANclB+mv8HdwPn+6gdGsfr3vNaVfnHRqLVJgQs5u+UnejVybwzLLkgQCRxmTtO2JR8uod1ldwTf/IL/E4pRrJ9UAvmfNZZUIZ0lN1bepfv/5GPEd+FAkcxizXQ2WFiKkyJaIrhT+c6O9QYAW/iEm96idLUs6lAtBCpSuMx7InNZxG1lrjlVjORu2YG08NHGGUsQ1gx0lck2tENAh//PUa/nw+QQomEUwVb1qXFaZAN4sAPsrnaMilaGnN3GQ276UabJ/SB9aQMb8g6m5Bz3LOu+sLvicTujLw511jCzasfGsWZU5TR9yumc/Fwj6gPa6lfcdWjMLRoZfk2J9mT
x-ms-exchange-antispam-messagedata: wA0Shwt8zjITubwMxTVvXLAjs/7WFzh7R0cFFKG6o44gE/075OL36ZYiA0852ynGw0GS25xSuNeHl3OWYipVj25Lq4e/kIfUejUu40dIMCXMFZC2MSZ/dvwQ5EVHjq4eJbKWZDfnwC1U6ZFmyDNQSw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5f242f-d83f-437a-67b0-08d7e2e72550
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 15:51:08.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9KKqGFJxO756Qmwou09UJJWgHCooVKVsyGIosqeslP76SC/+7w7TWpiBg/OlqyJLjRIMoRf0r6Mmfzoc1Z1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks reasonable to me.
+1
Ack
--mark

> -----Original Message-----
> From: madhuparnabhowmik10@gmail.com <madhuparnabhowmik10@gmail.com>
> Sent: Friday, April 17, 2020 8:35 AM
> To: Gross, Mark <mark.gross@intel.com>; arnd@arndb.de;
> gregkh@linuxfoundation.org
> Cc: linux-kernel@vger.kernel.org; andrianov@ispras.ru; ldv-
> project@linuxtesting.org; Madhuparna Bhowmik
> <madhuparnabhowmik10@gmail.com>
> Subject: [PATCH] drivers: char: tlclk.c: Avoid data race between init and=
 interrupt
> handler
>=20
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>=20
> After registering character device the file operation callbacks can be ca=
lled. The
> open callback registers interrupt handler.
> Therefore interrupt handler can execute in parallel with rest of the init=
 function. To
> avoid such data race initialize telclk_interrupt variable and struct alar=
m_events
> before registering character device.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/char/tlclk.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c index
> 6d81bb3bb503..896a3550fba9 100644
> --- a/drivers/char/tlclk.c
> +++ b/drivers/char/tlclk.c
> @@ -777,17 +777,21 @@ static int __init tlclk_init(void)  {
>  	int ret;
>=20
> +	telclk_interrupt =3D (inb(TLCLK_REG7) & 0x0f);
> +
> +	alarm_events =3D kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
> +	if (!alarm_events) {
> +		ret =3D -ENOMEM;
> +		goto out1;
> +	}
> +
>  	ret =3D register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
>  	if (ret < 0) {
>  		printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
> +		kfree(alarm_events);
>  		return ret;
>  	}
>  	tlclk_major =3D ret;
> -	alarm_events =3D kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
> -	if (!alarm_events) {
> -		ret =3D -ENOMEM;
> -		goto out1;
> -	}
>=20
>  	/* Read telecom clock IRQ number (Set by BIOS) */
>  	if (!request_region(TLCLK_BASE, 8, "telco_clock")) { @@ -796,7 +800,6
> @@ static int __init tlclk_init(void)
>  		ret =3D -EBUSY;
>  		goto out2;
>  	}
> -	telclk_interrupt =3D (inb(TLCLK_REG7) & 0x0f);
>=20
>  	if (0x0F =3D=3D telclk_interrupt ) { /* not MCPBL0010 ? */
>  		printk(KERN_ERR "telclk_interrupt =3D 0x%x non-mcpbl0010 hw.\n",
> @@ -837,8 +840,8 @@ static int __init tlclk_init(void)
>  	release_region(TLCLK_BASE, 8);
>  out2:
>  	kfree(alarm_events);
> -out1:
>  	unregister_chrdev(tlclk_major, "telco_clock");
> +out1:
>  	return ret;
>  }
>=20
> --
> 2.17.1


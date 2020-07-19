Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EF620738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 05:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgGSFuT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:50:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:25351 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSFuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 01:50:18 -0400
IronPort-SDR: 7pMQrBxKIDL0VwbpHaV8qc+jO2hyEUBY6hWLr6RBfWoaaBK8/t1hhLlX+0RRLDVwYNmsoiAcw7
 C2uAo+SUnS3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="147749961"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="147749961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 22:50:18 -0700
IronPort-SDR: 60F4I4iHhG52aKO7ohI8Kqw2MV0zmayWirJ6044zxDTpwaWRNF+A+6t+IqtLK80HJD1Wjk5aTX
 XZ7JIB9LhYxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="300965104"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2020 22:50:17 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 18 Jul 2020 22:50:17 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX602.ger.corp.intel.com (10.184.107.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jul 2020 08:50:15 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sun, 19 Jul 2020 08:50:15 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: Replace HTTP links with HTTPS ones
Thread-Topic: [PATCH] mei: Replace HTTP links with HTTPS ones
Thread-Index: AQHWXGxqJKkEttbDY0+bLNJvBGUVDqkOZ/sw
Date:   Sun, 19 Jul 2020 05:50:15 +0000
Message-ID: <c6075e9ccd4344a59ed6f79a931a592e@intel.com>
References: <20200717185925.84102-1-grandmaster@al2klimov.de>
In-Reply-To: <20200717185925.84102-1-grandmaster@al2klimov.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM as HTTPS
> traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov
> <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely  or at least not (just)
> HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  drivers/misc/mei/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> 9d7b3719bfa0..f5fd5b786607 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -9,7 +9,7 @@ config INTEL_MEI
>  	  if selected /dev/mei misc device will be created.
> 
>  	  For more information see
> -	  <http://software.intel.com/en-us/manageability/>
> +	  <https://software.intel.com/en-us/manageability/>
> 
>  config INTEL_MEI_ME
>  	tristate "ME Enabled Intel Chipsets"
> --
> 2.27.0


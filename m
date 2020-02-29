Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AA82468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgB2Q2Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:28:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:31496 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgB2Q2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:28:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 08:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,500,1574150400"; 
   d="scan'208";a="437751103"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 29 Feb 2020 08:28:13 -0800
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Feb 2020 08:28:13 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 29 Feb 2020 18:28:11 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sat, 29 Feb 2020 18:28:11 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] mei: Don't encourage to use kernel internal types in
 user code
Thread-Topic: [PATCH v1] mei: Don't encourage to use kernel internal types in
 user code
Thread-Index: AQHV7kmoHRGWq8a92EO3ikJkF4xQsagyWSTQ
Date:   Sat, 29 Feb 2020 16:28:11 +0000
Message-ID: <3bb5abe91919458aa6166eb60d9451ff@intel.com>
References: <20200228151328.45062-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200228151328.45062-1-andriy.shevchenko@linux.intel.com>
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
> uuid_le is internal kernel type which shall not be exposed to the user in the first
> place. 
Why, these types are exported via include/uapi/linux/uuid.h

In order to mitigate the (wrong) distribution of the use of that type,
> switch MEI AMT sample to plain unsigned char array.

There was a change to guid_t from uuild_le, anyhow there is much more code
 except this sample that uses those types. 

Nack so far.
Tomas

> 
> Note, there is no ABI change involved.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  samples/mei/mei-amt-version.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
> index 32234481ad7d..458cb6db57c6 100644
> --- a/samples/mei/mei-amt-version.c
> +++ b/samples/mei/mei-amt-version.c
> @@ -90,7 +90,7 @@
>  } while (0)
> 
>  struct mei {
> -	uuid_le guid;
> +	unsigned char guid[16];
>  	bool initialized;
>  	bool verbose;
>  	unsigned int buf_size;
> @@ -108,7 +108,7 @@ static void mei_deinit(struct mei *cl)
>  	cl->initialized = false;
>  }
> 
> -static bool mei_init(struct mei *me, const uuid_le *guid,
> +static bool mei_init(struct mei *me, const unsigned char *guid,
>  		unsigned char req_protocol_version, bool verbose)  {
>  	int result;
> @@ -126,7 +126,7 @@ static bool mei_init(struct mei *me, const uuid_le
> *guid,
>  	memset(&data, 0, sizeof(data));
>  	me->initialized = true;
> 
> -	memcpy(&data.in_client_uuid, &me->guid, sizeof(me->guid));
> +	memcpy(&data.in_client_uuid, me->guid, sizeof(me->guid));
>  	result = ioctl(me->fd, IOCTL_MEI_CONNECT_CLIENT, &data);
>  	if (result) {
>  		mei_err(me, "IOCTL_MEI_CONNECT_CLIENT receive message.
> err=%d\n", result); @@ -270,8 +270,11 @@ struct amt_host_if_resp_header {
>  	unsigned char data[0];
>  } __attribute__((packed));
> 
> -const uuid_le MEI_IAMTHIF = UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \
> -				0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81,
> 0x4c);
> +/* MEI AMT Interface GUID: 12f80028-b4b7-4b2d-aca8-46e0ff65814c */
> +const unsigned char mei_iamthif[16] = {
> +	0x28, 0x00, 0xf8, 0x12, 0xb7, 0xb4, 0x2d, 0x4b,
> +	0xac, 0xa8, 0x46, 0xe0, 0xff, 0x65, 0x81, 0x4c, };
> 
>  #define AMT_HOST_IF_CODE_VERSIONS_REQUEST  0x0400001A  #define
> AMT_HOST_IF_CODE_VERSIONS_RESPONSE 0x0480001A @@ -295,7 +298,7
> @@ static bool amt_host_if_init(struct amt_host_if *acmd,
>  		      unsigned long send_timeout, bool verbose)  {
>  	acmd->send_timeout = (send_timeout) ? send_timeout : 20000;
> -	acmd->initialized = mei_init(&acmd->mei_cl, &MEI_IAMTHIF, 0,
> verbose);
> +	acmd->initialized = mei_init(&acmd->mei_cl, mei_iamthif, 0, verbose);
>  	return acmd->initialized;
>  }
> 
> --
> 2.25.0


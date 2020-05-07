Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02350C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30DE21582
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGUIp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:08:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:50154 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:08:44 -0400
IronPort-SDR: vHNozOPniD9IXduQ3g977zM8LzOGG69RxENbCHdtLGfdYbfmBb8Zt6bIqEfPI8bQLsLUx8mfxW
 Y6FyNzGsBIhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 13:08:43 -0700
IronPort-SDR: kNBmpPTiIIT3xUKaY76vFUH7TgihcmBZxesy2tUDROkzb6YlRrOZj1162qnp/LLTSQ4pr3gdkf
 ubUjilR2rcwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="370223059"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 13:08:43 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 13:08:43 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 23:08:41 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 7 May 2020 23:08:41 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] treewide: Replace zero-length array with flexible-array
Thread-Topic: [PATCH] treewide: Replace zero-length array with flexible-array
Thread-Index: AQHWJKBOJSsbWiWaH0mmen9kZErTsqidDUCQ
Date:   Thu, 7 May 2020 20:08:40 +0000
Message-ID: <7cf79b41ef1e479196f0a644b55ff67b@intel.com>
References: <20200507185413.GA14583@embeddedor>
In-Reply-To: <20200507185413.GA14583@embeddedor>
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



> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Thursday, May 07, 2020 21:54
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] treewide: Replace zero-length array with flexible-array


Ack. 

> 
> The current codebase makes use of the zero-length array language extension to
> the C90 standard, but the preferred mechanism to declare variable-length types
> such as these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning in case
> the flexible array does not occur last in the structure, which will help us prevent
> some kind of undefined behavior bugs from being inadvertently introduced[3]
> to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator may
> not be applied. As a quirk of the original implementation of zero-length arrays,
> sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in which
> the sizeof operator is being incorrectly/erroneously applied to zero-length
> arrays and the result is zero. Such instances may be hiding some bugs. So, this
> work (flexible-array member conversions) will also help to get completely rid of
> those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  samples/mei/mei-amt-version.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
> index 32234481ad7d..ad3e56042f96 100644
> --- a/samples/mei/mei-amt-version.c
> +++ b/samples/mei/mei-amt-version.c
> @@ -267,7 +267,7 @@ struct amt_host_if_msg_header {  struct
> amt_host_if_resp_header {
>  	struct amt_host_if_msg_header header;
>  	uint32_t status;
> -	unsigned char data[0];
> +	unsigned char data[];
>  } __attribute__((packed));
> 
>  const uuid_le MEI_IAMTHIF = UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \


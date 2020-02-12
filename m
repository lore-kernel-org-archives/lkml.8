Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCDC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgBLWTx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:19:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:28120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgBLWTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:19:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 14:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="237849203"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 14:19:51 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 14:19:51 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Feb 2020 00:19:49 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 13 Feb 2020 00:19:48 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [PATCH] mei: bus: replace zero-length array with flexible-array
 member
Thread-Topic: [PATCH] mei: bus: replace zero-length array with flexible-array
 member
Thread-Index: AQHV4R8PZ6+DToj5cUCD4Y1TT5B8IKgYIqMQ
Date:   Wed, 12 Feb 2020 22:19:48 +0000
Message-ID: <71cd2c9eba7f4ac68de55148edb08e19@intel.com>
References: <20200211210822.GA31368@embeddedor>
In-Reply-To: <20200211210822.GA31368@embeddedor>
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
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Sent: Tuesday, February 11, 2020 23:08
> To: Winkler, Tomas <tomas.winkler@intel.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> Subject: [PATCH] mei: bus: replace zero-length array with flexible-array member
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
> some kind of undefined behavior bugs from being inadvertenly introduced[3] to
> the codebase from now on.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Ack.

> ---
>  drivers/misc/mei/bus-fixup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c index
> 5fcac02233af..aa3648d59a8a 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -107,7 +107,7 @@ struct mkhi_rule_id {  struct mkhi_fwcaps {
>  	struct mkhi_rule_id id;
>  	u8 len;
> -	u8 data[0];
> +	u8 data[];
>  } __packed;
> 
>  struct mkhi_fw_ver_block {
> @@ -135,7 +135,7 @@ struct mkhi_msg_hdr {
> 
>  struct mkhi_msg {
>  	struct mkhi_msg_hdr hdr;
> -	u8 data[0];
> +	u8 data[];
>  } __packed;
> 
>  #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
> --
> 2.25.0


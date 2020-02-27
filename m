Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D94C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89CE24683
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgB0Gvx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:51:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:7030 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgB0Gvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:51:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 22:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="227019761"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2020 22:51:52 -0800
Received: from hasmsx601.ger.corp.intel.com (10.184.107.141) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 22:51:51 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX601.ger.corp.intel.com (10.184.107.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Feb 2020 08:51:48 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Thu, 27 Feb 2020 08:51:48 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dimitri Sivanich" <sivanich@sgi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: Replace zero-length array with flexible-array
 member
Thread-Topic: [PATCH] misc: Replace zero-length array with flexible-array
 member
Thread-Index: AQHV7PLjz6Q4KeJpr0WTk38ynoXq0agumnNw
Date:   Thu, 27 Feb 2020 06:51:48 +0000
Message-ID: <7443c05135b24e75929b4f573b014df1@intel.com>
References: <20200226222240.GA14474@embeddedor>
In-Reply-To: <20200226222240.GA14474@embeddedor>
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
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Ack, though be happier if this is would come in two separate patches.

> ---
>  drivers/misc/mei/hw.h            | 2 +-
>  drivers/misc/mei/mei_dev.h       | 2 +-
>  drivers/misc/sgi-gru/grulib.h    | 2 +-
>  drivers/misc/sgi-gru/grutables.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h index
> 8231b6941adf..b1a8d5ec88b3 100644
> --- a/drivers/misc/mei/hw.h
> +++ b/drivers/misc/mei/hw.h
> @@ -216,7 +216,7 @@ struct mei_msg_hdr {
> 
>  struct mei_bus_message {
>  	u8 hbm_cmd;
> -	u8 data[0];
> +	u8 data[];
>  } __packed;
> 
>  /**
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h index
> 76f8ff5ff974..3a29db07211d 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -533,7 +533,7 @@ struct mei_device {
>  #endif /* CONFIG_DEBUG_FS */
> 
>  	const struct mei_hw_ops *ops;
> -	char hw[0] __aligned(sizeof(void *));
> +	char hw[] __aligned(sizeof(void *));
>  };
> 
>  static inline unsigned long mei_secs_to_jiffies(unsigned long sec) diff --git
> a/drivers/misc/sgi-gru/grulib.h b/drivers/misc/sgi-gru/grulib.h index
> e77d1b1f9d05..85c103923632 100644
> --- a/drivers/misc/sgi-gru/grulib.h
> +++ b/drivers/misc/sgi-gru/grulib.h
> @@ -136,7 +136,7 @@ struct gru_dump_context_header {
>  	pid_t		pid;
>  	unsigned long	vaddr;
>  	int		cch_locked;
> -	unsigned long	data[0];
> +	unsigned long	data[];
>  };
> 
>  /*
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index a7e44b2eb413..5ce8f3081e96 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -372,7 +372,7 @@ struct gru_thread_state {
>  	int			ts_data_valid;	/* Indicates if ts_gdata has
>  						   valid data */
>  	struct gru_gseg_statistics ustats;	/* User statistics */
> -	unsigned long		ts_gdata[0];	/* save area for GRU data (CB,
> +	unsigned long		ts_gdata[];	/* save area for GRU data (CB,
>  						   DS, CBE) */
>  };
> 
> --
> 2.25.0


Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E033C2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgFJRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:16:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:47491 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgFJRQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:22 -0400
IronPort-SDR: qYIXovBhxdeDvjNJbAFhA8Vu6lyMGRr0bKQnIqlTDH8AOqPb0048wvgUMJr3UjbseupH/q55Rx
 eq/7Yh/3CtWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:16:22 -0700
IronPort-SDR: ZY+dNot4VW1cZFIJXURBgJm7H4h4Bm0CkHkwoSYEn5XHzfmw9u0JAU40BmK7K4pdSQqKyNqtOu
 zfcms9JZCDjg==
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="447584797"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:16:21 -0700
Date:   Wed, 10 Jun 2020 10:16:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        rrichter@marvell.com
Subject: Re: [PATCH] EDAC, pnd2: set MCE_PRIO_EDAC priority for pnd2_mce_dec
 notifier
Message-ID: <20200610171620.GA1474@agluck-desk2.amr.corp.intel.com>
References: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:58:45PM +0800, Zhenzhong Duan wrote:
> ...or else it has MCE_PRIO_LOWEST priority by default.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  drivers/edac/pnd2_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
> index bc47328..368fae3 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -1434,6 +1434,7 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
>  
>  static struct notifier_block pnd2_mce_dec = {
>  	.notifier_call	= pnd2_mce_check_error,
> +	.priority	= MCE_PRIO_EDAC,
>  };
>  
>  #ifdef CONFIG_EDAC_DEBUG
> -- 

Looks OK. I'll queue this next week (after Linus releases v5.8-rc1). It should
be merged into v5.9

Thanks

-Tony

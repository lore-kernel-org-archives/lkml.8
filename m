Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F3220874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgGBJoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:44:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:58083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGBJoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:44:11 -0400
IronPort-SDR: JKHDewWt9I/w7af1lOJe2hqWqHioNjYSYeN1uGyFRMxiEia6QotJ5Rla4KTO+NpZKNTif35TYQ
 sU5joYGbfg0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="126463279"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126463279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 02:44:11 -0700
IronPort-SDR: 59cV44xd5Nrp05/QcqfbeZSu4KToURfaJOm3jm7A/YZhtWz9/K0ZIukK+aGuHMJr1O8pcd4ORU
 KWbsSLuWG3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="265656750"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jul 2020 02:44:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jqvlM-00HBG5-Cf; Thu, 02 Jul 2020 12:44:12 +0300
Date:   Thu, 2 Jul 2020 12:44:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uuid: Remove unused uuid_le_to_bin() definition
Message-ID: <20200702094412.GO3703480@smile.fi.intel.com>
References: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:53:55AM +0300, Andy Shevchenko wrote:
> There is no more user, so remove it.

Can we do this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/uuid.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/uuid.h b/include/linux/uuid.h
> index d41b0d3e9474..8cdc0d3567cd 100644
> --- a/include/linux/uuid.h
> +++ b/include/linux/uuid.h
> @@ -98,8 +98,6 @@ int guid_parse(const char *uuid, guid_t *u);
>  int uuid_parse(const char *uuid, uuid_t *u);
>  
>  /* backwards compatibility, don't use in new code */
> -#define uuid_le_to_bin(guid, u)	guid_parse(guid, u)
> -
>  static inline int uuid_le_cmp(const guid_t u1, const guid_t u2)
>  {
>  	return memcmp(&u1, &u2, sizeof(guid_t));
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko



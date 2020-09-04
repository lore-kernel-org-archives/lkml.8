Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938E4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664EA206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgIDJ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:58:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:32680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgIDJ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:58:08 -0400
IronPort-SDR: s9AjXpsgnAahdHcU9OT8VIec9tnMXCaC7d/ewQp/yw3BTrAIpn5+14QCsHnQ2ttQ6wqwNq5/5o
 TCDbB7UpxRNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145420783"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="145420783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 02:58:08 -0700
IronPort-SDR: r6Sy/0EGxh9ETEItlP6ZmNHb2sps6oc5aOXBdXj4S+8h2he9dQI7/q3G2RfJ3ztPKH/E+p3nVL
 W6BZqw19eTeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="332104706"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 04 Sep 2020 02:58:07 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kE8Ts-00EFVq-Uv; Fri, 04 Sep 2020 12:58:04 +0300
Date:   Fri, 4 Sep 2020 12:58:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1] once: Fix trivia typo Not -> Note
Message-ID: <20200904095804.GN1891694@smile.fi.intel.com>
References: <20200731112951.70567-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731112951.70567-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 02:29:51PM +0300, Andy Shevchenko wrote:
> Fix trivia typo Not -> Note in the comment to DO_ONCE().

Any comments?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/once.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/once.h b/include/linux/once.h
> index 9225ee6d96c7..095c6debd63b 100644
> --- a/include/linux/once.h
> +++ b/include/linux/once.h
> @@ -16,7 +16,7 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
>   * out the condition into a nop. DO_ONCE() guarantees type safety of
>   * arguments!
>   *
> - * Not that the following is not equivalent ...
> + * Note that the following is not equivalent ...
>   *
>   *   DO_ONCE(func, arg);
>   *   DO_ONCE(func, arg);
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D64620848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgCDPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:12:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:12633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDPM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:12:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 07:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="258787670"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 04 Mar 2020 07:12:25 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j9VhC-006s8I-RJ; Wed, 04 Mar 2020 17:12:26 +0200
Date:   Wed, 4 Mar 2020 17:12:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] vfsprintf: only hash addresses in security environment
Message-ID: <20200304151226.GE1224808@smile.fi.intel.com>
References: <20200304124707.22650-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304124707.22650-1-yanaijie@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 08:47:07PM +0800, Jason Yan wrote:
> When I am implementing KASLR for powerpc, Scott Wood argued that format
> specifier "%p" always hashes the addresses that people do not have a
> choice to shut it down: https://patchwork.kernel.org/cover/11367547/
> 
> It's true that if in a debug environment or security is not concerned,
> such as KASLR is absent or kptr_restrict = 0,  there is no way to shut
> the hashing down except changing the code and build the kernel again
> to use a different format specifier like "%px". And when we want to
> turn to security environment, the format specifier has to be changed
> back and rebuild the kernel.
> 
> As KASLR is available on most popular platforms and enabled by default,
> print the raw value of address while KASLR is absent and kptr_restrict
> is zero. Those who concerns about security must have KASLR enabled or
> kptr_restrict set properly.

Even w/o KASLR the kernel address is sensitive material.
However, as a developer, I would like to have means to shut the hashing down.

Btw, when pass 'nokaslr' to the kernel it should turned off as well.

> +	/*
> +	 * In security environment, while kaslr is enabled or kptr_restrict is

kaslr -> KASLR

> +	 * not zero, hash before printing so that addresses will not be
> +	 * leaked. And if not in a security environment, print the raw value

Missed period at the end of sentence.

> +	 */
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) || kptr_restrict)
> +		return ptr_to_id(buf, end, ptr, spec);
> +	else
> +		return pointer_string(buf, end, ptr, spec);
>  }

-- 
With Best Regards,
Andy Shevchenko



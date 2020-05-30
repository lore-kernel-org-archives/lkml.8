Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B228BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F7B20B80
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgE3KZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:25:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:11758 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3KZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:25:32 -0400
IronPort-SDR: pkFcV3y/FYgQlIDGVVJcGfs1vp99SFDjoVOS6CCWIyLjqfSgAASyA3AE0UGKiMkNPFI5m+SmFC
 TOk8AQhxLxDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 03:25:32 -0700
IronPort-SDR: wTiNQAItwI7OvYUUKMrrSbzgYuPEwwZQHZXWH5P3ZdlvnDiy3H/FqJDpCfXKXpUBGQCfetmiHP
 9fx6bxnMrbEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,451,1583222400"; 
   d="scan'208";a="267811284"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2020 03:25:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeygF-009nNa-3C; Sat, 30 May 2020 13:25:31 +0300
Date:   Sat, 30 May 2020 13:25:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: make a test module with get_count_order/long
Message-ID: <20200530102531.GA1634618@smile.fi.intel.com>
References: <20200530004328.30530-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530004328.30530-1-richard.weiyang@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 12:43:28AM +0000, Wei Yang wrote:
> A test module to make sure get_count_order/long returns the correct result.

>  lib/Kconfig.debug                  | 13 ++++++
>  lib/Makefile                       |  2 +
>  lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++

I didn't get why it's not a part of test_bitops?

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1AC2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgFHKMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:12:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:57438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgFHKMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:12:14 -0400
IronPort-SDR: 8XXPHiXJ4APnkYu4HYloBud3rEKQcKSRMy/8ZJJCa9fhrIpD6AN2k6mal03HhLkMg2zjjGmDac
 mqKr/2FPWcPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 03:12:13 -0700
IronPort-SDR: MXs4wO83ExVqUxCoPxfVRY2GhEmOL1kIlUgZh/1ItA0uOtVAWiI84uOiFYvXph5vvT71F8gzZx
 1A4HuBQ4AnIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="258657785"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2020 03:12:11 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiElK-00BeLy-Gr; Mon, 08 Jun 2020 13:12:14 +0300
Date:   Mon, 8 Jun 2020 13:12:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] lib: Add test for bitmap_cut()
Message-ID: <20200608101214.GE2428291@smile.fi.intel.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
 <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:13:29AM +0200, Stefano Brivio wrote:
> Based on an original patch by Yury Norov: introduce a test for
> bitmap_cut() that also makes sure functionality is as described for
> partially overlapping src and dst.

> Co-authored-by: Yury Norov <yury.norov@gmail.com>

Co-developed-by (and it requires Yury's SoB as well).

> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

...

> +static struct test_bitmap_cut test_cut[] = {
> +	{  0,  0,  8, { 0x0000000aUL, }, { 0x0000000aUL, }, },
> +	{  0,  0, 32, { 0xdadadeadUL, }, { 0xdadadeadUL, }, },
> +	{  0,  3,  8, { 0x000000aaUL, }, { 0x00000015UL, }, },
> +	{  3,  3,  8, { 0x000000aaUL, }, { 0x00000012UL, }, },
> +	{  0,  1, 32, { 0xa5a5a5a5UL, }, { 0x52d2d2d2UL, }, },
> +	{  0,  8, 32, { 0xdeadc0deUL, }, { 0x00deadc0UL, }, },
> +	{  1,  1, 32, { 0x5a5a5a5aUL, }, { 0x2d2d2d2cUL, }, },
> +	{  0, 15, 32, { 0xa5a5a5a5UL, }, { 0x00014b4bUL, }, },
> +	{  0, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> +	{ 15, 15, 32, { 0xa5a5a5a5UL, }, { 0x000125a5UL, }, },
> +	{ 15, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
> +	{ 16, 15, 32, { 0xa5a5a5a5UL, }, { 0x0001a5a5UL, }, },
> +
> +	{ BITS_PER_LONG, BITS_PER_LONG, BITS_PER_LONG,
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +	},
> +	{ 1, BITS_PER_LONG - 1, BITS_PER_LONG,
> +		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
> +		{ 0x00000001UL, 0x00000001UL, },
> +	},
> +
> +	{ 0, BITS_PER_LONG * 2, BITS_PER_LONG * 2 + 1,
> +		{ 0xa5a5a5a5UL, 0x00000001UL, 0x00000001UL, 0x00000001UL },

Perhaps leave comma as well?

> +		{ 0x00000001UL, },
> +	},
> +	{ 16, BITS_PER_LONG * 2 + 1, BITS_PER_LONG * 2 + 1 + 16,

> +		{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },

Ditto.

> +		{ 0x2d2dffffUL, },
> +	},
> +};
> +
> +static void __init test_bitmap_cut(void)
> +{
> +	unsigned long b[4], *in = &b[1], *out = &b[0];	/* Partial overlap */
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
> +		struct test_bitmap_cut *t = &test_cut[i];
> +
> +		memcpy(in, t->in, sizeof(t->in));
> +
> +		bitmap_cut(out, in, t->first, t->cut, t->nbits);

> +		if (!bitmap_equal(out, t->expected, t->nbits)) {
> +			pr_err("bitmap_cut failed: expected %*pb, got %*pb\n",
> +			       t->nbits, t->expected, t->nbits, out);
> +		}

Perhaps

	if (bitmap_equal(...))
		continue;

	...

?

> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



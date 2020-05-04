Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F79C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF13208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgEDLiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:38:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:51558 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEDLiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:38:05 -0400
IronPort-SDR: IgLLXOzWoIWFsOjGqR73R0oIUCM7VjdG1cbDiB30rchcPUq4i7L+TNb6LQouOIdf3hTFz1X25P
 X6J373eUHcqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 04:38:03 -0700
IronPort-SDR: 24VxZoaB1RBgCPhnwh1hh7Qghdow1u/ojEONOYnJ9i5hNLHjp1xp7lH8fXOkB3JK1NE4oi7wVx
 Z+KVR74ZYi8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="277504262"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2020 04:38:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jVZQC-004big-TU; Mon, 04 May 2020 14:38:04 +0300
Date:   Mon, 4 May 2020 14:38:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] lib/test_bitmap.c: Add for_each_set_clump test
 cases
Message-ID: <20200504113804.GD185537@smile.fi.intel.com>
References: <cover.1588460322.git.syednwaris@gmail.com>
 <3eeb13d101db69be8eca739522bbf303527339bd.1588460322.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eeb13d101db69be8eca739522bbf303527339bd.1588460322.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 04:41:42AM +0530, Syed Nayyar Waris wrote:
> The introduction of the generic for_each_set_clump macro need test
> cases to verify the implementation. This patch adds test cases for
> scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> The cases contain situations where clump is getting split at the word
> boundary and also when zeroes are present in the start and middle of
> bitmap.


> +static const unsigned long bitmap_test_data[] __initconst = {
> +	0x38000201,
> +	0x05ff0f38,
> +	0xeffedcba,
> +	0xbbbbabcd,
> +	0x000000aa,
> +	0x000000aa,
> +	0x00ff0000,
> +	0xaaaaaa00,
> +	0xff000000,
> +	0x00aa0000,
> +	0x00000000,
> +	0x00000000,
> +	0x00000000,
> +	0x0f000000,
> +	0x00000ac0,
> +};
> +
> +static const unsigned long clump_exp1[] __initconst = {
> +	0x01,	/* 1 bit set */
> +	0x02,	/* non-edge 1 bit set */
> +	0x00,	/* zero bits set */
> +	0x38,	/* 3 bits set across 4-bit boundary */
> +	0x38,	/* Repeated clump */
> +	0x0F,	/* 4 bits set */
> +	0xFF,	/* all bits set */
> +	0x05,	/* non-adjacent 2 bits set */
> +};
> +
> +static const unsigned long clump_exp2[] __initconst = {
> +	0xfedcba,	/* 24 bits */
> +	0xabcdef,
> +	0xaabbbb,	/* Clump split between 2 words */
> +	0x000000,	/* zeroes in between */
> +	0x0000aa,
> +	0x000000,
> +	0x0000ff,
> +	0xaaaaaa,
> +	0x000000,
> +	0x0000ff,
> +};
> +
> +static const unsigned long clump_exp3[] __initconst = {
> +	0x00000000,	/* starting with 0s*/
> +	0x00000000,	/* All 0s */
> +	0x00000000,
> +	0x00000000,
> +	0x3f00000f,     /* Non zero set */
> +	0x2aa80003,
> +	0x00000aaa,
> +	0x00003fc0,
> +};
> +
> +static const unsigned long clump_exp4[] __initconst = {
> +	0x00,
> +	0x2b,
> +};
> +

One more struct here, like

struct clump_test_data {
	unsigned long *data; // with offset implied
	unsigned long count;
	unsigned long size;
	unsigned long limit;
	unsigned long *exp;
};

> +static const unsigned long * const clump_data[] __initconst = {
> +	clump_exp1,
> +	clump_exp2,
> +	clump_exp3,
> +	clump_exp4,
> +};
> +
>  static void __init test_for_each_set_clump8(void)
>  {
>  #define CLUMP_EXP_NUMBITS 64
> @@ -610,6 +708,48 @@ static void __init test_for_each_set_clump8(void)
>  		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
>  }
>  
> +static void __init execute_for_each_set_clump_test(unsigned long *bits,
> +				unsigned long size,
> +				unsigned long clump_size,
> +				const unsigned long *clump_exp)
> +{
> +	unsigned long start, clump;
> +
> +	for_each_set_clump(start, clump, bits, size, clump_size)
> +		expect_eq_clump(start, size, clump_exp, &clump, clump_size);
> +}
> +

> +static void __init prepare_test_data(unsigned long * bits,
> +				const unsigned long * test_data,
> +				int start, int count)

... prepare_test_data(struct clump_test_data *data)
{
	...
}

> +{
> +	int i;
> +	unsigned long position = 0;
> +
> +	for(i = 0; i < count; i++)
> +	{
> +		bitmap_set_value(bits, test_data[start++], position, 32);
> +		position += 32;
> +	}
> +}
> +
> +static void __init test_for_each_set_clump(void)
> +{
> +	int i;
> +	int count[] = {2, 8, 4, 1};
> +	int offset[] = {0, 2, 10, 14};
> +	unsigned long limit[] = {64, 240, 240, 18};
> +	unsigned long clump_size[] = {8, 24, 30, 6};
> +	DECLARE_BITMAP(bits, 256);
> +
> +	for(i = 0; i < 4; i++)
> +	{
> +		prepare_test_data(bits, bitmap_test_data, offset[i], count[i]);
> +		execute_for_each_set_clump_test(bits, limit[i],
> +					clump_size[i], clump_data[i]);
> +	}

As I told you it should be as simple as

	unsigned int i;

	for (i < ARRAY_SIZE(clump_test_data)) {
		prepare()
		execute()
	}

> +}


-- 
With Best Regards,
Andy Shevchenko



Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18CE206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQvztgNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgFCN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:29:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FEC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:29:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so2146451ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MrO7sCuvFyHZzOxK1ts6WQ6CYsJDG8B8zQZ1TEMOj6M=;
        b=LQvztgNbZi/5Bd+RPl4q+1MBA5O5ivjuMN3AA+e98ZZwdY+YxjnIemhInYS8JfJ67s
         15ZOjJdypvDQ+97RShyx+Upl6t84hq8kQKiWN4lSK+JY+fmSDWPheOgC5mp8kNbWwcZl
         efQt23wChX7w+eBtWhQjBM6QIDHTae2IBV4kDMKt9fB7l9EvVoU9LFRYwEbNdP6xd31F
         BkC1zLx3TFoniCaI1t/aYO2x0QMad/TyqHGB2Jqj+quDU1sOHbqkSPhqrBXe2KJfABPA
         fgDosPAWfAaq7MPY7Tul9LW0NSjoqLcfOetKc/PbGLZIpJEfShMgn1SpyN0lbuwHo4ku
         F8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MrO7sCuvFyHZzOxK1ts6WQ6CYsJDG8B8zQZ1TEMOj6M=;
        b=IeWSKK9xzfBgUiMsdM4XTkNOd5FLhwk/yKD1BLYqCI4dbNJ5mmE5RBMzXq1TLTNDHH
         V7S2diSNkZOD6MT/8on0ynNNNJIDhIPxWRQyVfvf1za4H1Q+tsQQyq95LwbIP9awCl3t
         M6JW5ZAG38t0+fG0tB9bqWHkhFMFgvF5hrYduGmSbMzThrlXn8rsIfWwztGDsHJmMlP1
         ydBFXDcZf3uvunUG67A8PvMCuaHhkASTbV+J5+QhCuYiyuGRjQttKFQzCC6IyesDR35D
         hFffIhaSkDNi78wGAAb+jqar6+SiBtIEUZmMDOawoab7nFG+woAxJRYUkI8IIYWwS8g1
         XAqA==
X-Gm-Message-State: AOAM531k2qjxHl4XZx3b7cJe9f/722h8Pw7gNyT8Eb98bXaoXrJurM03
        p57NAAvQTycIhnjHuoXrxpM=
X-Google-Smtp-Source: ABdhPJyvrKGRV2eo73/RDPtXeQYvDyRf6qEZTtmDhGtObNnEc7vxMlnZ8avjd8WqWniH3H8BFcH7VA==
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr12427740ejb.91.1591190984750;
        Wed, 03 Jun 2020 06:29:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j11sm1116444ejf.53.2020.06.03.06.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 06:29:43 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:29:43 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200603132943.7e2wz6cyzyejtgrm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <20200603091802.GN2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603091802.GN2428291@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:18:02PM +0300, Andy Shevchenko wrote:
>On Tue, Jun 02, 2020 at 10:37:28PM +0000, Wei Yang wrote:
>> Add some test for get_count_order/long in test_bitops.c.
>
>Thanks! LGTM,
>Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>Note, we can have as many MODULE_AUTHOR() lines as we want.
>

Ah, got it.

>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v2: merge the test into test_bitops.c
>> ---
>>  lib/Kconfig.debug | 10 +++++-----
>>  lib/test_bitops.c | 40 ++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 43 insertions(+), 7 deletions(-)
>> 
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index f80d5609798f..512111a72e34 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1987,15 +1987,15 @@ config TEST_LKM
>>  	  If unsure, say N.
>>  
>>  config TEST_BITOPS
>> -	tristate "Test module for compilation of clear_bit/set_bit operations"
>> +	tristate "Test module for compilation of bitops operations"
>>  	depends on m
>>  	help
>>  	  This builds the "test_bitops" module that is much like the
>>  	  TEST_LKM module except that it does a basic exercise of the
>> -	  clear_bit and set_bit macros to make sure there are no compiler
>> -	  warnings from C=1 sparse checker or -Wextra compilations. It has
>> -	  no dependencies and doesn't run or load unless explicitly requested
>> -	  by name.  for example: modprobe test_bitops.
>> +	  set/clear_bit macros and get_count_order/long to make sure there are
>> +	  no compiler warnings from C=1 sparse checker or -Wextra
>> +	  compilations. It has no dependencies and doesn't run or load unless
>> +	  explicitly requested by name.  for example: modprobe test_bitops.
>>  
>>  	  If unsure, say N.
>>  
>> diff --git a/lib/test_bitops.c b/lib/test_bitops.c
>> index fd50b3ae4a14..702d5973a5b6 100644
>> --- a/lib/test_bitops.c
>> +++ b/lib/test_bitops.c
>> @@ -9,7 +9,11 @@
>>  #include <linux/module.h>
>>  #include <linux/printk.h>
>>  
>> -/* a tiny module only meant to test set/clear_bit */
>> +/* a tiny module only meant to test
>> + *
>> + *   set/clear_bit
>> + *   get_count_order/long
>> + */
>>  
>>  /* use an enum because thats the most common BITMAP usage */
>>  enum bitops_fun {
>> @@ -24,6 +28,26 @@ enum bitops_fun {
>>  
>>  static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
>>  
>> +unsigned int order_comb[][2] = {
>> +	{0x00000003,  2},
>> +	{0x00000004,  2},
>> +	{0x00001fff, 13},
>> +	{0x00002000, 13},
>> +	{0x50000000, 31},
>> +	{0x80000000, 31},
>> +	{0x80003000, 32},
>> +};
>> +
>> +unsigned long order_comb_long[][2] = {
>> +	{0x0000000300000000, 34},
>> +	{0x0000000400000000, 34},
>> +	{0x00001fff00000000, 45},
>> +	{0x0000200000000000, 45},
>> +	{0x5000000000000000, 63},
>> +	{0x8000000000000000, 63},
>> +	{0x8000300000000000, 64},
>> +};
>> +
>>  static int __init test_bitops_startup(void)
>>  {
>>  	pr_warn("Loaded test module\n");
>> @@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
>>  	set_bit(BITOPS_11, g_bitmap);
>>  	set_bit(BITOPS_31, g_bitmap);
>>  	set_bit(BITOPS_88, g_bitmap);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
>> +		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
>> +			pr_warn("get_count_order wrong for %x\n",
>> +				       order_comb[i][0]); }
>> +
>> +	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
>> +		if (order_comb_long[i][1] !=
>> +			       get_count_order_long(order_comb_long[i][0]))
>> +			pr_warn("get_count_order_long wrong for %lx\n",
>> +				       order_comb_long[i][0]); }
>> +
>>  	return 0;
>>  }
>>  
>> @@ -55,6 +91,6 @@ static void __exit test_bitops_unstartup(void)
>>  module_init(test_bitops_startup);
>>  module_exit(test_bitops_unstartup);
>>  
>> -MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
>> +MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>, Wei Yang <richard.weiyang@gmail.com>");
>>  MODULE_LICENSE("GPL");
>>  MODULE_DESCRIPTION("Bit testing module");
>> -- 
>> 2.23.0
>> 
>
>-- 
>With Best Regards,
>Andy Shevchenko
>

-- 
Wei Yang
Help you, Help me

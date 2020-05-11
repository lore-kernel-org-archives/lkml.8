Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE3C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232902082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgEKBgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:36:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:3855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgEKBgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:36:22 -0400
IronPort-SDR: UzlKFjr7B0avonjXh/HaKZ2mwf4B8y7rW/slzZwmHYS9hq++l3Lc37XjCuQCFII7hg+41sc66b
 WDz4ytRf2GxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 18:36:21 -0700
IronPort-SDR: hJ0RYXuNfJOqMfsJen2/OqlQJteg6//q7UrCk7QgeIqux0q3WuWLlkUJIygQegbRS6tQJiViHu
 XlV9mXHcldPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; 
   d="scan'208";a="436492239"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2020 18:36:20 -0700
Subject: Re: [pipe] f2af7d90e2: xfstests.btrfs.052.fail
To:     Matthew Wilcox <willy@infradead.org>
Cc:     0day robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200511010957.GW5770@shao2-debian>
 <20200511011601.GV16070@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <01134103-4ca4-958a-f627-a17097315429@intel.com>
Date:   Mon, 11 May 2020 09:36:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200511011601.GV16070@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/20 9:16 AM, Matthew Wilcox wrote:
> On Mon, May 11, 2020 at 09:09:57AM +0800, kernel test robot wrote:
>>      --- tests/btrfs/095.out	2020-04-09 10:45:28.000000000 +0800
>>      +++ /lkp/benchmarks/xfstests/results//btrfs/095.out.bad	2020-05-06 21:13:51.276485703 +0800
>>      @@ -1,35 +1,9 @@
>>       QA output created by 095
>>      -Blocks modified: [135 - 164]
>>      -Blocks modified: [768 - 792]
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
>>      +awk: line 19: function strtonum never defined
> This looks like a problem with the test setup.
>

Hi Matthew,

Thanks for the response, we'll double check it.

Best Regards,
Rong Chen

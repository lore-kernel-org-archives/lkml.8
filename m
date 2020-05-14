Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04185C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE816206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgENFMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:12:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:8386 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENFMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:12:39 -0400
IronPort-SDR: x4eLm4s8EycAxukLIjVESMrAwWJmQLlTxEeqyNTFSRTzY0WgV+I0Ms98nB60sr51WL9CWWzGbL
 t2FUxm3Tjn2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 22:12:39 -0700
IronPort-SDR: +AqZpAh+ZgEX+8D7aMBDV9LzVC160bZ2wR+gC48uAOo39K9V47xOvvJiJGvpLpE7ZvgtmTXWYl
 sfm9U3fu2gtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="437771590"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2020 22:12:36 -0700
Subject: Re: [Jfs-discussion] [fs] 05c5a0273b: netperf.Throughput_total_tps
 -71.8% regression
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lkp@lists.01.org, Markus.Elfring@web.de
References: <20200512030929.GA5770@shao2-debian>
 <alpine.DEB.2.22.395.2005132123020.14542@trent.utfs.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <5d4fbe21-7959-d53f-76c5-ed0299d8db23@intel.com>
Date:   Thu, 14 May 2020 13:12:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.395.2005132123020.14542@trent.utfs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/20 12:27 PM, Christian Kujau wrote:
> On Tue, 12 May 2020, kernel test robot wrote:
>> FYI, we noticed a -71.8% regression of netperf.Throughput_total_tps due to commit:
> As noted in this report, netperf is used to "measure various aspect of
> networking performance". Are we sure the bisect is correct? JFS is a
> filesystem and is not touching net/ in any way. So, having not attempted
> to reproduce this, maybe the JFS commit is a red herring?
>
> C.

Hi,

The commit also causes -74.6% regression of will-it-scale.per_thread_ops:

in testcase: will-it-scale
on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
with following parameters:

	nr_task: 100%
	mode: thread
	test: unlink2
	cpufreq_governor: performance
	ucode: 0x21

I'll send another report for this regression.

Best Regards,
Rong Chen


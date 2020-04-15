Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FDFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0B9206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405052AbgDOIyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:54:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:38552 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404961AbgDOIyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:54:13 -0400
IronPort-SDR: GL79KdS521HMHMDF8/5jRhP7hlzwzGiE9oswYgHt//nu7gFaR8WLn2VknX9FFcmq/1559rMiwN
 J2bBNb8CLisQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:54:11 -0700
IronPort-SDR: O7cjpUfFjgMpL7zI0bfxzytfapVd/xUtrDDlSDbMRWYfsMOTsPZkKP5VmCR4FSsG8ZzbzYqdaY
 ZjVyver8c2pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="453855992"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 01:54:09 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: linux-next: not-present page at swap_vma_readahead()
References: <874ktl1p7y.fsf@yhuang-dev.intel.com>
        <A6843BF5-6B4C-4A75-B68B-133E8FC77955@lca.pw>
Date:   Wed, 15 Apr 2020 16:54:08 +0800
In-Reply-To: <A6843BF5-6B4C-4A75-B68B-133E8FC77955@lca.pw> (Qian Cai's message
        of "Tue, 14 Apr 2020 22:12:55 -0400")
Message-ID: <875ze1yvrj.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

>> On Apr 14, 2020, at 10:01 PM, Huang, Ying <ying.huang@intel.com> wrote:
>> 
>> Is it possible to bisect this?
>
> Yes, I’ll need to find a quick reproducer first by analyzing the fuzzer’s last logs.

Can you share the reproducer to me when it's available?  Or the command
line you used to reproduce it now?

>> 
>> Because the crash point is identified, it may be helpful to collect and
>> analyze the status of the faulting page table and readahead ptes.  But I
>> am not familiar with the ARM64 architecture.  So I cannot help much
>> here.
>
> It happens for x86 as well where the trace is in the first email of this thread.

Got it!  Thanks!

Best Regards,
Huang, Ying

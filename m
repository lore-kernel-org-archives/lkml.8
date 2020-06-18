Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA7AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6572720720
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgFRWf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:35:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:3851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFRWf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:35:57 -0400
IronPort-SDR: gaVE7B71bqR7IuBD5Ms5tlKGqQGRPhpfvMPRuDSKYOi5+rIaTpjPQlHc86bbRJlLmc6g6NBVme
 ch7iHLasTk/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="122994596"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="122994596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 15:35:54 -0700
IronPort-SDR: tBl+yN1PD9XcwxdAGbq0xniZ49uCwAQ4ukB+smLqBDRoLXRsopap3LyS3IYK2v0YTFPormJYSz
 am0AUMiVKbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="383661822"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2020 15:35:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6070F301B21; Thu, 18 Jun 2020 15:35:55 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:35:55 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: Re: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Message-ID: <20200618223555.GB793265@tassilo.jf.intel.com>
References: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We noticed that this only happens with precise_ip >= 2. This is caused by 
> setup_pebs_fixed_sample_data() using pens->real_ip:
> 
> 	set_linear_ip(regs, pebs->real_ip);

With precise_ip == 1 the IP will be one instruction behind.
That's the only difference to 2 or 3.

So something about the actual instruction confuses the unwinder.

I would check if there is anything special about these IPs:

> 0xfffffe00004d1f78 entry_SYSCALL_64
> 0xfffffe00004d1fa0 entry_SYSCALL_64
> 0xfffffe00004d1fd8 entry_SYSCALL_64

> 
> For our use case, we do need precise_ip=2. So we would like suggestions to fix the
> warning and/or to avoid double fault. 

As a minimum, I would just add an && !in_nmi() to the warning. Clearly
it doesn't make sense to print a warning that overflows the stack.

-Andi


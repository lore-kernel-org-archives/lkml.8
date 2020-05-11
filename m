Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36697C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13913206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgEKAsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:48:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:11367 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKAsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:48:43 -0400
IronPort-SDR: X4vsdFenIFJgSKlt2CACB5s9w5A0uWJ3gxXWH4lZukLw1j8Tgm2hJ+UgMsqrDuKIx8Z6He6+uW
 ajI7T7G+Exiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 17:48:43 -0700
IronPort-SDR: 0rT8LofpJeZwr5rA4yJ6dR9cocpWl46vX4m/HcvmOB8psEsKXn7FLzgB5a+u1WPBBB09o3VIYt
 iriK1U1OLNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="296746824"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2020 17:48:42 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A7A1D301C52; Sun, 10 May 2020 17:48:42 -0700 (PDT)
Date:   Sun, 10 May 2020 17:48:42 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org, tony.luck@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
Message-ID: <20200511004842.GJ3538@tassilo.jf.intel.com>
References: <20200423232207.5797-1-sashal@kernel.org>
 <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
 <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> [ 6402.786418] ------------[ cut here ]------------
> [ 6402.787769] WARNING: CPU: 0 PID: 13802 at arch/x86/kernel/traps.c:811
> do_debug+0x16c/0x210
...

> [ 6402.848299]  ? trace_hardirqs_off_thunk+0x1a/0x33
> [ 6402.849593]  trace_hardirqs_off_caller+0xa6/0xd0
> [ 6402.850862]  ? debug+0x4e/0x70
> [ 6402.851727]  trace_hardirqs_off_thunk+0x1a/0x33
> [ 6402.852983]  debug+0x53/0x70
> [ 6402.853785] RIP: 0033:0x400060dd

So this is a check that checks if you're running in user mode if
you have a debug trap with single step, but somehow it triggered
for a user segment.

Probably the regs got corrupted. 

Sasha, I suspect you're missing a mov %rsp,%rdi somewhere in the
debug entry path that sets up the regs argument for the C code.

-Andi

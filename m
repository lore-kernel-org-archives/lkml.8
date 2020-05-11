Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C9C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C91206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEKAu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:50:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:49691 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKAu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:50:28 -0400
IronPort-SDR: Y2L6yXiv3EE+O9ZJQv8YQ+9IqpsyuvNnSMoDl1S+AyDXlffwn9koFaIuNHx6n0mmLqT8IYEUG+
 7LvpLpbIbaaA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 17:50:28 -0700
IronPort-SDR: jBNw3LvyTYq9CTX3yjVAc8sa/ZR6hJ4vMGpoNTS80+685W83DLQYRP9A4zrnt4/ahijke6PhDn
 VMSo7FveWRgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="463204297"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 10 May 2020 17:50:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 72A19301C52; Sun, 10 May 2020 17:50:28 -0700 (PDT)
Date:   Sun, 10 May 2020 17:50:28 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org, tony.luck@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
Message-ID: <20200511005028.GA226400@tassilo.jf.intel.com>
References: <20200423232207.5797-1-sashal@kernel.org>
 <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
 <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
 <20200511004842.GJ3538@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511004842.GJ3538@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So this is a check that checks if you're running in user mode if
> you have a debug trap with single step, but somehow it triggered
> for a user segment.
> 
> Probably the regs got corrupted. 
> 
> Sasha, I suspect you're missing a mov %rsp,%rdi somewhere in the
> debug entry path that sets up the regs argument for the C code.

... Ah never mind. Thomas has a better explanation.

-Andi

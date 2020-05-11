Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D07C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6492B206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgEKAxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:53:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:23446 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKAxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:53:21 -0400
IronPort-SDR: Dj545cRnwzBSmwdITV302YH53sLE9FM/JidYnU3p7v8/jzlT6G6xOjLo23/YAy6Xd390xh6TD2
 cjrgtvhe5gEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 17:53:20 -0700
IronPort-SDR: se7MRSAVgNLL7hgEf7NM19nsmWKHtosJ8Mz7fpmHQYheZCJwydqCvehiSoJb1IzvwtJLBhtaG+
 C3mdTM3Q/KPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="371058384"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2020 17:53:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8DBE4301C52; Sun, 10 May 2020 17:53:19 -0700 (PDT)
Date:   Sun, 10 May 2020 17:53:19 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 00/18] Enable FSGSBASE instructions
Message-ID: <20200511005319.GK3538@tassilo.jf.intel.com>
References: <20200509173655.13977-1-sashal@kernel.org>
 <c4f62190-260a-c6e3-f1f6-6498660a7d1f@intel.com>
 <20200510141625.GL13035@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510141625.GL13035@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My interest in this is that we have a few workloads that value the
> ability to access FS/GS base directly and show nice performance

Can you please share some rough numbers, Sasha?

I would expect everything that does a lot of context switches
to benefit automatically, apart from the new free register (which
requires enabling, but also has great potential)

Also of course NMIs will be faster, so perf will have somewhat
lower overhead when profiling.

-Andi

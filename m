Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8EC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16EF206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvYz6Vfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgH2PlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH2PlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:41:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D79C061236;
        Sat, 29 Aug 2020 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=93vPl4ISVwqsT/rzN0zFT8sEJycYYCjRF7JumF/z/7A=; b=NvYz6VfwpyD+r3/mz8kVTJNDWh
        oDcq20Px1L3OdYCXwdOTRowfxBe6Jgun2w/lOWw5H+CXzIMgFULh5o3BJdzMLMuhND59XX8x38tpW
        hCRZK+G1byqOABRJiqOMG2g56vu60fb7ObDIYg9bL5fTf7Tja9a5Ej9PoCff5agINSDREwe0pXMa3
        qQXc3ggYYnkjpFiHLKbUDkzDSS4LlshQ/AiA1tLITGOQ5ollyJbVMP6RNOG+vNotSQuG4BADxICEW
        4nLPsmTgilYClQbOoYaM/RjadHGFCCZZm6R79XhRmLmBHek5NbY1qpFuVFgv40DFOPLx8mxlb7Tc2
        BW1f9NVw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC2yQ-0002UI-Bu; Sat, 29 Aug 2020 15:40:58 +0000
Subject: Re: [ALTERNATE PATCH] memblock: fix min_low_pfn/max_low_pfn build
 errors
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
References: <20200829000139.2513-1-rdunlap@infradead.org>
 <20200829130429.GG167163@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0665bb7-3389-1178-0a79-2155fb88255d@infradead.org>
Date:   Sat, 29 Aug 2020 08:40:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829130429.GG167163@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/20 6:04 AM, Mike Rapoport wrote:
> On Fri, Aug 28, 2020 at 05:01:39PM -0700, Randy Dunlap wrote:
>> Export min_low_pfn & max_low_pfn in mm/memblock.c to fix build errors
>> on arch/microblaze/ and arch/ia64/: (e.g.)
> 
> Please don't. This would give driver developers a wrong impression that
> these variables can be used to query memory boundaries, but this is not
> the case, at least not on all architectures.
> 
> I would prefer fixing it up locally for microblaze and ia64.

I did that.
and that's why this is labeled as an ALTERNATE PATCH.


thanks.
-- 
~Randy


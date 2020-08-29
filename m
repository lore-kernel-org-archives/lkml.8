Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD53C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2691020757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VO9wJkzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgH2SVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:21:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6943C061236;
        Sat, 29 Aug 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sCTJwDpBVDy6vjt2oWMbe6yTHHpQzxZ85oQiCoGJzoA=; b=VO9wJkzwCNQAMyevUmb+NEanue
        wbH0HtrVz2gNbR4EPCwZrbwFycUhc500fSnPZuo2bEYiZpPliOiHI8oX80whGHCfpz4AqQrYm+MVL
        M2yiYMkDo52WLZ5vfoSD9tuKMI7Zn/Y9kg/s3yOmTNJsaCQ5evyKm13s41mF+8kch+7zDWR7OFdbR
        Akr/qhhqz6xaqv5hdNB8Hhy0yzxxZ4IqNA7DeQ1D/Zz5FIUlCXcxiNb112i0+juYYu3rDX7XgA738
        IewIGtLe4+nqbwhSMwzEfWF6Bqapvqq/6GMLxbfQMlo1aPr2R9Eb0vm1ATuZHG4fYMTlX3KHT01kv
        TJsu5jGg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC5Tc-0007bI-Hl; Sat, 29 Aug 2020 18:21:20 +0000
Subject: Re: [PATCH 1/3] ia64: do not typedef struct pal_min_state_area_s
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Cc:     linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20200829051524.706585-1-masahiroy@kernel.org>
 <20200829051524.706585-2-masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4cd59328-03b2-8da1-31fd-750c18a3f2bf@infradead.org>
Date:   Sat, 29 Aug 2020 11:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829051524.706585-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 10:15 PM, Masahiro Yamada wrote:
> Documentation/process/coding-style.rst says:
> 
>   Please don't use things like ``vps_t``.
>   It's a **mistake** to use typedef for structures and pointers.
> 
> This commit converts as follows:
> 
>   struct pal_min_state_area_s  ->  struct pal_min_state_area
>          pal_min_state_area_t  ->  struct pal_min_state_area
> 
> My main motivation for this is to slim down the include directives
> of <asm/mca.h> in the next commit.
> 
> Currently, <asm/mca.h> is required to include <asm/pal.h> directly
> or indirectly due to (pal_min_state_area_t *). Otherwise, it would
> have no idea what pal_min_state_area_t is.
> 
> Replacing it with (struct pal_min_state_area *) will relax the header
> dependency since it is enough to tell it is a pointer to a structure,
> and to resolve the size of struct pal_min_state_area. It will make
> <asm/mca.h> independent of <asm/pal.h>.
> 
> <asm/pal.h> typedef's a lot of structures, but it is trivial to
> convert the others in the same way.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> 
>  arch/ia64/include/asm/mca.h    |  2 +-
>  arch/ia64/include/asm/pal.h    |  4 ++--
>  arch/ia64/include/asm/sal.h    |  2 +-
>  arch/ia64/kernel/asm-offsets.c | 18 +++++++++---------
>  arch/ia64/kernel/mca.c         |  4 ++--
>  arch/ia64/kernel/mca_drv.c     |  2 +-
>  6 files changed, 16 insertions(+), 16 deletions(-)
> 


thanks.
-- 
~Randy

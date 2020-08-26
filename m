Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF67C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A0520738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rA8b32iO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgHZNBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbgHZNBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:01:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CCC061756;
        Wed, 26 Aug 2020 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5u1D5S4hoVeCokFlRoXkBVpzv2N9WFWKvXd4EhVfhi4=; b=rA8b32iOdfxrZ/AbJyc/6/cBOA
        B8Bddh4hnWGDFx6m7P99J4EWdzI8+2+wK8G50+THis5kC2M+0Stkb4r1EjeJ607sDckOUdik4yjU7
        eKZBNyp63OMiX8VnVEMcqEaz55bOC+VJ8ieLJWvRjE8tfRRWRyCpdPgZRpS6JPwghd3+r2jq1uZ0c
        +uXrVPtP2mW2B9BLt7s89IXAtiMLNDmK/WpCEp9nq/nMzGjKy40vxKaueDMxl6TOddgBK4V26eAtO
        kXkFJQ2+r5f6I3eihxFu2j9uVWDsNZ4bvVH4OVliy0f5Dpk/D8EwqHfp9GmzVF6+4mNULTJrhZJnt
        20rPuOUw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAv3K-0002lN-QU; Wed, 26 Aug 2020 13:01:22 +0000
Date:   Wed, 26 Aug 2020 14:01:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] MIPS: Loongson: Fix complie errors without CONFIG_SMP
Message-ID: <20200826130122.GR17456@casper.infradead.org>
References: <1598446407-8845-1-git-send-email-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598446407-8845-1-git-send-email-hejinyang@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 08:53:27PM +0800, Jinyang He wrote:
> +++ b/arch/mips/include/asm/mach-loongson64/topology.h
> @@ -4,7 +4,11 @@
>  
>  #ifdef CONFIG_NUMA
>  
> +#ifdef CONFIG_SMP
>  #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
> +#else
> +#define cpu_to_node(cpu)	0
> +#endif

Are you saying you've enabled NUMA without enabling SMP?  Does that make
sense?


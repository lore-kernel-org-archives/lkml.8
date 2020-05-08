Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40936C54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218F5218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rc2NnMQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEHSFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:05:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=nyAA7ZTVc4aZn+bjOblYi38TtJYlXgpSZoJBwcqY22Y=; b=rc2NnMQ8j2utR98+DOQ0CUlBYi
        mFVzAYNOeRfPkoSRsFPHE5n1BbmfbIPvhIxw55GPk+AoHS3DgsmFAbJH6/mf9hh/85wbckCWtSVRK
        hVcv+ct0Dc7wpekLPm05Rjm6/PNrGJCvawZ0j91uAgS4JqfwfsGSDLC0bjoK87EZCkSwV4qymg1DW
        Y7Jw0vpKOaRM0ULwyJPgiXAmWp7kbdhMfR9ZKOvGm+sFPpxehJNCuXPgFuSzBTlrzEKRbkDCnM4RG
        r0M39mKYZvD93SUoB39oDdd2y3iFzl/ZC90/Zc7tmw6H4hn5ex+DpIZ6AUgpMox+iCPXJK1EoXuGh
        yAvOJspg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX7NL-00019L-Ee; Fri, 08 May 2020 18:05:31 +0000
Subject: Re: [PATCH 1/2] HMM: test: fix CONFIG_DEVICE_PRIVATE dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200508144017.3501418-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3f55d763-9017-16e5-5765-75634c0c0c0c@infradead.org>
Date:   Fri, 8 May 2020 11:05:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508144017.3501418-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 7:40 AM, Arnd Bergmann wrote:
> One cannot select DEVICE_PRIVATE when its dependencies are disabled:
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ZONE_DEVICE [=n]
>   Selected by [m]:
>   - TEST_HMM [=m] && RUNTIME_TESTING_MENU [=y] && TRANSPARENT_HUGEPAGE [=y]
> lib/test_hmm.c:480:8: error: implicit declaration of function 'memremap_pages' [-Werror,-Wimplicit-function-declaration]
>         ptr = memremap_pages(&devmem->pagemap, numa_node_id());
>               ^
> lib/test_hmm.c:480:8: note: did you mean 'memcmp_pages'?
> include/linux/mm.h:3082:12: note: 'memcmp_pages' declared here
> extern int memcmp_pages(struct page *page1, struct page *page2);
>            ^
> lib/test_hmm.c:480:6: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Werror,-Wint-conversion]
>         ptr = memremap_pages(&devmem->pagemap, numa_node_id());
>             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_hmm.c:1089:4: error: implicit declaration of function 'memunmap_pages' [-Werror,-Wimplicit-function-declaration]
>                         memunmap_pages(&devmem->pagemap);
> 
> Add a dependency from CONFIG_TEST_HMM to ZONE_DEVICE, to disallow
> those broken configurations.
> 
> Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d9885fa37cc0..63667d62c9d8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2262,6 +2262,7 @@ config TEST_MEMINIT
>  config TEST_HMM
>  	tristate "Test HMM (Heterogeneous Memory Management)"
>  	depends on TRANSPARENT_HUGEPAGE
> +	depends on ZONE_DEVICE
>  	select DEVICE_PRIVATE
>  	select HMM_MIRROR
>  	select MMU_NOTIFIER
> 


-- 
~Randy

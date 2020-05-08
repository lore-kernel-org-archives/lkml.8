Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62059C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C94620736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FAx0BodV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEHRAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:00:21 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17063 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:00:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb58fa00001>; Fri, 08 May 2020 09:58:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 10:00:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 10:00:20 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 17:00:19 +0000
Subject: Re: [PATCH 1/2] HMM: test: fix CONFIG_DEVICE_PRIVATE dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200508144017.3501418-1-arnd@arndb.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <913026fd-1911-55dd-823c-b11bce9b2f37@nvidia.com>
Date:   Fri, 8 May 2020 10:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200508144017.3501418-1-arnd@arndb.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588957088; bh=dcJpg0FysVgftiU92EXiTO7WOwsgKp6NBzKm+wuQsF4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FAx0BodVHFLUY+FSvDHpvTF4RYQhnYTdR1kdjbOeITRX+ugaZJXndi2IKn+d/Jysk
         IUJ4c+PiZhlshoubc2WXNM5socv5jYvZAy3um0JPMB7RU1f5/6jqx37a+Q2akmfpRQ
         /PLMXwHWoSKwYNzyuY9MFtJuRAE483kdpl71w72gKeoyoFbUAcwgEBzzbT1EMMTxyl
         rPXHJB8HVyjDGLjGsSU0UBQe1FBOoC4+wVlEo4XKkdOc5DHOkkETj3SeKllM6n9J/c
         7+8PUI1DXgTXK44fwZUw2jOhJlcsGJTHvk8C0RJdi4V6IAHYq9nbpQetnyqszVQZNM
         qpx2e5CnbT7DQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/20 7:40 AM, Arnd Bergmann wrote:
> One cannot select DEVICE_PRIVATE when its dependencies are disabled:
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>    Depends on [n]: ZONE_DEVICE [=n]
>    Selected by [m]:
>    - TEST_HMM [=m] && RUNTIME_TESTING_MENU [=y] && TRANSPARENT_HUGEPAGE [=y]
> lib/test_hmm.c:480:8: error: implicit declaration of function 'memremap_pages' [-Werror,-Wimplicit-function-declaration]
>          ptr = memremap_pages(&devmem->pagemap, numa_node_id());
>                ^
> lib/test_hmm.c:480:8: note: did you mean 'memcmp_pages'?
> include/linux/mm.h:3082:12: note: 'memcmp_pages' declared here
> extern int memcmp_pages(struct page *page1, struct page *page2);
>             ^
> lib/test_hmm.c:480:6: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Werror,-Wint-conversion]
>          ptr = memremap_pages(&devmem->pagemap, numa_node_id());
>              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/test_hmm.c:1089:4: error: implicit declaration of function 'memunmap_pages' [-Werror,-Wimplicit-function-declaration]
>                          memunmap_pages(&devmem->pagemap);
> 
> Add a dependency from CONFIG_TEST_HMM to ZONE_DEVICE, to disallow
> those broken configurations.

Thanks for fixing this.

> 
> Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Since the HMM tests are not yet in Linus' tree, shouldn't this patch just be folded
into Jason's hmm tree instead of a Fixes: line?

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   lib/Kconfig.debug | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d9885fa37cc0..63667d62c9d8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2262,6 +2262,7 @@ config TEST_MEMINIT
>   config TEST_HMM
>   	tristate "Test HMM (Heterogeneous Memory Management)"
>   	depends on TRANSPARENT_HUGEPAGE
> +	depends on ZONE_DEVICE
>   	select DEVICE_PRIVATE
>   	select HMM_MIRROR
>   	select MMU_NOTIFIER
> 

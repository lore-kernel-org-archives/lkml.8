Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E36E20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mqlQ5Nf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGGOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:41:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34429 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:41:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200707144139euoutp025896329b6259adb70a2d958c0d450c9b~ff20r6D521891818918euoutp02Z
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:41:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200707144139euoutp025896329b6259adb70a2d958c0d450c9b~ff20r6D521891818918euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594132900;
        bh=cBvC5AP1d5/o5ONU52SMIFkT7SU7vajmYhikOgSKNBA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mqlQ5Nf2WUrBo/nJdFIMNN9CO2OhdmDqPq7TC164gSOxLqiAuU08zIYPRIo0U/uuo
         X3LEaMozjK4MN4t/ZaU4vT1ZLsdvr0KBalTwg+Qigty5kisC6A8oNhnHrcO68ghxRl
         1llmD02cw/acSr8gqkuprse47c0Tx4Q8fSh7uWbQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200707144139eucas1p24f316cf9a8426b7a2b98b6c3d46b8f72~ff20YMNj-0464204642eucas1p28;
        Tue,  7 Jul 2020 14:41:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.B1.06456.3A9840F5; Tue,  7
        Jul 2020 15:41:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200707144139eucas1p2c9121671808d695570092f9b64aae1dc~ff20EAmw_1234412344eucas1p2p;
        Tue,  7 Jul 2020 14:41:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200707144139eusmtrp29b599051fdc57c201434d7a89432feb8~ff20DOkSO0093400934eusmtrp2F;
        Tue,  7 Jul 2020 14:41:39 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-e0-5f0489a3068b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 23.46.06017.3A9840F5; Tue,  7
        Jul 2020 15:41:39 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200707144137eusmtip2bf3dc48ec38f0a4d231906613a0d1005~ff2ywayy_3094530945eusmtip2w;
        Tue,  7 Jul 2020 14:41:37 +0000 (GMT)
Subject: Re: [PATCH v7 02/36] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3297292e-51ac-faf7-ae51-4e7fe3882de1@samsung.com>
Date:   Tue, 7 Jul 2020 16:41:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-3-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7qLO1niDbZPU7LoPXeSyWLjjPWs
        Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHwwxNWiy1vJrI6cHusmbeG
        0WP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fm09UenzfJBXBFcdmkpOZk
        lqUW6dslcGW0n/7JUvBfrGLZ9HusDYz/BLsYOTkkBEwkVnS/Zuxi5OIQEljBKPH37xco5wuj
        xNR/i9ggnM+MEu8mTmWGaZlw8R5U1XJGiStfjrNAOO8ZJe6vmcIIUiUskC6x4to7JhBbRGAL
        o0TzVDeQImaQUa3X9oIl2AQ0Jf5uvskGYvMK2Enc3bySHcRmEVCRmL1uGVhcVCBOYv3L7UwQ
        NYISJ2c+YQGxOYHq/2+5C1bPLCAvsf3tHGYIW1yi6ctKVpBlEgIf2SWWfLvCBHG3i8TFHV9Y
        IWxhiVfHt7BD2DIS/3fOh6qpl7i/ooUZormDUWLrhp1QT1tL3Dn3C+giDqANmhLrd+lDhB0l
        enY+BgtLCPBJ3HgrCHEDn8SkbdOZIcK8Eh1tQhDVihL3z26FGigusfTCV7YJjEqzkHw2C8k3
        s5B8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBqe30v+OfdjB+vZR0iFGA
        g1GJhzcjkSVeiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9
        jBUSSE8sSc1OTS1ILYLJMnFwSjUwNlnx7Cms4GM5MsfszEPlg+U5pxg7S6zm7C7Lf3P7yb5X
        zD1OR8JuHTaYwymeNWFVQYWSYZK7ia7j7EvJxs2zl9lvfNzV+0p4lvEipqfcP49Nv+wptvB2
        y2/XN9fPGc3tsfyo1Bmtfvh5nlNU3a40kZJrFVN6NH+07Lm4Mlpa4st7p7s+EVK6SizFGYmG
        WsxFxYkAgUxnL2kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7qLO1niDY7e5bXoPXeSyWLjjPWs
        Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHwwxNWiy1vJrI6cHusmbeG
        0WP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fm09UenzfJBXBF6dkU5ZeW
        pCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GW0n/7JUvBfrGLZ
        9HusDYz/BLsYOTkkBEwkJly8x9jFyMUhJLCUUaLt2ktWiIS4xO75b5khbGGJP9e62CCK3jJK
        HH92ih0kISyQLrHi2jsmkISIwBZGiWcrDoONYhb4zCjx9/pHqJajjBLrPl5mA2lhE9CU+Lv5
        JpjNK2AncXfzSrBRLAIqErPXLQOLiwrESSzfMp8dokZQ4uTMJywgNidQ/f8td8HizAJmEvM2
        P2SGsOUltr+dA2WLSzR9Wck6gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLS
        vHS95PzcTYzAeN527OeWHYxd74IPMQpwMCrx8GYkssQLsSaWFVfmHmKU4GBWEuF1Ons6Tog3
        JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgakmryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QD49l5r7vXLZr2j+F8lbcw0741euyX+ZeLF5nudXdQ+qf/dvv25GhN
        hiR11hy1O5NcxfecKN5y4vHyVf2ZSeY3mlZuKHW/fYd5ncKcVcbyBqt3P7vye/UWliOPPGX3
        dgbqbv9dZf97iZ77rODJ2/kEk7Yz+nxU4exKe6nFIRBW3P8i9d/jppsdv5VYijMSDbWYi4oT
        AYofCv39AgAA
X-CMS-MailID: 20200707144139eucas1p2c9121671808d695570092f9b64aae1dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103654eucas1p227a1d6926d008ef21ba4e0b68a8de210@eucas1p2.samsung.com>
        <20200619103636.11974-3-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.06.2020 12:36, Marek Szyprowski wrote:
> Replace the current hand-crafted code for extracting pages and DMA
> addresses from the given scatterlist by the much more robust
> code based on the generic scatterlist iterators and recently
> introduced sg_table-based wrappers. The resulting code is simple and
> easy to understand, so the comment describing the old code is no
> longer needed.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


Nice simplification.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Btw, I've wrongly re-configured my e-mail client, so my R-Bs for other 
patches are little bit broken, I will resend them :)


Regards
Andrzej


> ---
>   drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
>   1 file changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 226cd6ad3985..b717e52e909e 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -990,45 +990,26 @@ EXPORT_SYMBOL(drm_gem_prime_import);
>   int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>   				     dma_addr_t *addrs, int max_entries)
>   {
> -	unsigned count;
> -	struct scatterlist *sg;
> -	struct page *page;
> -	u32 page_len, page_index;
> -	dma_addr_t addr;
> -	u32 dma_len, dma_index;
> -
> -	/*
> -	 * Scatterlist elements contains both pages and DMA addresses, but
> -	 * one shoud not assume 1:1 relation between them. The sg->length is
> -	 * the size of the physical memory chunk described by the sg->page,
> -	 * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
> -	 * described by the sg_dma_address(sg).
> -	 */
> -	page_index = 0;
> -	dma_index = 0;
> -	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> -		page_len = sg->length;
> -		page = sg_page(sg);
> -		dma_len = sg_dma_len(sg);
> -		addr = sg_dma_address(sg);
> -
> -		while (pages && page_len > 0) {
> -			if (WARN_ON(page_index >= max_entries))
> +	struct sg_dma_page_iter dma_iter;
> +	struct sg_page_iter page_iter;
> +	struct page **p = pages;
> +	dma_addr_t *a = addrs;
> +
> +	if (pages) {
> +		for_each_sgtable_page(sgt, &page_iter, 0) {
> +			if (p - pages >= max_entries)
>   				return -1;
> -			pages[page_index] = page;
> -			page++;
> -			page_len -= PAGE_SIZE;
> -			page_index++;
> +			*p++ = sg_page_iter_page(&page_iter);
>   		}
> -		while (addrs && dma_len > 0) {
> -			if (WARN_ON(dma_index >= max_entries))
> +	}
> +	if (addrs) {
> +		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +			if (a - addrs >= max_entries)
>   				return -1;
> -			addrs[dma_index] = addr;
> -			addr += PAGE_SIZE;
> -			dma_len -= PAGE_SIZE;
> -			dma_index++;
> +			*a++ = sg_page_iter_dma_address(&dma_iter);
>   		}
>   	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);

Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03794C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28C92076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cp/Nxb6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406326AbgDPFSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:18:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19159 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405531AbgDPFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:18:03 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200416051758epoutp04ff9c12e36ca3d767307832ebafdd41ae~GNRQEwPYn1856618566epoutp04U
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:17:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200416051758epoutp04ff9c12e36ca3d767307832ebafdd41ae~GNRQEwPYn1856618566epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587014278;
        bh=JjHChKzGJY+Pr+qRpva3bX9JQbfmcsF9pYyB07kf9Ks=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cp/Nxb6whZqS0+nBOOOKiPC7l7wmPas3qyX6FFgvNbFmtsYrBoPcC7OBc8DXGHoOi
         0lxIEbEPYQJj+wFxeYu0ylwsjjZxhaK40ebbmGBkZNgN9PLB4Juu/gvX3HZcCHAQzy
         WlRE5BtXQG02EmWndK1/Haoz7IvQ62h8pnFUsMDI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200416051758epcas1p29ca8461ac8318c4fc6c7360a77ca64f2~GNRPqI-N91700117001epcas1p23;
        Thu, 16 Apr 2020 05:17:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 492nYK272WzMqYkk; Thu, 16 Apr
        2020 05:17:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.2D.04648.58AE79E5; Thu, 16 Apr 2020 14:17:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200416051756epcas1p37b66d9feeb0cc5631a78ff7ec71d5e83~GNROSCCCF2145221452epcas1p36;
        Thu, 16 Apr 2020 05:17:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200416051756epsmtrp224d7921d5e52f120b8592f5b77a83f01~GNRORReiu0159501595epsmtrp2C;
        Thu, 16 Apr 2020 05:17:56 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-98-5e97ea85f560
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.E3.04158.48AE79E5; Thu, 16 Apr 2020 14:17:56 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200416051756epsmtip2311bd26cacc910e230800d3f7a1546ee~GNRN_Rkn10259202592epsmtip2M;
        Thu, 16 Apr 2020 05:17:56 +0000 (GMT)
Subject: Re: [PATCH] mm/vmscan: skip layzfree page on
 reclaim_clean_pages_from_list
To:     minchan@kernel.org, mgorman@suse.de, m.szyprowski@samsung.com,
        mina86@mina86.com, riel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E97EA84.8040303@samsung.com>
Date:   Thu, 16 Apr 2020 14:17:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200416033514.6366-1-jaewon31.kim@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmvm7rq+lxBvdW81vMWb+GzaJ780xG
        i8u75rBZ3Fvzn9Vi7ZG77BaT3z1jtFhwvIXVYtnX9+wWf6+sZ7F4vJ7bgctj56y77B6bVnWy
        eWz6NInd48SM3ywe6/68YvJ4v+8qm0ffllWMHptPV3t83iQXwBmVY5ORmpiSWqSQmpecn5KZ
        l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKeSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEn4/DrV2wF8yUrnm6NamD8
        LtLFyMkhIWAicarnOWsXIxeHkMAORok9t+8xQzifGCU6jx9mgnC+MUq0LOxmhWnZd/43VGIv
        o8T0mZdYQBJCAm8ZJbrn84PYwgKhEhuWL2cHKRIRaGKU+Ll5PlgRs0CyROubk0wgNpuAtsT7
        BZPApvIKaEl8/H0YrIZFQFWi+f4yMFtUIEJix9yPjBA1ghInZz4Bi3MK2Epc2nuXHWKmvETz
        1tlgd0sINLNLfP6zAGgoB5DjItF/qgTiamGJV8e3sEPYUhKf3+1lg6pnlHg7czMjhNPCKHF3
        Uy8jRJWxRG/PBWaQQcwCmhLrd+lDhBUldv6eywixmE/i3dceqF28Eh1tQhAlahItz75CQ0tG
        4u+/Z1C2h0TjqUvskJCbwCix/80q5gmMCrOQ/DYLyT+zEDYvYGRexSiWWlCcm55abFhgjBzF
        mxjBKVfLfAfjhnM+hxgFOBiVeHgNXk6LE2JNLCuuzD3EKMHBrCTCu8N/epwQb0piZVVqUX58
        UWlOavEhRlNgcE9klhJNzgfmg7ySeENTI2NjYwsTM3MzU2Mlcd6p13PihATSE0tSs1NTC1KL
        YPqYODilGhjtb0UssU9Zsy3a/duj9OUsc7oli8s8A7ylDzkKG1yUt5Y9Gvj48LqaK9uZbrl1
        ZGRFP8sV39BrG3Hs1qzv3z1Oimz2emq9xo7HWeya6ym/+medvJ+/GF97Vxq3MOLsadGiCvnJ
        of0OsjoCm+Y+bBEQvalw48o3/eun2r4GuBq8C7ZpmrvUWECJpTgj0VCLuag4EQAxWn0szwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXrfl1fQ4g+eH9S3mrF/DZtG9eSaj
        xeVdc9gs7q35z2qx9shddovJ754xWiw43sJqsezre3aLv1fWs1g8Xs/twOWxc9Zddo9NqzrZ
        PDZ9msTucWLGbxaPdX9eMXm833eVzaNvyypGj82nqz0+b5IL4IzisklJzcksSy3St0vgyjj8
        +hVbwXzJiqdboxoYv4t0MXJySAiYSOw7/5upi5GLQ0hgN6PErH+fmSASMhJvzj9l6WLkALKF
        JQ4fLoaoec0oMWXbRnaQGmGBUIkNy5ezgyREBJoYJV61rmaGqJrAKPFo6yywKmaBZIkHp7ex
        gdhsAtoS7xdMYgWxeQW0JD7+PswCYrMIqEo0318GZosKREisXneNGaJGUOLkzCdgcU4BW4lL
        e+9CzVSX+DPvEjOELS/RvHU28wRGwVlIWmYhKZuFpGwBI/MqRsnUguLc9NxiwwKjvNRyveLE
        3OLSvHS95PzcTYzgSNLS2sF44kT8IUYBDkYlHt6O19PihFgTy4orcw8xSnAwK4nw7vCfHifE
        m5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBUShp+fec2syA
        PQorP9bcTXjNKpmvHbNVKNv3cqEEW9JX9msqMn4B8wRvTbrvoXNrhqKkUNiTrMP/GeqiHums
        2XDk5rZjuQzGd77t2bzgeP2No7+17hSKPf6bf4p5u29Lanq63SNDnU9PfmxelLtGQc116aKs
        /9UBL7sWLDr7OUfEmLMm6MZCNyWW4oxEQy3mouJEANfIwh6gAgAA
X-CMS-MailID: 20200416051756epcas1p37b66d9feeb0cc5631a78ff7ec71d5e83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a
References: <CGME20200416033543epcas1p2b256bef770bb1310a9bf62bda80a976a@epcas1p2.samsung.com>
        <20200416033514.6366-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 16일 12:35, Jaewon Kim wrote:
> This patch fix nr_isolate_* mismatch problem between cma and dirty
> lazyfree page.
>
> If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
> page, then the lazyfree page is changed to a normal anon page having
> SwapBacked by commit 18863d3a3f59 ("mm: remove SWAP_DIRTY in ttu"). Even
> with the change, reclaim context correctly counts isolated files because
Sorry, I think I pointed a wrong commit, the SwapBacked was recovered
by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages").
> it uses is_file_lru to distinguish file. And the change to anon is not
> happened if try_to_unmap_one is used for migration. So migration context
> like compaction also correctly counts isolated files even though it uses
> page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
> renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
> MADV_FREE").
>
> But the nr_isolate_* mismatch problem happens on cma alloc. There is
> reclaim_clean_pages_from_list which is being used only by cma. It was
> introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
> contiguous allocation instead of migration") to reclaim clean file pages
> without migration. The cma alloc uses both reclaim_clean_pages_from_list
> and migrate_pages, and it uses page_is_file_lru to count isolated
> files. If there are dirty lazyfree pages allocated from cma memory
> region, the pages are counted as isolated file at the beginging but are
> counted as isolated anon after finished.
>
> Mem-Info:
> Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>
> Like log above, there was too much isolated file, 37664kB, which
> triggers too_many_isolated in reclaim when there is no isolated file in
> system wide. It could be reproducible by running two programs, doing
> MADV_FREE, writing and doing cma alloc, respectively. Although isolated
> anon is 0, I found that the internal value of isolated anon was the
> negative value of isolated file.
>
> Fix this by skipping anon pages on reclaim_clean_pages_from_list. The
> lazyfree page can be checked by both PageAnon(page) and
> page_is_file_lru. But in this case, PageAnon is enough to skip all
> anon pages.
>
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b06868fc4926..9380a18eef5e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1497,6 +1497,9 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  	LIST_HEAD(clean_pages);
>  
>  	list_for_each_entry_safe(page, next, page_list, lru) {
> +		/* to avoid race with MADV_FREE anon page */
> +		if (PageAnon(page))
> +			continue;
>  		if (page_is_file_lru(page) && !PageDirty(page) &&
>  		    !__PageMovable(page) && !PageUnevictable(page)) {
>  			ClearPageActive(page);


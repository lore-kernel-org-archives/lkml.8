Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A89C5518A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3E720857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 03:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tryu3A23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgDWDQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:16:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:24526 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDWDQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 23:16:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200423031606epoutp04ad34ad188652cf0cafd401952779a91c~IVH1lkgwr0508605086epoutp04P
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:16:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200423031606epoutp04ad34ad188652cf0cafd401952779a91c~IVH1lkgwr0508605086epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587611766;
        bh=2Q1ywereXXZrpfKmqsfK5VroIXWEuFSzCYW+j3bXqr4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tryu3A23yQxgCvbviqqEfQ7FTnxdZTwZfkNWsP/Dq41kyn1zrLGS1hnzxifCDTlNa
         Ir76FPgoHPiWZThjGxTSwwKZuQ48KJQ1hDzSSZozU6LTnAU6841N50mdAuRe8hAI70
         zIlNjw2IEmBiMDyGQGudqmvZyxtFdtZkQx9z6Rbo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200423031605epcas1p2a7c8604f2ebbaf7f2409d230c3a2bde0~IVH1KB9LP1109811098epcas1p2e;
        Thu, 23 Apr 2020 03:16:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4972WS1rpYzMqYkW; Thu, 23 Apr
        2020 03:16:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.CF.04402.47801AE5; Thu, 23 Apr 2020 12:16:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200423031603epcas1p23b29e014c3b9182b495bdd368e3b340f~IVHy699Do0880208802epcas1p2p;
        Thu, 23 Apr 2020 03:16:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200423031603epsmtrp28a5d14fb3cd29af686a268a657f95fc7~IVHy58JfP2823928239epsmtrp2W;
        Thu, 23 Apr 2020 03:16:03 +0000 (GMT)
X-AuditID: b6c32a35-76bff70000001132-3d-5ea10874db02
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.36.04158.37801AE5; Thu, 23 Apr 2020 12:16:03 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200423031602epsmtip2f454c065270303101c7eedab570922a6~IVHyfO7At1819118191epsmtip29;
        Thu, 23 Apr 2020 03:16:02 +0000 (GMT)
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix
 nr_isolated_* mismatch
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     minchan@kernel.org, mgorman@suse.de, m.szyprowski@samsung.com,
        mina86@mina86.com, shli@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5EA10872.3010500@samsung.com>
Date:   Thu, 23 Apr 2020 12:16:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200422130751.GD358439@cmpxchg.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmgW4Jx8I4g2uneC3mrF/DZrF6k69F
        9+aZjBaXd81hs7i35j+rxdojd9ktJr97xmix4HgLq8Wyr+/ZLZbt7GexeLye24Hb4/Cb98we
        E5vfsXvsnHWX3WPTqk42j02fJrF7nJjxm8Vj3Z9XTB59W1Yxemw+Xe3xeZNcAFdUjk1GamJK
        apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
        4mIlfTubovzSklSFjPziElul1IKUnAJDgwK94sTc4tK8dL3k/FwrQwMDI1OgyoScjIaT39kK
        tvJX3Jl4nr2BcTFPFyMnh4SAicTFn7OZuhi5OIQEdjBKvL6xiQXC+cQoMfPKcijnG6NE6583
        rDAta55uYoRI7GWUmLW+E8p5yyix4sMWZpAqYYEIiW8de8FsEQENiUuLOthAipgFHjJKHHxy
        gQUkwSagLfF+wSSwsbwCWhIrNq4Fa2ARUJVYs+kCmC0KNGjH3I+MEDWCEidnPgHr5RQwktjz
        by5YnFlAXqJ562xmkAUSAtPZJW5O+Q51q4vEvqm/mSBsYYlXx7ewQ9hSEp/f7WWDaGhmlHg7
        czMjhNPCKHF3Uy8jRJWxRG8PyBkcQCs0Jdbv0ocIK0rs/A2zmU/i3dceVpASCQFeiY42IYgS
        NYmWZ1+hbpCR+PvvGZTtIfHu+kFWSHDtZJR4M/8e+wRGhVlInpuF5KFZCJsXMDKvYhRLLSjO
        TU8tNiwwRI7lTYzgVKxluoNxyjmfQ4wCHIxKPLwRigvihFgTy4orcw8xSnAwK4nwbng4L06I
        NyWxsiq1KD++qDQntfgQoykwvCcyS4km5wPzRF5JvKGpkbGxsYWJmbmZqbGSOO/U6zlxQgLp
        iSWp2ampBalFMH1MHJxSDYzsknk3NwdrJR1S2u933/pepOHk54bb8qLzbtVJWaw+K8GzUp57
        6v5lujwSZdk5pgb7jiYkCxybfCuqT1iyj+ftxFUGE5hq1ruIbpkYMrFKn4lnlf2lL3JyesdO
        hSvF5z2Xi1h6lfNxrkD27Qr2jTwekRMNA7dNUuCZXijvNnvCnRSZPfU/dyixFGckGmoxFxUn
        AgAB08d12wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG4xx8I4g/MbeSzmrF/DZrF6k69F
        9+aZjBaXd81hs7i35j+rxdojd9ktJr97xmix4HgLq8Wyr+/ZLZbt7GexeLye24Hb4/Cb98we
        E5vfsXvsnHWX3WPTqk42j02fJrF7nJjxm8Vj3Z9XTB59W1Yxemw+Xe3xeZNcAFcUl01Kak5m
        WWqRvl0CV0bDye9sBVv5K+5MPM/ewLiYp4uRk0NCwERizdNNjF2MXBxCArsZJQ6tucgGkZCR
        eHP+KUsXIweQLSxx+HAxRM1rRol5K34ygdQIC0RI3Pp2kR3EFhHQkLi0qIMNomgno0Tz1t1g
        U5kFHjJKrP0xlQWkik1AW+L9gkmsIDavgJbEio1rmUFsFgFViTWbLoDZokBTV6+7xgxRIyhx
        cuYTsF5OASOJPf/mMoJcxCygLrF+nhBImFlAHmjXbOYJjIKzkHTMQqiahaRqASPzKkbJ1ILi
        3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4MjS0trBeOJE/CFGAQ5GJR7eCMUFcUKsiWXFlbmH
        GCU4mJVEeDc8nBcnxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJ
        g1OqgTHzxfnSzcefFN31uab1Scy2YVfKo8fz5Dje+KX8WHBwluFBvZaegIBNAiw7Gz8URu5K
        69otd226z1Ip/e8WH7V3eIYfXt/fEmWjtW/OBav50RGM098XnsnQZFdX+cPzKrv6QBvDG5nC
        5U2aLE1xuywenJ08u/PL802ZSqInb999VVqTWn+vr1WJpTgj0VCLuag4EQD8FuNKqAIAAA==
X-CMS-MailID: 20200423031603epcas1p23b29e014c3b9182b495bdd368e3b340f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
        <20200422084815.21913-1-jaewon31.kim@samsung.com>
        <20200422130751.GD358439@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 22일 22:07, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
>> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>  		 */
>>  		if (page_mapped(page)) {
>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>>  
>>  			if (unlikely(PageTransHuge(page)))
>>  				flags |= TTU_SPLIT_HUGE_PMD;
>> +
>>  			if (!try_to_unmap(page, flags)) {
>>  				stat->nr_unmap_fail += nr_pages;
>> +				if (lazyfree && PageSwapBacked(page))
> This looks pretty strange, until you remember that try_to_unmap()
> could SetPageSwapbacked again.
>
> This might be more obvious?
>
> 			was_swapbacked = PageSwapBacked(page);
> 			if (!try_to_unmap(page, flags)) {
> 				stat->nr_unmap_fail += nr_pages;
> 				if (!was_swapbacked && PageSwapBacked(page))
Hello Johannes, thank you for your comment.

The name can changed from layzyfree to was_swapbacked.
By the way, did you mean removing PageAnon(page), too? It seems to be OK, though.
>> +					stat->nr_lazyfree_fail += nr_pages;
>>  				goto activate_locked;
> Or at least was_lazyfree.
Sorry but I'm confused.
I think you meant additional comment to previous your comment
rather than you wanted to rename stat->nr_lazyfree_fail to stat->was_lazyfree.
>
>> @@ -1491,8 +1495,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>>  		.priority = DEF_PRIORITY,
>>  		.may_unmap = 1,
>>  	};
>> -	struct reclaim_stat dummy_stat;
>> -	unsigned long ret;
>> +	struct reclaim_stat stat;
>> +	unsigned long reclaimed;
> nr_reclaimed would be better.
I will add nr_ prefix on next patch.
>
> I also prefer keeping dummy_stat, since that's still what it is.
This patch uses stat.nr_lazyfree_fail, I do not understand why it is still dummy_stat.
If you want, I will keep dummy_stat, though.

Thank you
Jaewon Kim
>
>


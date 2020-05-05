Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29290C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02170206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zkZhOMbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEEA2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:28:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEEA2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:28:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0450HdsP079246;
        Tue, 5 May 2020 00:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=A60tIjrFlCWczDSGE6nphoyY+quycdG0047aXGDBwXM=;
 b=zkZhOMbL5ntt8V+FauVJdMoxGpMiiNxxKf4JrjWnjAN05FHvvX0Ql2S+bPRezp3uCU9L
 H9PCi429eviWsQPB22XxSxA4ABVFlrZEXVoGnCqmnLb1/Y7kzKhFY8uqPRVra4iMqTYz
 wQHLJzjmvD1lSCIik427sDWielozZiI0cWLaKhpCTVcPzO0jgByjY6aTCeGnSCfpoG9q
 ILdQzrviGKqfWRhCYJkHy7O0weSnQ6PUdeQ8WrkZp4tVIEtAnXDvoaXhGuK/trdcIMYw
 b1v+ZfzcchpXBMKdn5jY0Z0DR4hz0qS+myC335sjxVwil9mR8E0JpWQUaiogktg9EUT3 pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09r20ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 00:27:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0450GtQN065070;
        Tue, 5 May 2020 00:27:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdrs6uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 00:27:58 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0450RuSm027475;
        Tue, 5 May 2020 00:27:56 GMT
Received: from [10.159.232.15] (/10.159.232.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 17:27:56 -0700
Subject: Re: [PATCH] mm: Limit boost_watermark on small zones.
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
 <20200501155729.a479c4b27f127d9aa866bd8e@linux-foundation.org>
 <20200504124409.GB3758@techsingularity.net>
 <20200504133604.5fd0b0b11b93bb4d9a0fed68@linux-foundation.org>
From:   Henry Willard <henry.willard@oracle.com>
Message-ID: <fdfd6647-da93-297a-1122-64be8daa8e1c@oracle.com>
Date:   Mon, 4 May 2020 17:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504133604.5fd0b0b11b93bb4d9a0fed68@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 1:36 PM, Andrew Morton wrote:
> On Mon, 4 May 2020 13:44:09 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
>
>> On Fri, May 01, 2020 at 03:57:29PM -0700, Andrew Morton wrote:
>>> On Thu, 30 Apr 2020 17:49:08 -0700 Henry Willard <henry.willard@oracle.com> wrote:
>>>
>>>> Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
>>>> fragmentation event occurs") adds a boost_watermark() function which
>>>> increases the min watermark in a zone by at least pageblock_nr_pages or
>>>> the number of pages in a page block. On Arm64, with 64K pages and 512M
>>>> huge pages, this is 8192 pages or 512M. It does this regardless of the
>>>> number of managed pages managed in the zone or the likelihood of success.
>>>> This can put the zone immediately under water in terms of allocating pages
>>>> from the zone, and can cause a small machine to fail immediately due to
>>>> OoM. Unlike set_recommended_min_free_kbytes(), which substantially
>>>> increases min_free_kbytes and is tied to THP, boost_watermark() can be
>>>> called even if THP is not active. The problem is most likely to appear
>>>> on architectures such as Arm64 where pageblock_nr_pages is very large.
>>>>
>>>> It is desirable to run the kdump capture kernel in as small a space as
>>>> possible to avoid wasting memory. In some architectures, such as Arm64,
>>>> there are restrictions on where the capture kernel can run, and therefore,
>>>> the space available. A capture kernel running in 768M can fail due to OoM
>>>> immediately after boost_watermark() sets the min in zone DMA32, where
>>>> most of the memory is, to 512M. It fails even though there is over 500M of
>>>> free memory. With boost_watermark() suppressed, the capture kernel can run
>>>> successfully in 448M.
>>>>
>>>> This patch limits boost_watermark() to boosting a zone's min watermark only
>>>> when there are enough pages that the boost will produce positive results.
>>>> In this case that is estimated to be four times as many pages as
>>>> pageblock_nr_pages.
>>>>
>> ...
>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Cool.  I wonder if we should backport this into -stable kernels?  "can
> cause a small machine to fail immediately" sounds serious, but
> 1c30844d2dfe is from December 2018.  Any thoughts?
It is a trivial patch, and we always like to have them in -stable 
kernels when possible. It was a serious problem for us, because we had a 
configuration where kdump on Arm always failed. However, other than 
kdump, the problem is probably relatively rare.

Thanks,
Henry


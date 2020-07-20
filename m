Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E207DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686F20702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zpfsd67U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGTWfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:35:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgGTWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:35:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMMjBm021631;
        Mon, 20 Jul 2020 22:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wgQd7RhVNzKT+T0oY87IVbiVIaLuPib3LL8sHz8Q5Xw=;
 b=Zpfsd67UUsom1PDdI+vIm55wgo6WyuliHM7LVCzpr2vhfoqsB/aWkotz0hIquhU+nms1
 abdFDKUrtIIWGZFJbgRXfKeZoUCAhCTyFK4tnVEoSWjIGemnp45FU5Gs82Hoc37ycFPk
 Mw3pa6v0NlUJPIDJgEwNAvU6zT969tCzV52qLQg9IAYd1DHAO9bAQEiuSkwO6EVedOCb
 ruWMgRLwBU6KWOm1Bh+AAR0LPGjRWdgkmvB1db9572bD/IJICX8XRlT3zTwV/xklZ8I0
 QIqmYMPU4F1JevPK57/mzdGm9LLGdtL6L+ksnjIhFs2EIUd48Bke7dFovaNh7IbEZrnF xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32bs1m9n56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 22:34:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMIKVX188933;
        Mon, 20 Jul 2020 22:34:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32dkjrj0n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 22:34:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06KMYuZR008837;
        Mon, 20 Jul 2020 22:34:56 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 22:34:56 +0000
Subject: Re: [PATCH 2/5] mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return
 bool
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-3-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5fda8ff8-c9fb-08c0-be8a-a2cf3af4fccf@oracle.com>
Date:   Mon, 20 Jul 2020 15:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720062623.13135-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:26 PM, Baoquan He wrote:
> Just like his neighbour is_hugetlb_entry_migration() has done.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 191a585bb315..a58f976a9dd9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3754,17 +3754,17 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  		return false;
>  }
>  
> -static int is_hugetlb_entry_hwpoisoned(pte_t pte)
> +static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  {
>  	swp_entry_t swp;
>  
>  	if (huge_pte_none(pte) || pte_present(pte))
> -		return 0;
> +		return false;
>  	swp = pte_to_swp_entry(pte);
>  	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> -		return 1;
> +		return true;
>  	else
> -		return 0;
> +		return false;
>  }
>  
>  int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> 

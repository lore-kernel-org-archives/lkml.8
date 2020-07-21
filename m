Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D40208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SC9zbmmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGUAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:39:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgGUAjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:39:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06L0d26p152395;
        Tue, 21 Jul 2020 00:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SOydNk4NfHk1SJHZ5z8aPTebLmt7sZyrmhdUciJmqm0=;
 b=SC9zbmmhSIUB4w52bDf26AOXZg0ED7+FHkmp/iEfIJERyHBeIwOud8BH26xClMFDlNaB
 0RGUbvfrbfjAY964CsQvZ+Jh6RtIAjXMRz27wX6GdcsdedqwX2mfl5rcReYJyBIThN/c
 dB8upDd2BFGT8ukmz9QxFH6ZM8U6teKX6StiN6l0NFpZXRhAvaywI1YNY0kaXWZpGWyS
 /6+VWCU/Z1lY2RZjuGG8bB6q8cBz75hMuRNKqwKZvmWUv+FRRARl6YtpjsGP0iKByC3/
 FbYM8MB1zOuBWw3URFr6ZmtogwYEdineaCTsAqoI7ZQDTXm0XHMpb1QoIZCZk+HoDtHP Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgra1cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 00:39:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06L0MvAh194983;
        Tue, 21 Jul 2020 00:39:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32dnmq8q63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 00:39:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06L0d0Jh022871;
        Tue, 21 Jul 2020 00:39:00 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 17:39:00 -0700
Subject: Re: [PATCH 5/5] mm/hugetl.c: warn out if expected count of huge pages
 adjustment is not achieved
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-6-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
Date:   Mon, 20 Jul 2020 17:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720062623.13135-6-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=2 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=2 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:26 PM, Baoquan He wrote:
> A customer complained that no any message is printed out when failed to
> allocate explicitly specified number of persistent huge pages. That
> specifying can be done by writing into /proc/sys/vm/nr_hugepages to
> increase the persisten huge pages.
> 
> In the current code, it takes the best effort way to allocate the expected
> number of huge pages. If only succeeding to get part of them, no any
> information is printed out.
> 
> Here try to send out warning message if the expected number of huge pages
> adjustment is not achieved, including increasing and decreasing the count
> of persistent huge pages.

Perhaps change the wording a bit,

A customer complained that no message is logged when the number of
persistent huge pages is not changed to the exact value written to
the sysfs or proc nr_hugepages file.

In the current code, a best effort is made to satisfy requests made
via the nr_hugepages file.  However, requests may be only partially
satisfied.

Log a message if the code was unsuccessful in fully satisfying a
request.  This includes both increasing and decreasing the number
of persistent huge pages.

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/hugetlb.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

I am not opposed to this patch.  However, I believe the best way for a user
to determine if their request was successful is to compare the value of
nr_hugepages to the value which was written.

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 467894d8332a..1dfb5d9e4e06 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			      nodemask_t *nodes_allowed)
>  {
> -	unsigned long min_count, ret;
> +	unsigned long min_count, ret, old_max;
>  	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
>  
>  	/*
> @@ -2723,6 +2723,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	 * pool might be one hugepage larger than it needs to be, but
>  	 * within all the constraints specified by the sysctls.
>  	 */
> +	old_max = persistent_huge_pages(h);
>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>  			break;
> @@ -2779,6 +2780,16 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	}
>  out:
>  	h->max_huge_pages = persistent_huge_pages(h);
> +	if (count != h->max_huge_pages) {
> +		char buf[32];
> +
> +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +		pr_warn("HugeTLB: %s %lu of page size %s failed. Only %s %lu hugepages.\n",
> +			count > old_max ? "increasing" : "decreasing",
> +			abs(count - old_max), buf,
> +			count > old_max ? "increased" : "decreased",
> +			abs(old_max - h->max_huge_pages));
> +	}
>  	spin_unlock(&hugetlb_lock);

I would prefer if we drop the lock before logging the message.  That would
involve grabbing the value of h->max_huge_pages before dropping the lock.
-- 
Mike Kravetz

>  
>  	NODEMASK_FREE(node_alloc_noretry);
> 

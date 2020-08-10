Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57C2206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GcYIDRFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgHJVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:46:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56062 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:46:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ALfx1t054218;
        Mon, 10 Aug 2020 21:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lF0KrpARyaF0oOEZrIWdYjpu2+gftHlgYUpzH+7Q/4s=;
 b=GcYIDRFqwL00Yiq6NF28HCcx6p4RToQnUu4dhXWw5IjpzozfC5u4QjzbTt3xWpOO4Mo5
 j9yqiChds+N74GadT0yNOw/Xq4StmrmB/Bh3Hfj8goHrX18IaG9gfX7AbTyTRQnbez+S
 9WkA7UA2O4Hnt7SoIXqi+nmH3Kq4UdTFN0DAeKWKE8Ejc/kLoknO2cSjegKd9RRrrW2L
 QOOORvGWujjGWmr6Dbc5kiveQfV6cVq10Xsob1KqZ7GU+VEntD4wKZNMwE/wwURm4rcL
 kayb5tILnT+58cT8/Zr4+QiIwtX5QJc60376JY+o6FGoyv7X7K3w3XO3AyGY5qZcaCpH 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32t2ydfjgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 21:46:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ALhTT6144114;
        Mon, 10 Aug 2020 21:46:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32t5mn7wqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 21:46:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07ALkM58029342;
        Mon, 10 Aug 2020 21:46:23 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 21:46:22 +0000
Subject: Re: [PATCH 04/10] mm/hugetlb: count file_region to be added when
 regions_needed != NULL
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-5-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9ff6babc-d525-e0b1-ca6c-9c8b24e5a07f@oracle.com>
Date:   Mon, 10 Aug 2020 14:46:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807091251.12129-5-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 2:12 AM, Wei Yang wrote:
> There are only two cases of function add_reservation_in_range()
> 
>     * count file_region and return the number in regions_needed
>     * do the real list operation without counting
> 
> This means it is not necessary to have two parameters to classify these
> two cases.
> 
> Just use regions_needed to separate them.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Thanks!

I really like removal of the 'count_only' parameter.  However, within the
routine 'count_only' made the code just a little easier to understand. I
might have:
- Removed the function parameter.
- Added local variable
  bool count_only = regions_needed != NULL;
- Left remaining code as it.

I'm OK with the proposed change.  Any change to readability is VERY minimal.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

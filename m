Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E76C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C707020716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jEdnyYD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgHJWAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:00:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJWAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:00:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ALw2F5089286;
        Mon, 10 Aug 2020 22:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wwYxdHePoZSP5awC7hLOOLxR/czdyqyoSrmTLyW544w=;
 b=jEdnyYD5HxY/8nNnLjWB4z5UyOpkXG20Wj6q3pDw/vnoXQDtDejXx/mTrPg26YGYQpKd
 1pIosWY9+/+0O4r9pL1kLEfKj8CN79T2/Nid58n+EjMD9eU7kcqnGW2spu1Q16HeZbo/
 9tjlbiOZlr7dq7VDHhEOdrhg3yKdMFGj9I8wxzTWFL3yXDYuudB/ErTMfB8i2wzJPcyN
 geb+rGCkBELF6aaxfNhA8j9RpGdkVdTqBMYEay+1m41OEkLuJhMZGU+mDMQGsz5XBVh4
 HBESgwtIK4uD9JhCIS/SOdzcQx5Lm9uuQg3vKROujv1yLhSXdeMPuZZiOnAT0nYttyvG 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ydfm7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 22:00:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07ALwN86162641;
        Mon, 10 Aug 2020 22:00:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32t5yxhjy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 22:00:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07AM0Oe5027394;
        Mon, 10 Aug 2020 22:00:24 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 22:00:24 +0000
Subject: Re: [PATCH 06/10] mm/hugetlb: remove redundant huge_pte_alloc() in
 hugetlb_fault()
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-7-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <06d2d8d9-ddd2-0c43-0cad-0c175ceff0dd@oracle.com>
Date:   Mon, 10 Aug 2020 15:00:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807091251.12129-7-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 2:12 AM, Wei Yang wrote:
> Before proper processing, huge_pte_alloc() would be called
> un-conditionally. It is not necessary to do this when ptep is NULL.

Worse, that extra call is a bug.  I believe Andrew pulled this patch into
his queue.  It still could use a review.

https://lore.kernel.org/linux-mm/e670f327-5cf9-1959-96e4-6dc7cc30d3d5@oracle.com/

-- 
Mike Kravetz

Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E20C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE632072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ihv/yPG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJDOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:14:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:14:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A3Cvpt191184;
        Fri, 10 Jul 2020 03:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LVkgz0YdmriXPrbU9G10n342hyOtAHH8iV0FCyOgr6k=;
 b=Ihv/yPG23iLYzP7Sg4l7IKpuF48Y+S4YSCIhUkuBczEoUrwWvjH8yMBtf9UiCjjU9ZAa
 XYuPcPOI/6YxDu+PQa/XBZIWB8JuvlxTkcgp40H4WeqdJERFZp2ptJx8hdEptohb1NPg
 MYXqm2xiEBpz5I0N9p0lqWKfyJJdqpGoVb3NSKljyJ38ASxOotjKvp70iByDi675KI+a
 jDG3HmP8PK6ioZaITSmrBQiKTOjCPoaw4DgelpOGuUwxU8IFZxeG7c5tKWsypSKcZB/g
 XYza1L1TNbvzB4dPNx04UIXW4GYD8c48CyQkMpe4k93IsKgp6vwAX48a2p1oXSaqM6/i kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 325y0an2c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 03:13:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A34NbP087260;
        Fri, 10 Jul 2020 03:11:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 325k41gxqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 03:11:42 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06A3Be8I009396;
        Fri, 10 Jul 2020 03:11:40 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 20:11:40 -0700
Subject: Re: [PATCH v4] mm/hugetlb: avoid hardcoding while checking if cma is
 enabled
To:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
References: <20200710005726.36068-1-song.bao.hua@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f8f2a080-4bfe-8e3f-02bd-6fc5c9c59574@oracle.com>
Date:   Thu, 9 Jul 2020 20:11:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710005726.36068-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 5:57 PM, Barry Song wrote:
> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> enabled. gigantic pages might have been reserved on other nodes.
> This patch fixes possible double reservation and CMA leak.
> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

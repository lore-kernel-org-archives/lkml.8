Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA42C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E7720768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ET1Chz0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbgFXVTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:19:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:19:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OLHvgE028970;
        Wed, 24 Jun 2020 21:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4vb8mzCTrugFu8Whb9uR67i2bumZL2/U7E2uotWgqjU=;
 b=ET1Chz0tXMyrQb6M7I4nTqoMHGEJnoezzLJC2DDfpepmN4EVH3hAJ3FVVwCZgziyztXC
 0j6ey+PsZCniLWQMhjKY7MhwCAjfAvkzXpf5tDLMOj4k/wYkswA6IlocmoTs5bk3s6CX
 dIBXD6iEdMKnw8C/EUUDvqKjuB+4re/6BnECepZb6ncZJR7Z2y0KvNt0foGikQ180Qou
 6MQKMoUEQ6it8+A7gL5PI+guAkUsBfylDQftE1Qcemhp/0+j25ZoLDPStWmw7JpsE6cT
 8BbWgKiEJknWy2PWV6zyrgaAhtZV3dkEepma2eRFaorpYX+9Xhl8qjrljx9wGL8RSFAP EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31uustn8c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 21:18:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OLDsM8144332;
        Wed, 24 Jun 2020 21:18:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31uur08v8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 21:18:53 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OLImMQ008836;
        Wed, 24 Jun 2020 21:18:49 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 21:18:48 +0000
Subject: Re: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <17006bfd-290a-e443-a734-1717bfb8bb9c@oracle.com>
Date:   Wed, 24 Jun 2020 14:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 11:13 PM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is no difference between two migration callback functions,
> alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> __GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
> alloc_huge_page_nodemask() and replace the callsite for
> alloc_huge_page_node() with the call to
> alloc_huge_page_nodemask(..., __GFP_THISNODE).
> 
> It's safe to remove a node id check in alloc_huge_page_node() since
> there is no caller passing NUMA_NO_NODE as a node id.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks for consolidating these.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

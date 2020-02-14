Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB53C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C5C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UGOcS6nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBNXma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:42:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBNXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:42:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ENcvop123335;
        Fri, 14 Feb 2020 23:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tbNdfqYrYh6i+Qtlbrau2oHkQi8x7QDUc6eg1xYv1mQ=;
 b=UGOcS6nwXGYckKfWTBg9l6ujnyRM+HYK1lpE5XBTm3VHOQoVV97dVli1C0TYLzx+SSwZ
 zJPUSuXKZhD3KAUZe7MOQa1K0HqWHiaH9kULhQItsP5CzhdSkeRCaqr9ijQHjkuxYkDq
 xZYqoTOr0reRvUncFotW7ztSzsUlS0g/Rs0aCWleGfyJQ5cHZ5t5g30AWPwFZEiSntUc
 EIJwFr7rpnbbluo8WGATl/NH8qLwedqJ9mFY0lXAk96AKDGYbMf9rNPtxYJUfsqCr5pX
 qtfiQUplvwNgaPrtsh3Xa8iq/jRqQHLBmerTdLTTbeEJEj0xABX+6j0UPrUFcE45MtWY Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y2jx6vdat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 23:42:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01ENc3fC086120;
        Fri, 14 Feb 2020 23:40:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y4k3f5yh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 23:40:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01ENeOBU024383;
        Fri, 14 Feb 2020 23:40:24 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 15:40:24 -0800
Subject: Re: [PATCH 06/30] mm/hugetlb: Add missing annotation for
 gather_surplus_pages()
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        HUGETLB FILESYSTEM <linux-mm@kvack.org>
References: <0/30> <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-7-jbi.octave@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2df96cb5-e4db-6133-3406-a97fef9a3028@oracle.com>
Date:   Fri, 14 Feb 2020 15:40:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214204741.94112-7-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 12:47 PM, Jules Irenge wrote:
> Sparse reports a warning at gather_surplus_pages()
> 
> warning: context imbalance in hugetlb_cow() - unexpected unlock
> 
> The root cause is the missing annotation at gather_surplus_pages()
> Add the missing __must_hold(&hugetlb_lock)
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

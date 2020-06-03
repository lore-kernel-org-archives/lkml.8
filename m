Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BF820679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x7ti2329"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFCR2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:28:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:28:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HQUMV137150;
        Wed, 3 Jun 2020 17:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vbY728mY2dJ2mA65YYNK1FR2EZFZUAkwrFnDgcYPCww=;
 b=x7ti2329haYELDIERJPt68C9Ymc6fEhOfCuzf3u2ZWfaQWqkOyiyWrSBOgx42PoENzFt
 OJgJcXFntqHgw6Y3ptJOsuR3c2s8q2Apm+ZZZl5Fo9HFz9Jg7UpOl67ud4A6h/kqskMW
 jALl1PEfYueNbSw6nEjuhT433e1jpTdMxIjK7Bj4nHCQvx+uAr0xCs4yx2GQztBE58kf
 ByfOaLlxSo/2X6WkpoUGvKH3OrjRfrQwCCfP3yN1uYSNQwE6RtiwBI6rSaP6c8UqP7M0
 XK3QwbwCbwz5PQLDzceRyw1MUiUP5GR9R+ZZlpdoUEwEwJPACcsQrtKMUVOZRjjGA5qy pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfemag42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:28:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HRS4q077907;
        Wed, 3 Jun 2020 17:28:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31c12r6v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:28:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053HS7N3031977;
        Wed, 3 Jun 2020 17:28:07 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:28:07 -0700
Subject: Re: [PATCH 2/2] mm: hugetlb: fix the name of hugetlb CMA
To:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org
Cc:     guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
 <20200603084025.62740-3-song.bao.hua@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1027f43d-b756-7dca-e409-430b189947ca@oracle.com>
Date:   Wed, 3 Jun 2020 10:28:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603084025.62740-3-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 1:40 AM, Barry Song wrote:
> once we enable CMA_DEBUGFS, we will get the below errors:
> directory 'cma-hugetlb' with parent 'cma' already present
> 
> only the first numa node will get a directory in debugfs.
> we should have different names for different CMA areas.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Thank you

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

--
Mike Kravetz

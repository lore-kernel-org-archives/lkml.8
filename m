Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F87C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F45E207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuM35CN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBTAHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:07:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48678 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBTAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:07:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K04BQT194613;
        Thu, 20 Feb 2020 00:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3aT7epndnvHOqxfRhKxEGkq1oPJFl97KJ9zSmkPfAGI=;
 b=VuM35CN9btm1xWOt5CyZnr6lyZBvCWi8B26oHpcT0aJAMPC5hYY94SGZ+ojmod41gLsK
 L/B1vBC/TaKiY0o1/TUUW9VDjbrnbZtz2ymx7M/N+O7BaOckY1US6/4kfHn/9ZQp7aAV
 HNeqnPubR6HgUN6G/ZDWO3X9Er3j2lnQJpBpF8L3T3BQecKV9Oea5VghtKSS5mmzxacS
 B01FgInrXptM+Lx3vtG/6JhcORzLA9Lst5ULjuY4oRtH4TlWPSxs6uILxvuN3MOGixu7
 cN+AKZiY3DGPyhrzPQ9PvBump/U7MJcdwLkU/xuLnHU31n5soeDpA1eNxq8W9h2RrjE4 EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud16h7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 00:07:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K02SNm181708;
        Thu, 20 Feb 2020 00:07:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y8ud8pbrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 00:07:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01K07HtU002816;
        Thu, 20 Feb 2020 00:07:18 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 16:07:17 -0800
Subject: Re: [PATCH] hugetlb: Remove check_coalesce_bug debug code
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cb402ae6-8424-c1f7-35ff-6acc68f9a23b@oracle.com>
 <20200219233610.13808-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a0d7b8e1-cb43-3b43-68c3-55631f2ce199@oracle.com>
Date:   Wed, 19 Feb 2020 16:07:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219233610.13808-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 3:36 PM, Mina Almasry wrote:
> Commit b5f16a533ce8a ("hugetlb: support file_region coalescing
> again") made changes to the resv_map code which are hard to test, it
> so added debug code guarded by CONFIG_DEBUG_VM which conducts an
> expensive operation that loops over the resv_map and checks it for
> errors.
> 
> Unfortunately, some distros have CONFIG_DEBUG_VM on in their default
> kernels, and we don't want this debug code behind CONFIG_DEBUG_VM
> and called each time a file region is added. This patch removes this
> debug code. I may look into making it a test or leave it for my local
> testing.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: David Rientjes <rientjes@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Fixes: b5f16a533ce8a ("hugetlb: support file_region coalescing again")

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

The review also applies to the original patch with the removal of
this code.
-- 
Mike Kravetz

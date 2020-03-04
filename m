Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56446C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F87B20661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldXQ0oXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgCDCU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:20:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45970 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgCDCUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:20:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0242EQs6115587;
        Wed, 4 Mar 2020 02:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eFV22HHbaKS3x4oCXdEGLU9J7x32IJMaz4nLH/50CKY=;
 b=ldXQ0oXseOkrVwoFUqOm38qMWTBNGcWWvh1F5sNpQ/9VXKfzyuaKPuEnE6NpzPNL5MUt
 gCRnGpdiFuXh19j6Wrlpf9lLf8wkUgl7iqfwPa3r7gUU+npDIe5pMpxZ7JOLJw8xR/pF
 efoBZrVcwrWXL0F4r14ztKzPihyzNs73fy1d+15QYs1ccat7AiP54zZdbgigGizJEKv9
 RL035gIDa3TtdTKXsj7JZIUQW5CSYlp/3oOutDAG4NZwh7Q7MrSg0Fp/n8MpitKiUg/u
 UKT0OdL3gRymmdFGd70dm7t56dTDgrpVRCmmxFASBkiA81XexJ1s7XnjqEs0JhdUunoK lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqu8w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 02:20:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0242IUDI155317;
        Wed, 4 Mar 2020 02:20:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1p624wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 02:20:49 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0242Kn0h000787;
        Wed, 4 Mar 2020 02:20:49 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 18:20:48 -0800
Subject: Re: [PATCH] mm/hugetlb.c: Clean code by removing unnecessary
 initialization
To:     mateusznosek0@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
References: <20200303212354.25226-1-mateusznosek0@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <87d405de-d73b-9ba9-1644-c2222881ed98@oracle.com>
Date:   Tue, 3 Mar 2020 18:20:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303212354.25226-1-mateusznosek0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 1:23 PM, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously variable 'check_addr' was initialized,
> but was not read later before reassigning.
> So the initialization can be removed.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

Thanks, that is indeed not needed.
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e4116385a4e1..7fb31750e670 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5021,7 +5021,7 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
> -	unsigned long check_addr = *start;
> +	unsigned long check_addr;
>  
>  	if (!(vma->vm_flags & VM_MAYSHARE))
>  		return;
> 

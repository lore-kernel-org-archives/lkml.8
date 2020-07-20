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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63747C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4029120702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y/DrWO/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgGTWet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:34:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgGTWet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:34:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMMRkB021497;
        Mon, 20 Jul 2020 22:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=J1Q1jxTQ9tgAsI8azWPhhYPMvBAeaRSq3GTglc5dUP0=;
 b=Y/DrWO/wBrD9bM7MXK8XCna0gnNAFsnva0ofblAzgEH8Pl9sFLt+gmaZrUUVZ5vNMcjq
 i0N9mdZ3DfpLtgK8Nv2BmjTQzqasSQk3EppwMHU7wgix8XhMDiCQgglLyq3JlIK7VZfs
 L0bNHH4C+l480D/JwRlLKLdH3wVBfh/I/Z802bsd40NJz0S2EBqJ+av4Nq7UxKr+8mHm
 m7No1nDL6pV0w5RG+Iu2MltsXi/iT/xeK9wuJMR3Hx3HdPUvC/19PZLQ13nGlzcA3GjN
 v7EsFZR8oGazlbCr9c3BOxvc6Fe2H7sS3j5BlLlnheC6yhNH4+qZMdGV+ssQUfW23gOy AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32bs1m9n4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 22:34:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMKg8T026710;
        Mon, 20 Jul 2020 22:32:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32djyx4aup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 22:32:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KMWgo0005807;
        Mon, 20 Jul 2020 22:32:42 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 15:32:41 -0700
Subject: Re: [PATCH 1/5] mm/hugetlb.c: Fix typo of glb_reserve
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-2-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0834fb69-7cc0-8c0f-d5aa-8ed6ffe9a2e2@oracle.com>
Date:   Mon, 20 Jul 2020 15:32:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720062623.13135-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:26 PM, Baoquan He wrote:
> The local variable is for global reservation of region.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/hugetlb.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24acb3af741..191a585bb315 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3649,7 +3649,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
>  	struct resv_map *resv = vma_resv_map(vma);
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	unsigned long reserve, start, end;
> -	long gbl_reserve;
> +	long glb_reserve;

I see both 'gbl' and 'glb' being used for global in variable names.  grep will
actually return more hits for gbl than glb.  Unless there is consensus that
'glb' should be used for global, I would prefer not to make this change.

-- 
Mike Kravetz

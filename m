Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1878DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33542073B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbgEXRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:49:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387766AbgEXRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:49:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04OHV5pJ043199;
        Sun, 24 May 2020 13:49:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 316wyq7s5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 May 2020 13:49:29 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04OHePxJ063022;
        Sun, 24 May 2020 13:49:28 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 316wyq7s53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 May 2020 13:49:28 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04OHk8nh010858;
        Sun, 24 May 2020 17:49:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 316uf8h262-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 May 2020 17:49:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04OHnOCW3211544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 May 2020 17:49:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFE5152050;
        Sun, 24 May 2020 17:49:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.201.18])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4097C5204F;
        Sun, 24 May 2020 17:49:24 +0000 (GMT)
Date:   Sun, 24 May 2020 20:49:22 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     daeroro <skseofh@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock:Do not retry a range that has already been
 checked
Message-ID: <20200524174922.GB1515425@linux.ibm.com>
References: <20200524141640.GA10017@roro-Lenovo-Y520-15IKBN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524141640.GA10017@roro-Lenovo-Y520-15IKBN>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-24_06:2020-05-22,2020-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=5 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005240142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:16:40PM +0900, daeroro wrote:
> The range that has already been checked
> don't have to be checked in a second attempt.

The first attempts tries to find free memory in the interval [min_addr,
max_addr) and the second attempt does not care about min_addr and looks
for free memory in the interval [0, max_addr).

Is there a problem you see with this algorthim?

> Signed-off-by: daeroro <skseofh@naver.com>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 39aceafc57f6..6f72fae415ee 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1489,7 +1489,7 @@ static void * __init memblock_alloc_internal(
>  
>  	/* retry allocation without lower limit */
>  	if (!alloc && min_addr)
> -		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
> +		alloc = memblock_alloc_range_nid(size, align, 0, min_addr, nid,
>  						exact_nid);
>  
>  	if (!alloc)
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

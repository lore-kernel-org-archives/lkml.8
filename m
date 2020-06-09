Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B69AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDDC206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgFIOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:23:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgFIOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:23:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059E44GR047427;
        Tue, 9 Jun 2020 10:23:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jayd2qq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:23:23 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 059E4cWQ055957;
        Tue, 9 Jun 2020 10:23:23 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jayd2qp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:23:23 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059ELJeE012234;
        Tue, 9 Jun 2020 14:23:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7tgfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 14:23:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059ENIxe9437552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 14:23:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EE4811C050;
        Tue,  9 Jun 2020 14:23:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2734911C052;
        Tue,  9 Jun 2020 14:23:18 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.154.183])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Jun 2020 14:23:18 +0000 (GMT)
Date:   Tue, 9 Jun 2020 16:23:16 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v1] lib/bitmap: Convert infinite while loop to for one
Message-ID: <20200609142316.GA7558@oc3871087118.ibm.com>
References: <20200609140535.87160-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609140535.87160-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_06:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:05:35PM +0300, Andy Shevchenko wrote:
> Convert infinite while loop to for one in order to be more explicit
> in one place what we are doing with chunks.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Andrew, this can be folded to the fix
> 
>  lib/bitmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 10f8fa0497e3..03ef42fbe658 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -740,10 +740,10 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  	const char *end = strnchrnul(start, buflen, '\n') - 1;
>  	int chunks = BITS_TO_U32(nmaskbits);
>  	u32 *bitmap = (u32 *)maskp;
> -	int chunk = 0;
>  	int unset_bit;
> +	int chunk;
>  
> -	while (1) {
> +	for (chunk = 0; ; chunk++) {
>  		end = bitmap_find_region_reverse(start, end);
>  		if (start > end)
>  			break;
> @@ -758,7 +758,6 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  #endif
>  		if (IS_ERR(end))
>  			return PTR_ERR(end);
> -		chunk++;
>  	}
>  
>  	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
> -- 
> 2.27.0.rc2
> 

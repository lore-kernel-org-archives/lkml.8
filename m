Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515CC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C298C2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBZNiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:38:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726975AbgBZNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:38:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QDUMbY000906
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:38:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcngep1d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:38:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 26 Feb 2020 13:38:43 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Feb 2020 13:38:41 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01QDce0W43057544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 13:38:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F64DA404D;
        Wed, 26 Feb 2020 13:38:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68735A4040;
        Wed, 26 Feb 2020 13:38:40 +0000 (GMT)
Received: from [9.145.16.175] (unknown [9.145.16.175])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Feb 2020 13:38:40 +0000 (GMT)
Subject: Re: [PATCH] gcov: gcc_4_7: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200213152241.GA877@embeddedor>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 26 Feb 2020 14:38:40 +0100
MIME-Version: 1.0
In-Reply-To: <20200213152241.GA877@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022613-0020-0000-0000-000003ADC877
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022613-0021-0000-0000-00002205E372
Message-Id: <47b4c6e3-db25-abf4-1b7b-b85697b802c1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_04:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=786
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2020 16:22, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you pick this patch up?

> ---
>  kernel/gcov/gcc_4_7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index ec37563674d6..908fdf5098c3 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -68,7 +68,7 @@ struct gcov_fn_info {
>  	unsigned int ident;
>  	unsigned int lineno_checksum;
>  	unsigned int cfg_checksum;
> -	struct gcov_ctr_info ctrs[0];
> +	struct gcov_ctr_info ctrs[];
>  };
>  
>  /**
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany


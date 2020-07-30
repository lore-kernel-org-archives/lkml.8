Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD31C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8073E2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgG3Hfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:35:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgG3Hfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:35:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U7VrDG129127;
        Thu, 30 Jul 2020 03:35:21 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32jpw53eu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 03:35:21 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06U7VsxZ020674;
        Thu, 30 Jul 2020 07:35:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32jgvpsnkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 07:35:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06U7ZGFk56033544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 07:35:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CE9A4040;
        Thu, 30 Jul 2020 07:35:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C61ACA4057;
        Thu, 30 Jul 2020 07:35:15 +0000 (GMT)
Received: from sig-9-145-12-12.uk.ibm.com (unknown [9.145.12.12])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jul 2020 07:35:15 +0000 (GMT)
Message-ID: <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Wang Hai <wanghai38@huawei.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, colin.king@canonical.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Jul 2020 09:35:15 +0200
In-Reply-To: <20200730063602.31581-1-wanghai38@huawei.com>
References: <20200730063602.31581-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_04:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=770
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=3 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-30 at 14:36 +0800, Wang Hai wrote:
> test_unwind() misses to call kfree(bt) in an error path.
> Add the missed function call to fix it.
> 
> Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding
> results")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  arch/s390/lib/test_unwind.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/lib/test_unwind.c
> b/arch/s390/lib/test_unwind.c
> index 32b7a30b2485..b0b12b46bc57 100644
> --- a/arch/s390/lib/test_unwind.c
> +++ b/arch/s390/lib/test_unwind.c
> @@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct
> *task, struct pt_regs *regs,
>  			break;
>  		if (state.reliable && !addr) {
>  			pr_err("unwind state reliable but addr is
> 0\n");
> +			kfree(bt);
>  			return -EINVAL;
>  		}
>  		sprint_symbol(sym, addr);

Looks good to me, thanks!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>


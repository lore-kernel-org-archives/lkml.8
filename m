Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA01C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B14420729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Abn2toQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHQOlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:41:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbgHQOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:41:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HEYxiW103579;
        Mon, 17 Aug 2020 10:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=eR/szBjZg8h5VQ4Cg6ZXPhbeG0pfH9sw3a+/KivWloY=;
 b=Abn2toQF/U6FUytnQUsCXm5c5EaOcvjsFs44hDf1rwXZ2CRkMCr/52ZXs2KmnxpxzGiD
 sT7ITsNzQwDvk5uC4XuzCGf6Z2a84OkT/bhu9ZxYiKhrZ9kFVEil9ZVf4AoSt/W0z6oq
 XD/HpXqqgETgVHSlaIGK6I9NnGP32FAs2lyeTTR6+bgkAYs1U/7P40vTEM3+LB0TKtCX
 T7EJ7mUXojyyYfMrltTRwBHJYcTdlaB7HSv840a3euL2r7BXfFUZCNtcR/Oxh9aF6lYN
 68IBzBWfRRBRmRP0Ki489fEobFgNRy3cWKHKo1lynSorzMETEfGzNWkzsaqu/lrk+9lz vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y6yw44a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 10:40:56 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HEZsYX107607;
        Mon, 17 Aug 2020 10:40:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y6yw449c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 10:40:55 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HEYZtG031934;
        Mon, 17 Aug 2020 14:40:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32x7b82c6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 14:40:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HEepeY25690542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 14:40:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F4CC52050;
        Mon, 17 Aug 2020 14:40:51 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 1173452054;
        Mon, 17 Aug 2020 14:40:49 +0000 (GMT)
Date:   Mon, 17 Aug 2020 20:10:49 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] uprobes: __replace_page() avoid BUG in munlock_vma_page()
Message-ID: <20200817144049.GD32655@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_10:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=2 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008170112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [2020-08-16 13:44:25]:

> syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(),
> when called from uprobes __replace_page().  Which of many ways to fix it?
> Settled on not calling when PageCompound (since Head and Tail are equals
> in this context, PageCompound the usual check in uprobes.c, and the prior
> use of FOLL_SPLIT_PMD will have cleared PageMlocked already).
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.4+
> ---
> This one is not a 5.9-rc regression, but still good to fix.
> 
>  kernel/events/uprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
> +++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
> @@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
>  		try_to_free_swap(old_page);
>  	page_vma_mapped_walk_done(&pvmw);
> 
> -	if (vma->vm_flags & VM_LOCKED)
> +	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
>  		munlock_vma_page(old_page);
>  	put_page(old_page);
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

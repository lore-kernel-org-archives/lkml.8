Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134ABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD5F207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgFKKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:53:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbgFKKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:53:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BAZKU8087824;
        Thu, 11 Jun 2020 06:53:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kgry4mah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 06:53:37 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BApHBe005728;
        Thu, 11 Jun 2020 10:53:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s81g89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 10:53:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05BArX2q58458278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 10:53:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F04614203F;
        Thu, 11 Jun 2020 10:53:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31F0A42042;
        Thu, 11 Jun 2020 10:53:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.183.79])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jun 2020 10:53:32 +0000 (GMT)
Message-ID: <1591872811.5140.41.camel@linux.ibm.com>
Subject: Re: [LKP] [ima] 8eb613c0b8: stress-ng.icache.ops_per_sec -84.2%
 regression
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Date:   Thu, 11 Jun 2020 06:53:31 -0400
In-Reply-To: <cb6a244c-5bab-1ccc-4386-e1b1caf48eb3@linux.intel.com>
References: <20200603091150.GH12456@shao2-debian>
         <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
         <1591797185.5140.2.camel@linux.ibm.com>
         <cb6a244c-5bab-1ccc-4386-e1b1caf48eb3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_10:2020-06-10,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 15:10 +0800, Xing Zhengjun wrote:
> On 6/10/2020 9:53 PM, Mimi Zohar wrote:
>  	ucode: 0x500002c
> > 
> > Does the following change resolve it?
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index c44414a7f82e..78e1dfc8a3f2 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -426,7 +426,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> >   	int pcr;
> >   
> >   	/* Is mprotect making an mmap'ed file executable? */
> > -	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
> > +	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
> > +	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
> >   		return 0;
> >   
> >   	security_task_getsecid(current, &secid);
> > 
> Thanks. I test the change, it can resolve the regression.

Thanks!  Can I get your "Tested-by" tag?

Mimi

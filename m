Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31597C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E6A2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgFJNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:53:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgFJNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:53:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ADalrB163781;
        Wed, 10 Jun 2020 09:53:11 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31k02k9e8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 09:53:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ADpIE4016092;
        Wed, 10 Jun 2020 13:53:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 31g2s8372b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 13:53:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05ADr7W943647130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 13:53:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 416135205A;
        Wed, 10 Jun 2020 13:53:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.196.221])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2C96F52051;
        Wed, 10 Jun 2020 13:53:06 +0000 (GMT)
Message-ID: <1591797185.5140.2.camel@linux.ibm.com>
Subject: Re: [LKP] [ima] 8eb613c0b8: stress-ng.icache.ops_per_sec -84.2%
 regression
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Date:   Wed, 10 Jun 2020 09:53:05 -0400
In-Reply-To: <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
References: <20200603091150.GH12456@shao2-debian>
         <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_08:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1011 cotscore=-2147483648 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xing,

On Wed, 2020-06-10 at 11:21 +0800, Xing Zhengjun wrote:
> Hi Mimi,
> 
>      Do you have time to take a look at this? we noticed a 3.7% 
> regression of boot-time.dhcp and a 84.2% regression of 
> stress-ng.icache.ops_per_sec. Thanks.
> 
> On 6/3/2020 5:11 PM, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a 3.7% regression of boot-time.dhcp due to commit:
> > 
> > 
> > commit: 8eb613c0b8f19627ba1846dcf78bb2c85edbe8dd ("ima: verify mprotect change is consistent with mmap policy")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: stress-ng
> > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > with following parameters:
> > 
> > 	nr_threads: 100%
> > 	disk: 1HDD
> > 	testtime: 30s
> > 	class: cpu-cache
> > 	cpufreq_governor: performance
> > 	ucode: 0x500002c

Does the following change resolve it?

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c44414a7f82e..78e1dfc8a3f2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -426,7 +426,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
 	security_task_getsecid(current, &secid);


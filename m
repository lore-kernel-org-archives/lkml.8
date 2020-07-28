Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E82C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EC42070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kzz29S/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG1CpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:45:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgG1CpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:45:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S2c0eu048341;
        Tue, 28 Jul 2020 02:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kPPLZrPLpL2zp0OOWIUD7B1FEIfWL28jajNLZXNrjVw=;
 b=Kzz29S/UO/CAc1I+7uKGyDg+IpnlsJWnfpquzEyp/Y/Jw0sGJv86Nrd9A1GXwkeiIdbu
 hZNgdun0Fmc7AFgVcTdYU70ULObXr4VMtMwPa4t98zaQT6GRve91fa0deqgyK6BwZGh3
 itFBeRZnAzANJVkXM7pMkQxlBh7Zrg2M6tCDqBiWDioAtk4UuH9w1ArxIiWIwEfATMVP
 HOqG2BGjieQgPoQ8vd/vB+bnu0oTdQEJqJXDmbXVf70O36XUbdhyXck2FHaRxunDgzPu
 X9/BaCsSZTFgUVarlUxCM8eFcte2kLV/Uq430BH45bBsgzfDkhRcRIsMs8ArhaHyYTJZ MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1j4tma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 02:45:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S2cXec172776;
        Tue, 28 Jul 2020 02:43:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32hu5s2wd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 02:43:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06S2h1X5025746;
        Tue, 28 Jul 2020 02:43:01 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 19:43:01 -0700
Subject: Re: [PATCH v3] mm/hugetlb: add mempolicy check in the reservation
 routine
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, rientjes@google.com, mgorman@suse.de,
        walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
References: <20200725080749.70470-1-songmuchun@bytedance.com>
 <20200727171953.443afb897bb88261facf5512@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <833be473-a065-4402-f369-f946b6f4e312@oracle.com>
Date:   Mon, 27 Jul 2020 19:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727171953.443afb897bb88261facf5512@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=2 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=2 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 5:19 PM, Andrew Morton wrote:
> On Sat, 25 Jul 2020 16:07:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
>> In the reservation routine, we only check whether the cpuset meets
>> the memory allocation requirements. But we ignore the mempolicy of
>> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
>> memory allocation may fail due to mempolicy restrictions and receives
>> the SIGBUS signal. This can be reproduced by the follow steps.
>>
>>  1) Compile the test case.
>>     cd tools/testing/selftests/vm/
>>     gcc map_hugetlb.c -o map_hugetlb
>>
>>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
>>     system. Each node will pre-allocate one huge page.
>>     echo 2 > /proc/sys/vm/nr_hugepages
>>
>>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
>>     numactl --membind=0 ./map_hugetlb 4
>>
>> With this patch applied, the mmap will fail in the step 3) and throw
>> "mmap: Cannot allocate memory".
> 
> This doesn't compile with CONFIG_NUMA=n - ther eis no implementation of
> get_task_policy().
> 
> I think it needs more than a simple build fix - can we please rework
> the patch so that its impact (mainly code size) on non-NUMA machines is
> minimized?

I'll let Muchun see if there is a more elegant fix.  However, a relatively
simple build fix such as:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8069ca47c18c..4bfbddfee0d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3455,12 +3455,14 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
 	unsigned int nr = 0;
-	struct mempolicy *mpol = get_task_policy(current);
-	nodemask_t *mpol_allowed;
+	nodemask_t *mpol_allowed = NULL;
 	unsigned int *array = h->free_huge_pages_node;
+#ifdef CONFIG_NUMA
+	struct mempolicy *mpol = get_task_policy(current);
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 
 	mpol_allowed = policy_nodemask(gfp_mask, mpol);
+#endif
 
 	for_each_node_mask(node, cpuset_current_mems_allowed) {
 		if (!mpol_allowed ||


Does not have much of an impact on code size.  Here are the non-numa
versions of the routine before Muchun's patch and after.

Dump of assembler code for function cpuset_mems_nr:
   0xffffffff8126a3a0 <+0>:	callq  0xffffffff81060f80 <__fentry__>
   0xffffffff8126a3a5 <+5>:	xor    %eax,%eax
   0xffffffff8126a3a7 <+7>:	mov    %gs:0x17bc0,%rdx
   0xffffffff8126a3b0 <+16>:	testb  $0x1,0x778(%rdx)
   0xffffffff8126a3b7 <+23>:	jne    0xffffffff8126a3ba <cpuset_mems_nr+26>
   0xffffffff8126a3b9 <+25>:	retq   
   0xffffffff8126a3ba <+26>:	mov    (%rdi),%eax
   0xffffffff8126a3bc <+28>:	retq   
End of assembler dump.

Dump of assembler code for function allowed_mems_nr:
   0xffffffff8126a3a0 <+0>:	callq  0xffffffff81060f80 <__fentry__>
   0xffffffff8126a3a5 <+5>:	xor    %eax,%eax
   0xffffffff8126a3a7 <+7>:	mov    %gs:0x17bc0,%rdx
   0xffffffff8126a3b0 <+16>:	testb  $0x1,0x778(%rdx)
   0xffffffff8126a3b7 <+23>:	jne    0xffffffff8126a3ba <allowed_mems_nr+26>
   0xffffffff8126a3b9 <+25>:	retq   
   0xffffffff8126a3ba <+26>:	mov    0x6c(%rdi),%eax
   0xffffffff8126a3bd <+29>:	retq   
End of assembler dump.

-- 
Mike Kravetz

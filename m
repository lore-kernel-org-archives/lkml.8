Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA32207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k9iDPY3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgH1Oqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:46:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH1Oqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:46:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SEe7p0085647;
        Fri, 28 Aug 2020 14:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TSfkQvlp3RoT0bcBu1bpHKHqwBLRPoFqnZTeU1aBZps=;
 b=k9iDPY3ZkGRyjC5eEQNpeCLgIzRacQor+dAaXNtYpriFIuDgeTbI1Y9hMEiMbuYIg93K
 LE1KKNv5XHdd0fObY/pWcU1V20C43N7TktVqb6Dgp8vFvdXrVbRQPIqTsw9joUgsoAK+
 MmJM5eFhrYwp6aE+4HrfjIK+FiiQAqKR0JND+1/d+lpCWMY6N/yVbINq91u1Mpv+SsOb
 WeVYEz4oXaxoQG9UgnEgJJTy3zUpQMmHD6IlpNHHqNhx8mIaQ8X9bGzjQSqo0KzoWiYu
 ln+r+pESRs+BZD1T+oRFKQ7cBYG05+kH2zbEepWOFiarAfMUvfGcT0JGeC4N8vOjvy/9 Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6uaw79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 14:46:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SEewel008297;
        Fri, 28 Aug 2020 14:46:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 333r9prjfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 14:46:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07SEkVCE008111;
        Fri, 28 Aug 2020 14:46:32 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 07:46:31 -0700
Subject: Re: [PATCH v2] mm/hugetlb: Fix a race between hugetlb sysctl handlers
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200828031146.43035-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3841cb84-9d0b-3327-16fe-e3ea45245fb5@oracle.com>
Date:   Fri, 28 Aug 2020 07:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828031146.43035-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:11 PM, Muchun Song wrote:
> There is a race between the assignment of `table->data` and write value
> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> the other thread.
> 
> CPU0:                                 CPU1:
>                                       proc_sys_write
> hugetlb_sysctl_handler                  proc_sys_call_handler
> hugetlb_sysctl_handler_common             hugetlb_sysctl_handler
>   table->data = &tmp;                       hugetlb_sysctl_handler_common
>                                               table->data = &tmp;
>     proc_doulongvec_minmax
>       do_proc_doulongvec_minmax           sysctl_head_finish
>         __do_proc_doulongvec_minmax         unuse_table
>           i = table->data;
>           *i = val;  // corrupt CPU1's stack
> 
> Fix this by duplicating the `table`, and only update the duplicate of
> it. And introduce a helper of proc_hugetlb_doulongvec_minmax() to
> simplify the code.
> 
> The following oops was seen:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     Code: Bad RIP value.
>     ...
>     Call Trace:
>      ? set_max_huge_pages+0x3da/0x4f0
>      ? alloc_pool_huge_page+0x150/0x150
>      ? proc_doulongvec_minmax+0x46/0x60
>      ? hugetlb_sysctl_handler_common+0x1c7/0x200
>      ? nr_hugepages_store+0x20/0x20
>      ? copy_fd_bitmaps+0x170/0x170
>      ? hugetlb_sysctl_handler+0x1e/0x20
>      ? proc_sys_call_handler+0x2f1/0x300
>      ? unregister_sysctl_table+0xb0/0xb0
>      ? __fd_install+0x78/0x100
>      ? proc_sys_write+0x14/0x20
>      ? __vfs_write+0x4d/0x90
>      ? vfs_write+0xef/0x240
>      ? ksys_write+0xc0/0x160
>      ? __ia32_sys_read+0x50/0x50
>      ? __close_fd+0x129/0x150
>      ? __x64_sys_write+0x43/0x50
>      ? do_syscall_64+0x6c/0x200
>      ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3976D20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hrKzx0va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHXVVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:21:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgHXVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:21:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OLJC6H023009;
        Mon, 24 Aug 2020 21:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fpRDC2bHPNF6m/pB8XIxeOQ3WPtTDRkGmvzUK9xLqGE=;
 b=hrKzx0vaQAcliZjQUlO+QnsL9u/LZuZD93HwLF6LVBoJ6ju5M0Xmv53S3WP9Y0BW4PTJ
 zbZPoreVAQOs+6zHMpxEQjsUhnC8+B90ygGBKVt4W+OQMnPZAysSSY1lN02fXbJbpUBV
 L72ZEzKz2ezbDjAqmTVE5jOWm82lbuScjRs1ryVGxwuUjrcK5RL5NLIJlFYvU/9yXeNq
 wZytV/aYpjjsqQx4G0jBrKCM8f1X1lRFCP8OMWDXuHVjmN93/+sjoOrAQJXhfeSYW23T
 eL9g3glZcf5EXpTSRbVqlISB7F5FKobngrjia7PL5X5B+0VwXYAj90DWTJYVzcv/OHae GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 333w6tnhp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 21:21:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OLAYsY146623;
        Mon, 24 Aug 2020 21:19:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 333rtx1gcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 21:19:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OLJ8Hn023370;
        Mon, 24 Aug 2020 21:19:08 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 14:19:08 -0700
Subject: Re: [PATCH] mm/hugetlb: Fix a race between hugetlb sysctl handlers
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     npiggin@suse.de, agl@us.ibm.com, ak@linux.intel.com,
        nacc@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200822095328.61306-1-songmuchun@bytedance.com>
 <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <79800508-54c9-4cda-02de-29b1a6912e75@oracle.com>
Date:   Mon, 24 Aug 2020 14:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824135924.b485e000d358cee817c4f05c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 1:59 PM, Andrew Morton wrote:
> On Sat, 22 Aug 2020 17:53:28 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
>> There is a race between the assignment of `table->data` and write value
>> to the pointer of `table->data` in the __do_proc_doulongvec_minmax().
> 
> Where does __do_proc_doulongvec_minmax() write to table->data?
> 
> I think you're saying that there is a race between the assignment of
> ctl_table->table in hugetlb_sysctl_handler_common() and the assignment
> of the same ctl_table->table in hugetlb_overcommit_handler()?
> 
> Or not, maybe I'm being thick.  Can you please describe the race more
> carefully and completely?
> 

I too am looking at this now and do not completely understand the race.
It could be that:

hugetlb_sysctl_handler_common
...
	table->data = &tmp;

and, do_proc_doulongvec_minmax()
...
	return __do_proc_doulongvec_minmax(table->data, table, write, ...
with __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, ...
...
	i = (unsigned long *) data;
	...
		*i = val;
	
So, __do_proc_doulongvec_minmax can be dereferencing and writing to the pointer
in one thread when hugetlb_sysctl_handler_common is setting it in another?

Another confusing part of the message is the stack trace which includes
...
     ? set_max_huge_pages+0x3da/0x4f0
     ? alloc_pool_huge_page+0x150/0x150

which are 'downstream' from these routines.  I don't understand why these
are in the trace.

If the race is with the pointer set and dereference/write, then this type of
fix is OK.  However, if you really have two 'sysadmin type' global operations
racing then one or both are not going to get what they expected.  Instead of
changing the code to 'handle the race', I think it might be acceptable to just
put a big semaphore around it.
-- 
Mike Kravetz

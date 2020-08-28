Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB479C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61FF20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B5HtY/oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgH1ROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:14:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH1ROY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:14:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SHBjBF128436;
        Fri, 28 Aug 2020 17:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TvpLX89fFc3G0zhH6t9biLjj5IBnJOaFWiDmP7KCHEE=;
 b=B5HtY/oFX5F6HT/AcRU63GfovsI5QlVqfk+Rf1TWaSt9aaknIjOM1R9+P6gCpWfs2Eon
 eJXnp3S7GO+rcgIFqk7c+gWshlH9IEOnqjB9ofNSPHi+ipGf9DFgACykI1PjhimZEoO3
 6NGYoS7l7/sps2fnWoohiETuAl6DXjV0OC+pHY30p9e1BlSS6QihTe9sEnzcyM/7T1aq
 EX7SS9tqaVZ/hQWi1LwhXBsjyBnrtiuOihtvqyZUaN41jthP8+RfbdMaJSB/OVNcHPWE
 axiAq0rymGg64YFJAunHfoDeK83wNhDX6sEg7RcJVWXemebfdM01KxZP14GlFL+azXwz 2g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 336ht3n65t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 17:14:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SHBXZC147699;
        Fri, 28 Aug 2020 17:14:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9ptr07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 17:14:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07SHEHq9025040;
        Fri, 28 Aug 2020 17:14:17 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 10:14:17 -0700
Subject: Re: [PATCH v2] mm/hugetlb: Fix a race between hugetlb sysctl handlers
To:     Andi Kleen <ak@linux.intel.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200828031146.43035-1-songmuchun@bytedance.com>
 <20200828145950.GS1509399@tassilo.jf.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fee0c3a6-af68-5971-1959-a66d41ea16a3@oracle.com>
Date:   Fri, 28 Aug 2020 10:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828145950.GS1509399@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 7:59 AM, Andi Kleen wrote:
>> Fixes: e5ff215941d5 ("hugetlb: multiple hstates for multiple page sizes")
> 
> I believe the Fixes line is still not correct. The original patch
> didn't have that problem. Please identify which patch added
> the problematic code.

Hi Andi,

I agree with Muchun's assessment that the issue was caused by e5ff215941d5.
Why?

Commit e5ff215941d5 changed initialization of the .data field in the
ctl_table structure for hugetlb_sysctl_handler.  This was required because
the commit introduced multiple hstates.  As a result, it can not be known
until runtime the value for .data.  This code was added to
hugetlb_sysctl_handler to set the value at runtime.

@@ -1037,8 +1109,19 @@ int hugetlb_sysctl_handler(struct ctl_table *table, int write,
                           struct file *file, void __user *buffer,
                           size_t *length, loff_t *ppos)
 {
+       struct hstate *h = &default_hstate;
+       unsigned long tmp;
+
+       if (!write)
+               tmp = h->max_huge_pages;
+
+       table->data = &tmp;
+       table->maxlen = sizeof(unsigned long);

The problem is that two threads running in parallel can modify table->data
in the global data structure without any synchronization.  Worse yet, is
that that value is local to their stacks.  That was the root cause of the
issue addressed by Muchun's patch.

Does that analysis make sense?  Or, are we missing something.
-- 
Mike Kravetz

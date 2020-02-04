Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7818C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DCE2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="miSX6bp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBDVn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:43:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgBDVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:43:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014Lc6DA177766;
        Tue, 4 Feb 2020 21:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cI83NiMZiUIDnvdb8KUxJgxBQNusH8bMD4a4D0szAf4=;
 b=miSX6bp09Hr1NgY4XkZ5xe1w7yagvQs0w65oO+jeTgqhOKuW4+tOjTlGwqsn+gc7SY09
 epW/hr4FzKwZvph7C2UsBTEdklp7LyZQHMBBe84Xb9zysLws5lhK5z02b8nn7FaQDwst
 6wBSa5Y00mlNTlq3yFDve3eLuMEISpyQG+WqOEwgO5pOzKaH+LaCYFv/DqpVxVUJwXSI
 EwEe0SL+c2DMz2Gu7pXmOYcAsHAoufXYjBsr07euAPbNu61EBScZofxQqdAUCfaVUVNr
 7YYDjxFb/+L/7CYph5bPkhstveSVib+p9xV2tTH9QCeemYmdB4od5EQL9MGpEtK/+e5D qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xwyg9nwmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 21:42:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014LdUtE119922;
        Tue, 4 Feb 2020 21:42:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xxvy3yh04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 21:42:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014LgiQP028259;
        Tue, 4 Feb 2020 21:42:45 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 13:42:44 -0800
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
Date:   Tue, 4 Feb 2020 13:42:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 12:33 PM, David Rientjes wrote:
> On Tue, 4 Feb 2020, Mike Kravetz wrote:
> 
> Hmm, if khugepaged_adjust_min_free_kbytes() increases min_free_kbytes for 
> thp, then the user has no ability to override this increase by using 
> vm.min_free_kbytes?
> 
> IIUC, with this change, it looks like memory hotplug events properly 
> increase min_free_kbytes for thp optimization but also doesn't respect a 
> previous user-defined value?

Good catch.

We should only call khugepaged_adjust_min_free_kbytes from the 'true'
block of this if statement in init_per_zone_wmark_min.

	if (new_min_free_kbytes > user_min_free_kbytes) {
		min_free_kbytes = new_min_free_kbytes;
		if (min_free_kbytes < 128)
			min_free_kbytes = 128;
		if (min_free_kbytes > 65536)
			min_free_kbytes = 65536;
	} else {
		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
				new_min_free_kbytes, user_min_free_kbytes);
	}

In the existing code, a hotplug event will cause min_free_kbytes to overwrite
the user defined value if the new value is greater.  However, you will get
the warning message if the user defined value is greater.  I am not sure if
this is the 'desired/expected' behavior?  We print a warning if the user value
takes precedence over our calculated value.  However, we do not print a message
if we overwrite the user defined value.  That doesn't seem right!

> So it looks like this is fixing an obvious correctness issue but also now 
> requires users to rewrite the sysctl if they want to decrease the min 
> watermark.

Moving the call to khugepaged_adjust_min_free_kbytes as described above
would avoid the THP adjustment unless we were going to overwrite the
user defined value.  Now, I am not sure overwriting the user defined value
as is done today is actually the correct thing to do.

Thoughts?
Perhaps we should never overwrite a user defined value?
-- 
Mike Kravetz

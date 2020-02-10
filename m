Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E079C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11F720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcqt5M6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBJS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:58:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBJS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:58:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AIr6ON050048;
        Mon, 10 Feb 2020 18:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wFgDz4N6HWtjN6jyjTPks3bbgtJyNVrIk8Z3sBNbVBc=;
 b=fcqt5M6noodBnOuPGFEJTZbnEFrLGIKpz+wS+uc60cxgEMn4xEwVWPq6pmVRkFG7HuKt
 26SYjcUQQ2jkTGAqkPcWo8BIcAN5Luj6QT8q5s53VwxCYEqoGoBR/Ie5Z44ZHvCFpJHQ
 1907YiDkYmuImKAQ/ezOGOnROImBT112+VlUXOjlB/WOE91rp+YebODgltvKmN3K27VB
 mPUihBJ0urDvSo4H63VEZYjBfNehbF2w6yN4KsGRsCNePeFsiGl2t01uWi9btfu6zgxD
 cDzwVQrXcG5twWGzEbA/JhkGW5KMH0Xifbvps+nbQg2rOtld5gLbYEUo+FFJ9ScA1Ucm Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3s6fax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 18:58:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01AIw6NZ026611;
        Mon, 10 Feb 2020 18:58:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y26htg2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 18:58:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01AIw2p3018584;
        Mon, 10 Feb 2020 18:58:02 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 10:58:02 -0800
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
 <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
 <20200204215319.GO8731@bombadil.infradead.org>
 <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
 <2ba63021-d05c-a648-f280-6c751e01adf6@oracle.com>
 <20200206203945.GZ8731@bombadil.infradead.org>
 <5e7800f2-3df3-a597-c164-5537b7f66417@oracle.com>
 <20200206213255.GC8731@bombadil.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b18a50de-9229-9cbe-3e78-9e0c92edc5f1@oracle.com>
Date:   Mon, 10 Feb 2020 10:58:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206213255.GC8731@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=2 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 1:32 PM, Matthew Wilcox wrote:
> On Thu, Feb 06, 2020 at 01:23:21PM -0800, Mike Kravetz wrote:
>> On 2/6/20 12:39 PM, Matthew Wilcox wrote:
>>> On Wed, Feb 05, 2020 at 05:36:44PM -0800, Mike Kravetz wrote:
>>>> The value of min_free_kbytes is calculated in two routines:
>>>> 1) init_per_zone_wmark_min based on available memory
>>>> 2) set_recommended_min_free_kbytes may reserve extra space for
>>>>    THP allocations
>>>>
>>>> In both of these routines, a user defined min_free_kbytes value will
>>>> be overwritten if the value calculated in the code is larger. No message
>>>> is logged if the user value is overwritten.
>>>>
>>>> Change code to never overwrite user defined value.  However, do log a
>>>> message (once per value) showing the value calculated in code.
>>>
>>> But what if the user set min_free_kbytes to, say, half of system memory,
>>> and then hot-unplugs three quarters of their memory?  I think the kernel
>>> should protect itself against such foolishness.
>>
>> I'm not sure what we should set it to in this case.  Previously you said,
>>
>>>> I'm reluctant to suggest we do a more complex adjustment of the value
>>>> (eg figure out what the adjustment would have been, then apply some
>>>> fraction of that adjustment to keep the ratios in proportion) because
>>>> we don't really know why they adjusted it.
>>
>> So, I suspect you would suggest setting it to the default computed value?
>> But then, when do we start adjusting?  What if they only remove a small
>> amount of memory?  And, then add the same amount back in?
> 
> I don't know about the default computed value ... we don't seem to have
> any protection against the user setting min_free_kbytes to double the
> amount of memory in the machine today.  Which would presumably cause
> problems if I asked to maintain 32GB free at all times on my 16GB laptop?
> 
> Maybe we should have such protection?

I am not going to attempt to define parameters for user defined values
of min_free_kbytes.  Someone smarter than me can take that on.  Documentation
is pretty clear that user is allowed to do bad things which will immediately
cause them problems.

I'm going to explicitly send out the v2 version of patch.  It is not something
I feel strongly about.  Just an attempt to clean up some inconsistencies
observed while looking at something else.
-- 
Mike Kravetz

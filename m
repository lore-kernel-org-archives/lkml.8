Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F3AC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A02920838
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f9yPcb7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBKAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:04:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgBKAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:04:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B02PPY102417;
        Tue, 11 Feb 2020 00:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6hRV+oc+Bf7KmfRTgGYMolEJVUABCzAUgVO168ZiNQc=;
 b=f9yPcb7ctgY4PSRrO2pbnhVrwr4VMW62v0VEJgJMAgPtTwX6W8YwLxabLhM4n3Fk4Shm
 FyJcABSmFIUiUUic1WuzBRzLvpTvldvtC4uGQ2kg7Dp5VHoeaBZXfGzYNgFQ3ipR0cRN
 0wnQ1dDohWukUlop6koRamqGZEUJSlUdy3zymxCxsqarcQ+dRtxY5GQnrNEBXS9UIVxW
 FBBLFyMYAGb4KgktM7zBQfs4jsdKgAGMIWv0ACSDSIDsVQfkOh90Ua4p/7egfE74bAok
 m1fRbqm68M3a5Yi+i1IAZfSzLeSlGVLsnnOBCoWmSySWAOcA3Hv9jkoAweiwcb/MTT0E 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y2k88042y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 00:04:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B02hAQ056698;
        Tue, 11 Feb 2020 00:02:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y26q077wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 00:02:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01B02Nv6023038;
        Tue, 11 Feb 2020 00:02:24 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 16:02:23 -0800
Subject: Re: [PATCH v2] mm: Don't overwrite user min_free_kbytes, consider THP
 when adjusting
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20200210190121.10670-1-mike.kravetz@oracle.com>
 <20200210141903.413880202fa3e858e27272fd@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <834af4ca-5e3d-f034-fa48-f8672b75a9f2@oracle.com>
Date:   Mon, 10 Feb 2020 16:02:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210141903.413880202fa3e858e27272fd@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=2 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=2 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 2:19 PM, Andrew Morton wrote:
> On Mon, 10 Feb 2020 11:01:21 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> The value of min_free_kbytes is calculated in two routines:
>> 1) init_per_zone_wmark_min based on available memory
>> 2) set_recommended_min_free_kbytes may reserve extra space for
>>    THP allocations
>>
>> In both of these routines, a user defined min_free_kbytes value will
>> be overwritten if the value calculated in the code is larger. No message
>> is logged if the user value is overwritten.
> 
> Could we provide a detailed description of why this is considered to be
> a problem?  This is fairly easily guessable, but is there a real
> in-field bad user experience we can point at?

I do not have an example of a bad user experience.  This observation came
about when I was modifying min_free_kbytes while working on some other
issue.  To me, it seems like the current behavior is not what one would
expect.  Logging messages when we do not overwrite the user value and not
logging anything when we do seems a bit backward.

Changing this is not important to me.  It has been like this for quite some
time and I am not aware of any user complaints/issues.

>> Change code to never overwrite user defined value.  However, do log a
>> message (once per value) showing the value calculated in code.
>>
>> At system initialization time, both init_per_zone_wmark_min and
>> set_recommended_min_free_kbytes are called to set the initial value
>> for min_free_kbytes.  When memory is offlined or onlined, min_free_kbytes
>> is recalculated and adjusted based on the amount of memory.  However,
>> the adjustment for THP is not considered.  Here is an example from a 2
>> node system with 8GB of memory.
>>
>>  # cat /proc/sys/vm/min_free_kbytes
>>  90112
>>  # echo 0 > /sys/devices/system/node/node1/memory56/online
>>  # cat /proc/sys/vm/min_free_kbytes
>>  11243
>>  # echo 1 > /sys/devices/system/node/node1/memory56/online
>>  # cat /proc/sys/vm/min_free_kbytes
>>  11412
>>
>> One would expect that min_free_kbytes would return to it's original
>> value after the offline/online operations.
>>
>> Create a simple interface for THP/khugepaged based adjustment and
>> call this whenever min_free_kbytes is adjusted.
>>
>> ...
>>
>>  include/linux/khugepaged.h |  5 ++++
>>  mm/internal.h              |  2 ++
>>  mm/khugepaged.c            | 56 ++++++++++++++++++++++++++++++++------
>>  mm/page_alloc.c            | 35 ++++++++++++++++--------
> 
> min_free_kbytes gets a few mentions in Documentation/.  Should we make
> the appropriate updates there to bring this behavior to people's
> attention?

I'm happy to update the documentation to match current behavior.  Changing
the documentation may prompt people to ask if we should change the code. :)
-- 
Mike Kravetz

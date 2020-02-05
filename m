Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69AC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E621321582
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jPuuL8HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBEAfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:35:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37676 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:35:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0150XHhc108952;
        Wed, 5 Feb 2020 00:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kGOQ7NHx5iGyKYpiBgXur9/H4UicNxrTxCUlBQ+Qh6M=;
 b=jPuuL8HZrmAKrURhg44aIRjLWSTWAqBdNgn9vwUDRORuyBShty7i6//C53vdJ127l9Zh
 sx/CUEvnF4PcRt6xXROKLLs5t1ARlDaK6n7afxud/CW8AZcM46/dxWI1tEJ4GqoMzQts
 ty1G1LhaeqrXFF4Sg09FCla+ZHu8MOdFVVSiRaTiFA2eLBU0YwpqIv3KARnR1LhjMN26
 4S56Ey+P5ww3cEFL+SvtbuSEUGiBC/KQTVP+10+K5eV36jnqDHDTzUxsDmcs6SYEMK1f
 aW3g+Amrp6UiT5cdA7QSGmxHZ7DCeY2yrL0vqfYII2EiPjuf6is/MQq8s2rIZwUTgLXA kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xyhkf8b2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 00:34:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0150YcUp115308;
        Wed, 5 Feb 2020 00:34:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xyhmqxv67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 00:34:42 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0150XT2S005360;
        Wed, 5 Feb 2020 00:33:29 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 16:33:28 -0800
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
Date:   Tue, 4 Feb 2020 16:33:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204215319.GO8731@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2001150001 definitions=main-2002050001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-2001150001
 definitions=main-2002050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 1:53 PM, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 01:42:43PM -0800, Mike Kravetz wrote:
>> On 2/4/20 12:33 PM, David Rientjes wrote:
>>> On Tue, 4 Feb 2020, Mike Kravetz wrote:
>>>
>>> Hmm, if khugepaged_adjust_min_free_kbytes() increases min_free_kbytes for 
>>> thp, then the user has no ability to override this increase by using 
>>> vm.min_free_kbytes?
>>>
>>> IIUC, with this change, it looks like memory hotplug events properly 
>>> increase min_free_kbytes for thp optimization but also doesn't respect a 
>>> previous user-defined value?
>>
>> Good catch.
>>
>> We should only call khugepaged_adjust_min_free_kbytes from the 'true'
>> block of this if statement in init_per_zone_wmark_min.
>>
>> 	if (new_min_free_kbytes > user_min_free_kbytes) {
>> 		min_free_kbytes = new_min_free_kbytes;
>> 		if (min_free_kbytes < 128)
>> 			min_free_kbytes = 128;
>> 		if (min_free_kbytes > 65536)
>> 			min_free_kbytes = 65536;
>> 	} else {
>> 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>> 				new_min_free_kbytes, user_min_free_kbytes);
>> 	}
>>
>> In the existing code, a hotplug event will cause min_free_kbytes to overwrite
>> the user defined value if the new value is greater.  However, you will get
>> the warning message if the user defined value is greater.  I am not sure if
>> this is the 'desired/expected' behavior?  We print a warning if the user value
>> takes precedence over our calculated value.  However, we do not print a message
>> if we overwrite the user defined value.  That doesn't seem right!
>>
>>> So it looks like this is fixing an obvious correctness issue but also now 
>>> requires users to rewrite the sysctl if they want to decrease the min 
>>> watermark.
>>
>> Moving the call to khugepaged_adjust_min_free_kbytes as described above
>> would avoid the THP adjustment unless we were going to overwrite the
>> user defined value.  Now, I am not sure overwriting the user defined value
>> as is done today is actually the correct thing to do.
>>
>> Thoughts?
>> Perhaps we should never overwrite a user defined value?
> 
> We should certainly warn if we would have adjusted it, had they not
> changed it!

Ok, the code above does that today.

> I'm reluctant to suggest we do a more complex adjustment of the value
> (eg figure out what the adjustment would have been, then apply some
> fraction of that adjustment to keep the ratios in proportion) because
> we don't really know why they adjusted it.

Agree!

> OTOH, we should adjust it if the user-set min_free_kbytes is now too
> large for the amount of memory now in the machine.

Today, we never overwrite a user defined value that is larger than
that calculated by the code.  However, we will owerwrite a user defined
value if the code calculates a larger value.

I'm starting to think the best option is to NEVER overwrite a user defined
value.
-- 
Mike Kravetz

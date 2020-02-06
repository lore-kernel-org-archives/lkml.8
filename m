Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CAAC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F4A21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vnWWkmhO";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZK2Hhho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:23:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:23:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016LDpgE072659;
        Thu, 6 Feb 2020 21:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kXyLuuTleweR3Q/RmMl5/NXxybMm5CpUL6rc5MySJP0=;
 b=vnWWkmhOC5vbaFQmrkz7V5SBUm2MCpNRmvjcyB5YFrM33iaywU74Rwh3MZNhiyGmnBaj
 D7GSs2xOWNi77iePl+WdB47ABU5QbHOC0mS7KeQ+QkdoYsSAYR+mbGcqbugacAKLaHu1
 MAdZGpADPFE1Kbquiitw/GvpdYeAlxfvIwoDjr8D4WqIuK65ABQ5V+Kf+BuCxAHJ6Ytw
 xE2gCRJBgn2cUPQly9YSPMqf73/9JUMkJbKPzFxNWhtkylhsdoUGws4Hybxbf1h3rpJL
 n0Fkp8jruGvcwegvcA97retoMDiAaKZFhYo9K/SQc3ukS8gygRjyKf+UIGxkEiA+lGX0 +w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kXyLuuTleweR3Q/RmMl5/NXxybMm5CpUL6rc5MySJP0=;
 b=BZK2HhhofdilbiCS5ZWmoSRs+Vg8BHQHGzYtsT2Jpcg/Jc3+qAUL6Wn7KUuxvtXYCf0p
 c6J918VJthgxOo9g6uiqcZI5LgywfXhH5v0KMvta+q0sBOhsz0OlutAqT4s9riIT1wDu
 GpP0UOhLmBa/FRpJjn++o1L63pcoG3UexdKnC8PcVzgmaYVRO5eJaVgJztZxM7ytgPtI
 XY44PfT49S+mvfv4wkCHn26xfo6UmPwSe4ZjZMlECuCRnUFkxxZgg9JIFCw2CGRFPyXa
 B5fouoPC0Z5HgUlz7jV2A3PuyM1UBmK0b76LLweSUhgdLYoSV+wXkxD+MFIEwF0YdW53 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xykbpcfmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 21:23:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016LDnGj015840;
        Thu, 6 Feb 2020 21:23:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y0mnkjkp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 21:23:27 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016LNNSc028362;
        Thu, 6 Feb 2020 21:23:23 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 13:23:22 -0800
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5e7800f2-3df3-a597-c164-5537b7f66417@oracle.com>
Date:   Thu, 6 Feb 2020 13:23:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206203945.GZ8731@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 12:39 PM, Matthew Wilcox wrote:
> On Wed, Feb 05, 2020 at 05:36:44PM -0800, Mike Kravetz wrote:
>> The value of min_free_kbytes is calculated in two routines:
>> 1) init_per_zone_wmark_min based on available memory
>> 2) set_recommended_min_free_kbytes may reserve extra space for
>>    THP allocations
>>
>> In both of these routines, a user defined min_free_kbytes value will
>> be overwritten if the value calculated in the code is larger. No message
>> is logged if the user value is overwritten.
>>
>> Change code to never overwrite user defined value.  However, do log a
>> message (once per value) showing the value calculated in code.
> 
> But what if the user set min_free_kbytes to, say, half of system memory,
> and then hot-unplugs three quarters of their memory?  I think the kernel
> should protect itself against such foolishness.

I'm not sure what we should set it to in this case.  Previously you said,

>> I'm reluctant to suggest we do a more complex adjustment of the value
>> (eg figure out what the adjustment would have been, then apply some
>> fraction of that adjustment to keep the ratios in proportion) because
>> we don't really know why they adjusted it.

So, I suspect you would suggest setting it to the default computed value?
But then, when do we start adjusting?  What if they only remove a small
amount of memory?  And, then add the same amount back in?

BTW - In the above scenario existing code would not change min_free_kbytes
because the user defined value is greater than value computed in code.
-- 
Mike Kravetz

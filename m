Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA63CC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0920873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4hdOJNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCISCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:02:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCISCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:02:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029HqQnY029082;
        Mon, 9 Mar 2020 18:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=i+I7FtDi+geKjajTcMa1VMyYQqYJpGmwL1EGuhTiZkY=;
 b=V4hdOJNCKk1DazVE+8MHAIsHwSDACLLknRCYefsHsRTQWQLIvfwfD0F9V/7SpYGte+bT
 sPYXUUx7KfMX3ZD1QgWQQ6qeXtbKJXpHUN7DKFnPwaHM7vWsDOCI7jU1gwZRRDe7YngT
 RtjdsL8czpUM4oLUpeKMHfTHCksD3UBtoxk5Y6KlMiLpGFDxFOLEcD0R9e9w+hjgZsN8
 KfaENlvPBd2E8wlVg3pVi5HyUkszqp/rqMWs7PlOHSPYKLj+0wFgA+GDYFxC1n50EaTD
 iwi7mY33tA7UVt8IYQuk8zPd/SmjizC63e+nm//MvNJvwYebG2PKkSjrhsMJozerfkOz Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ym3jqgq6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 18:02:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Hxlfm090751;
        Mon, 9 Mar 2020 18:02:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ymun77ha0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 18:02:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029I1wcg016709;
        Mon, 9 Mar 2020 18:01:58 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 11:01:58 -0700
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
To:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, x86@kernel.org
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box> <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309113658.bctbw35e73ahhgbu@box> <20200309122646.GM8447@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2c309d66-60bb-fcfe-97f5-0828a88ead56@oracle.com>
Date:   Mon, 9 Mar 2020 11:01:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309122646.GM8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/20 5:26 AM, Michal Hocko wrote:
> On Mon 09-03-20 14:36:58, Kirill A. Shutemov wrote:
>> On Mon, Mar 09, 2020 at 10:06:30AM +0100, Michal Hocko wrote:
>>> On Mon 09-03-20 03:08:20, Kirill A. Shutemov wrote:
>>>> On Fri, Mar 06, 2020 at 05:03:53PM -0800, Cannon Matthews wrote:
>>>>> Reimplement clear_gigantic_page() to clear gigabytes pages using the
>>>>> non-temporal streaming store instructions that bypass the cache
>>>>> (movnti), since an entire 1GiB region will not fit in the cache anyway.
>>>>>
>>> Gigantic huge pages are a bit different. They are much less dynamic from
>>> the usage POV in my experience. Micro-optimizations for the first access
>>> tends to not matter at all as it is usually pre-allocation scenario.
>>
>> The page got cleared not on reservation, but on allocation, including page
>> fault time. Keeping the page around the fault address can still be
>> beneficial.
> 
> You are right of course. What I meant to say that GB pages backed
> workloads I have seen tend to pre-allocate during the startup so they do
> not realy on lazy initialization duing #PF. This is slightly easier to
> handle for resource that is essentially impossible to get on-demand so
> an early failure is easier to handle.
> 
> If there are workloads which can benefit from page fault
> microptimizations then all good but this can be done on top and
> demonstrate by numbers. It is much more easier to demonstrate the speed
> up on pre-initialization workloads. That's all I wanted to say here.

I tend to agree that use of GB pages is generally going to be in workloads
that will do a one time setup/allocation/initialization of all the pages
it will use.  These improvements will help most in those workloads.

Workloads which include random faults should still benefit.  And, yes
the code could be made even better by taking the faulting address into
account.

I would be happy to see this go forward after addressing the few nits
mentioned by Andrew.  However, I myself can not comment with authority
on the low level x86 specific code.
-- 
Mike Kravetz

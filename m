Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55838C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3014A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2a8qvoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgEKSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:50:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbgEKSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:50:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BIlBYe194121;
        Mon, 11 May 2020 18:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ho+TJR2bHaPVB8fdDxH9KqcgGiIrAX/QH02McijZ/ds=;
 b=a2a8qvoMPfVMSLmB0YJ6hFMDqWoDYjuqArTQZext/iDa3bH9/RXn19l8t5tAENpHqLhP
 f1LvntTjpS/FoDx/Uy/Q8ZmPz4qtSeqfuJXwz1gTbukerLPhiSnwQOBor1cDLinfU3pU
 yLe7xKuy8yDk7w3KagRt9/b6fNprh7xwla+lqTtEHZkrm8XvHqcoJeUs4cCj9JSRaE2r
 bxq6V2mN8e6hwm8ZNYDlw6W9JvY2im2UEgBiIPVrYWQsiYZt6XG3zU5AYXCGIryoRBwv
 z2NFG6dhYHbb4kT3xyGle/qxKiwB7JV3WYm/EpfLUEt8WQq6XgQX5UzHRzajdSJkZeBC Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30x3mbpvb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 18:49:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BIltAg134470;
        Mon, 11 May 2020 18:49:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30x6ewjsrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 18:49:55 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BInsUM023494;
        Mon, 11 May 2020 18:49:54 GMT
Received: from [192.168.2.157] (/73.164.160.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 11:49:54 -0700
Subject: Re: [PATCH V3 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
 <1588907271-11920-2-git-send-email-anshuman.khandual@arm.com>
 <7db44202-0d21-d8fb-6998-0210508a488a@oracle.com>
 <19ffbe33-3a42-6d90-6c48-19645a898383@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7642f615-23ff-56c7-25da-f84c409449b5@oracle.com>
Date:   Mon, 11 May 2020 11:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <19ffbe33-3a42-6d90-6c48-19645a898383@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 9:02 PM, Anshuman Khandual wrote:
> On 05/09/2020 03:39 AM, Mike Kravetz wrote:
>> On 5/7/20 8:07 PM, Anshuman Khandual wrote:
>> I know you made this change in response to Will's comment.  And, since
>> changes were made to consistently use READ_ONCE in arm64 code, it makes
>> sense for that architecture.
>>
>> However, with this change to generic code, you introduce READ_ONCE to
>> other architectures where it was not used before.  Could this possibly
>> introduce inconsistencies in their use of READ_ONCE?  To be honest, I
>> am not very good at identifying any possible issues this could cause.
>> However, it does seem possible.
> 
> Could you please give some more details. Is there any particular problem
> which might be caused by this new READ_ONCE() here, that you you are
> concerned about. READ_ONCE() is already getting used in multiple places
> in core MM which can not be configured out (like mm/gup.c). It is getting
> used in core HugeTLB (mm/hugetlb.c) as well. AFAICS, there is no standard
> for using READ_ONCE() while walking page tables entries. We have examples
> in core MM for both ways.
> 
>>
>> Will was nervous about dropping this from arm64.  I'm just a little nervous
>> about adding it to other architectures.
>>
> AFAICS, __HAVE_ARCH_HUGE_PTEP_GET should be used on a platform only when
> a HugeTLB entry could not constructed by dereferencing a page table entry
> as in the case with ARM (32 bit). Using READ_ONCE() while dereferencing is
> really not a special case that will need __HAVE_ARCH_HUGE_PTEP_GET. Moving
> READ_ONCE() into generic definition solves the problem while also taking
> care of a known problem on arm64. IMHO, it seems like the right thing to
> do unless there is another problem that pops up some where else because of
> READ_ONCE().

I have no specific concerns or objection.  After thinking about it some more,
I do not see how adding the READ_ONCE could cause any issues.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

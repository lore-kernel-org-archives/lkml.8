Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F7C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA782074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KMk362xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGQRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:40:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HHXZ9q196286;
        Fri, 17 Jul 2020 17:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SVx6BH4aVrKb+YsXwH6wtgExVfzosSHE90mwJsHLmS8=;
 b=KMk362xGILyVP8H+tYkGylYZ4m71ZMJwK2gDH30ZlIvSXY/jB8GfjwaZmqhuc1N6ZCiE
 XYMFnLrM5vHs8SQiFwdQmuc7ArrNS2Pbw4ajSGVI+soiA07cuzUF8CpN5UYalBhhRWwv
 7pB4DmoQfrOXIJV4lvnP689lf3XZ6diA0FfM64qWNjsDar9jGh3Zgv6qbIrPnAPXA4Np
 FlTmKqXgBcGW3bJKr2kw2P7QvnxquHyfr4i12otQoyPEqAYo0SSlHV6nZ9ZtJIQF1whB
 rlkb53jfAzrUIz6x5PJN17obfESUTjr0vcAbccYUOSA4GnX4YBBMSz0Rod+fjiw/q86U Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275cmrjwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 17:39:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HHbn0e056821;
        Fri, 17 Jul 2020 17:37:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32bfc3u3vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 17:37:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HHbaFp031945;
        Fri, 17 Jul 2020 17:37:37 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 10:37:36 -0700
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
 <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
 <81103d30-f4fd-8807-03f9-d131da5097bd@arm.com>
 <20200717083608.GA8293@willie-the-truck>
 <921bc084-fbde-7975-d6d3-842ee22a38d7@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c2e4d47b-940b-481c-c155-a34c3e853e85@oracle.com>
Date:   Fri, 17 Jul 2020 10:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <921bc084-fbde-7975-d6d3-842ee22a38d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 spamscore=100
 adultscore=0 malwarescore=0 mlxlogscore=-1000 mlxscore=100 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=100
 impostorscore=0 malwarescore=0 mlxlogscore=-1000 clxscore=1015
 mlxscore=100 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 2:51 AM, Anshuman Khandual wrote:
> 
> 
> On 07/17/2020 02:06 PM, Will Deacon wrote:
>> On Fri, Jul 17, 2020 at 10:32:53AM +0530, Anshuman Khandual wrote:
>>>
>>>
>>> On 07/16/2020 11:55 PM, Mike Kravetz wrote:
>>>> >From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
>>>> From: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Date: Tue, 14 Jul 2020 15:54:46 -0700
>>>> Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
>>>>  hstate
>>>>
>>>> Instead of calling hugetlb_cma_reserve() directly from arch specific
>>>> code, call from hugetlb_add_hstate when adding a gigantic hstate.
>>>> hugetlb_add_hstate is either called from arch specific huge page setup,
>>>> or as the result of hugetlb command line processing.  In either case,
>>>> this is late enough in the init process that all numa memory information
>>>> should be initialized.  And, it is early enough to still use early
>>>> memory allocator.
>>>
>>> This assumes that hugetlb_add_hstate() is called from the arch code at
>>> the right point in time for the generic HugeTLB to do the required CMA
>>> reservation which is not ideal. I guess it must have been a reason why
>>> CMA reservation should always called by the platform code which knows
>>> the boot sequence timing better.
>>
>> Ha, except we've moved it around two or three times already in the last
>> month or so, so I'd say we don't have a clue when to call it in the arch
>> code.
> 
> The arch dependency is not going way with this change either. Just that
> its getting transferred to hugetlb_add_hstate() which gets called from
> arch_initcall() in every architecture.
> 
> The perfect timing here happens to be because of arch_initcall() instead.
> This is probably fine, as long as
> 
> 0. hugetlb_add_hstate() is always called at arch_initcall()

In another reply, I give reasoning why it would be safe to call even later
at hugetlb command line processing time.

> 1. N_MEMORY mask is guaranteed to be initialized at arch_initcall()

This is a bit more difficult to guarantee.  I find the init sequence hard to
understand.  Looking at the arm code, arch_initcall(hugetlbpage_init)
happens after N_MEMORY mask is setup.  I can't imagine any arch code setting
up huge pages before N_MEMORY.  But, I suppose it is possible and we would
need to somehow guarantee this.

> 2. CMA reservation is available to be called at arch_initcall()

Since I am pretty sure we can delay the reservation until hugetlb command
line processing time, it would be great if it was always done there.
Unfortunately, I can not immediately think of an easy way to do this.
-- 
Mike Kravetz

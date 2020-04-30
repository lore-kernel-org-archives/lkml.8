Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691BC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C98220774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 22:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TNJMwVu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgD3W02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:26:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1432 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgD3W01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 18:26:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eab50500000>; Thu, 30 Apr 2020 15:25:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Apr 2020 15:26:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Apr 2020 15:26:27 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 22:26:26 +0000
Received: from [10.2.50.180] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 22:26:26 +0000
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        <akpm@linux-foundation.org>, <jack@suse.cz>, <kirill@shutemov.name>
CC:     <david@redhat.com>, <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <frankja@linux.ibm.com>, <sfr@canb.auug.org.au>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <peterz@infradead.org>, <sean.j.christopherson@intel.com>
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
 <4b32c162-6ea4-ba91-b6d5-8961b7dff6e8@de.ibm.com>
 <f681d61d-c83b-1472-a52f-d5cb951676fd@de.ibm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0b7c0575-5d31-e34a-13bf-f2e67c5aa3d4@nvidia.com>
Date:   Thu, 30 Apr 2020 15:26:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f681d61d-c83b-1472-a52f-d5cb951676fd@de.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588285520; bh=PfIc0Ej9cQtaja7/GNMf6pJmEyJmx2HiNl1JcjlZMjI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TNJMwVu65tIQy0f8Eu+UM3gRKR0uy+hIEPwjoqG97gQY5yl45DX4WrNL82IpcqY/H
         UPj2px7nL/QYT3AqfyOKZ5SZ796Ylk+yKN9Tx1ujJgTNtEJvycUjJl4AR//Ja0NJpi
         yVN40wmDcT6+eZa7uWEEbCyjV0O7/Jdlz/7f+/o5nNsDUwvTxdeTWNC1SOFZKNGsXG
         TlbQwpoyR3gYnpbbjCDbO4p4cIrUmwPRh/lTkXqARO+cTp+uQOr5DGBorFtnK9sQtE
         znNkhTl7fy0k6QKtqMc8iwVpNKP/farng/97d6N2+eM5J+87lcN29eh7DVUCsb0Apj
         tWxFiFyU11sug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-30 12:54, Christian Borntraeger wrote:
> On 30.04.20 21:02, Christian Borntraeger wrote:
>> On 30.04.20 20:12, Christian Borntraeger wrote:
>>> On 29.04.20 18:07, Dave Hansen wrote:
>>>> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
>>>>> If a page is inaccesible and it is used for things like sendfile, then
>>>>> the content of the page is not always touched, and can be passed
>>>>> directly to a driver, causing issues.
>>>>>
>>>>> This patch fixes the issue by adding a call to arch_make_page_accessible
>>>>> in page_cache_pipe_buf_confirm; this fixes the issue.
>>>>
>>>> I spent about 5 minutes putting together a patch:
>>>>
>>>> 	https://sr71.net/~dave/intel/accessible.patch
>>>
>>> You only set the page flag for compound pages. that of course leaves a big pile
>>> of pages marked a not accessible, thus explaining the sendto trace and all kind
>>> of other random traces.
>>>
>>>
>>> What do you see when you also do the  SetPageAccessible(page);
>>> in the else page of prep_new_page (order == 0).
>>> (I do get > 10000 of these non compound page allocs just during boot).
>>>
>>
>> And yes, I think you are right that we should call the callback also for !FOLL_PIN.
> 


Disclaimer: I haven't dug into the details of the latest points above,
so answers below will be narrowly focused.


> 
> Thinking again about this I am no longer sure. Adding John Hubbard.
> 
> Documentation/core-api/pin_user_pages.rst says:
> -------snip----------
> Another way of thinking about these flags is as a progression of restrictions:
> FOLL_GET is for struct page manipulation, without affecting the data that the
> struct page refers to. FOLL_PIN is a *replacement* for FOLL_GET, and is for
> short term pins on pages whose data *will* get accessed. As such, FOLL_PIN is
> a "more severe" form of pinning. And finally, FOLL_LONGTERM is an even more
> restrictive case that has FOLL_PIN as a prerequisite: this is for pages that
> will be pinned longterm, and whose data will be accessed.
> -------snip----------
> 
> So John,is it ok to give a page to an I/O device where the code has used gup
> with FOLL_GET (or gup fast without pup) or would you consider this a bug?
> 

Well, it's a bug (or a bug-in-waiting): even though gup/FOLL_GET works
just as well (and as badly) as ever, pup/FOLL_PIN is required in order
to safely and correctly allow a non-CPU device to operate on a page's
data. Core mm and fs code is going to key off of page_maybe_dma_pinned()
in order to make critical decisions about writeback and umount, and
FOLL_PIN opts into that; FOLL_GET does not.

Basically, you'd be creating another set of call sites that someone
would have to convert to pup/FOLL_PIN.

btw, on the FOLL_LONGTERM documentation above: that's more of an
aspiration than a description of current behavior, in some ways.
The current FOLL_LONGTERM is a little more quirky than is implied
there.

Also on a related note, I've been slow in posting patches to implement
the remaining call site conversions, and am trying to get back to that
asap. There have been some distractions. :) Once every call site is
correctly using gup or pup, it will be easier for everyone.


thanks,
--
John Hubbard
NVIDIA

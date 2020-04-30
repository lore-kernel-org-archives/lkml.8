Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B9E20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3Rat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:30:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:3763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3Rat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:30:49 -0400
IronPort-SDR: e+XXIm3CQg5gywrw5T0anvkkUus9+sndbahOrJLocgTUkpwN9sR/By25dcqyzirOFgyzp3a7vm
 M21e9Mq9zGLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 10:30:47 -0700
IronPort-SDR: nR9A2hO335Nlc6ffJ/468OydJfaeKmgbg0HpbUFjPIOUfJvW5+jcBLPMb60l+3eNrqKDg0Qihd
 8hgjXgtg4FGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="261853654"
Received: from rariojas-mobl.amr.corp.intel.com (HELO [10.252.135.40]) ([10.252.135.40])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2020 10:30:46 -0700
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name,
        david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        Ulrich.Weigand@de.ibm.com
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
 <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
 <20200430005310.7b25efab@p-imbrenda>
 <172c51f7-7dd6-7dd0-153f-aedd4b10a9f3@intel.com>
 <20200430191942.3ae9155f@p-imbrenda>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <fb4e4e90-6694-da90-7a72-c7bc9e9c356a@intel.com>
Date:   Thu, 30 Apr 2020 10:30:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430191942.3ae9155f@p-imbrenda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 10:19 AM, Claudio Imbrenda wrote:
> On Wed, 29 Apr 2020 16:52:46 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
>> On 4/29/20 3:53 PM, Claudio Imbrenda wrote:
>>>> Actually, that's the problem.  You've gone through all these
>>>> careful checks and made the page inaccessible.  *After* that
>>>> process, how do you keep the page from being hit by an I/O device
>>>> before it's made accessible again?  My patch just assumes that
>>>> *all* pages have gone through that process and passed those
>>>> checks.  
>>> I don't understand what you are saying here.
>>>
>>> we start with all pages accessible, we mark pages as inaccessible
>>> when they are imported in the secure guest (we use the PG_arch_1
>>> bit in struct page). we then try to catch all I/O on inaccessible
>>> pages and make them accessible so that I/O devices are happy.   
>>
>> The catching mechanism is incomplete, that's all I'm saying.
> 
> well, sendto in the end does a copy_from_user or a get_user_pages_fast,
> both are covered (once we fix the make_accessible to work on FOLL_GET
> too). 

Agreed.  This is inching forward, increasing the coverage of the hooks.
 My confidence in the hooks being complete at this point is pretty low.

>> Without looking too hard, and not even having the hardware, I've found
>> two paths where the "catching" was incomplete:
>>
>> 	1. sendfile(), which you've patched
>> 	2. sendto(), which you haven't patched
>>
>>> either your quick and dirty patch was too dirty (e.g. not accounting
>>> for possible races between make_accessible/make_inaccessible), or
>>> some of the functions in the trace you provided should do
>>> pin_user_page instead of get_user_page (or both)  
>>
>> I looked in the traces for any races.  For sendto(), at least, the
>> make_accessible() never happened before the process exited.  That's
>> entirely consistent with the theory that it entirely missed being
>> caught.  I can't find any evidence that there were races.
>>
>> Go ahead and try it.  You have the patch!  I mean, I found a bug in
>> about 10 minutes in one tiny little VM.
> 
> I tried your patch, but I could not reproduce the problem. I have a
> Debian 10 x86_64 with the latest kernel from master and your patch on
> top. is there anything I'm missing? which virtual devices are you using?
> any particular .config options?

I'm using an emulated e1000 which seems to be the device that notices
problems most readily.  A snippet of the qemu command-line is:

qemu-system-x86_64 -enable-kvm -drive id=disk,file=/path,if=none -device
ahci,id=ahci -device ide-drive,drive=disk,bus=ahci.0 -net
nic,model=e1000 -net user,net=192.168.76.0/24,dhcpstart=192.168.76.44

I'm also using "-cpu host,-pcid" if that makes a difference.  It's just
a plain Skylake client system: "Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz".

> are you using transparent hugepages by any chance? the
> infrastructure for inaccessible pages is meant only for small pages,
> since on s390x only small pages can ever be used for secure
> guests and therefore become inaccessible.

Yes, THP is probably enabled and in play.  But, I did dump out
PageAnon() in some of my traces and it was never set, which rules out THP.

The fact that this infrastructure is not designed to play nicely with
large pages doesn't bode well for its use on a second architecture.

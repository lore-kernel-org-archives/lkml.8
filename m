Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB3DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C47206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgC3MZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:25:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgC3MZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B12F30E;
        Mon, 30 Mar 2020 05:25:24 -0700 (PDT)
Received: from [10.163.1.70] (unknown [10.163.1.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA27D3F68F;
        Mon, 30 Mar 2020 05:25:21 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC] mm/page_alloc: Enumerate bad page reasons
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
References: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
 <20200330084300.GC14243@dhcp22.suse.cz>
Message-ID: <689b594f-c18a-4131-8049-ac917345099b@arm.com>
Date:   Mon, 30 Mar 2020 17:55:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200330084300.GC14243@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2020 02:13 PM, Michal Hocko wrote:
> On Mon 30-03-20 12:21:37, Anshuman Khandual wrote:
>> Enumerate all existing bad page reasons which can be used in bad_page() for
>> reporting via __dump_page(). Unfortunately __dump_page() cannot be changed.
>> __dump_page() is called from dump_page() that accepts a raw string and is
>> also an exported symbol that is currently being used from various generic
>> memory functions and other drivers. This reduces code duplication while
>> reporting bad pages.
> 
> I dunno. It sounds like over engineering something that is an internal
> stuff. Besides that I consider string reasons kinda obvious and I am
> pretty sure I would have to check them for each numeric alias when want
> to read the code. Yeah, yeah, nothing really hard but still...

Right these are very much self explanatory. Would moving these aliases into
mm/page_alloc.c itself, make it any better for quicker access ?

> 
> So I am not really sure this is all worth the code churn. Besides

I understand but is not just repeating the same strings in similar functions
bit suboptimal as well.

> that I stongly suspect you wanted ...
> 
>> -static void bad_page(struct page *page, const char *reason,
>> +static void bad_page(struct page *page, int reason,
>>  		unsigned long bad_flags)
> 
> ... enum page_bad_reason reason here, right? What is the point of declaring
> an enum when you are not using it?

Sure, will replace here and other local reason variables which are 'int'.

Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3984F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgEVMui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:50:38 -0400
Received: from foss.arm.com ([217.140.110.172]:34956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgEVMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:50:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CABD55D;
        Fri, 22 May 2020 05:50:36 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6196F3F68F;
        Fri, 22 May 2020 05:50:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix W+X debug feature on x86
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200521152308.33096-1-steven.price@arm.com>
 <20200521120843.427b7ff33f8ed7f824eb07f9@linux-foundation.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <4e5eefc0-140c-e1d8-93e9-7f52deb434f9@arm.com>
Date:   Fri, 22 May 2020 13:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521120843.427b7ff33f8ed7f824eb07f9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 20:08, Andrew Morton wrote:
> On Thu, 21 May 2020 16:23:06 +0100 Steven Price <steven.price@arm.com> wrote:
> 
>> Jan alert me[1] that the W+X detection debug feature was broken in x86
>> by my change[2] to switch x86 to use the generic ptdump infrastructure.
>>
>> Fundamentally the approach of trying to move the calculation of
>> effective permissions into note_page() was broken because note_page() is
>> only called for 'leaf' entries and the effective permissions are passed
>> down via the internal nodes of the page tree. The solution I've taken
>> here is to create a new (optional) callback which is called for all
>> nodes of the page tree and therefore can calculate the effective
>> permissions.
>>
>> Secondly on some configurations (32 bit with PAE) "unsigned long" is not
>> large enough to store the table entries. The fix here is simple - let's
>> just use a u64.
> 
> I assumed that a cc:stable was appropriate on both of these(?).

Yes thanks.

>> I'd welcome testing (and other comments), especially if you have a
>> configuration which previously triggered W+X warnings as I don't have
>> such a setup.
> 
> I'll wait a while for such testing.  If nothing happens then I guess we
> merge it up and see what then happens.
> 

Thanks,

Steve

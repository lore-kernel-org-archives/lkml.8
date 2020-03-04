Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0104C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44B2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCDFw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:52:57 -0500
Received: from foss.arm.com ([217.140.110.172]:56118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDFw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:52:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08EF30E;
        Tue,  3 Mar 2020 21:52:55 -0800 (PST)
Received: from [10.163.1.88] (unknown [10.163.1.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC5B3F6CF;
        Tue,  3 Mar 2020 21:52:48 -0800 (PST)
Subject: Re: [RFC 2/3] mm/vma: Introduce VM_ACCESS_FLAGS
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Nick Hu <nickhu@andestech.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Springer <rspringer@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-3-git-send-email-anshuman.khandual@arm.com>
 <52b4565f-2dab-c3e5-ead8-d76258f43a10@suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d00c5b01-fb69-3a83-3eae-36231c5b08e9@arm.com>
Date:   Wed, 4 Mar 2020 11:22:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52b4565f-2dab-c3e5-ead8-d76258f43a10@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2020 11:18 PM, Vlastimil Babka wrote:
> On 3/2/20 7:47 AM, Anshuman Khandual wrote:
>> There are many places where all basic VMA access flags (read, write, exec)
>> are initialized or checked against as a group. One such example is during
>> page fault. Existing vma_is_accessible() wrapper already creates the notion
>> of VMA accessibility as a group access permissions. Hence lets just create
>> VM_ACCESS_FLAGS (VM_READ|VM_WRITE|VM_EXEC) which will not only reduce code
>> duplication but also extend the VMA accessibility concept in general.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Mark Salter <msalter@redhat.com>
>> Cc: Nick Hu <nickhu@andestech.com>
>> CC: Ley Foon Tan <ley.foon.tan@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Guan Xuetao <gxt@pku.edu.cn>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Rob Springer <rspringer@google.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-c6x-dev@linux-c6x.org
>> Cc: nios2-dev@lists.rocketboards.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: devel@driverdev.osuosl.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Dunno. Such mask seems ok for testing flags, but it's a bit awkward when
> initializing flags, where it covers just one of many combinations that seem
> used. But no strong opinions, patch looks correct.

Fair enough. The fact that it covers only one of the many init combinations
used at various places, is indeed a good point. The page fault handlers does
start with VMA flags mask as VM_ACCESS_FLAGS, hence will keep them and drop
other init cases here.

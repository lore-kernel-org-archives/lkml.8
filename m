Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632752074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgFPJtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:49:02 -0400
Received: from foss.arm.com ([217.140.110.172]:34568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFPJtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:49:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3001FB;
        Tue, 16 Jun 2020 02:49:00 -0700 (PDT)
Received: from [10.163.80.105] (unknown [10.163.80.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0160C3F6CF;
        Tue, 16 Jun 2020 02:48:58 -0700 (PDT)
Subject: Re: [PATCH] mm/pgtable: Move extern zero_pfn outside
 __HAVE_COLOR_ZERO_PAGE
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
 <f55dff2d-d32e-8de1-0177-e6ba713e0cd9@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <19858112-8f10-493c-9873-84f2000b00b0@arm.com>
Date:   Tue, 16 Jun 2020 15:18:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f55dff2d-d32e-8de1-0177-e6ba713e0cd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/16/2020 01:09 PM, David Hildenbrand wrote:
> On 16.06.20 06:08, Anshuman Khandual wrote:
>> zero_pfn variable is required whether __HAVE_COLOR_ZERO_PAGE is enabled
> 
> Why is that relevant for this patch?

That just states how it is organized right now wrt __HAVE_COLOR_ZERO_PAGE.

> 
>> or not. Also it should not really be declared individually in all functions
>> where it gets used. Just move the declaration outside, which also makes it
>> available for other potential users.
> 
> So, all you're essentially doing is exposing zero_pfn in pgtable.h now.

Right, but it just happens in the process of consolidating three different
instances of 'extern unsigned long zero_pfn' in the same file which are
redundant.

> 
> If everybody should just use my_zero_pfn(), I don't really see the
> benefit of this patch, sorry.

It consolidates redundant declarations and reduces code. We could just have
a comment for zero_pfn stating that it should not be used directly.

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E03CC2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgC3M2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:28:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbgC3M2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:28:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7515C30E;
        Mon, 30 Mar 2020 05:28:49 -0700 (PDT)
Received: from [10.163.1.70] (unknown [10.163.1.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914AA3F68F;
        Mon, 30 Mar 2020 05:28:46 -0700 (PDT)
Subject: Re: [RFC] mm/page_alloc: Enumerate bad page reasons
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
References: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
 <d482aa0a-db1a-a4df-e2c5-1598e0fb28ad@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8601ad7b-30dc-14db-48e3-2ceb1f52400f@arm.com>
Date:   Mon, 30 Mar 2020 17:58:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d482aa0a-db1a-a4df-e2c5-1598e0fb28ad@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2020 02:15 PM, David Hildenbrand wrote:
> On 30.03.20 08:51, Anshuman Khandual wrote:
>> Enumerate all existing bad page reasons which can be used in bad_page() for
>> reporting via __dump_page(). Unfortunately __dump_page() cannot be changed.
>> __dump_page() is called from dump_page() that accepts a raw string and is
>> also an exported symbol that is currently being used from various generic
>> memory functions and other drivers. This reduces code duplication while
>> reporting bad pages.
> 
> Yeah sounds nice, but "56 insertions(+), 20 deletions(-)" does not sound
> so nice ... and the "code duplication" is actually "repeating strings".

But repeating strings in very similar functions dealing with bad page state
is not bit suboptimal ?

> 
> ... I don't think we want/need this.
> 

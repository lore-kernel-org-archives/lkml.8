Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7811820767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 22:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406686AbgFYW3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 18:29:45 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47766 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404360AbgFYW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 18:29:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U0hvnAM_1593124180;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0hvnAM_1593124180)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jun 2020 06:29:41 +0800
Date:   Fri, 26 Jun 2020 06:29:40 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200625222940.GA16822@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
 <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
 <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 12:46:43PM -0700, Dan Williams wrote:
>On Wed, Jun 24, 2020 at 10:53 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>
>>
>> > Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:
>> >
>> > ﻿On Wed, Jun 24, 2020 at 3:44 PM Wei Yang
>> > <richard.weiyang@linux.alibaba.com> wrote:
>> > [..]
>> >>> So, you are right that there is a mismatch here, but I think the
>> >>> comprehensive fix is to allow early sections to be partially
>> >>> depopulated/repopulated rather than have section_activate() and
>> >>> section_deacticate() special case early sections. The special casing
>> >>> is problematic in retrospect as section_deactivate() can't be
>> >>> maintained without understand special rules in section_activate().
>> >>
>> >> Hmm... This means we need to adjust pfn_valid() too, which always return true
>> >> for early sections.
>> >
>> > Right, rather than carry workarounds in 3 locations, and the bug that
>> > has resulted from then getting out of sync, just teach early section
>> > mapping to allow for the subsection populate/depopulate.
>> >
>>
>> I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_online_page() will need changes as well.
>
>Agree, yes, let's do the simple fix first for 5.8 and the special-case
>elimination work later.

Ok, let me send v2 with detailed change log and a comment in code first.

Thanks all for your time.

-- 
Wei Yang
Help you, Help me

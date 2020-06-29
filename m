Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F820C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8C206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgF2W6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:58:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44774 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728318AbgF2W6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:58:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U16XY0q_1593471523;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U16XY0q_1593471523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Jun 2020 06:58:43 +0800
Date:   Tue, 30 Jun 2020 06:58:42 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200629225842.GA38617@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
 <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
 <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
 <20200629083411.GA38188@L-31X9LVDL-1304.local>
 <CAPcyv4gK2PL5YNLkeQjSCLrNZ62P1U_HjuBSNpkEvuHMcyeGOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4gK2PL5YNLkeQjSCLrNZ62P1U_HjuBSNpkEvuHMcyeGOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 03:13:25PM -0700, Dan Williams wrote:
>On Mon, Jun 29, 2020 at 1:34 AM Wei Yang
><richard.weiyang@linux.alibaba.com> wrote:
>>
>> On Thu, Jun 25, 2020 at 12:46:43PM -0700, Dan Williams wrote:
>> >On Wed, Jun 24, 2020 at 10:53 PM David Hildenbrand <david@redhat.com> wrote:
>> >>
>> >>
>> >>
>> >> > Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:
>> >> >
>> >> > ﻿On Wed, Jun 24, 2020 at 3:44 PM Wei Yang
>> >> > <richard.weiyang@linux.alibaba.com> wrote:
>> >> > [..]
>> >> >>> So, you are right that there is a mismatch here, but I think the
>> >> >>> comprehensive fix is to allow early sections to be partially
>> >> >>> depopulated/repopulated rather than have section_activate() and
>> >> >>> section_deacticate() special case early sections. The special casing
>> >> >>> is problematic in retrospect as section_deactivate() can't be
>> >> >>> maintained without understand special rules in section_activate().
>> >> >>
>> >> >> Hmm... This means we need to adjust pfn_valid() too, which always return true
>> >> >> for early sections.
>> >> >
>> >> > Right, rather than carry workarounds in 3 locations, and the bug that
>> >> > has resulted from then getting out of sync, just teach early section
>> >> > mapping to allow for the subsection populate/depopulate.
>> >> >
>> >>
>> >> I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_online_page() will need changes as well.
>> >
>> >Agree, yes, let's do the simple fix first for 5.8 and the special-case
>> >elimination work later.
>>
>> Dan,
>>
>> A quick test shows this is not a simple task.
>
>Thanks for taking a look...
>
>> First, early sections don't set subsection bitmap, which is necessary for the
>> hot-add/remove.
>>
>> To properly set subsection bitmap, we need to know how many subsections in
>> early section. While current code doesn't has a alignment requirement for
>> last early section. We mark the whole last early section as present.
>
>I was thinking that the subsection map does not need to be accurate on
>initial setup, it only needs to be accurate after the first removal.
>However, that would result in new special casing that somewhat defeats
>the purpose. The hardest part is potentially breaking up a PMD mapping
>of the page array into a series of PTE mappings without disturbing
>in-flight pfn_to_page() users.
>
>> I don't find a way to enable this.
>
>While I don't like that this bug crept into the mismatched special
>casing of early sections, I'm now coming around to the same opinion.
>I.e. that making the memmap for early sections permanent is a simpler
>mechanism to maintain.

I think so ...

-- 
Wei Yang
Help you, Help me

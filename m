Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD38D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbgFXWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:44:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49165 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388739AbgFXWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:44:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U0dYaOT_1593038651;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0dYaOT_1593038651)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jun 2020 06:44:11 +0800
Date:   Thu, 25 Jun 2020 06:44:10 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624224410.GD15016@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
 <20200624061340.GA11552@L-31X9LVDL-1304.local>
 <CAPcyv4gEUq0yyz00AbQQSyo_acj1wUCZPse5vEff_Bq7GmeksQ@mail.gmail.com>
 <20200624220552.GA15016@L-31X9LVDL-1304.local>
 <CAPcyv4iHM2d0qZFsznwv20Z+rTcj-8CZTDBQv1kJ50FwZuM90Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iHM2d0qZFsznwv20Z+rTcj-8CZTDBQv1kJ50FwZuM90Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:20:59PM -0700, Dan Williams wrote:
>On Wed, Jun 24, 2020 at 3:06 PM Wei Yang
><richard.weiyang@linux.alibaba.com> wrote:
>>
>> On Wed, Jun 24, 2020 at 09:10:09AM -0700, Dan Williams wrote:
>> >On Tue, Jun 23, 2020 at 11:14 PM Wei Yang
>> ><richard.weiyang@linux.alibaba.com> wrote:
>> >>
>> >> On Tue, Jun 23, 2020 at 05:18:28PM +0200, Michal Hocko wrote:
>> >> >On Tue 23-06-20 17:42:58, Wei Yang wrote:
>> >> >> For early sections, we assumes its memmap will never be partially
>> >> >> removed. But current behavior breaks this.
>> >> >>
>> >> >> Let's correct it.
>> >> >>
>> >> >> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> >> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> >> >
>> >> >Can a user trigger this or is this a theoretical bug?
>> >>
>> >> Let me rewrite the changelog a little. Look forward any comments.
>> >>
>> >>    For early sections, its memmap is handled specially even sub-section is
>> >>    enabled. The memmap could only be populated as a whole.
>> >>
>> >>    Quoted from the comment of section_activate():
>> >>
>> >>        * The early init code does not consider partially populated
>> >>        * initial sections, it simply assumes that memory will never be
>> >>        * referenced.  If we hot-add memory into such a section then we
>> >>        * do not need to populate the memmap and can simply reuse what
>> >>        * is already there.
>> >>
>> >>    While current section_deactivate() breaks this rule. When hot-remove a
>> >>    sub-section, section_deactivate() would depopulate its memmap. The
>> >>    consequence is if we hot-add this subsection again, its memmap never get
>> >>    proper populated.
>> >
>> >Ok, forgive the latency as re-fetched this logic into my mental cache.
>> >So what I was remembering was the initial state of the code that
>> >special cased early sections, and that still seems to be the case in
>> >pfn_valid(). IIRC early_sections / bootmem are blocked from being
>> >removed entirely. Partial / subsection removals are ok.
>>
>> Would you mind giving more words? Partial subsection removal is ok, so no need
>> to fix this?
>
>Early sections establish a memmap for the full section. There's
>conceptually nothing wrong with unplugging the non-system-RAM portion
>of the memmap, but it would need to be careful, at least on x86, to
>map the partial section with PTEs instead of PMDs.
>
>So, you are right that there is a mismatch here, but I think the
>comprehensive fix is to allow early sections to be partially
>depopulated/repopulated rather than have section_activate() and
>section_deacticate() special case early sections. The special casing
>is problematic in retrospect as section_deactivate() can't be
>maintained without understand special rules in section_activate().

Hmm... This means we need to adjust pfn_valid() too, which always return true
for early sections.

-- 
Wei Yang
Help you, Help me

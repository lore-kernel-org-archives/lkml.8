Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F39C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21392084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgANCJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:09:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:26863 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgANCJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:09:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 18:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="422998128"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2020 18:09:21 -0800
Date:   Tue, 14 Jan 2020 10:09:29 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
Message-ID: <20200114020929.GA6889@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109025240.GA2000@richard>
 <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard>
 <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
 <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
 <20200113003343.GA27210@richard>
 <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:07:18PM +0300, Konstantin Khlebnikov wrote:
>On 13/01/2020 03.33, Wei Yang wrote:
>> On Sun, Jan 12, 2020 at 12:55:45PM +0300, Konstantin Khlebnikov wrote:
>> > 
>> > 
>> > On 12/01/2020 01.38, Wei Yang wrote:
>> > > On Fri, Jan 10, 2020 at 11:11:23AM +0300, Konstantin Khlebnikov wrote:
>> > > [...]
>> > > > > > > > 
>> > > > > > > > series of vma in parent with shared AV:
>> > > > > > > > 
>> > > > > > > > SRC1 - AV0
>> > > > > > > > SRC2 - AV0
>> > > > > > > > SRC3 - AV0
>> > > > > > > > ...
>> > > > > > > > SRCn - AV0
>> > > > > > > > 
>> > > > > > > > in child after fork
>> > > > > > > > 
>> > > > > > > > DST1 - AV_OLD_1 (some old vma, picked by anon_vma_clone) plus DST1 is attached to same AVs as SRC1
>> > > > > > > > DST2 - AV_OLD_2 (other old vma) plus DST1 is attached to same AVs as SRC2
>> > > > > > > > DST2 - AV1 prev AV parent does not match AV0, no old vma found for reusing -> allocate new one (child of AV0)
>> > > > > > > > DST3 - AV1 - DST2->AV->parent == SRC3->AV (AV0) -> share AV with prev
>> > > > > > > > DST4 - AV1 - same thing
>> > > > > > > > ...
>> > > > > > > > DSTn - AV1
>> > > > > > > > 
>> > > 
>> > > To focus on the point, I rearranged the order a little. Suppose your following
>> > > comments is explaining the above behavior.
>> > > 
>> > >      I've illustrated how two heuristics (reusing-old and sharing-prev) _could_ work together.
>> > >      But they both are optional.
>> > >      At cloning first vma SRC1 -> DST1 there is no prev to share anon vma,
>> > >      thus works common code which _could_ reuse old vma because it have to.
>> > >      If there is no old anon-vma which have to be reused then DST1 will allocate
>> > >      new anon-vma (AV1) and it will be used by DST2 and so on like on your picture.
>> > > 
>> > > I agree with your 3rd paragraph, but confused with 2nd.
>> > > 
>> > > At cloning first vma SRC1 -> DST1, there is no prev so anon_vma_clone() would
>> > > pick up a reusable anon_vma. Here you named it AV_OLD_1. This looks good to
>> > > me. But I am not sure why you would picked up AV_OLD_2 for DST2? In parent,
>> > > SRC1 and SRC2 has the same anon_vma, AV0. So in child, DST1 and DST2 could
>> > > also share the same anon_vma, AV_OLD_1.
>> > > 
>> > > Sorry for my poor understanding, would you mind giving me more hint on this
>> > > change?
>> > 
>> > For DST2 heuristic "share-with-prev" will not work because if prev (DST1)
>> > uses old AV (AV_OLD_1) and AV_OLD_1->parent isn't SRC2->AV (AV0).
>> > So DST2 could only pick another old AV or allocate new.
>> 
>> I know this behavior after your change, my question is why you want to do so.
>
>Because I want to keep both heuristics.
>This seems most sane way of interaction between them.
>

I am not sure this is more sane.

Still suggest to separate your idea into a new patch, so audience could
analysis and notice the change clearly. Otherwise audience would be confused
with this behavior.

>Unfortunately even this patch is slightly broken.
>Condition prev->anon_vma->parent == pvma->anon_vma doesn't guarantee that
>prev vma has the same set of anon-vmas like current vma.
>I.e. anon_vma_clone(vma, prev) might be not enough for keeping connectivity.
>Building such case isn't trivial job but I see nothing that could prevent it.
>
>> 
>> > 
>> > My patch uses condition dst->prev->anon_vma->parent == src->anon_vma rather
>> > than obvious src->prev->anon_vma == src->anon_vma because in this way it
>> > eliminates all unwanted corner cases and explicitly verifies that we going to
>> > share related anon-vma.
>> > 
>> 
>> This do eliminates some corner case, but as you showed child and parent don't
>> share the same AV topology. To keep the same AV topology is the purpose of my
>> commit.
>> 
>> I agree you found some bug that previous commit doesn't do it is expected. But
>> since you change the design a little, I suggest you split this idea to a
>> separate patch so that reviewer and audience in the future could understand
>> your approach clearly. Otherwise audience would be confused and hard to track
>> this change.
>> 
>> For example, you describe the behavior after your change. The second vma would
>> probably have a different AV from first vma.
>> 
>> > Heuristic "reuse-old" uses fact that VMA links and AV parent chain are tracked
>> > independently: when VMA reuses old AV it still links to all related AV even
>> > if VMA->AV points into some old AV in the middle of inheritance chain.
>> > 
>> > > 
>> > > > > > > 
>> > > > > > > Yes, your code works for DST3..DSTn. They will pick up AV1 since
>> > > > > > > (DST2->AV->parent == SRC3->AV).
>> > > > > > > 
>> > > > > > > My question is why DST1 and DST2 has different AV? The purpose of my patch
>> > > > > > > tries to make child has the same topology and parent. So the ideal look of
>> > > > > > > child is:
>> > > > > > > 
>> > > > > > > DST1 - AV1
>> > > > > > > DST2 - AV1
>> > > > > > > DST2 - AV1
>> > > > > > > DST3 - AV1
>> > > > > > > DST4 - AV1
>> > > > > > > 
>> > > > > > > Would you mind putting more words on DST1 and DST2? I didn't fully understand
>> > > > > > > the logic here.
>> > > > > > > 
>> > > > > > > Thanks
>> > > > > > > 
>> > > > > > 
>> > > > > > I think that the first version is doing the work as you expected, but been
>> > > > > > revised in second version, to limits the number of users of reused old
>> > > > > > anon(which is picked in anon_vma_clone() and keep the tree structure.
>> > > > > > 
>> > > > > 
>> > > > > Any reason to reduce the reuse? Maybe I lost some point.
>> > > > 
>> > > > > 
>> > > > > > > --
>> > > > > > > Wei Yang
>> > > > > > > Help you, Help me
>> > > > > 
>> > > 
>> 

-- 
Wei Yang
Help you, Help me

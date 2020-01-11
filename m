Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5EC33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93542084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgAKWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:38:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:24099 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731372AbgAKWi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 17:38:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 14:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,422,1571727600"; 
   d="scan'208";a="224535091"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2020 14:38:24 -0800
Date:   Sun, 12 Jan 2020 06:38:20 +0800
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
Message-ID: <20200111223820.GA15506@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <157839239609.694.10268055713935919822.stgit@buzz>
 <20200108023211.GC13943@richard>
 <b019b294-61fa-85fc-cf43-c6d3e9fddc71@yandex-team.ru>
 <20200109025240.GA2000@richard>
 <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard>
 <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:11:23AM +0300, Konstantin Khlebnikov wrote:
[...]
>> > > > 
>> > > > series of vma in parent with shared AV:
>> > > > 
>> > > > SRC1 - AV0
>> > > > SRC2 - AV0
>> > > > SRC3 - AV0
>> > > > ...
>> > > > SRCn - AV0
>> > > > 
>> > > > in child after fork
>> > > > 
>> > > > DST1 - AV_OLD_1 (some old vma, picked by anon_vma_clone) plus DST1 is attached to same AVs as SRC1
>> > > > DST2 - AV_OLD_2 (other old vma) plus DST1 is attached to same AVs as SRC2
>> > > > DST2 - AV1 prev AV parent does not match AV0, no old vma found for reusing -> allocate new one (child of AV0)
>> > > > DST3 - AV1 - DST2->AV->parent == SRC3->AV (AV0) -> share AV with prev
>> > > > DST4 - AV1 - same thing
>> > > > ...
>> > > > DSTn - AV1
>> > > > 

To focus on the point, I rearranged the order a little. Suppose your following
comments is explaining the above behavior.

   I've illustrated how two heuristics (reusing-old and sharing-prev) _could_ work together.
   But they both are optional.
   
   At cloning first vma SRC1 -> DST1 there is no prev to share anon vma,
   thus works common code which _could_ reuse old vma because it have to.
   
   If there is no old anon-vma which have to be reused then DST1 will allocate
   new anon-vma (AV1) and it will be used by DST2 and so on like on your picture.

I agree with your 3rd paragraph, but confused with 2nd.

At cloning first vma SRC1 -> DST1, there is no prev so anon_vma_clone() would
pick up a reusable anon_vma. Here you named it AV_OLD_1. This looks good to
me. But I am not sure why you would picked up AV_OLD_2 for DST2? In parent,
SRC1 and SRC2 has the same anon_vma, AV0. So in child, DST1 and DST2 could
also share the same anon_vma, AV_OLD_1.

Sorry for my poor understanding, would you mind giving me more hint on this
change?

>> > > 
>> > > Yes, your code works for DST3..DSTn. They will pick up AV1 since
>> > > (DST2->AV->parent == SRC3->AV).
>> > > 
>> > > My question is why DST1 and DST2 has different AV? The purpose of my patch
>> > > tries to make child has the same topology and parent. So the ideal look of
>> > > child is:
>> > > 
>> > > DST1 - AV1
>> > > DST2 - AV1
>> > > DST2 - AV1
>> > > DST3 - AV1
>> > > DST4 - AV1
>> > > 
>> > > Would you mind putting more words on DST1 and DST2? I didn't fully understand
>> > > the logic here.
>> > > 
>> > > Thanks
>> > > 
>> > 
>> > I think that the first version is doing the work as you expected, but been
>> > revised in second version, to limits the number of users of reused old
>> > anon(which is picked in anon_vma_clone() and keep the tree structure.
>> > 
>> 
>> Any reason to reduce the reuse? Maybe I lost some point.
>
>> 
>> > > --
>> > > Wei Yang
>> > > Help you, Help me
>> 

-- 
Wei Yang
Help you, Help me

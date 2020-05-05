Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27151C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0775B206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEEMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:34:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:62798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:34:51 -0400
IronPort-SDR: FATU/mbVA63zbCLlXXkd0e2NQ6mgVyNaAr8MBs2uJuhVumSB32MW9tLuLCXjJ+IVSY7LV3Jt5U
 kuekYbJF0tcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 05:34:48 -0700
IronPort-SDR: 5sPwFZ5SegOPdotfSIk2A0YgWqeEhHdmFdVY8CDlelqI6TsiAarzVP5Ycxj38/uhqZwbRiKMK1
 7pLUNH1MltEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="263151718"
Received: from jmserbon-mobl1.amr.corp.intel.com (HELO [10.254.110.254]) ([10.254.110.254])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2020 05:34:45 -0700
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Ulrich Weigand <uweigand@de.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        viro@zeniv.linux.org.uk, david@redhat.com,
        akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        jack@suse.cz, kirill@shutemov.name, peterz@infradead.org,
        sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
Date:   Tue, 5 May 2020 05:34:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504134154.GA21001@oc3748833570.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 6:41 AM, Ulrich Weigand wrote:
> On Fri, May 01, 2020 at 09:32:45AM -0700, Dave Hansen wrote:
>> The larger point, though, is that the s390 code ensures no extra
>> references exist upon entering make_secure_pte(), but it still has no
>> mechanism to prevent future, new references to page cache pages from
>> being created.
> 
> Hi Dave, I worked with Claudio and Christian on the initial design
> of our approach, so let me chime in here as well.

Hi Ulrich!

> You're right that there is no mechanism to prevent new references,
> but that's really never been the goal either.  We're simply trying
> to ensure that no I/O is ever done on a page that is in the "secure"
> (or inaccessible) state.  To do so, we rely on the assumption that
> all code that starts I/O on a page cache page will *first*:
> - mark the page as pending I/O by either taking an extra page
>   count, or by setting the Writeback flag; then:
> - call arch_make_page_accessible(); then:
> - start I/O; and only after I/O has finished:
> - remove the "pending I/O" marker (Writeback and/or extra ref)

Let's ignore writeback for a moment because get_page() is the more
general case.  The locking sequence is:

1. get_page() (or equivalent) "locks out" a page from converting to
   inaccessbile,
2. followed by a make_page_accessible() guarantees that the page
   *stays* accessible until
3. I/O is safe in this region
4. put_page(), removes the "lock out", I/O now unsafe

They key is, though, the get_page() must happen before
make_page_accessible() and *every* place that acquires a new reference
needs a make_page_accessible().

try_get_page() is obviously one of those "new reference sites" and it
only has one call site outisde of the gup code: generic_pipe_buf_get(),
which is effectively patched by the patch that started this thread.  The
fact that this one oddball site _and_ gup are patched now is a good sign.

*But*, I still don't know how that could work nicely:

> static inline __must_check bool try_get_page(struct page *page)
> {
>         page = compound_head(page);
>         if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>                 return false;
>         page_ref_inc(page);
>         return true;
> }

If try_get_page() collides with a freeze_page_refs(), it'll hit the
WARN_ON_ONCE(), which is surely there for a good reason.  I'm not sure
that warning is _actually_ valid since freeze_page_refs() isn't truly a
0 refcount.  But, the fact that this hasn't been encountered means that
the testing here is potentially lacking.

> We thought we had identified all places where we needed to place
> arch_make_page_accessible so that the above assumption is satisfied.
> You've found at least two instances where this wasn't true (thanks!);
> but I still think that this can be fixed by just adding those calls.

Why do you think that's the extent of the problem?  Because the crashes
stopped?

I'd feel a lot more comfortable if you explained the audits that you've
performed or _why_ you think that.  What I've heard thus far is
basically that you've been able to boot a guest and you're ready to ship
this code.

>> The one existing user of expected_page_refs() freezes the refs then
>> *removes* the page from the page cache (that's what the xas_lock_irq()
>> is for).  That stops *new* refs from being acquired.
>>
>> The s390 code is missing an equivalent mechanism.
>>
>> One example:
>>
>> 	page_freeze_refs();
>> 	// page->_count==0 now
>> 					find_get_page();
>> 					// ^ sees a "freed" page
>> 	page_unfreeze_refs();
>>
>> find_get_page() will either fail to *find* the page because it will see
>> page->_refcount==0 think it is freed (not great), or it will
>> VM_BUG_ON_PAGE() in __page_cache_add_speculative().
> 
> I don't really see how that could happen; my understanding is that
> page_freeze_refs simply causes potential users to spin and wait
> until it is no longer frozen.  For example, find_get_page will
> in the end call down to find_get_entry, which does:
> 
>         if (!page_cache_get_speculative(page))
>                 goto repeat;
> 
> Am I misunderstanding anything here?

Dang, I think I was looking at the TINY_RCU code, which is unfortunately
first in page_cache_get_speculative().  It doesn't support PREEMPT or
SMP, so it can take some shortcuts.

But, with regular RCU, you're right, it _does_ appear that it would hit
that retry loop, but then it would *succeed* in getting a reference.  In
the end, this just supports the sequence I wrote above:
arch_make_page_accessible() is only valid when called with an elevated
refcount and the refcount must be held to lock out make_secure_pte().

>> My bigger point is that this patches doesn't systematically stop finding
>> page cache pages that are arch-inaccessible.  This patch hits *one* of
>> those sites.
> 
> As I said above, that wasn't really the goal for our approach.
> 
> In particular, note that we *must* have secure pages present in the
> page table of the secure guest (that is a requirement of the architecture;
> note that the "secure" status doesn't just apply to the phyiscal page,
> but a triple of "*this* host physical page is the secure backing store
> of *this* guest physical page in *this* secure guest", which the HW/FW
> tracks based on the specific page table entry).
> 
> As a consequence, the page really also has to remain present in the
> page cache (I don't think Linux mm code would be able to handle the
> case where a file-backed page is in the page table but not page cache).

It actually happens transiently, at least.  I believe inode truncation
removes from the page cache before it zaps the PTEs.

> I'm not sure what exactly the requirements for your use case are; if those
> are significantly differently, maybe we can work together to find an
> approach that works for both?

I'm actually trying to figure out what to do with AMD's SEV.  The
current state isn't great and, for instance, allows userspace to read
guest ciphertext.  But, the pages come and go out of the encrypted state
at the behest of the guest, and the kernel needs *some* mapping for the
pages to do things like instruction emulation.

I started looking at s390 because someone said there was a similar
problem there and suggested the hooks might work.  I couldn't figure out
how they worked comprehensively on s390, and that's how we got here.

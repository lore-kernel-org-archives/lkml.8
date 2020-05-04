Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B8A20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgEDOHp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:07:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52066 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgEDOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:07:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVbkt-0005Vo-88; Mon, 04 May 2020 08:07:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jVbkc-0004Rq-KP; Mon, 04 May 2020 08:07:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
        <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
        <87h7wzvjko.fsf@x220.int.ebiederm.org>
        <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
Date:   Mon, 04 May 2020 09:03:56 -0500
In-Reply-To: <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
        (Joonsoo Kim's message of "Mon, 4 May 2020 12:10:36 +0900")
Message-ID: <87ftcfpzjn.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jVbkc-0004Rq-KP;;;mid=<87ftcfpzjn.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LaTlNQHloxB04ZCtMYj2M+lNA8nn2ED8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 03/10] kexec: separate PageHighMem() and PageHighMemZone() use case
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have added in the kexec mailling list.

Looking at the patch we are discussing it appears that the kexec code
could be doing much better in highmem situations today but is not.


Joonsoo Kim <js1304@gmail.com> writes:

> 2020년 5월 1일 (금) 오후 11:06, Eric W. Biederman <ebiederm@xmission.com>님이 작성:
>>
>> js1304@gmail.com writes:
>>
>> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> >
>> > Until now, PageHighMem() is used for two different cases. One is to check
>> > if there is a direct mapping for this page or not. The other is to check
>> > the zone of this page, that is, weather it is the highmem type zone or not.
>> >
>> > Now, we have separate functions, PageHighMem() and PageHighMemZone() for
>> > each cases. Use appropriate one.
>> >
>> > Note that there are some rules to determine the proper macro.
>> >
>> > 1. If PageHighMem() is called for checking if the direct mapping exists
>> > or not, use PageHighMem().
>> > 2. If PageHighMem() is used to predict the previous gfp_flags for
>> > this page, use PageHighMemZone(). The zone of the page is related to
>> > the gfp_flags.
>> > 3. If purpose of calling PageHighMem() is to count highmem page and
>> > to interact with the system by using this count, use PageHighMemZone().
>> > This counter is usually used to calculate the available memory for an
>> > kernel allocation and pages on the highmem zone cannot be available
>> > for an kernel allocation.
>> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
>> > is just copy of the previous PageHighMem() implementation and won't
>> > be changed.
>> >
>> > I apply the rule #2 for this patch.
>>
>> Hmm.
>>
>> What happened to the notion of deprecating and reducing the usage of
>> highmem?  I know that we have some embedded architectures where it is
>> still important but this feels like it flies in the face of that.
>
> AFAIK, deprecating highmem requires some more time and, before then,
> we need to support it.

But it at least makes sense to look at what we are doing with highmem
and ask if it makes sense.

>> This part of kexec would be much more maintainable if it had a proper
>> mm layer helper that tested to see if the page matched the passed in
>> gfp flags.  That way the mm layer could keep changing and doing weird
>> gyrations and this code would not care.
>
> Good idea! I will do it.
>
>>
>> What would be really helpful is if there was a straight forward way to
>> allocate memory whose physical address fits in the native word size.
>>
>>
>> All I know for certain about this patch is that it takes a piece of code
>> that looked like it made sense, and transfroms it into something I can
>> not easily verify, and can not maintain.
>
> Although I decide to make a helper as you described above, I don't
> understand why you think that a new code isn't maintainable. It is just
> the same thing with different name. Could you elaborate more why do
> you think so?

Because the current code is already wrong.  It does not handle
the general case of what it claims to handle.  When the only distinction
that needs to be drawn is highmem or not highmem that is likely fine.
But now you are making it possible to draw more distinctions.  At which
point I have no idea which distinction needs to be drawn.


The code and the logic is about 20 years old.  When it was written I
don't recally taking numa seriously and the kernel only had 3 zones
as I recall (DMA aka the now deprecated GFP_DMA, NORMAL, and HIGH).

The code attempts to work around limitations of those old zones amd play
nice in a highmem world by allocating memory HIGH memory and not using
it if the memory was above 4G ( on 32bit ).

Looking the kernel now has GFP_DMA32 so on 32bit with highmem we should
probably be using that, when allocating memory.




Further in dealing with this memory management situation we only
have two situations we call kimage_alloc_page.

For an indirect page which must have a valid page_address(page).
We could probably relax that if we cared to.

For a general kexec page to store the next kernel in until we switch.
The general pages can be in high memory.

In a highmem world all of those pages should be below 32bit.



Given that we fundamentally have two situations my sense is that we
should just refactor the code so that we never have to deal with:


			/* The old page I have found cannot be a
			 * destination page, so return it if it's
			 * gfp_flags honor the ones passed in.
			 */
			if (!(gfp_mask & __GFP_HIGHMEM) &&
			    PageHighMem(old_page)) {
				kimage_free_pages(old_page);
				continue;
			}

Either we teach kimage_add_entry how to work with high memory pages
(still 32bit accessible) or we teach kimage_alloc_page to notice it is
an indirect page allocation and to always skip trying to reuse the page
it found in that case.

That way the code does not need to know about forever changing mm internals.



We should probably investigate GFP_DMA32 at the same time, and switch to
that for 32bit rather than continuing to use GFP_HIGHUSER.

Eric

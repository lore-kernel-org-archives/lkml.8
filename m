Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7ADC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FDD206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgEAOGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:06:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54108 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgEAOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:06:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUWJM-0004gf-TM; Fri, 01 May 2020 08:06:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUWJK-0006hx-Mv; Fri, 01 May 2020 08:06:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
        <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
Date:   Fri, 01 May 2020 09:03:19 -0500
In-Reply-To: <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com> (js's
        message of "Wed, 29 Apr 2020 12:26:36 +0900")
Message-ID: <87h7wzvjko.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUWJK-0006hx-Mv;;;mid=<87h7wzvjko.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OrQA4UGeE4A+/sWRinwFintIJ4nH0kP4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 03/10] kexec: separate PageHighMem() and PageHighMemZone() use case
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

js1304@gmail.com writes:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Until now, PageHighMem() is used for two different cases. One is to check
> if there is a direct mapping for this page or not. The other is to check
> the zone of this page, that is, weather it is the highmem type zone or not.
>
> Now, we have separate functions, PageHighMem() and PageHighMemZone() for
> each cases. Use appropriate one.
>
> Note that there are some rules to determine the proper macro.
>
> 1. If PageHighMem() is called for checking if the direct mapping exists
> or not, use PageHighMem().
> 2. If PageHighMem() is used to predict the previous gfp_flags for
> this page, use PageHighMemZone(). The zone of the page is related to
> the gfp_flags.
> 3. If purpose of calling PageHighMem() is to count highmem page and
> to interact with the system by using this count, use PageHighMemZone().
> This counter is usually used to calculate the available memory for an
> kernel allocation and pages on the highmem zone cannot be available
> for an kernel allocation.
> 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
> is just copy of the previous PageHighMem() implementation and won't
> be changed.
>
> I apply the rule #2 for this patch.

Hmm.

What happened to the notion of deprecating and reducing the usage of
highmem?  I know that we have some embedded architectures where it is
still important but this feels like it flies in the face of that.


This part of kexec would be much more maintainable if it had a proper
mm layer helper that tested to see if the page matched the passed in
gfp flags.  That way the mm layer could keep changing and doing weird
gyrations and this code would not care.


What would be really helpful is if there was a straight forward way to
allocate memory whose physical address fits in the native word size.


All I know for certain about this patch is that it takes a piece of code
that looked like it made sense, and transfroms it into something I can
not easily verify, and can not maintain.

As it makes the code unmaintainable.
Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Not to say that the code isn't questionable as it is, but this change just
pushes it over the edge into gobbledy gook.

Eric


> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ba1d91e..33097b7 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -766,7 +766,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  			 * gfp_flags honor the ones passed in.
>  			 */
>  			if (!(gfp_mask & __GFP_HIGHMEM) &&
> -			    PageHighMem(old_page)) {
> +			    PageHighMemZone(old_page)) {
>  				kimage_free_pages(old_page);
>  				continue;
>  			}

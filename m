Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF861C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABE02192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp5sCxQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgCKLM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:12:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgCKLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583925176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J27SQcQ8+CHD3vks6FCpV5FX2N8wFEgpobTli186cvI=;
        b=Mp5sCxQtyzWHWHBbka0ds0kYmPp47R0B/xpgons1w1mRxhW3rRNJIAPQ6EiZVXaVShFZx3
        M7XxaGxPrd5oI46qCrxCjJlfNjwpLkznYqeeXr+v98Oj+F2I24xR9/0efE/jpd/klCcChv
        TWn1flMk/zsXdnPKZKs4760pHsZjBlc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-8t7uUoNuPIipMjAN9Kc5fw-1; Wed, 11 Mar 2020 07:12:46 -0400
X-MC-Unique: 8t7uUoNuPIipMjAN9Kc5fw-1
Received: by mail-qk1-f199.google.com with SMTP id 22so1218848qkc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J27SQcQ8+CHD3vks6FCpV5FX2N8wFEgpobTli186cvI=;
        b=YPeBcuVV4+1K623544wBLzIGPU4wCxCX/Zef4kvbACZVEJF8JVGvAX5Z85UQ+cYQCX
         a3mbf4s00Fw2m8Z4RIFMOcBC3g2wAb+WnwY3lGF8F94GWiKBrWQWBe+YyhKVQoC1lI1q
         EgqGZrskUrPpux3FObPyk1K5c4uw1njGLo9zJrhY94iJmRjAltqHFGsNW4Cl/8uhEfYi
         E3nzft/1FaISyh8uP4V3sWXarUVQU/ncYOgetArb7UgOA1YvPBYMno+bUOezkZzxti/2
         gpPgBtF5O0gSQPL+tWCPleLGA9B/G2o7azPDcqwAEcBz7T/DLbJszJb2GuHR4A0QHNc2
         Yagg==
X-Gm-Message-State: ANhLgQ0fnx+8djJhtP4aCoVy9OZ54eoka2Oxm5U5taOicTgfYywgQD1a
        mLvUESR5iOX2TOFNbs8RE2PjNT3H049tfG68Ff50mQXWaG3i1yRT6fopxsjFQDWO1eWPwfyvSF4
        ZqpPWLUYpYrLdF/+aPUjiw1NC
X-Received: by 2002:a37:bc1:: with SMTP id 184mr2146583qkl.57.1583925165494;
        Wed, 11 Mar 2020 04:12:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFYc5tFK7zblYvbrcTfg23/Z2VBpJF5tj1r6y1PoPqomX102twr6p25lkiLGbRFJbUQ7JMrQ==
X-Received: by 2002:a37:bc1:: with SMTP id 184mr2146542qkl.57.1583925165130;
        Wed, 11 Mar 2020 04:12:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id o7sm7446399qtg.63.2020.03.11.04.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:12:43 -0700 (PDT)
Date:   Wed, 11 Mar 2020 07:12:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200311070952-mutt-send-email-mst@kernel.org>
References: <20200310113854.11515-1-david@redhat.com>
 <alpine.DEB.2.21.2003101204590.90377@chino.kir.corp.google.com>
 <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:13:19PM +0100, David Hildenbrand wrote:
> On 10.03.20 20:05, David Rientjes wrote:
> > On Tue, 10 Mar 2020, David Hildenbrand wrote:
> > 
> >> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> >> changed the behavior when deflation happens automatically. Instead of
> >> deflating when called by the OOM handler, the shrinker is used.
> >>
> >> However, the balloon is not simply some other slab cache that should be
> >> shrunk when under memory pressure. The shrinker does not have a concept of
> >> priorities yet, so this behavior cannot be configured. Eventually once
> >> that is in place, we might want to switch back after doing proper
> >> testing.
> >>
> >> There was a report that this results in undesired side effects when
> >> inflating the balloon to shrink the page cache. [1]
> >> 	"When inflating the balloon against page cache (i.e. no free memory
> >> 	 remains) vmscan.c will both shrink page cache, but also invoke the
> >> 	 shrinkers -- including the balloon's shrinker. So the balloon
> >> 	 driver allocates memory which requires reclaim, vmscan gets this
> >> 	 memory by shrinking the balloon, and then the driver adds the
> >> 	 memory back to the balloon. Basically a busy no-op."
> >>
> >> The name "deflate on OOM" makes it pretty clear when deflation should
> >> happen - after other approaches to reclaim memory failed, not while
> >> reclaiming. This allows to minimize the footprint of a guest - memory
> >> will only be taken out of the balloon when really needed.
> >>
> >> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
> >> this has no such side effects. Always register the shrinker with
> >> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
> >> pages that are still to be processed by the guest. The hypervisor takes
> >> care of identifying and resolving possible races between processing a
> >> hinting request and the guest reusing a page.
> >>
> >> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
> >> notifier with shrinker"), don't add a moodule parameter to configure the
> >> number of pages to deflate on OOM. Can be re-added if really needed.
> >> Also, pay attention that leak_balloon() returns the number of 4k pages -
> >> convert it properly in virtio_balloon_oom_notify().
> >>
> >> Testing done by Tyler for future reference:
> >>   Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
> >>   GB file full of random bytes that we continually cat to /dev/null.
> >>   This fills the page cache as the file is read. Meanwhile we trigger
> >>   the balloon to inflate, with a target size of 53 GB. This setup causes
> >>   the balloon inflation to pressure the page cache as the page cache is
> >>   also trying to grow. Afterwards we shrink the balloon back to zero (so
> >>   total deflate = total inflate).
> >>
> >>   Without patch (kernel 4.19.0-5):
> >>   Inflation never reaches the target until we stop the "cat file >
> >>   /dev/null" process. Total inflation time was 542 seconds. The longest
> >>   period that made no net forward progress was 315 seconds (see attached
> >>   graph).
> >>   Result of "grep balloon /proc/vmstat" after the test:
> >>   balloon_inflate 154828377
> >>   balloon_deflate 154828377
> >>
> >>   With patch (kernel 5.6.0-rc4+):
> >>   Total inflation duration was 63 seconds. No deflate-queue activity
> >>   occurs when pressuring the page-cache.
> >>   Result of "grep balloon /proc/vmstat" after the test:
> >>   balloon_inflate 12968539
> >>   balloon_deflate 12968539
> >>
> >>   Conclusion: This patch fixes the issue. In the test it reduced
> >>   inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
> >>   But more importantly, if we hadn't killed the "grep balloon
> >>   /proc/vmstat" process then, without the patch, the inflation process
> >>   would never reach the target.
> >>
> >> [1] https://www.spinics.net/lists/linux-virtualization/msg40863.html
> >>
> >> Reported-by: Tyler Sanderson <tysand@google.com>
> >> Tested-by: Tyler Sanderson <tysand@google.com>
> >> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Wei Wang <wei.w.wang@intel.com>
> >> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> Cc: David Rientjes <rientjes@google.com>
> >> Cc: Nadav Amit <namit@vmware.com>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Acked-by: David Rientjes <rientjes@google.com>
> > 
> 
> Thanks!

David could you repost with corrected commit log
so Andrew can merge? To make sure it's not missed,
it's probably a good idea to have a cover letter
mentioning mm in the subject.

> > Should this have:
> > 
> > Cc: stable@vger.kernel.org # 4.19+
> 
> I guess as nothing will actually "crash" it's not worth stable.
> 
> -- 
> Thanks,
> 
> David / dhildenb


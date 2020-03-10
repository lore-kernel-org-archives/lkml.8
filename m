Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD3C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90F21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiD4hzkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCJTFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:05:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56177 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:05:36 -0400
Received: by mail-pj1-f68.google.com with SMTP id a18so813774pjs.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=v8GsiRik2mrX2L1ExptNFr8axv3wfoWM2X7VsCOjmKw=;
        b=jiD4hzkPe1Bx8wT0mrrukaMqHcSnjl3SW+PpVZW7NLFmNMmtXoMw2MQB4JIGlXUAoz
         PGdnwyNhU16axQ5mvCNaMXP0h+kzvPzKSQ+EkfkNirhZccYmQV/jihjJUubruSvCKerK
         Ggb1XpUS5kj17Rpt3/DLCPtsHy0wzFT8wFZHvYE9f5Dq1Jpqi6nqX+OJ8YXc1T4qJV4L
         ePcohJ846/f7iwq/rryRQN8QwD9POr/lMjiyrByRdkTIMHUiAmKWL4pSS7DJnz9QgIWG
         ARAIw8Qv4YyRSFfm4ANDKsGvJdV2kBURKKuqTthcsVIQXcF8m1+HoeB+hs8q9I903/OF
         VJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=v8GsiRik2mrX2L1ExptNFr8axv3wfoWM2X7VsCOjmKw=;
        b=fCJvfJoKoN/dMpFJh1v7Ulmb3/isRf+jA8Lqf1+bqqfdW26JWRmOU5AF0pp7mzStvy
         3PczjkLe72u3/28+J3nIBELjhXmSgUkXT9VwbBtE/7EvmJ5qytcrjAZ5oWtWGmGJ82WD
         M4+5CUgyBMlez0rzgKcwHg8dQ1ARfZkSNLNMyFcD+lSW9XOtNyntYD0cLWznbq+CDqFT
         qovanRBf7B8Q6QZaHYOQN4noBa4YYjdVdhFLfqAXs/FdTm+5rcdq1y04BRafBHcT0E/j
         GTFSX+IaYPFwF8mypQYzrrHefsmRP//nPBUVSRiYLhzV3inSio3qDGDRScfizHVY5Z6f
         K9NQ==
X-Gm-Message-State: ANhLgQ3hFu++XwYf6/5Cd74dG6H8dh0fM2gDJHSKWF9EllP1g0oq/gUo
        zKQiAKwBjOsAyxz+rzdVmEKwMA==
X-Google-Smtp-Source: ADFU+vv3mVq93iP5Eam0h9fV6x3EIyC6U+vBhRlKIxBX+AVcP5oHlIrtsSv1JHwo1ZRt8kGQSLAx6Q==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr3072909pjs.69.1583867134456;
        Tue, 10 Mar 2020 12:05:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j2sm13584896pfg.169.2020.03.10.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:05:33 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:05:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Hildenbrand <david@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tyler Sanderson <tysand@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
In-Reply-To: <20200310113854.11515-1-david@redhat.com>
Message-ID: <alpine.DEB.2.21.2003101204590.90377@chino.kir.corp.google.com>
References: <20200310113854.11515-1-david@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, David Hildenbrand wrote:

> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> changed the behavior when deflation happens automatically. Instead of
> deflating when called by the OOM handler, the shrinker is used.
> 
> However, the balloon is not simply some other slab cache that should be
> shrunk when under memory pressure. The shrinker does not have a concept of
> priorities yet, so this behavior cannot be configured. Eventually once
> that is in place, we might want to switch back after doing proper
> testing.
> 
> There was a report that this results in undesired side effects when
> inflating the balloon to shrink the page cache. [1]
> 	"When inflating the balloon against page cache (i.e. no free memory
> 	 remains) vmscan.c will both shrink page cache, but also invoke the
> 	 shrinkers -- including the balloon's shrinker. So the balloon
> 	 driver allocates memory which requires reclaim, vmscan gets this
> 	 memory by shrinking the balloon, and then the driver adds the
> 	 memory back to the balloon. Basically a busy no-op."
> 
> The name "deflate on OOM" makes it pretty clear when deflation should
> happen - after other approaches to reclaim memory failed, not while
> reclaiming. This allows to minimize the footprint of a guest - memory
> will only be taken out of the balloon when really needed.
> 
> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
> this has no such side effects. Always register the shrinker with
> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
> pages that are still to be processed by the guest. The hypervisor takes
> care of identifying and resolving possible races between processing a
> hinting request and the guest reusing a page.
> 
> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
> notifier with shrinker"), don't add a moodule parameter to configure the
> number of pages to deflate on OOM. Can be re-added if really needed.
> Also, pay attention that leak_balloon() returns the number of 4k pages -
> convert it properly in virtio_balloon_oom_notify().
> 
> Testing done by Tyler for future reference:
>   Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
>   GB file full of random bytes that we continually cat to /dev/null.
>   This fills the page cache as the file is read. Meanwhile we trigger
>   the balloon to inflate, with a target size of 53 GB. This setup causes
>   the balloon inflation to pressure the page cache as the page cache is
>   also trying to grow. Afterwards we shrink the balloon back to zero (so
>   total deflate = total inflate).
> 
>   Without patch (kernel 4.19.0-5):
>   Inflation never reaches the target until we stop the "cat file >
>   /dev/null" process. Total inflation time was 542 seconds. The longest
>   period that made no net forward progress was 315 seconds (see attached
>   graph).
>   Result of "grep balloon /proc/vmstat" after the test:
>   balloon_inflate 154828377
>   balloon_deflate 154828377
> 
>   With patch (kernel 5.6.0-rc4+):
>   Total inflation duration was 63 seconds. No deflate-queue activity
>   occurs when pressuring the page-cache.
>   Result of "grep balloon /proc/vmstat" after the test:
>   balloon_inflate 12968539
>   balloon_deflate 12968539
> 
>   Conclusion: This patch fixes the issue. In the test it reduced
>   inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
>   But more importantly, if we hadn't killed the "grep balloon
>   /proc/vmstat" process then, without the patch, the inflation process
>   would never reach the target.
> 
> [1] https://www.spinics.net/lists/linux-virtualization/msg40863.html
> 
> Reported-by: Tyler Sanderson <tysand@google.com>
> Tested-by: Tyler Sanderson <tysand@google.com>
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

Should this have:

Cc: stable@vger.kernel.org # 4.19+

?

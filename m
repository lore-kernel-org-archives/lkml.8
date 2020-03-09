Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE9C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8301520873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOxiuZjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCIKYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:24:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgCIKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583749472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvgDdAy0zWidzBgy80Pgtcr4prXz51m6ojJnNdb1JlQ=;
        b=bOxiuZjY3jCGfxHUDKSLlmpz77PhK5OUOcXTZ1q8J2RJq0ITB+/DKbcOC4LKClZm3yY7XV
        BpI0+8qxzWSc+MKK0KsuJFjub/9gDtqU1Qp5hPdUtkfh4LRiWUPjgE5T7mR50K1zA/tbqp
        fi6gh+jFQ823mT5mYQdJftA8gWh7PoU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-0suY0zmYMBynPKWlNGyeuA-1; Mon, 09 Mar 2020 06:24:31 -0400
X-MC-Unique: 0suY0zmYMBynPKWlNGyeuA-1
Received: by mail-qk1-f197.google.com with SMTP id l27so6964211qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvgDdAy0zWidzBgy80Pgtcr4prXz51m6ojJnNdb1JlQ=;
        b=ZXLMjC+sq9ZlAXX21UkDXBCH2TwQ6Yrwbi0rCYVZXsEjY54gqkvrgSF7xaM6uu07ic
         mCH+3unfK0KgI/fQeasgOPEMg2yIKrgINxH8SAzXPcwHW5PleVSlcEfBuqKgXdKgNUJ3
         qhFrn+TvRbvb0w0G7XCh5t7fIr/i1XP2XRxoFREhqn7QhFJ6SJaDjsbPoLLG1cM+NS7l
         /im/wQc14hvOw629ORHPFKDMyl5NymbfNJxXcnzGki/QkvjN4jMKmDW6xet7kq6vGt7R
         KNy+yVQbKMfEMoSASdlte0u1oco1CNDacR5CaK9dKjj+900jC9bY3smzyPzvF56VZ+jK
         7S+Q==
X-Gm-Message-State: ANhLgQ0+LTJoTEI85D+1zIgL6isl7NJW5+d0o5YkuU8LiNtwVe+T+DPR
        1wGm6l4D9ymkfxiUtAHCh4K1YyGqbUbW9tfw8wgPbqK76NsQX2or5HVjX1VfMi/9O09AKruQgdC
        6267qxDGwPy5ZiJNp01NB5HsJ
X-Received: by 2002:a0c:b757:: with SMTP id q23mr13919346qve.213.1583749470560;
        Mon, 09 Mar 2020 03:24:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs94BstrUypTvkiq+ZB1SWuvp4PA0n76GPDFRgcGKLKhcm6kiXzdCnIcquLiXGnqsLFDRSIzg==
X-Received: by 2002:a0c:b757:: with SMTP id q23mr13919333qve.213.1583749470343;
        Mon, 09 Mar 2020 03:24:30 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id n5sm21958459qkk.121.2020.03.09.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 03:24:29 -0700 (PDT)
Date:   Mon, 9 Mar 2020 06:24:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tyler Sanderson <tysand@google.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200309062311-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
 <20200216044641-mutt-send-email-mst@kernel.org>
 <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
 <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 08:47:25PM -0800, Tyler Sanderson wrote:
> Tested-by: Tyler Sanderson <tysand@google.com>
> 
> Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
> GB file full of random bytes that we continually cat to /dev/null.
> This fills the page cache as the file is read. Meanwhile we trigger
> the balloon to inflate, with a target size of 53 GB. This setup causes
> the balloon inflation to pressure the page cache as the page cache is
> also trying to grow. Afterwards we shrink the balloon back to zero (so
> total deflate = total inflate).
> 
> Without patch (kernel 4.19.0-5):
> Inflation never reaches the target until we stop the "cat file >
> /dev/null" process. Total inflation time was 542 seconds. The longest
> period that made no net forward progress was 315 seconds (see attached
> graph).
> Result of "grep balloon /proc/vmstat" after the test:
> balloon_inflate 154828377
> balloon_deflate 154828377
> 
> With patch (kernel 5.6.0-rc4+):
> Total inflation duration was 63 seconds. No deflate-queue activity
> occurs when pressuring the page-cache.
> Result of "grep balloon /proc/vmstat" after the test:
> balloon_inflate 12968539
> balloon_deflate 12968539
> 
> Conclusion: This patch fixes the issue. In the test it reduced
> inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
> But more importantly, if we hadn't killed the "grep balloon
> /proc/vmstat" process then, without the patch, the inflation process
> would never reach the target.
> 
> Attached is a png of a graph showing the problematic behavior without
> this patch. It shows deflate-queue activity increasing linearly while
> balloon size stays constant over the course of more than 8 minutes of
> the test.

OK this is now queued for -next. Tyler thanks a lot for the detailed
test report - it's really awesome! I included it in the commit log in
full so that if we need to come back to this it's easy to reproduce the
testing.

-- 
MST


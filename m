Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF317C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2F520732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6YfiAIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgDMOtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:49:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728185AbgDMOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWFIUTP14rr06BBJf7/lRX/qB9hDoGM3irEGOnU8QDY=;
        b=H6YfiAIiJrlwxl3OhnlAnqjlK17V3IuiwjWK5EJQxjeJbk0WWsQ72sh6TGeFiV2IpsaSrV
        Fwba6VhOtuSErSK4mKKbJWCYVUY/My/A48uoZEkc6ggwwehJDibhgMPX/qYlUJefO4HZmP
        LR0v6gk4ITVzMDeLWpV0ne4eKjuHFMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ucynfrusNL-k6vaR3IKi2Q-1; Mon, 13 Apr 2020 10:49:21 -0400
X-MC-Unique: ucynfrusNL-k6vaR3IKi2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6592DB63;
        Mon, 13 Apr 2020 14:49:19 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968A05C1B2;
        Mon, 13 Apr 2020 14:49:15 +0000 (UTC)
Date:   Mon, 13 Apr 2020 08:49:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
Message-ID: <20200413084915.1bae0007@w520.home>
In-Reply-To: <f9a3be0b-fe8d-ca25-f0df-4b9fd1f0fed5@intel.com>
References: <20200412090728.GA19572@open-light-1.localdomain>
        <f9a3be0b-fe8d-ca25-f0df-4b9fd1f0fed5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Apr 2020 18:43:07 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/12/20 2:07 AM, liliangleo wrote:
> > Zero out the page content usually happens when allocating pages,
> > this is a time consuming operation, it makes pin and mlock
> > operation very slowly, especially for a large batch of memory.
> > 
> > This patch introduce a new feature for zero out pages before page
> > allocation, it can help to speed up page allocation.  
> 
> I think the bar for getting something like this merged is going to be
> pretty high.  We have a long history of zeroing close to page use for
> cache warmth reasons.  Starting up big VMs which won't soon touch the
> memory they are allocating is basically the most pathological case
> against our approach since they don't *care* about cache warmth.
> 
> I'm also not sure it's something we _want_ to optimize for.
> 
> VFIO's unconditional page pinning is the real problem here IMNHO.  They
> don't *really* need to pin the memory.  We just don't have good
> paravirtualized IOMMU support or want to pay the runtime cost for
> pin/unpin operations.  You *could* totally have speedy VM startup if
> only the pages being accessed or having DMA performed to them were
> allocated.  But, the hacks that are in place mean that everything must
> be pinned.

Maybe in an SEV or Secure Boot environment we can assume the VM guest
OS uses the IOMMU exclusively for DMA, but otherwise the IOMMU is
optional (at least for x86, other archs do require IOMMU support
afaik).  Therefore, how would we know which pages to pin when there are
only limited configs where we might be able to lean on the vIOMMU to
this extent?  Thanks,

Alex


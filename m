Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC02C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459FA207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dKlIDqIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbgFXXUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFXXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:20:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F80C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:20:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l188so3629183qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=50l5Dv+6ZxPyVzpp0Gvp+/OZMC9Zz2ShDuxO8n/e6qc=;
        b=dKlIDqIO1zKZ5/r3LEEqIIdXXMvKWYtqZh7kuJcGaewZfIiKKHCMQINMIvisSlXQH1
         xWmHbqQ+xmEOXDLfwSjs4SKukimSGWgCe/tn2h3unn/czaeRTH4VfyNkvG3t6OyCmhTX
         8rymFqCr5v6Csjrxd+jyQEE4grQgfTRkyG76KizeQJcPdm6g687B1vDC1dHlYPLJy9EM
         wS751PjIZpPmXB9jpDk8F5kPJ7qUyxAr7I3yxxFFMpjYI6iMqvS7haf+GQt1A0NXBM2e
         WVNmFKTUOvehhDhTGPeD79nZ4NVgUdQXLXxz8/RTDA2tr+ZdNsK37lM1U+8haZ7Hb2wa
         LAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50l5Dv+6ZxPyVzpp0Gvp+/OZMC9Zz2ShDuxO8n/e6qc=;
        b=ORZ0qIbch8hWMZV2wjZ4rMGdrW2KAIzsl2fNLwH786d0tg2u2ac3r0AF13/ejKkGm2
         fCZt4clTM1vKYt4yLz8zk5ZJ0vNT/JYgH4RyHIxwwc/RcfR/v3o/w6qY6xuo7Aqv+fqt
         V5MCKKuC/BmydQfrtZpZ5t8WcC5WMf7Ok7YaBeQPdZRPiY3oIoYRQoyapEP6rdEdATtG
         qGt0DyyzsGUaV9WSRTmQUd7k0VElcEGL/m+Pe1Lv2+FK33ixM8/XWQlp3ZLoR153fwY+
         Yr1V8HMEJiSs0VLm0m9NsEuLCAkltLpU/KEyHRSEGWQISmH5eX/41nhaGWcIGsBzkSmY
         BFeQ==
X-Gm-Message-State: AOAM5316t4diipmo8nwe0gxmnrdkQiunaAEz7v1oy/WkvDPQKskKlhQ0
        OBrpQ827g4j4ZGm4pbp5BiWsTw==
X-Google-Smtp-Source: ABdhPJwJc/5vcM8iqN/INyrOnQzJ0qVecIjg2WtX4ifSmsVgC0ZMiY8O/7SJAPB5rKpjXVNlBg2h0g==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr25764049qke.207.1593040849174;
        Wed, 24 Jun 2020 16:20:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a28sm4047194qko.45.2020.06.24.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:20:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joEhD-00DqBT-Fa; Wed, 24 Jun 2020 20:20:47 -0300
Date:   Wed, 24 Jun 2020 20:20:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200624232047.GP6578@ziepe.ca>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200624192116.GO6578@ziepe.ca>
 <44708b2e-479f-7d58-fe01-29cfd6c70bdb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44708b2e-479f-7d58-fe01-29cfd6c70bdb@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:47:23PM -0700, John Hubbard wrote:
> On 2020-06-24 12:21, Jason Gunthorpe wrote:
> > On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> > > A general rule of thumb is that shrinkers should be fast and effective.
> > > They are called from direct reclaim at the most incovenient of times when
> > > the caller is waiting for a page. If we attempt to reclaim a page being
> > > pinned for active dma [pin_user_pages()], we will incur far greater
> > > latency than a normal anonymous page mapped multiple times. Worse the
> > > page may be in use indefinitely by the HW and unable to be reclaimed
> > > in a timely manner.
> > 
> > A pinned page can't be migrated, discarded or swapped by definition -
> > it would cause data corruption.
> > 
> > So, how do things even get here and/or work today at all? I think the
> > explanation is missing something important.
> > 
> 
> Well, those activities generally try to unmap the page, and
> have to be prepared to deal with failure to unmap. From my reading,
> it seemed very clear.

I think Yang explained it - the page is removed from the mappings but
freeing it does not happen because page_ref_freeze() does not succeed
due to the pin.

Presumably the mappings can reconnect to the same physical page if
it is re-faulted to avoid any data corruption.

So, the issue here is the mappings are trashed while the page remains
- and trashing the mapping triggers a mmu notifier which upsets i915.

> What's less clear is why the comment and the commit description
> only talk about reclaim, when there are additional things that call
> try_to_unmap(), including:
> 
>     migrate_vma_unmap()
>     split_huge_page_to_list() --> unmap_page()

It looks like the same unmap first then abort if the refcount is still
elevated design as shrink_page_list() ?

> I do like this code change, though. And I *think* it's actually safe to
> do this, as it stays away from writeback or other filesystem activity.
> But let me double check that, in case I'm forgetting something.

It would be nice to have an explanation why it is OK now to change
it..

I don't know, but could it be that try_to_unmap() has to be done
before checking the refcount as each mapping is included in the
refcount? ie we couldn't know a DMA pin was active in advance?

Now that we have your pin stuff we can detect a DMA pin without doing
all the unmaps?

Jason

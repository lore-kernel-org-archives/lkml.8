Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED2C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882D9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588375347;
	bh=c2vmIQk/4SDEyjp+ex+5JL9glUnCL/yZZYv7Uw/LnVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCpwMTaix7nDtS5ODwqxERmoA8zreJ99tAFVsdc1S+5p03+Fln92hNPJE9xc20TQs
	 FnyUCh7BYfV6UKRgcOXf90gtoi1i6M4crfhZXy0aiug/ZI9cLl6BT/dkzN2/6AY59z
	 xDVJDnHoBBc5E7ij4VW9JbZvOuwhEwNTYevISi/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgEAXW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgEAXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:22:26 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8475D2166E;
        Fri,  1 May 2020 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588375346;
        bh=c2vmIQk/4SDEyjp+ex+5JL9glUnCL/yZZYv7Uw/LnVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nTfYKjejvcpKTU8bmoZwGhKdSlpuBDhBCH/OTSaohinK1l/idP5/y7M5b6nCvQUQj
         vbfRRvi6ahGOrvYKiOx/dgwEShx3JlMoHQc+QLNZFculRxZLwOInwAvyg2n96UmDmx
         eqoBkAprwqouAwDxHAVtTmTGvMae63VlN5J1A0AA=
Date:   Fri, 1 May 2020 16:22:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
Message-ID: <20200501232224.GC915@sol.localdomain>
References: <20200407200318.11711-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407200318.11711-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:03:18PM -0400, Waiman Long wrote:
> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.
> 
> This patch introduces a new kvfree_sensitive() for freeing those
> sensitive data objects allocated by kvmalloc(). The relevnat places
> where kvfree_sensitive() can be used are modified to use it.
> 
> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Looks good, feel free to add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

(I don't really buy the argument that the compiler could compile away memset()
before kvfree().  But I agree with using memzero_explicit() anyway to make the
intent explicit.)

I don't see this patch in linux-next yet.  Who is planning to take this patch?
Presumably David through the keyrings tree, or Andrew through mm?

- Eric

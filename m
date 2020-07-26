Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E383C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296C220714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595746151;
	bh=+VYq+RbQ8frAwBD/FYSNz/CnuEVFlWBkeansQT6Isw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iSPaUuQwppd1KKzURr97k63LZv3mo6O8wEyc3u9ksNGlPEsRmNfzq1yPyHSt+uk6Y
	 sTH5WDDt6mm1rrPhAQprhfih4BQiInOiRby1/LfWoqCbCv9qdQTmSsdp8chBrrrahP
	 JljCRCtFglL6madS+kqkfUMxyurctR0PVfJgVO2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGZGtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 02:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGZGtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 02:49:09 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75253206E3;
        Sun, 26 Jul 2020 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595746148;
        bh=+VYq+RbQ8frAwBD/FYSNz/CnuEVFlWBkeansQT6Isw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnlF+wl9+bUq/TNkYnxiQvU10+8DdZePmQB8HlLOD5srQD5hzxcbMVkUQXaPhyFFF
         ubgNoXgoKP6b4LmTHxJDt35YjsGrbk7+9KJGO4RXsMqnDEQ4d7G+l9Vk4e3ZykZ0lk
         CD6P0UxTVhi2Bpq4xdOn6k8h+ASPvzyQeqEXFCbM=
Date:   Sun, 26 Jul 2020 09:48:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Drop unused MAX_PHYSADDR_BITS
Message-ID: <20200726064859.GA2835983@kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:15:41PM -0400, Arvind Sankar wrote:
> This #define is not used anywhere, and has the wrong value on x86_64.
> 
> I tried digging into the history a bit, but it seems to have been unused
> even in the initial merge of sparsemem in v2.6.13, when it was first
> defined.
> 
> Arvind Sankar (3):
>   x86/mm: Drop unused MAX_PHYSADDR_BITS
>   sh/mm: Drop unused MAX_PHYSADDR_BITS
>   sparc: Drop unused MAX_PHYSADDR_BITS

For the series

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

 
>  arch/sh/include/asm/sparsemem.h    | 4 +---
>  arch/sparc/include/asm/sparsemem.h | 1 -
>  arch/x86/include/asm/sparsemem.h   | 6 +-----
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

-- 
Sincerely yours,
Mike.

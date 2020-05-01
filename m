Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4773C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C5721835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588369073;
	bh=rcMy9hOYjnMdOayqZO4Al68Sx1wGMaF1BzVTkCR2gEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YdGSdhuaAIacFQ2rQvg6qKIG6d0n5vELxaAw/FEw1Y7karL9OgtUdu2AEtz2k68tp
	 w/dhT2+/9truaA7zV6dtO5dX50M+btLZAYFvJyOfRGYKUHDaWz3JkhYg4oMD31cN2g
	 Yuf/yOUAylgW9/6DSH3djTNtNAAO8BY8/C58NIIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgEAVhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:37:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96CE208DB;
        Fri,  1 May 2020 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588369072;
        bh=rcMy9hOYjnMdOayqZO4Al68Sx1wGMaF1BzVTkCR2gEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EE0JWT4QbsM5NXoYqeGRwX35IXmZwZDtWMmG79PhEJMPg/dW6L2Ekb5n6GRYDVAG1
         S2D3DFiTj80Uo0hKoZzajmP8k6tZ2Df6C3vWJHZKE6+8GlLTwRLKvvuHIFslK9OofV
         A8JTM9gcNPlIMEGLm4/fvLhC/zRG3SSadWhrPPKw=
Date:   Fri, 1 May 2020 14:37:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Message-Id: <20200501143751.97a25bb7f89f8d93ec443868@linux-foundation.org>
In-Reply-To: <20200501211540.71216-1-aquini@redhat.com>
References: <20200501211540.71216-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:15:40 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> Sometimes it is desirable to override SLUB's debug facilities
> default behavior upon stumbling on a cache or object error
> and just stop the execution in order to grab a coredump, at
> the error-spotting time, instead of trying to fix the issue
> and report in an attempt to keep the system rolling.
> 
> This patch introduces a new debug flag SLAB_PANIC_ON_ERROR,
> along with its related SLUB-machinery, in order to extend
> current slub_debug facilites and provide the aforementioned
> behavior override.
> 

Sees reasonable.

> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -54,6 +54,8 @@ Possible debug options are::
>  			caused higher minimum slab orders
>  	-		Switch all debugging off (useful if the kernel is
>  			configured with CONFIG_SLUB_DEBUG_ON)
> +	C		Toggle panic on error (crash) to allow for post-mortem
> +			analysis of a coredump taken at the error-spotting time

nit: "toggle" means to switch to the other state.  But what we're doing
here is to set to the "on" state.  This:

--- a/Documentation/vm/slub.rst~mm-slub-add-panic_on_error-to-the-debug-facilities-fix
+++ a/Documentation/vm/slub.rst
@@ -49,12 +49,12 @@ Possible debug options are::
 	P		Poisoning (object and padding)
 	U		User tracking (free and alloc)
 	T		Trace (please only use on single slabs)
-	A		Toggle failslab filter mark for the cache
+	A		Enable failslab filter mark for the cache
 	O		Switch debugging off for caches that would have
 			caused higher minimum slab orders
 	-		Switch all debugging off (useful if the kernel is
 			configured with CONFIG_SLUB_DEBUG_ON)
-	C		Toggle panic on error (crash) to allow for post-mortem
+	C		Enable panic on error (crash) to allow for post-mortem
 			analysis of a coredump taken at the error-spotting time
 
 F.e. in order to boot just with sanity checks and red zoning one would specify::
_


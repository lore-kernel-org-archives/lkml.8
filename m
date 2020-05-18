Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEF320709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgERLjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:39:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgERLjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:39:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D38C9106F;
        Mon, 18 May 2020 04:39:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73FB53F52E;
        Mon, 18 May 2020 04:39:01 -0700 (PDT)
Date:   Mon, 18 May 2020 12:38:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 2/6] scs: Move accounting into alloc/free functions
Message-ID: <20200518113858.GB1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-3-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:52PM +0100, Will Deacon wrote:
> There's no need to perform the shadow stack page accounting independently
> of the lifetime of the underlying allocation, so call the accounting code
> from the {alloc,free}() functions and simplify the code in the process.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/scs.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)

One (super trivial) nit below, but regardless this looks like a sound
and sensible cleanup, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

> diff --git a/kernel/scs.c b/kernel/scs.c
> index 5ff8663e4a67..aea841cd7586 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -14,25 +14,35 @@

>  static void *scs_alloc(int node)
>  {

> +	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> +
> +	if (!s)
> +		return NULL;

Super trivial nit, but could we omit the line space between these two,
to fit with usual style?

Mark.

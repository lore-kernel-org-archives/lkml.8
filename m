Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBCC20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCQSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:37:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCQSh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:37:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D608131B;
        Tue, 17 Mar 2020 11:37:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D383F67D;
        Tue, 17 Mar 2020 11:37:25 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:37:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     glider@google.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH] arm64: define __alloc_zeroed_user_highpage
Message-ID: <20200317183723.GH632169@arrakis.emea.arm.com>
References: <20200312155920.50067-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155920.50067-1-glider@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:59:20PM +0100, glider@google.com wrote:
> When running the kernel with init_on_alloc=1, calling the default
> implementation of __alloc_zeroed_user_highpage() from include/linux/highmem.h
> leads to double-initialization of the allocated page (first by the page
> allocator, then by clear_user_page().
> Calling alloc_page_vma() with __GFP_ZERO, similarly to e.g. x86, seems
> to be enough to ensure the user page is zeroed only once.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

I queued this for 5.7. Thanks.

-- 
Catalin

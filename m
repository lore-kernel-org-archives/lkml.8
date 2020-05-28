Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4063F208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627349;
	bh=LVt+v07eAhhKUzT7NqWt/6bOrLAfS45SVvYmNSlojo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zjDqSqmr+C+P8inQGxjA2x/kyQ7/HHNzb8nhbONhu4uoQp1gx3b0s5cTMHfKsINMX
	 pV4J5uXohf5TwzEraTJTdkYTISIHCtyInR3yymGrDe+vrr0bTjO6yWTUj2LlPHItlX
	 J9sjQ9C03tdKO2uTus0w/lzOfu/A0xGc0DtcTCZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE1Azs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 20:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1Azs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:55:48 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70B8207CB;
        Thu, 28 May 2020 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627348;
        bh=LVt+v07eAhhKUzT7NqWt/6bOrLAfS45SVvYmNSlojo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jv37DevlwxDmCOqr9Zb5+P2Xeq5ZWKgzCjORE0J9RBB7bJfqb3n8CvDivIWERcESE
         VM38R5KdZwFEAuJzap4U8cYrCW2Bkn8bZDTrxsIVze5ZoSzUpmeMIKrR/RqWTuadrt
         WomSlE/Kd+KPBoOd1wYzuXZRNXU+tR00icpmem+o=
Date:   Wed, 27 May 2020 17:55:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/23] maccess: unify the probe kernel arch hooks
Message-Id: <20200527175547.0260fb90d76734d4e0f56def@linux-foundation.org>
In-Reply-To: <20200521152301.2587579-11-hch@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
        <20200521152301.2587579-11-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 17:22:48 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Currently architectures have to override every routine that probes
> kernel memory, which includes a pure read and strcpy, both in strict
> and not strict variants.  Just provide a single arch hooks instead to
> make sure all architectures cover all the cases.

Fix a buildo.

--- a/arch/x86/mm/maccess.c~maccess-unify-the-probe-kernel-arch-hooks-fix
+++ a/arch/x86/mm/maccess.c
@@ -29,6 +29,6 @@ bool probe_kernel_read_allowed(const voi
 {
 	if (!strict)
 		return true;
-	return (unsigned long)vaddr >= TASK_SIZE_MAX;
+	return (unsigned long)unsafe_src >= TASK_SIZE_MAX;
 }
 #endif
_


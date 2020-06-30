Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787D120702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgF3Uwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgF3Uwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:52:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB0C061755;
        Tue, 30 Jun 2020 13:52:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 06AED12786C13;
        Tue, 30 Jun 2020 13:52:37 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:52:37 -0700 (PDT)
Message-Id: <20200630.135237.1160983148962711910.davem@davemloft.net>
To:     peterx@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, jhubbard@nvidia.com, mpe@ellerman.id.au,
        gerald.schaefer@de.ibm.com, aarcange@redhat.com,
        torvalds@linux-foundation.org, will@kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 21/26] mm/sparc64: Use general page fault accounting
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200630204556.39491-1-peterx@redhat.com>
References: <20200630204556.39491-1-peterx@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 13:52:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>
Date: Tue, 30 Jun 2020 16:45:56 -0400

> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
> 
> CC: David S. Miller <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>

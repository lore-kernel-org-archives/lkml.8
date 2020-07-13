Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E382067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjTsw3Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgGMQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:41:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04CC061755;
        Mon, 13 Jul 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/smdC20zlWM8SPs5G47I6CVNiPuYGFy43OW503ZUCwE=; b=RjTsw3Oe8lcsM1sWH5Sqr3stoq
        X/cJMjzKyIgX7hDQQcrXyFtuuO7pPqUseEeeFQE2oayeIcIYgoo4kS31SAC7OZfGZesrACego17/e
        LDUu86YATcC2DfoVuNAenFSKu7Ep3J4Z/m6bCxVDf41IdQLXSBexhzwaPWxo9+8kAb6YMFCefz3Ut
        n4QOrPOEhurY59/py5smPdcslUdbxFMw6S7WKaKxfwzn7HtK+WAXJ64FJ9dyHxN0JLP4VbAWV+vfE
        0Gqw6XJx3M7LbjGUn2RJJpQd8Lgw77p7S+Ll+QmQ5gri72zvnb3Hc+kP9vjJOc6gFex4FjmhYKjZx
        sY8sam+w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jv1WT-0003jZ-MK; Mon, 13 Jul 2020 16:41:45 +0000
Date:   Mon, 13 Jul 2020 17:41:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 1/2] tmpfs: Per-superblock i_ino support
Message-ID: <20200713164145.GY12769@casper.infradead.org>
References: <cover.1594656618.git.chris@chrisdown.name>
 <2cddd4498ba1db1c7a3831d47b9db0d063746a3b.1594656618.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cddd4498ba1db1c7a3831d47b9db0d063746a3b.1594656618.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:15:39PM +0100, Chris Down wrote:
> +#define SHMEM_INO_BATCH 1024U
...
> +		if (unlikely((ino & ~SHMEM_INO_BATCH) == 0)) {

I don't think that works.  I think you meant to write ~(SHMEM_INO_BATCH - 1).
Or just ino % SHMEM_INO_BATCH which works even for non-power-of-two.


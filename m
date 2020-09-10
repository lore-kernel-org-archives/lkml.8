Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5279CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3202078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIJQ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:59:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:42276 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgIJQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:56:59 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8FD2B4FA;
        Thu, 10 Sep 2020 16:56:58 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:56:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/doc: add usage description for migrate_vma_*()
Message-ID: <20200910105657.6007c5ca@lwn.net>
In-Reply-To: <20200909212956.20104-1-rcampbell@nvidia.com>
References: <20200909212956.20104-1-rcampbell@nvidia.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 14:29:56 -0700
Ralph Campbell <rcampbell@nvidia.com> wrote:

> The migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
> API usage by device drivers is not well documented.
> Add a description for how device drivers are expected to use it.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> There shouldn't be any merge conflict with my previous patch which
> touched hmm.rst but since Jonathan Corbet took my last patch, perhaps he
> would like to take this one through his tree too.

I'm happy to take it, but it certainly needs an ack from somebody who
understands HMM better than I do.

Thanks,

jon

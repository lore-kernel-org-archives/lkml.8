Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FDC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E167216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588373338;
	bh=+8ojglKGEmkO9iB05BMBJhMJkf9Z5gTGUig9zB2BCYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tK9/r7XHMbo+XK8Msl7mG2iorjK4QF25544Osx5epg2fXEBGasg391olyDyDdhT9x
	 WAUnJv42syDcLA23BAmzfwlCSgpIJJweYcHS05hg54+yucpw+bY+SmsiAuh07nwsqI
	 teZFO3NNKUM6tjsS55UmW9HPi/ncYgQmtDy9cdh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgEAWsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAWsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:48:54 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA7C208D6;
        Fri,  1 May 2020 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588373334;
        bh=+8ojglKGEmkO9iB05BMBJhMJkf9Z5gTGUig9zB2BCYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qXb1AUxFwf8SfiVD1hp1KVtxCVgLHhwERL3lbJCOXqQdCh2GuFvS/26htkilGQR4D
         ++9T85SXIC7GxJxaRwnLa1L0MH/Y+nuC+D6+lklVCuVQnC3GRBL+d9Te+eu784JxhI
         WoRVqqX4yFb7Rm5cXWyKbQzt3ZUpRasuhXHC/DBY=
Date:   Fri, 1 May 2020 15:48:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     ying.huang@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than
 SWAP_MAP_MAX
Message-Id: <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
In-Reply-To: <20200501015259.32237-3-richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
        <20200501015259.32237-3-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> When the condition is true, there are two possibilities:

I'm struggling with this one.

>    1. count == SWAP_MAP_BAD
>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM

I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
COUNT_CONTINUED) is zero.  I guess it meant "|"?

Also, the return value documentation says we return EINVAL for migration
entries.  Where's that happening, or is the comment out of date?

> The first case would be filtered by the first if in __swap_duplicate().
> 
> And the second case means this swap entry is for shmem. Since we never
> do another duplication for shmem swap entry. This won't happen neither.



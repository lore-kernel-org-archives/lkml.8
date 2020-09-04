Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B8EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A198D2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599216170;
	bh=DFTWqjK+p1fxUtSNHMS3CQCsb9VG5YY6ZHyEUoVL7D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YpXkwTiAxIJnZUhKVGeTRpgK/97BYb97WrYkfRcXrSdkHNDXU+etYa6Sl69G+hn2+
	 M48tp/7zIiIuuPp6bRkpq6/grGPXkSuKp3TeU6vJItJrepcdU7Ev7iZc7I4+0t0wLP
	 6iIv/rAhONpPuuaU8NfMngXJu/qp2mJ7c4B85uyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgIDKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbgIDKlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:41:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6F020770;
        Fri,  4 Sep 2020 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599216081;
        bh=DFTWqjK+p1fxUtSNHMS3CQCsb9VG5YY6ZHyEUoVL7D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwRJcxyeXYlNFR+cCrg4Aa77XUvivpKLnr6yiT5B+ojLFx4jNqsgjQHeEXNG17NEG
         yA87BvgJEh5XKYq9P1rKxIkawbbvFv+Yl13+CPJO2FGGcEoNIZw/sPnWkoFVDIwVcz
         2ZcLMh9mMH9PFGrGMXXtPSESteQbDUE1DVFnksqA=
Date:   Fri, 4 Sep 2020 12:41:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire fixes for v5.9
Message-ID: <20200904104143.GA2718648@kroah.com>
References: <20200904100818.GZ2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904100818.GZ2639@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:38:18PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> I have two fixes for soundwire subsystem, please pull.
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.9-fixes

Pulled and pushed out, thanks.

greg k-h

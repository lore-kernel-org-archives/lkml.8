Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F89C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9755E2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579015322;
	bh=FsuKKaA++OmWYtzIWBQZCFLq/3Fy/H3EQ5V+c+zgmTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UW1ecrgv752TquLLiH4Sk3dG1JZZVkOPGKI+n22wqIVKt1w0C8cly6j4m5OLBoZ4f
	 fbR1EbZYMK0Fl786K3CKLFzOvJ5VONWMlWgFov2ZPMshT477uZO6VIM2hsS3tS4IcX
	 rJ2lfSq2mBjJZYnVJX/kv/isvmI2aE0NaY5HjnEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgANPWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgANPWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:22:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFC22072B;
        Tue, 14 Jan 2020 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579015321;
        bh=FsuKKaA++OmWYtzIWBQZCFLq/3Fy/H3EQ5V+c+zgmTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCr1fOQnifCArkQEREQkjVb2C0nvw+BLfSt1eB+1MB/JHLRSsyZQQ9qn6n0AAUiAw
         9cc+ybzxOROorYnOOXIUfETwI7LMsa3QZuhKLByXb8huu+E5Kmxx9xP5U0M/9webeX
         9K2f2Ptg1BRM2JtyBkyYahuM4z/RvK03ot8rGcuQ=
Date:   Tue, 14 Jan 2020 16:21:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: remove header include path to
 drivers/staging
Message-ID: <20200114152158.GA2041564@kroah.com>
References: <20200104161827.18960-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104161827.18960-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 01:18:27AM +0900, Masahiro Yamada wrote:
> There is no need to add "ccflags-y += -I $(srctree)/drivers/staging"
> just for including <most/core.h>.
> 
> Use the #include "..." directive with the correct relative path.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This patch doesn't apply to my staging-next branch at all, what did you
make it against?  Perhaps if you rebase it against linux-next it can
work?

thanks,

greg k-h

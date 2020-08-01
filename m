Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BFCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C6220888
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596277974;
	bh=Us7KyQlqbWziFvUO2tehMhyV7K+1Pb82dffy9qOq2Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zHfnV2Elm6ny1G/lB5rfLVyigIUWz+vb/vZxjdrXYil0VxW5B6L+nc9zesfUsfwaH
	 +qw6ktVA6Ivc9jDThH4unLZ+RGPTZdKzEB+2VUmW5UmXFV+wvcHZSE/Zs8Dg2mXUMv
	 Lz/y+cccNjxK1hFR1LRSSg//uBr+CJVEKYjJOEEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHAKcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 06:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgHAKcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:32:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1988620716;
        Sat,  1 Aug 2020 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596277964;
        bh=Us7KyQlqbWziFvUO2tehMhyV7K+1Pb82dffy9qOq2Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zla2CnEEfepAQxSPEXCGH2cwP++BLmpL2HVs7zW2atNSmoTgXR82sgNZOnNMeZ2R0
         BMRcc14V8jMY5C8VPYSZkOsB63A0ODzS+6WLPdOctPgT8maySdJwfM9FM/BV/xp2FX
         MeLO05iGcxDVe7H6M93TFhNJOahg/WDnnpJVYlZk=
Date:   Sat, 1 Aug 2020 12:32:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     jaegeuk@kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: check memory boundary by insane namelen" has been
 added to the 4.9-stable tree
Message-ID: <20200801103229.GB3309560@kroah.com>
References: <20200801010825.43C5A2076B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801010825.43C5A2076B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:08:24PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: check memory boundary by insane namelen
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-check-memory-boundary-by-insane-namelen.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Also breaks the build here, so now dropped.


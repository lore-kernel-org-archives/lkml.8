Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEF720767
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598400646;
	bh=gCTPTSDOmtHoYUtD6saSkQXlFuKATF/IBsr4Y4tUrSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CoHz2r3rfOrTRBzDCxzajMnb/JNbY0/+JeZHs5ZBRdMs5jV0e/fdW9g7C7357gdjt
	 GzcRGFF+4X3ZLMLMq+HbuFYcZlbPPY+BLWsSACEnHTZiTBMm99D0JXOMweouKCbAEs
	 vB3SJYsy5lLDKpN4pdkk/Ex5NjVe3DICTwtYhly4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHZAKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgHZAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:10:44 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58834206F0;
        Wed, 26 Aug 2020 00:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598400643;
        bh=gCTPTSDOmtHoYUtD6saSkQXlFuKATF/IBsr4Y4tUrSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIalxQiBCwEKnmDveEQp9lYVpNWsYOR9ObVl7FMgbmgfFrR/kaJ/bo16WOZliq5Oj
         uJXLNyoHf9t3Oc+fbkI884wcL0HF3EpC8gAxAvJoA5ur2PHBjOAF62iYhrVB70zMWg
         UphQP4qRfVJF2FIbCY68mMqDlX6MMwKb5N6oj4yU=
Date:   Tue, 25 Aug 2020 19:16:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc3
Message-ID: <20200826001642.GA2671@embeddedor>
References: <20200824034841.GA29995@embeddedor>
 <d2c2cbb5-c63e-773f-5e90-1287e926bfa8@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c2cbb5-c63e-773f-5e90-1287e926bfa8@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:36:20AM +0200, Peter Rosin wrote:
> 
> Comments are important.
>

I agree. :)

Actually, both things are important: comments and the fallthrough work.

So, here you go:

https://lore.kernel.org/lkml/20200826000844.GA16807@embeddedor/

Thanks
--
Gustavo

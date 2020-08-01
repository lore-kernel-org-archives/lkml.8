Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9847AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AAF20888
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596278050;
	bh=JtQYQ/CF/Jsm+44EZC6sjK3RU/Cq7WnwL4vBc72IQDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nh8rGr4kzhD7TDkwtEgs+3t0Knwi0YrAi6g2zkYa64kDD7cbyQkOzgEafmaGUCpRW
	 8nXRam6DVHS37fVM3f7DspcMUmK6W4qBEV8w8BGjM/sL2qYPfKWfZepKK3J+txbtMD
	 CV87LYRTaiBfUOQxYfwMmgILSI/Rf4tpiuK/PCwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgHAKeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 06:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgHAKeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:34:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B52E20716;
        Sat,  1 Aug 2020 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596278047;
        bh=JtQYQ/CF/Jsm+44EZC6sjK3RU/Cq7WnwL4vBc72IQDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxDaC1rYE2BMM1S9G/nlbVb1V3qSPJ6SVSbC6cOZAcrq122egH1JAACix/unsbi09
         Iy/HJ/1g2Tuxjc75YLhfevTGbRCxE0SUjt9CB5b0qvbxDp6wxW+vUYpCuI3zwW2aIl
         VL3CBM+q1PgflQHIshqipKxZHvsevyJf2WIUF9Vc=
Date:   Sat, 1 Aug 2020 12:33:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     shengyong1@huawei.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: check if file namelen exceeds max value" has been
 added to the 4.4-stable tree
Message-ID: <20200801103352.GD3309560@kroah.com>
References: <20200801010839.A21512076B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801010839.A21512076B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:08:38PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: check if file namelen exceeds max value
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-check-if-file-namelen-exceeds-max-value.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Dropped from all branches due to the previous patch breaking the build,
so this patch does not apply to the trees anymore.

thanks,

greg k-h

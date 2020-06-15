Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98726C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D52078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592229000;
	bh=NFtkf5n5oNeaKNI75yVpxri+dQ4mPbBtK+e9CYNi690=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sMvb238Ccz1ukrCXAxN2aVqtCFSHkGdXxbIXoWNWIptR+WmlV0nKFYoB/2mluZDk+
	 KoX7YW28a1uEERx+r4iqw3GPltSmwV3IzrXe4apOlOQcNhF8wKKW2xq4fc14dUB5W9
	 JL0THN1dueEsOGfmbLhrPPupTdXJtZZ+ieFkIJL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgFONt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgFONtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:49:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5592078E;
        Mon, 15 Jun 2020 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592228991;
        bh=NFtkf5n5oNeaKNI75yVpxri+dQ4mPbBtK+e9CYNi690=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKoZ2joih1uVvfjpoOw+BT8Zy8/j/rHho/i+ScqiXY3ySS95VnA0cuxMMSDLhHwHs
         xCX6dLI3RA5UTCggvdwUdaBa4tG4E7rsAeqkVN5Z+bEI+yb/xxA4esm5Kv7fwT2snb
         rCkP7vYad/TCcdto0Ra3qwiMEiNCyV3ZonamYd48=
Date:   Mon, 15 Jun 2020 15:49:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, stable-commits@vger.kernel.org
Subject: Re: Patch "perf probe: Accept the instance number of kretprobe
 event" has been added to the 4.4-stable tree
Message-ID: <20200615134939.GA1398696@kroah.com>
References: <20200612014155.BC4FA20853@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612014155.BC4FA20853@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:41:54PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     perf probe: Accept the instance number of kretprobe event
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      perf-probe-accept-the-instance-number-of-kretprobe-e.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This shouldn't have gone to 4.4.y or 4.9.y, so dropping it from those
trees now...



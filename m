Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE137C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA292206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588081214;
	bh=z6FwCpZc4bewQTILO5ed54oDlhcVRcQNbY1dTaBbd6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ORPv+/Ch74Q6ORJHbCSu4PRZrfi1diMa95oocjwH9I3OQlmgN/NunB3w8/nYjtv2r
	 NXVV7Llbs0QLL8FMYygHb/Iv+UHvBiSmVtMEyBL2hoQYPEGg4ieD+AjBaK0KF57LlJ
	 GoSf+yllci4d2o6wyjkaRrN7DRlpW/ZsZf1r/9TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgD1NkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgD1NkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:40:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC285206D7;
        Tue, 28 Apr 2020 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588081213;
        bh=z6FwCpZc4bewQTILO5ed54oDlhcVRcQNbY1dTaBbd6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVkICW4Z7Gqg9PFeTpJx749wpYdzY1xShHb2yMmN+xaT45MjnilFD+afecPd9dSto
         sCzuyHDpAkyNOtqJYSPbwgTSTHwvuxcIZn0gS4NvHa860NVVh5lfoqvwLdsHACsIrT
         W/NEXMgeOvEPPtZv63J1pgPB/026WMACNMYwLFKI=
Date:   Tue, 28 Apr 2020 15:40:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Staging: mt7621-dma: mtk-hsdma.c: Fix Missing a blank
 line after declarations
Message-ID: <20200428134010.GA1374852@kroah.com>
References: <20200426161319.23941-1-john.oldman@polehill.co.uk>
 <20200426170719.GA2138855@kroah.com>
 <CA+JojbpBAkBHqZ3RUXjf-u-j9DUoS_m5oYwHQ=AWWp7qWQ8G-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+JojbpBAkBHqZ3RUXjf-u-j9DUoS_m5oYwHQ=AWWp7qWQ8G-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:21:25PM +0100, John Oldman wrote:
> I was not so happy about this one, even though I went and committed it.
> 
> Without the blank line checkpatch reports:
> 
> WARNING: Missing a blank line after declarations
> #160: FILE: drivers/staging/mt7621-dma/mtk-hsdma.c:160:
> + struct tasklet_struct task;
> + volatile unsigned long chan_issued;
> 
> So I dumly inserted a blank line to silence checkpatch.

As checkpatch is just a simple script, it is not always right, don't
blindly follow it.

> In hindsight maybe a false positive, blank lines in a struct might not be
> helpful.

It can be, but not here.

thanks,

greg k-h

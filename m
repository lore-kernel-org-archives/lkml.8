Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297B72078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587362857;
	bh=K6gEHvBM5iZ2rpg06eEoZWOrbw/+rY/wdMGoxIdaZfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uNNRuIsLhqanjKsaSSuPFeYd6Vc9pGfQ/FgTSzjshE3S0yfWssbSCGHhkGfm37enV
	 FmNJ0p4Ew7E5fm3q/hyoaa9hbmw+QSb6xAt1kU68N127cL0ffc+/iuhvijqcz6bbPg
	 qu3fzbiN0TWvAIoPaiuDnKhpu6VVtLLQhW+1r85M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDTGHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgDTGHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:07:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E60206F6;
        Mon, 20 Apr 2020 06:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587362854;
        bh=K6gEHvBM5iZ2rpg06eEoZWOrbw/+rY/wdMGoxIdaZfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8FhR3kiGytw0aG5y6UTU4w4dKDbzKkk+dyGFvWt6JkjYp9TKb1/mXtAivfwvLW+0
         utCML4WQbbq0/T3m870mS7/3xYwydjA/rAhJtzUWAGiF0oUdlOh6WfLiicBvujvBS7
         xHnMiK0678zqux+g/nUH9Z5b/1euEgO7n4AraPLo=
Date:   Mon, 20 Apr 2020 08:07:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] x86/CPU: Add native CPUID variants returning a
 single datum
Message-ID: <20200420060732.GA3704191@kroah.com>
References: <20200419162943.3704-1-evalds.iodzevics@gmail.com>
 <20200419165434.GA3697654@kroah.com>
 <CADqhmmdrXa6jrHEa-C2bLurM9DKhVxrQ1TeJdaOkWEA0D16-sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqhmmdrXa6jrHEa-C2bLurM9DKhVxrQ1TeJdaOkWEA0D16-sQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Apr 20, 2020 at 08:52:53AM +0300, Evalds Iodzevics wrote:
> The second patch depends on this commit by Borislav so i included
> this, probably I should have just mentioned it in my comment?

I really do not understand this sentence at all.  I have no context as
to what you are trying to do.

greg k-h

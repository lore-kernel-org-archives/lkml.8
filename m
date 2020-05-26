Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DD2208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590481076;
	bh=FSwmFkxuSzNUR+zuH7Zn3DAi6cLT2fFo8dtMDocf8cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o/kTqcWj00oItc6fK3ijSx1MsL2tsTgyY8hR9xSwo37TUKcbLUIHKuqN9dcvMUSfz
	 khmgZ6SupHbJVbejrZabwq2lfMxeREder/QqNRzW6VG22HcU1DDvRRncRYxG5vUDvc
	 uHb692UpYgObC+eeqR+eNAKvWTYhcqNYe0MC86mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgEZIRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEZIRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:17:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0B320776;
        Tue, 26 May 2020 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590481075;
        bh=FSwmFkxuSzNUR+zuH7Zn3DAi6cLT2fFo8dtMDocf8cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quWEouPkVJ9Znhpt/F+1qts9DS26VXpGDAS6hvdCF87TyIXFu3qLUDZ8st7rXVf8m
         0JHpATuvZsGTQgfwvYLv7aCyoR8v8CV72nNPAq8RDa5zWut82u4sXHwLCZQyz2gscC
         h87tfCpsU+JOXvXlDsVqkhIAaRZDuWNX3ZQCnjMI=
Date:   Tue, 26 May 2020 10:17:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, Andi Kleen <ak@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] x86: Pin cr4 FSGSBASE
Message-ID: <20200526081752.GA2650351@kroah.com>
References: <20200526052848.605423-1-andi@firstfloor.org>
 <20200526065618.GC2580410@kroah.com>
 <20200526075736.GH317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526075736.GH317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:57:36AM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 08:56:18AM +0200, Greg KH wrote:
> > On Mon, May 25, 2020 at 10:28:48PM -0700, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Since there seem to be kernel modules floating around that set
> > > FSGSBASE incorrectly, prevent this in the CR4 pinning. Currently
> > > CR4 pinning just checks that bits are set, this also checks
> > > that the FSGSBASE bit is not set, and if it is clears it again.
> > 
> > So we are trying to "protect" ourselves from broken out-of-tree kernel
> > modules now?  Why stop with this type of check, why not just forbid them
> > entirely if we don't trust them?  :)
> 
> Oh, I have a bunch of patches pending for that :-)

Ah, I thought I had seen something like that go by a while ago.

It's sad that we have to write a "don't do stupid things" checker for
kernel modules now :(

> It will basically decode the module text and refuse to load the module
> for most CPL0 instruction.

Ok, so why would Andi's patch even be needed then?  Andi, why post this?

thanks,

greg k-h

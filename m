Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA50C206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406144AbgE1TGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406029AbgE1TF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:05:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73389C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:05:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeNql-00H4bm-VX; Thu, 28 May 2020 19:05:56 +0000
Date:   Thu, 28 May 2020 20:05:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528190555.GO23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:34:38AM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 12:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > I'm wondering, shouldn't we also zero-initialize the dump data to
> > begin with? See the patch below (untested).
> 
> I actually got this patch from Andrew today independently due to a
> KMSAN report. Which I'm applying.

It doesn't fix all problems, though - you don't get an infoleak, but
you do get incorrect data...

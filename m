Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EE92071A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgF1HUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:20:16 -0400
Received: from verein.lst.de ([213.95.11.211]:55600 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgF1HUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:20:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAD6F68AFE; Sun, 28 Jun 2020 09:20:12 +0200 (CEST)
Date:   Sun, 28 Jun 2020 09:20:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] stop using ->read and ->write for kernel access v2
Message-ID: <20200628072012.GA16344@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiFVdi_AGKvUH5FWfD4Pe-dFa+iYPzS174AHKx_ZsjW5w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:15:00PM -0700, Linus Torvalds wrote:
> > as part of removing set_fs entirely (for which I have a working
> > prototype), we need to stop calling ->read and ->write with kernel
> > pointers under set_fs.
> >
> > My previous "clean up kernel_{read,write} & friends v5" series, on which
> > this one builds, consolidate those calls into the __ḵernel_{read,write}
> > helpers.  This series goes further and removes the option to call
> > ->read and ->write with kernel pointers entirely.
> 
> Ack. I scanned through these and didn't find anything odd.
> 
> Which either means that it's all good, or that my scanning was too
> limited. But this does feel like the right way to go about things.

Thanks.  If we move forward with this I'd like to get it merge soon
so that we get an as long as possible exposure in linux-next to find
the occasional candidate that needs to be converted to the iter ops.

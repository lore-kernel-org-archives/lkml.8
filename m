Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73817C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A822072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG0GuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:50:00 -0400
Received: from verein.lst.de ([213.95.11.211]:42221 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0GuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:50:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2774168B05; Mon, 27 Jul 2020 08:49:58 +0200 (CEST)
Date:   Mon, 27 Jul 2020 08:49:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     hpa@zytor.com
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Message-ID: <20200727064957.GB2317@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-19-hch@lst.de> <20200727030534.GD795125@ZenIV.linux.org.uk> <F3DAF5DA-82C2-4833-805D-4F54F7C4326E@zytor.com> <20200727062425.GA2005@lst.de> <366377E2-6F19-45E1-9285-CFA5E660C6B5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366377E2-6F19-45E1-9285-CFA5E660C6B5@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:36:15PM -0700, hpa@zytor.com wrote:
> >Err, why?  The changes have been pretty simple, and I'd rather not come
> >up with new crazy ways just to make things complicated.
> 
> Why? To avoid this neverending avalanche of special interfaces and layering violations. Neatly deals with non-contiguous contents and initramfs in device memory, etc. etc. etc.

I don't think it will be all that simple.  But given that linux-next
is just missing one series Al was already ok with to kill off set_fs
entirely for about half of our architectures I'd rather go ahead with
this series.  If you can send a series mapping user memory that actually
cleans things up on top of it I'm not going to complain, but I'm not
sure it really is going to be all that much cleaner.

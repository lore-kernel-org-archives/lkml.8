Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A666AC35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89593206E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBAScc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:32:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBAScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:32:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixxZH-005pJF-4j; Sat, 01 Feb 2020 18:32:31 +0000
Date:   Sat, 1 Feb 2020 18:32:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix do_last() regression
Message-ID: <20200201183231.GL23230@ZenIV.linux.org.uk>
References: <20200201162645.GJ23230@ZenIV.linux.org.uk>
 <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 10:29:17AM -0800, Linus Torvalds wrote:
> On Sat, Feb 1, 2020 at 8:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Brown paperbag time: fetching ->i_uid/->i_mode really should've been
> > done from nd->inode.
> 
> I'm assuming you want me to apply this directly as a patch, or was it
> meant as a heads-up with a future pull request?

The former, actually, but I can throw it into #fixes and send a pull
request if you prefer it that...

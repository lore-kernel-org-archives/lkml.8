Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2180C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4BD206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCNBAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:00:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCNBAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:00:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCvAV-00B8Rf-AJ; Sat, 14 Mar 2020 01:00:47 +0000
Date:   Sat, 14 Mar 2020 01:00:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v4 12/69] teach handle_mounts() to handle RCU mode
Message-ID: <20200314010047.GQ23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
 <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:28:12PM -0700, Linus Torvalds wrote:
> Oh, and here you accidentally fix the problem I pointed out about
> patch 11, as you move the code:
> 
> On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +               if (unlikely(!*inode))
> > +                       return -ENOENT;
> 
> Correct test added.
> 
> > -                       if (unlikely(!inode))
> > -                               return -ENOENT;
> 
> Incorrect test removed.
> 
> And again, maybe I'm misreading the patch. But it does look like it's
> wrong in the middle of the series, which would make bisection if
> there's some related bug "interesting".

Bisect hazard on botched reordering, actually.  Fixed (IOW, that should've
been if (!*inode) already in #11).

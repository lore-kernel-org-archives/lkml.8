Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3109C206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgGCHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:44:17 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:49652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgGCHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:44:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 01971182CF665;
        Fri,  3 Jul 2020 07:44:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: peace82_23082f326e90
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 07:44:13 +0000 (UTC)
Message-ID: <d7c902f9eecffc51f3a5761fa343bedad89dff7e.camel@perches.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 03 Jul 2020 00:44:12 -0700
In-Reply-To: <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
References: <20200701200951.3603160-1-hch@lst.de>
         <20200701200951.3603160-17-hch@lst.de>
         <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
         <20200702135054.GA29240@lst.de>
         <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 07:56 +0200, Miguel Ojeda wrote:
> On Thu, Jul 2, 2020 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > Do you have a suggestion for an automated replacement which does?
> > I'll happily switch over to that.
> 
> I guess I'd simply find the unique set of cases that occur and create
> a replacement for each manually. A handful of them or so may already
> cover the majority of cases. CC'ing Joe since he deals with this sort
> of stuff all the time.

I do that with a diff and emacs script.

And I'd generally not bother with 80 column rewrapping
here as it both makes a diff harder for not much value and
it's only a few characters added to a few lines that might
now exceed 80 columns.

I presume that clang-format would work well enough too.


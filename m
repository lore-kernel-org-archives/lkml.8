Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFB320772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgGBNu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:50:57 -0400
Received: from verein.lst.de ([213.95.11.211]:44181 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgGBNu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:50:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C93A68AFE; Thu,  2 Jul 2020 15:50:54 +0200 (CEST)
Date:   Thu, 2 Jul 2020 15:50:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
Message-ID: <20200702135054.GA29240@lst.de>
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-17-hch@lst.de> <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:46:17AM +0200, Miguel Ojeda wrote:
> Hi Christoph,
> 
> On Wed, Jul 1, 2020 at 10:25 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Switch over all instances used directly as methods using these sed
> > expressions:
> >
> > sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nit: the replacements don't take into account the spaces/tabs needed
> to align the designated initializers.

Do you have a suggestion for an automated replacement which does?
I'll happily switch over to that.

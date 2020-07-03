Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701AEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F18206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGCKca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:32:30 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:48788 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725891AbgGCKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:32:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C982C18224D65;
        Fri,  3 Jul 2020 10:32:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit08_621075526e91
X-Filterd-Recvd-Size: 1830
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 10:32:27 +0000 (UTC)
Message-ID: <1ff3cb8b4d3bdb7f25ea7fa1a45704f202dd1648.camel@perches.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
From:   Joe Perches <joe@perches.com>
To:     Zong Li <zong.li@sifive.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Jul 2020 03:32:26 -0700
In-Reply-To: <CANXhq0q=kEmXjBoSYrdKCHB=X_kksPro3gBQg8LCaSJcfLowqQ@mail.gmail.com>
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
         <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
         <CANiq72=Qakg1HAW8XggsBqiu=6-GVtQNDzeefmXxVG_RNA8MkA@mail.gmail.com>
         <9f0f19938130cbe9fd9412091254bacb8dd8bee1.camel@perches.com>
         <CANXhq0q=kEmXjBoSYrdKCHB=X_kksPro3gBQg8LCaSJcfLowqQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 18:22 +0800, Zong Li wrote:
> On Fri, Jul 3, 2020 at 5:51 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2020-07-03 at 11:41 +0200, Miguel Ojeda wrote:
> > > On Fri, Jul 3, 2020 at 10:51 AM Joe Perches <joe@perches.com> wrote:
> > > > I'd prefer to delete Lindent instead.
> > > 
> > > +1, especially since there is `clang-format` now.
> 
> Agree, it is often used.
> 
> > Awhile back I did send a patch:
> > https://lore.kernel.org/lkml/1360610974.28491.6.camel@joe-AO722/
> > 
> Cool, let us go the patch above.

You are welcome to refresh it as a lot has
changed in the 7.5 years since then.




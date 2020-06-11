Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513FCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338D12078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFKKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:36:40 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:38818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726945AbgFKKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:36:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 96B0E1802912B;
        Thu, 11 Jun 2020 10:36:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snake19_1e133c026dd3
X-Filterd-Recvd-Size: 1904
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 10:36:35 +0000 (UTC)
Message-ID: <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
Subject: Re: [PATCH] .clang-format: update column limit
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 03:36:34 -0700
In-Reply-To: <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
         <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
         <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 12:03 +0200, Miguel Ojeda wrote:
> Hi Joe,
> 
> On Wed, Jun 10, 2020 at 7:13 PM Joe Perches <joe@perches.com> wrote:
> > Ii think this is a not a good change.
> > 
> > If you read the commit log you provided, it ways
> > "staying withing 80 columns is certainly still _preferred_"
> 
> Yes, but the related email discussions were not about establishing a
> new hard limit, but about avoiding such hard limits for
> historical/technical reasons.

Exactly.  So don't set a new hard limit of 100.

This would _always_ wrap lines to 100 columns when
80 columns is still preferred.

Imagine using a 100 column limit where a statement still
fits on 2 lines.  Now imagine the same statement wrapped
at 80 columns still fitting on 2 lines.

Which would you prefer and why?



Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF83C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E290320760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGACjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:39:17 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:46382 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726874AbgGACjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:39:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1BE6B100E7B43;
        Wed,  1 Jul 2020 02:39:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toad01_1017c2226e7d
X-Filterd-Recvd-Size: 2160
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Jul 2020 02:39:14 +0000 (UTC)
Message-ID: <e49592775b3886ed80122ede38feab198e3ca517.camel@perches.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
From:   Joe Perches <joe@perches.com>
To:     Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Date:   Tue, 30 Jun 2020 19:39:13 -0700
In-Reply-To: <CANn89iLKZQAtpejcLHmOu3dsrGf5eyFfHc8JqoMNYisRPWQ8kQ@mail.gmail.com>
References: <CANn89iLPqtJG0iESCHF+RcOjo95ukan1oSzjkPjoSJgKpO2wSQ@mail.gmail.com>
         <20200701020211.GA6875@gondor.apana.org.au>
         <CANn89iKP-evuLxeLo6p_98T+FuJ-J5YaMTRG230nqj3R=43tVA@mail.gmail.com>
         <20200701022241.GA7167@gondor.apana.org.au>
         <CANn89iLKZQAtpejcLHmOu3dsrGf5eyFfHc8JqoMNYisRPWQ8kQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-30 at 19:30 -0700, Eric Dumazet wrote:
> On Tue, Jun 30, 2020 at 7:23 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Tue, Jun 30, 2020 at 07:17:46PM -0700, Eric Dumazet wrote:
> > > The main issue of the prior code was the double read of key->keylen in
> > > tcp_md5_hash_key(), not that few bytes could change under us.
> > > 
> > > I used smp_rmb() to ease backports, since old kernels had no
> > > READ_ONCE()/WRITE_ONCE(), but ACCESS_ONCE() instead.
> > 
> > If it's the double-read that you're protecting against, you should
> > just use barrier() and the comment should say so too.
> 
> I made this clear in the changelog, do we want comments all over the places ?

Having to run git for every line of code isn't great.

Comments in code is better than comments in changelogs.



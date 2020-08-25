Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12334C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECECF20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHYQku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:40:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:40:48 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kAc06-00071k-AN; Tue, 25 Aug 2020 16:40:46 +0000
Date:   Tue, 25 Aug 2020 18:40:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
Message-ID: <20200825164045.fkwws77einqbbhat@wittgenstein>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
 <87zh6in140.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zh6in140.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:26:07AM -0500, Eric W. Biederman wrote:
> 
> A) If we are going to have this discussion in public we really should
>    include the containers list.

Ah, just used the output from get_maintainers.pl.

> 
> B) The challenge is that most of the namespace work has become part of
>    it's upstream subsystem so we really need to list the containers
>    list and ourselves as reviewers, more than maintainers who run
>    a tree for the code.
> 
> C) You have overstated what I have agreed to here.
>    I have have previously said that I agree that having a MAINTAINERS
>    entry so people who are unfamiliar with the situation with namespaces
>    can find us.  Given that most of the changes going forward are likely
>    to be maintenance changes.
> 
>    I also said we need to talk about how we plan to maintain the code
>    here.
> 
>    It feels like you are pushing this hard, and I am not certain why you
>    are pushing and rushing this.  With my maintainer hat on my big
>    concern is we catch the issues that will introduce security issue.
>    Recently I have seen a report that there is an issue on Ubuntu
>    kernels where anyone can read /etc/shadow.  The problem is that
>    Ubuntu has not been cautions and has not taken the time to figure out
>    how to enable things for unprivileged users safely, and have just
>    enabled the code to be used by unprivileged users because it is
>    useful.
> 
>    In combination with you pushing hard and not taking the time to
>    complete this conversation in private with me, this MAINTAINERS entry
>    makes me uneasy as it feels like you may be looking for a way to push
>    the code into the mainline kernel like has been pushed into the
>    Ubuntu kernel.  I may be completely wrong I just don't know what to
>    make of your not finishing our conversation in private, and forcing
>    my hand by posting this patch publicly.
> 
> The files you have listed are reasonable for a maintainers entry as they
> have no other maintainers.
> 
> I know I have been less active after the birth of my young son, and I
> know the practical rule is that the person who does the work is the
> maintainer.  At the same time I am not convinced you are actually going
> to do the work to make new code maintainable and not a problem for other
> kernel developers.
> 
> A big part the job over the years has been to make the namespace ideas
> proposed sane, and to keep the burden from other maintainers of naive
> and terrible code.  Pushing this change before we finished our private
> conversation makes me very nervous on that front.

Ok, Eric. I've tried to do this with the best intentions possible and I
would assume that this is the default assumption everyone would have
after all these years. This type of response is very shocking to me and
I honestly don't know how to respond!

I'm dropping this completely because I'm not going to be accused of
having a hidden agenda! Such an accusation is imho completely out of
line and it is completely unacceptable to treat a peer like this!

Christian

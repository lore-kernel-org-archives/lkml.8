Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC90C22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgHETyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHEQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:40 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k3L7L-0001LE-7y; Wed, 05 Aug 2020 15:14:11 +0000
Date:   Wed, 5 Aug 2020 17:14:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fork cleanup for v5.9
Message-ID: <20200805151410.ikwqc6c2miylmj5f@wittgenstein>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
 <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:56:04PM -0700, Linus Torvalds wrote:
> On Tue, Aug 4, 2020 at 4:28 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > This is a series announced some time back (cf. [2]) when we reworked a chunk of
> > the process creation paths in the kernel and switched to struct
> > {kernel_}clone_args.
> 
> You have those refs to [2] (and later [1]), but not the actual links
> they refer to.
> 
> I just edited them out, but please try to avoid this in the future.

Hm, odd. I'll try not do have that happen again.
Christian

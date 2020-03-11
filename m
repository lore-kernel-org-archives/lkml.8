Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9087C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E7120738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583948116;
	bh=uRPyYMPVAszfnVKvro8kpzdf0xTwiUPLRA5JUmq/v9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RWBAceaCnik+BYupb0W15I4VeeQ0TuIXlHeqMBUT1f5EDB6VP0d75U4VJ7Ro208ed
	 X7zH0XqSkNW3oSUphip2b/zPgAwUDcFbl+l/z9xNzYMHf0If4mMBWrm2CNfQ4iXfxT
	 OizL/Z5WkpD4DXMGI+ug9EFGkRMQv4XoLjmMgLTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgCKRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgCKRfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:35:14 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57EBA2072F;
        Wed, 11 Mar 2020 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583948114;
        bh=uRPyYMPVAszfnVKvro8kpzdf0xTwiUPLRA5JUmq/v9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFREYax8HihMgrTlVKVrpk3AA9/wEAT4h2oCHN1AyBMB7R+05HA2C0vFxIJMHH27R
         UPkC4nDbncZxW0a7COmWptXuSEreRqBTWA6DrlfAZg5l5dN1cyosfdQT2vN4xMPlh0
         7y7peuTKexQxFbK0VPX1Og1l2zOYka3QVDU2pjwc=
Date:   Wed, 11 Mar 2020 10:35:13 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
Message-ID: <20200311173513.GA261045@google.com>
References: <20200311162735.GA152176@google.com>
 <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 9:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Sorry for late pull request. Could you please consider this?
> 
> I pulled this, and then immediately unpulled.
> 
> Most (all?) of the commits have been committed basically minutes
> before you sent the pull request.
> 
> That's simply not acceptable. Not when we're in late rc, and with
> hundreds of lines of changes, and when there is no explanation for a
> late pull request that was very very recently generated.

I actually merged the last three patches which were introduced yesterday.
I thought that it'd be fine to pull in, since they are quite trivial several
lines of code changes.

Others were merged over a week ago, and I've tested in the mean time.
It seems the commit times were modified as recent date, when I reorganized
there-in commits aligned to other branch, dev-test. Probably, I had to keep
the commit date in somehow.

Thanks,

> 
>                 Linus

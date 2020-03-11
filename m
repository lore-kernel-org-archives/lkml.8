Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75519C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31BC2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583948921;
	bh=o6cfFMd76vbeZd9f32n4LmEvpTaX32KdbDibeKUu9jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xf3sOkKz1Vv22gPtUeAdqcObJCXWc/MY5eBzoKka1tg/Mrhz68OXpii0WTNOObGgL
	 aWpnuq5EHeKT12DK1uwjzs8bs/IydqltZxea0IDhKymem+6OHZsvjtQkHH+cqQBNv4
	 wqGwBsU8MUsMhwwj52MJMlzf/WeMhH7ARf4/4zik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgCKRsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgCKRsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:48:38 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C5B20734;
        Wed, 11 Mar 2020 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583948919;
        bh=o6cfFMd76vbeZd9f32n4LmEvpTaX32KdbDibeKUu9jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNcHirCXMuXTRjxAhcBTXM+uJDRIFTyQ7xcnNZSGcV3HXtYu50FYhlFQKyeqt5Qi+
         ybY2UKmTNNL9si7JuFc72Uusfw+T/EyxehtOUL6ajiw4gusPq9ta9DeeW7dm3u+qzM
         /B07T/grBRqlow0OJHle22MB4VhyWV3rB0tgMFRw=
Date:   Wed, 11 Mar 2020 10:48:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
Message-ID: <20200311174837.GA82207@google.com>
References: <20200311162735.GA152176@google.com>
 <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
 <20200311173513.GA261045@google.com>
 <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 10:35 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > I actually merged the last three patches which were introduced yesterday.
> >
> > Others were merged over a week ago.
> 
> No, three were done just before you sent the pull request, and then
> seven others were done yesterday.

Due to my rebase work. :(

> 
> Yes, the rest were a week ago.
> 
> But basically, by rc6, I want to get the warm and fuzzies that the
> code has been tested, seen review, and isn't some last-minute
> addition.

Ok, I see. Let me prepare them for next merge window.

Thanks,

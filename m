Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7205C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B7821739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0SOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:14:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0SOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 254A8AAB8;
        Mon, 27 Jan 2020 18:14:09 +0000 (UTC)
Date:   Mon, 27 Jan 2020 19:14:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/microcode for 5.6
Message-ID: <20200127181402.GG24228@zn.tnic>
References: <20200127113903.GD24228@zn.tnic>
 <CAHk-=wgedtBiFok8twm499FmNCJ6icWdG7Deb7f4jcDYS4Y_Lg@mail.gmail.com>
 <20200127173852.GF24228@zn.tnic>
 <CAHk-=wiOQhFckQftz_bLC9qsntdm5n_TbC02=sfWy2nM+bmrFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiOQhFckQftz_bLC9qsntdm5n_TbC02=sfWy2nM+bmrFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:02:31AM -0800, Linus Torvalds wrote:
> Early-onset something or other..

:-) Same here.

> No, it's fine. I'll figure it out and maybe remember next time.

I'll try to remember to point that out in the pull request message next
time.

> I do prefer signed tags even from kernel.org, and maybe you can
> encourage the other tip people to sign things too one day ...

Yap, just did and I'll try to work on them in the future. But I'm sure
you know how some of them are stubborn and unwilling to change their
ways.

:-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

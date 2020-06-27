Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F03C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF367204EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593299417;
	bh=/ft0gEdXgdrpBXeR5hwd2mEJMfyWjzRx7hEcjdZ+TNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tmc+eiGIK2uCtbQ/MIzIZ/5tgfxtZfmHkWunlQ6Y4PvaL4JFeuEiycI7p71CVgz84
	 wABg3ICUM91mNYeaKkM8kxjS9SXWxEPd5xabhIUKQYhatGFvCapR9bD9Y+yKiB5MCZ
	 LUnjSbfD/xzyhUFBf3XaJS5shJ9ND0UhrRdD8wzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgF0XKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 19:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgF0XKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 19:10:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3917820707;
        Sat, 27 Jun 2020 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593299415;
        bh=/ft0gEdXgdrpBXeR5hwd2mEJMfyWjzRx7hEcjdZ+TNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoDOyld9MuOVGH4iJuZ+iBHgjZH9PZxkzlfM86zFy/I0J99jZTg6FG73e9bRd11gT
         aPDyr/lstgl6eteNtDc09aOcMozcGW1T0F8qhIbOVL7ACUiUKzJehNz0thD1rA4uKw
         bVaTg0Wa/hclcMQ9rr5hV9X5IAyHZsYK9VjeO/ds=
Date:   Sat, 27 Jun 2020 16:10:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-mm@kvack.org
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
Message-ID: <20200627231013.GM7065@sol.localdomain>
References: <CACT4Y+ZcbA=9L2XPC_rRG-FdwOoH6XteOoGHg7jfvd+1CH2M+w@mail.gmail.com>
 <121C0D57-C9E6-406B-A280-A67E773EA9D0@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <121C0D57-C9E6-406B-A280-A67E773EA9D0@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc linux-mm; +Bcc linux-fsdevel]

On Mon, Jun 22, 2020 at 03:28:09AM -0400, Qian Cai wrote:
> 
> 
> > On Jun 22, 2020, at 2:42 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > 
> > There is a reason, it's still important for us.
> > But also it's not our strategy to deal with bugs by not testing
> > configurations and closing eyes on bugs, right? If it's an official
> > config in the kernel, it needs to be tested. If SLAB is in the state
> > that we don't care about any bugs in it, then we need to drop it. It
> > will automatically remove it from all testing systems out there. Or at
> > least make it "depends on BROKEN" to slowly phase it out during
> > several releases.
> 
> Do you mind sharing what’s your use cases with CONFIG_SLAB? The only thing prevents it from being purged early is that it might perform better with a certain type of networking workloads where syzbot should have nothing to gain from it.
> 
> I am more of thinking about the testing coverage that we could use for syzbot to test SLUB instead of SLAB. Also, I have no objection for syzbot to test SLAB, but then from my experience, you are probably on your own to debug further with those testing failures. Until you are able to figure out the buggy patch or patchset introduced the regression, I am afraid not many people would be able to spend much time on SLAB. The developers are pretty much already half-hearted on it by only fixing SLAB here and there without runtime testing it.
> 

This bug also got reported 2 days later by the kernel test robot
(https://lore.kernel.org/lkml/20200623090213.GW5535@shao2-debian/).
Then it was fixed by commit 437edcaafbe3, so telling syzbot:

#syz fix: mm, slab/slub: improve error reporting and overhead of cache_from_obj()-fix

If CONFIG_SLAB is no longer useful and supported then it needs to be removed
from the kernel.  Otherwise, it needs to be tested just like all other options.

- Eric

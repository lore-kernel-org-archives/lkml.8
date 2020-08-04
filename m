Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A54C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7332D20786
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596502211;
	bh=PdHeGqguVQqNl2iBh6HxmGsanO5DiavSPdWdC17XBw0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f1WEScvP3jAeWgs0HLSli2ElGFEOSxuiFMqsulLmPXbVc4vIxiacw0jGwi0u83Zea
	 iNFGswLUdqaBPf2pmM3zfHh+GfGyndtRBsux4kjbSN1tURRRW8KeUIKld4iGisyurN
	 fcafvPBHslQYbreTbvIJWcARnhFYF4+n97RzHEao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgHDAuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbgHDAuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:08 -0400
Subject: Re: [GIT PULL] x86/fpu change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502207;
        bh=PdHeGqguVQqNl2iBh6HxmGsanO5DiavSPdWdC17XBw0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e1FtxxL67IzP6U4bwtBq367zfDsolrYU4sP4J31CqtqoJmiWWY8gSwVrHabfbiYdq
         9EAJZWzks8MoJQaOTzVskEf4rXeERJn0nNRYkRHeYLh82mopAEewk6GISiCoFzVAzV
         KZG6xh7RQ5hXFIgrO6WPQ+VKJ8oFqrVEk4CUwveI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803182335.GA1103918@gmail.com>
References: <20200803182335.GA1103918@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803182335.GA1103918@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-08-03
X-PR-Tracked-Commit-Id: 4185b3b92792eaec5869266e594338343421ffb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a897743ac258927dd29bb91ac663b568f53429d
Message-Id: <159650220770.17631.15328839201396615432.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 20:23:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a897743ac258927dd29bb91ac663b568f53429d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

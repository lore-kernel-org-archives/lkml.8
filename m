Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DA5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B156820702
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593273616;
	bh=ExmDMQi9xiuf55HUjdu6pZxC89O5BDsJ1uQhCgOD9Gs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jsDYtzPZiDYG73xTOEE+tbLfMYWf/zlw/ZsR8c/GDH7n4O8mt9J5MeuS1YF2uXJzD
	 pPTjoJPcXaquThhQgtoQPO9JXyJKK5fTOkB32t8QhIMEtmQ3phnezlpLcZwfCkUxIn
	 z1L0dU6eXRfi1N1Ha9xp/Rb7QKZOjpeH+Apnr+qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgF0QAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Subject: Re: [GIT PULL] kgdb changes for v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273613;
        bh=ExmDMQi9xiuf55HUjdu6pZxC89O5BDsJ1uQhCgOD9Gs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vu57IiRpB74DOHvoKsUJ++vqterGCH5dl4CzSEbLDliQdRAQFH+e47P3Zf6Gpm/H+
         tPZbdhevqb76/BKkvaUArxO4zXqBqfPUSoc+mC26/5qIuZJMsh4p9zTDNfDQ9sQUNN
         H+NcD+oa7KO4igyuDuzDiWHVQ5pmAaMbpS/1bAa4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626145457.5weza5ow3hrm7kum@holly.lan>
References: <20200626145457.5weza5ow3hrm7kum@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626145457.5weza5ow3hrm7kum@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.8-rc3
X-PR-Tracked-Commit-Id: 440ab9e10e2e6e5fd677473ee6f9e3af0f6904d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6116dea80dfd5b8d3825bf7f2e44a8bc2730f3d0
Message-Id: <159327361296.7015.17400727299585096692.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:00:12 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 15:54:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6116dea80dfd5b8d3825bf7f2e44a8bc2730f3d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE7C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5829520760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599345407;
	bh=WR5uGs+/NFZgVEqlcWJK91hOncPor40GpM8OqKM17II=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ODp8cUEUf60fYheb/WG0dgxZcUpVjBm3NzNVrIoMp5g8xpsrAjkzNYTUBqhZU/4vU
	 dMC2XQbeZZU/v5PmQkm5ZFMQW84VvvzKGs2MepnzB0b06DyMiSxGFtTL/GPiGoe3EJ
	 FfrHFKy486TQqCjvnLe5twDxbhqHkca9plhHDpTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgIEWgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbgIEWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:36:30 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599345389;
        bh=WR5uGs+/NFZgVEqlcWJK91hOncPor40GpM8OqKM17II=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aj+pQWya0CNIapKCxKNOdcolkEN+YIhzaHPfo3KurkazXBtwoGkI0I2IXbTbNaCbc
         keERWGlKxYeOs98+jZCJzY6LSsqv0trlE6PnOsWMarYksOWznXxdwPCPAeeWZoxDzs
         blYwg0ECQ7I0pBW9oFpORFCDEFufVhY9TKTOoCg0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200905113752.GA4762@gmail.com>
References: <20200905113752.GA4762@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200905113752.GA4762@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc4
X-PR-Tracked-Commit-Id: 46d4a403a04c0ba46641452367b6a04bcf918a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd9fb9bb3340c791a2be106fdc895db75f177343
Message-Id: <159934538972.12925.11078356568448048869.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Sep 2020 22:36:29 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Sep 2020 13:37:52 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd9fb9bb3340c791a2be106fdc895db75f177343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

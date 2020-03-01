Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C9524650
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583025907;
	bh=rYsXurT4DNJvltnTF7xO+00kfQ3KGNns2BFrFHrnkmA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lRK8ZxLeBMRuvoB6EuP22AJ5EI5oQpvMb+pCM4hSLRgbDbs6r+eEPK61d39bWhJKO
	 XCXOq7mjNK5rfBpQcoi6OktYluavIfSVZMevt97ZWE3zMXl8BJ6qHWvvPnmNQ5HS4B
	 3ieRKoOxeggbZjnCl7w0To761R+8hdwPgSYm/FSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCABZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCABZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 20:25:06 -0500
Subject: Re: [PULL REQUEST] i2c for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583025905;
        bh=rYsXurT4DNJvltnTF7xO+00kfQ3KGNns2BFrFHrnkmA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H9xgqQCPBWgW05yRabHfwognG5/Qz48hr36GvotY/uUKg1Fm5HbXALD09siN4Uag2
         w3RlG2wM5RoSJQvrE6hcbMiLLvIPI9tQb+eLxnYPBaH7BjRAF8urTY3nXHQkajxW0U
         U4tUFAD9rEKzWZRDurzlS5/VI8k/7N0sLht3ABqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200229201726.GA2089@ninjato>
References: <20200229201726.GA2089@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200229201726.GA2089@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: 38b17afb0ebb9ecd41418d3c08bcf9198af4349d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb279f4e238617417b132a550f24c1e86d922558
Message-Id: <158302590559.1645.8749085952981671824.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Mar 2020 01:25:05 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Feb 2020 21:17:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb279f4e238617417b132a550f24c1e86d922558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

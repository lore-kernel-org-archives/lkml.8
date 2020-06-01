Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8582076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591052106;
	bh=HPCEBbtDEAn1GNhRAktpzqTXTAxic4iU9i0mxbesenw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uU8K6Oj2gLj2XQ7lEyerjf0nG3eh1SXisZQy6jY815WiXJxMuRc8fQdQmpuk8pZMq
	 TeCFqqgujylqZKEf9gz9qcXV5Mr+ALAbw0a8p9SlJtHk6NC70Bd34UwxWDBsLCEPlh
	 eEkWqzm2Xx7SzKc8XI62zFun01SNLm3E4IQmBpH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgFAWzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgFAWzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:55:05 -0400
Subject: Re: [GIT PULL] Documentation for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591052105;
        bh=HPCEBbtDEAn1GNhRAktpzqTXTAxic4iU9i0mxbesenw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e0nWrQhAZAUpSNYbbOKNNlqOnOmtIszZFxZFkawesDwegrjdfa/mTkjVbCJB0lA5E
         D0gTZlbBRcxNMzMRitPscG6INbRbl5wmP0Zqb8rGqNAwFDU2uNhYHFRxt/mSOGczJD
         QIb7A+u2hTQSiuCn7NOV6llAjUmpkfcPf8TPPmT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601094600.19c6fe0b@lwn.net>
References: <20200601094600.19c6fe0b@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601094600.19c6fe0b@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.8
X-PR-Tracked-Commit-Id: e35b5a4c494a75a683ddf4901a43e0a128d5bfe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69
Message-Id: <159105210511.25569.4101174637421068247.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 22:55:05 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 09:46:00 -0600:

> git://git.lwn.net/linux.git tags/docs-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

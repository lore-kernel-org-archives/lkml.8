Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C1C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA3821775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586408134;
	bh=cWRQCtrlTDdL8U+k2fQvJ7I/8GpqVP8VinRoB7sPoPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fKEAdUKMlLNl6MZVWKQWLlAj5L03uXco3gxW/xw3KU2vM5e03a3okmQs2mYD7Gsdk
	 IMH5pp4c96FCf/kZJoxe5y4z1Bfgsot2PRsQuzWs50T/OaDgMRxLBMBSEHyhcEFf+/
	 mX7tZxsDdX2TZuC4v2zbijSjKEzMo0oaayaxNhP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDIEzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgDIEza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:30 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408130;
        bh=cWRQCtrlTDdL8U+k2fQvJ7I/8GpqVP8VinRoB7sPoPs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=myg+8e6q9CTygKATX2NYP0xFCEESRThSIUFOHoqy4uAEZelmBlHuOrLipUnxhC6WR
         nB72Tw+e3MCjNAoRm959eGm53rDdJ3s49QKD6bmdWcvkXVnCgfpPXIP8V8UkKN7P2X
         QsjJ1tz2MVTEsq/SsmzF26+UfUq0qD1HkQGyxkqM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200408055336.GA123431@google.com>
References: <20200408055336.GA123431@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200408055336.GA123431@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.7
X-PR-Tracked-Commit-Id: a46387712da12b61bf1ce1a3f63b60a17b098960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 413a103cf6e507f6304ec42b89ed45428942c43f
Message-Id: <158640813050.3202.5614073362747400593.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:30 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 22:53:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/413a103cf6e507f6304ec42b89ed45428942c43f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E9D22CBB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596768505;
	bh=vLE3j0Nz1rVZsqEsjGiLfaRreFdGW5ybwUgQ++LjBm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Yf3V2vRi+m4yYrRTf3Y3i1eri8gQpLfP4HrulAiXPF7ynTXH1Zg+fQcZT8khRCKn1
	 4eEny+AAY/0BRgsqUNd3/4mBRKX/4bBeHOkIwoi+o+jOzCW8C/qZvjfiYMfjH1sXPF
	 cdkZOncYAX2LU3aSTjOJ76rpHuSEoDWpNhj6AFVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHGCsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHGCsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:48:22 -0400
Subject: Re: [GIT PULL] dlm updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596768502;
        bh=vLE3j0Nz1rVZsqEsjGiLfaRreFdGW5ybwUgQ++LjBm4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NHxk2fJMAmPp34J2pwESVdMhqbEh7sDMWvZ9p96S1EH4w/D9ALHUHHoowyBb9Ctoh
         LiUC8AeIB1LpAEIM7Ryb8zNf9l+xI8P9P2T1OgyadzHlWICGFS0AP/ucHkFQl8xB4m
         LzSzmrEYreC/MksCZK/hAZDnjknwD3RSOod25gk4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806164507.GC9935@redhat.com>
References: <20200806164507.GC9935@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806164507.GC9935@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.9
X-PR-Tracked-Commit-Id: 055923bf6b48659755b5f0169e34107ee2cb9b68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86cfccb66937dd6cbf26ed619958b9e587e6a115
Message-Id: <159676850246.27658.17097927006270866281.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 02:48:22 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 11:45:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86cfccb66937dd6cbf26ed619958b9e587e6a115

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

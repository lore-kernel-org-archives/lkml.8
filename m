Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FC12075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295132;
	bh=4ZbWLrY2SFwlyNm8arlgBezHXz+WAK+PDnPLbtZJjbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sUe7B9lM6ivN+I1iTdZO3KZ9SUW6cdOqmPt0q1vm2rOIep2DinfYTGDNgjx6ro5XV
	 Xq5uaI81gwyPnQU0F6XbI/ZbbHJCPrBW36AstASXFOZ16oY0lUNLvOqDSpWd7wL3p4
	 qtB4Q0tpwS6WiA4ocQaUievFqLMAnpZ1zuLqac3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgFDSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgFDSZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:16 -0400
Subject: Re: [GIT PULL] pcmcia updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295116;
        bh=4ZbWLrY2SFwlyNm8arlgBezHXz+WAK+PDnPLbtZJjbI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nq2cM27UpRt7fzUkSXfphjtjZPYYxto529ULUrCWJFqaccOtSbhuN51KbXTUVszj3
         R3+uJ5P9eZofLXq+qVeG5jPJYV1OanrS2jFs0Mm3wxul6hiAI2iLIbZ0vuzlVKzFpN
         Ws7bTbet91E0tkCAhdEnG30aK7n+X93RK9pqmhic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604165233.GA167431@light.dominikbrodowski.net>
References: <20200604165233.GA167431@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604165233.GA167431@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: 46d0797906633d82bd50ef26780ee39fac5d27d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0a4d17e02a80a74a63c7cbb7bc8cea2f0b7d8b1
Message-Id: <159129511618.18772.11924071820503131097.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:16 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 18:52:33 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0a4d17e02a80a74a63c7cbb7bc8cea2f0b7d8b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
